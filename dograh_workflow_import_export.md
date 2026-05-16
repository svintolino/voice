# Dograh Workflow Import/Export

Dograh now exposes workflow import/export directly in the workflow editor UI.

## What changed
- Export is a visible action in the workflow header.
- Import is a visible action in the workflow header.
- Import accepts either:
  - pasted JSON
  - a `.json` file upload
- The imported workflow is applied to the editor state and marked dirty for saving.

## Supported JSON forms
- Raw workflow object with `nodes` and `edges`
- Wrapped export object with `workflow_definition`
- Wrapped export object with `workflowDefinition`

## Recommended use
- Export a workflow from one Dograh instance.
- Import it into another Dograh instance.
- Review the editor state before saving.
- Save the imported workflow to persist it.

## Caveat
The import path validates obvious malformed structures, but very custom or broken JSON can still fail later in the editor or save flow if it does not match Dograh’s workflow schema.
