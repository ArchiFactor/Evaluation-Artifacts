# ArchiFactor Evaluation Artifacts

This repository holds the evaluation artifacts of the MSc thesis "Refactoring towards a Modular Monolith Architecture Leveraging Domain-Driven Design Principles" (Athens University of Economics and Business). The source code of each subject, with the refactoring and the agent's repairs as commits, lives in its own repository of this organization.

## Layout

Each subject folder holds the same four kinds of artifact.

| Path | Content |
|---|---|
| `module-identification-results/` | Phase 1 output at γ = 0.5, 1.0, 1.5 and 2.0. Each file prints the static graph, the graph after enhancement, one entry per call-graph entry point (`Endpoint:`), and the clusters (`Cluster:`). |
| `images/` | Screenshots of the three ArchiFactor views during the run. |
| `*-repair-agent-instructions.txt` | The additional instructions typed into the Repair JPQL Queries view. |
| `*-repair-agent-results*.txt` | The complete Claude Code transcript, one JSON event per line. The last line is the result object with turns, durations, token usage and cost. |

`mojito/mojito-linux-worktree.sh` is the Docker runner that mojito's additional instructions call, because mojito's suite only passes on Linux.

## Subjects and commits

The baseline is the parent of the deterministic commit. The repair commit holds the agent's edits, which the agent leaves uncommitted and which were committed after each run.

| Subject | Repository | Deterministic commit (Phase 2) | Repair commit (Phase 3) |
|---|---|---|---|
| mojito, run 1 | `mojito`, branch `archifactor` | `845e65ef` | `cffa114c` |
| mojito, run 2 | `mojito`, branch `archifactor` | `8c33d6ec` | `a892ba5f` |
| BurningOKR | `BurningOKR`, branch `archifactor` | `036d1f5` | `0ec0c0e` |
| iridium | `iridium`, branch `archifactor` | `7a76170` | `cb7e8b4` |
| Shopizer | `shopizer`, branch `archifactor` | `d9b98a4` | `70a792c` |
| Budget-Management | `Budget-Management`, branch `archifactor` | `b5bd57e` | none, the agent changed nothing |

To see what Phase 2 changed, run `git show <deterministic commit>`. 
To see what the agent changed, run `git show <repair commit>`.
