;;;; Algol
(defvar algol-mode-hook nil)
(defvar algol-mode-map (make-keymap) "Keymap for algol-mode")

;;;###autoload
(add-to-list 'auto-mode-alist '("\\.a68\\'" . algol-mode))

(defconst *ident* "\\([a-z][a-z0-9 ]*\\)")
(defvar algol-mode-font-lock-keywords
  `((
	 ;; Comment
	 ("COMMENT \\(\\|.\\)*? COMMENT" . font-lock-comment-face)
	 ("CO \\(\\|.\\)*? CO" . font-lock-comment-face)

	 ;; Strings
	 ("[\"'$].*?[\"'$]" 0 font-lock-string-face t)

	 ;; GO TO label
	 (,(concat "\\<\\(GO TO\\|GOTO\\)\\>[[:space:]]+" *ident*) (1 font-lock-keyword-face) (2 font-lock-string-face))

	 ;; Function name
	 (,(concat "\\<\\(PROC\\)\\>[[:space:]]+" *ident*) (1 font-lock-string-face) (2 font-lock-function-name-face))
	 
	 ;; Keywords
	 ("\\<\\(IF\\|THEN\\|ELSE\\|ELIF\\|FI\\|FOR\\|FROM\\|BY\\|TO\\|UNTIL\\|WHILE\\|DO\\|OD\\|CASE\\|IN\\|OUT\\|OUSE\\|ESAC\\|TRUE\\|FALSE\\|EMPTY\\|NIL\\|PRAGMAT\\|BEGIN\\|END\\|GO TO\\|GOTO\\|EXIT\\|OF\\|SKIP\\|OP\\)\\>" . font-lock-keyword-face)

	 ;; Declaration symbols
 	 ("\\<\\(REF\\|STRUCT\\|UNION\\|PROC\\|FLEX\\|HEAP\\|LOC\\|LONG\\|SHORT\\)" . font-lock-string-face)

	 ;; Builtin types
 	 ("\\<\\(INT\\|REAL\\|COMPL\\|BOOL\\|CHAR\\|BITS\\|BYTES\\|STRING\\|FORMAT\\|FILE\\|CHANNEL\\|SEMA\\|VOID\\)" . font-lock-type-face)

 	 ;; Operators
	 ("\\<\\(MOD\\|EQ\\|NE\\|LT\\|GT\\|LE\\|GE\\|AND\\|OR\\|NOT\\|IS\\|ISNT\\|LWB\\|UPB\\|ABS\\|REPR\\|SORT\\|BIN\\|SHL\\|SHR\\)" . font-lock-keyword-face)

	 ;; Builtin functions
 	 ("\\(new line\\|die\\)" . font-lock-function-name-face)

	 ;; Type decls
 	 (,(concat "\\(MODE\\)[[:space:]]+" *ident*) (1 font-lock-keyword-face) (2 font-lock-type-face))

	 ;; Builtin identifiers
	 ("\\<\\(stand \\(error\\|draw\\|in\\|out\\|back\\)\\( channel\\)?\\)\\>" . font-lock-warning-face)

	 ;; Function calls
	 (,(concat *ident* "[[:space:]]*\\((\\)") (1 font-lock-function-name-face) (2 font-lock-keyword-face))

	 ;; Labels
	 ( "\\([a-z][a-z0-9 ]*[a-z0-9]+\\)\\(:\\) " (1 font-lock-string-face) (2 font-lock-keyword-face))

	 ;; Variables
	 (,*ident* . font-lock-variable-name-face)

	 ;; Numbers
	 ("\\_<[0-9][0-9a-fA-F]*\\_>" . font-lock-constant-face)

	 ;; Operators
	 ("\\[\\|\\]\\|\\*\\|[+-;=≠():<>|%÷]" . font-lock-keyword-face)
	 )))

(defvar algol-mode-syntax-table
  (make-syntax-table)
  "Syntax table for algol-mode")

;; The backslash is just a regular character in ALGOL.
(modify-syntax-entry
 ?\\ "."
 algol-mode-syntax-table)

(defun algol-indent-line () (insert "    "))

(define-derived-mode algol-mode fundamental-mode "ALGOL 68"
	"Major mode for editing algol rule files"
	(setq font-lock-defaults algol-mode-font-lock-keywords)
	(setq comment-start "CO")
	(setq comment-end "CO")
	(electric-indent-mode 0)
	(set (make-local-variable 'indent-line-function) 'algol-indent-line))

(provide 'algol-mode)
