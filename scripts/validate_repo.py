"""Offline repository validation for internal documentation links and deployment guardrails."""

from __future__ import annotations

import re
import sys
from pathlib import Path

import yaml

ROOT = Path(__file__).resolve().parents[1]
LINK = re.compile(r"\[[^\]]+\]\(([^)]+)\)")


def check_links() -> list[str]:
    errors: list[str] = []
    for document in ROOT.rglob("*.md"):
        for target in LINK.findall(document.read_text(encoding="utf-8")):
            if target.startswith(("http://", "https://", "mailto:", "#")):
                continue
            path = target.split("#", maxsplit=1)[0]
            if path and not (document.parent / path).resolve().exists():
                errors.append(f"{document.relative_to(ROOT)} references missing {target}")
    return errors


def check_workflows() -> list[str]:
    errors: list[str] = []
    for workflow in (ROOT / ".github" / "workflows").glob("*.y*ml"):
        payload = yaml.safe_load(workflow.read_text(encoding="utf-8"))
        if not isinstance(payload, dict):
            errors.append(f"{workflow.relative_to(ROOT)} is not a YAML mapping")
            continue
        if "permissions" not in payload:
            errors.append(f"{workflow.relative_to(ROOT)} must declare explicit permissions")
        if "pull_request_target" in payload:
            errors.append(f"{workflow.relative_to(ROOT)} must not use pull_request_target")
    return errors


def check_platform_contract() -> list[str]:
    values = ROOT / "charts" / "basalt" / "values.yaml"
    terraform = ROOT / "terraform" / "environments" / "dev" / "main.tf"
    errors: list[str] = []
    if "warehouseReadApiUrl" not in values.read_text(encoding="utf-8"):
        errors.append("Helm values must expose the dashboard warehouse read API boundary")
    if "backend \"s3\"" not in terraform.read_text(encoding="utf-8"):
        errors.append("Terraform environment must require an external S3 backend")
    return errors


def main() -> int:
    errors = [*check_links(), *check_workflows(), *check_platform_contract()]
    if errors:
        print("Platform validation failed:", *[f"- {error}" for error in errors], sep="\n")
        return 1
    print("Platform documentation and workflow guardrails passed.")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
