# Keymaps

Leader is **Space**. So `<leader>dt` means: `Space` then `d` then `t`.

Press `Space` and wait for which-key, or search every mapping with `Space sk`.

Custom maps are marked **(custom)**. `*` in examples is the cursor.

---

## Vue / CSS / SCSS **(custom)**

These only exist in `.vue`, `.scss`, and `.css` buffers.

### `Space dt` — delete surrounding tag, keep the text

Same as `dst` (nvim-surround). Cursor can be anywhere on the tag or inside it.

```
Before:  <span class="muted">Hello*</span>
After:   Hello
```

```
Before:  <button type="submit">Save*</button>
After:   Save
```

Use this when the wrapper is noise and you want the inner text to stay.

---

### `Space rc` — rename a class inside a marked block

Not the whole file. Only the range between mark `a` and mark `b`.

1. Go to the start of the block, press `ma` (mark a).
2. Go to the end, press `mb` (mark b).
3. Press `Space rc`.
4. Type the old class, Enter, then the new class, Enter.

```
Marks cover this SCSS block:

  .card {
    &__title { color: blue; }
    &__body  { color: gray; }
  }

Prompt: Old class:  __title
Prompt: New class:  __heading

After:  &__heading { color: blue; }
```

For a rename across the whole repo, use `Space sr` instead.

---

### `Space hv` — replace a hex color with a CSS variable (whole file)

```
Before (many times in the file):  color: #1b1e28;

Prompt: Hex color:       #1b1e28
Prompt: Variable name:   var(--bg)

After:  color: var(--bg);
```

To *nudge* a hex instead of replacing it, put the cursor on `#1b1e28` and hit `Ctrl-a` / `Ctrl-x`.

---

## Daily drivers

| Key | Example |
| --- | --- |
| `Space Space` | Fuzzy-find `UserCard.vue` without knowing the path |
| `Space /` | Type `useUser` → every match in the repo |
| `Space e` | File tree on the left (like VS Code explorer) |
| `s` then `us` | Labels appear on every `us…` on screen; type the label to jump there |
| `S` | Labels on whole functions / Vue tags; jump to a `<script>` block |
| `Space H` then `Space 1` | Pin this file; later `Space 1` jumps back instantly |
| `gd` | Cursor on `useUser` → opens `useUser.ts` |
| `gr` | Cursor on `UserCard` → list of every place it is imported |
| `K` | Hover: types / docs for the symbol under the cursor |
| `Space cr` | Rename `getUser` → `fetchUser` with live preview in the file |
| `Space ca` | Menu: “Add missing import”, “Fix this ESLint”, etc. |
| `Space cf` | Run Prettier / Ruff on this file now |
| `Space xx` | All errors/warnings in a list you can jump through |
| `Space sr` | `oldClass` → `newClass` across `*.vue` files, preview, then apply |
| `Space gg` | Lazygit TUI: stage, commit, push |
| `Space T` **(custom)** | Terminal docked on the right (`pnpm dev`) |
| `Ctrl-/` | Toggle the floating terminal |
| `Ctrl-s` | Save (works in insert mode too) |
| `Alt-w` **(custom)** | Close this file; the split stays |

---

## Files, buffers, explorer

**Find files**

- `Space Space` / `Space ff` — files from the project root (`package.json` / `.git`).
- `Space fF` — files from *this folder* (useful in a monorepo package).
- `Space fg` — only git-tracked files (skips `node_modules` noise).
- `Space fr` — files you opened recently.
- `Space fc` — files inside `~/.config/nvim`.
- `Space fn` — empty unnamed buffer (scratch a snippet).

**Explorer**

- `Space e` — tree at project root. Open `src/components/UserCard.vue` with `j`/`k`/`Enter`.
- `Space E` — tree at the folder of the current file.

**Buffers** (open files)

You have `UserCard.vue` and `useUser.ts` open.

- `Shift-h` / `Shift-l` — flip between them.
- `Space bb` — jump to the other one (`#`).
- `Space bd` / `Alt-w` — close this file; the window layout stays **(custom BufDel)**.
- `Space bo` — close everything except this file.
- `Space bD` — close file *and* the split.

---

## Search

You are in `UserCard.vue` looking at the word `fullName`.

- `Space /` — live grep the repo. Type `fullName`.
- `Space sw` — grep *this word* immediately (or the visual selection).
- `Space sb` — fuzzy search *lines in this file* (like `/` but a picker).
- `Space sr` — search & replace UI. Filter is prefilled `*.vue`. Replace `fullName` → `displayName`, preview, apply.
- `Space sk` — “what was the keymap for blame?” Type `blame`.
- `Space ss` — symbols in this Vue file: `props`, `emit`, `setup`, functions.
- `Space sS` — same, whole project.
- `Space sR` — reopen the last picker (you grepped, looked at a file, want the grep back).
- `Space st` — jump to `TODO:` / `FIXME:` comments.

---

## Flash (jumping)

`s` is **not** substitute. To change one character: `cl`.

**`s` — jump to something you can see**

```
The word "submit" is 40 lines down. Don't hold j.

s  → type su  → labels a, b, c appear on matches
   → type the label  → cursor is on submit
```

Works after operators too: `d` then `s` then jump → delete from here to there.

**`S` — jump to a syntax node**

In a Vue SFC, `S` labels `<template>`, functions, `if` blocks. Jump to the whole `onMounted(...)` call.

**`r` (after d/c/y)** — operate far away, stay here

Cursor in `setup()`. `d` `r` then flash to a word in the template → that word is deleted; you are still in `setup()`.

**`Ctrl-Space`** — expand selection: word → statement → function → whole `<script>` block. `Backspace` shrinks.

---

## Windows and terminal

Two splits: code left, terminal right.

- `Ctrl-h/j/k/l` — move between splits **and tmux panes**.
- `Space -` — split this window horizontally.
- `Space |` — split vertically.
- `Space wd` — close this split (file stays in a buffer).
- `Space wm` — this split fills the screen; again to restore.
- `Space T` **(custom)** — open/focus a **right** terminal. Run `pnpm dev` here.
- `Ctrl-/` — toggle LazyVim’s terminal (same key hides it from inside the terminal).
- `Space .` — scratch pad (throwaway notes; not a real file).

---

## LSP (go to things, rename, fix)

Cursor on `getUser` in `UserCard.vue`.

| Key | What happens |
| --- | --- |
| `gd` | Opens `api.ts` on `function getUser` |
| `gD` | TS: skip `.d.ts` types, go to your real source |
| `gr` | Picker: every `getUser(` call site |
| `gy` | Go to the *type* (`User`, not the function) |
| `gI` | Go to the class/interface that *implements* this |
| `gR` | TS: every file that imports *this file* |
| `K` | Popup with the signature and docstring |
| `Space cr` | Type the new name; every reference updates as you type |
| `Space cR` | Rename the *file* and fix imports |
| `Space ca` | List of fixes for this spot (import, eslint, extract…) |
| `Space co` | Sort / remove unused imports |
| `Space cf` | Format this file |
| `Space cn` | Insert a JSDoc / Python docstring stub above the function |
| `Space cs` | Outline sidebar: jump to `methods`, `computed`, headings |
| `Space cv` | Python: pick `.venv` so imports resolve |
| `Space cM` | TS: add all missing imports at once |
| `Space cD` | TS: apply all auto-fixable diagnostics in the file |

**Errors**

Red gutter on line 12 (`name` is possibly undefined).

- `]e` — jump to the next error.
- `Space cd` — float showing the full message.
- `Space xx` — list of every error in the project; Enter to jump.

---

## Git

You edited 8 lines in `UserCard.vue`. The gutter has a `▎` next to those lines (a **hunk**).

- `]h` / `[h` — next / previous hunk.
- `Space ghs` — stage *just this hunk* (`git add -p` without leaving nvim).
- Visual select 3 of the 8 lines, `Space ghs` — stage only those.
- `Space ghr` — throw away this hunk (back to HEAD).
- `Space ghp` — inline diff of the hunk.
- `dih` — delete the hunk (`ih` = “inside hunk”).
- `Space gbl` **(custom)** — toggle `aayush, 2 hours ago · fix padding` at end of line.
- `Space gg` — Lazygit: stage, commit message, push.
- `Space gB` — open this line on GitHub in the browser.
- `Space gY` — copy that GitHub URL.

---

## Editing

### Surround

| You type | Before | After |
| --- | --- | --- |
| `ysiw)` | `hello*` | `(hello)` |
| `ysiw(` | `hello*` | `( hello )` |
| `yss"` | `hello world*` | `"hello world"` |
| `ds"` | `"hello*"` | `hello` |
| `dst` / `Space dt` | `<p>hello*</p>` | `hello` |
| `dsf` | `Math.max*(1, 2)` | `1, 2` |
| `cs'"` | `'hello*'` | `"hello"` |
| `cstdiv` then Enter | `<span>hello*</span>` | `<div>hello</div>` |
| visual select + `S)` | `hello` selected | `(hello)` |

### Text objects

`d` / `c` / `y` / `v` + `i` (inside) or `a` (around).

```
function getUser(id) {
  return api.get(`/users/${id}`)
}

cif     → change inside function  (body emptied, still inside { })
daf     → delete whole function
cit     → change inside <div>…</div>
die     → change the camelCase piece: get*User → get|
dig     → delete entire file contents
ciu     → change the call: getUser(*) → you type new args
```

### Yanky (clipboard history)

You yanked `user`, then `id`, then `email`.

- `p` pastes `email`.
- `[y` cycles the paste to `id`, then `user`.
- `Space p` — picker of all recent yanks; pick `user`.
- `]p` — paste and match the indent of this nested block.

### Dial (`Ctrl-a` / `Ctrl-x`)

Cursor on the thing:

| Before | `Ctrl-a` |
| --- | --- |
| `true` | `false` |
| `let` | `const` |
| `#1b1e28` | next hex |
| `2024/01/31` | `2024/02/01` |
| `- [ ]` | `- [x]` |
| `## Title` | `### Title` |
| `1.1.2` in JSON | `1.1.3` |

Visual select `1 1 1` and `g Ctrl-a` → `1 2 3`.

On a Mac, **Control-a** increments; **Cmd-a** is select all.

### Comments and lines

```
gcc     → toggle comment on this line
gcip    → comment the inner paragraph / block
gco     → open a new commented line below (keep writing a note)
Alt-j   → this line swaps with the one below
```

### Visual wrap **(custom)**

Select `hello` in visual mode:

| Key | After |
| --- | --- |
| `Space i` | `*hello*` |
| `Space B` | `**hello**` |
| `Space "` | `"hello"` |
| `Space (` | `(hello)` |
| `Space {` | `{hello}` |
| `Space [` | `[hello]` |

---

## Harpoon (a tiny file list)

You keep bouncing between 3 files.

1. Open `UserCard.vue` → `Space H` (slot 1).
2. Open `useUser.ts` → `Space H` (slot 2).
3. Open `users.ts` → `Space H` (slot 3).
4. Anywhere: `Space 1` / `2` / `3` jumps.
5. `Space h` — menu to reorder or drop.

Unlike `Space Space`, you do not type a filename.

---

## Tests (`Space t…`)

Cursor inside `def test_login():` in Python.

- `Space tr` — run that test.
- `Space tt` — run the whole file.
- `Space tl` — run whatever you ran last (fix, hit this again).
- `Space ts` — tree of pass/fail.
- `Space to` — failure output.
- `Space tw` — re-run the file when it saves.
- `Space td` — run nearest test **under the debugger**.

Vue/TS: these keys exist, but you still need a vitest/jest adapter. Until then use `Space T` and run `pnpm test`.

---

## Debug (`Space d…`)

Red-gutter breakpoint on the line that crashes.

- `Space db` — toggle breakpoint on this line.
- `Space dB` — breakpoint only if `user is None`.
- `Space dc` — start / continue (like F5).
- `Space dO` — step over this line.
- `Space di` — step into `getUser()`.
- `Space do` — step out of this function.
- `Space du` — scopes / watches / stack UI.
- `Space de` on `user.name` (or visual select) — print that value.
- `Space dt` — stop the debug session.

---

## Markdown

- `Space cp` — live preview in the browser.
- Select a phrase, `Space B` → `**phrase**`.
- Cursor on `- [ ]`, `Ctrl-a` → `- [x]`.

---

## UI toggles (`Space u…`)

These are on/off, not “do a thing to the text”.

| Key | When you’d hit it |
| --- | --- |
| `Space uf` | This generated file should *not* auto-format on save |
| `Space ud` | Hide red squiggles for a minute |
| `Space uh` | Show/hide inline types (`: string`) |
| `Space uw` | Soft-wrap a long markdown line |
| `Space ut` | Sticky `function setup()` header while you scroll |
| `Space uz` | Zen: hide UI, one file |
| `Space ubl` | Hide the `author, 3 hours ago` at end of line **(custom)** |
| `Space uC` | Preview colorschemes |

---

## Sessions and quitting

You closed nvim with 6 files and 2 splits.

- Next day, `Space ql` — that layout comes back.
- `Space qs` — restore session for *this* folder.
- `Space qd` — quit without writing a session (one-off junk).
- `Space qq` — quit all.
- `Space l` — plugin manager. `Space cm` — install LSPs (Mason).

Lua config: `\ r` runs the current Lua file / selection.

---

## macOS **(custom)**

Cmd acts like Ctrl (`Cmd-s` saves, `Cmd-/` toggles terminal), except:

| Key | What |
| --- | --- |
| `Cmd-c` / `Cmd-v` / `Cmd-x` | Copy / paste / cut |
| `Cmd-z` / `Cmd-Shift-z` | Undo / redo |
| `Cmd-a` | Select all (not increment) |
