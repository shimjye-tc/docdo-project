# docdo-project
docdo-fm: Document do FreeMarker - BETA - Data is not safe!!!

### Introduce
- I Can't find the 2-phase generator. So, This is it.(AS-IS: template-content-result(3-phase) / THIS: template-result(content is included in result by comment))
- The docdo-fm means "Document(comment) do FreeMarker".
- Dokdo is beautiful Island of Korean. (https://dokdo.mofa.go.kr/eng)
- FreeMarker-base-file-generator
- FreeMarker-wrapping-for-magical-comment
- Code snippet management and rapid develop tool.

### Design
- IDE works by external-tool(shell-script/docdoc.sh).
- open-api (not friendly)
- source-keyword $docdo-src-start, $docdo-src-end, $docdo-src-gen
  - $docdo-ss={"id":"input", "as":"alias", "from":"as-value", to="out-file"}, $docdo-se, $docdo-sg
- template-keyword $docdo-ftl-start, $docdo-ftl-end
  - $docdo-ts={"id":"input"}, $docdo-te

### Working with freemarker
- src/test/java/com/sootnoon/docdo/example (Source, Template)
- https://freemarker.apache.org/ (for Template)


# tool

## docdoc
- docdo-client
- /src/resources/tool/docdoc.sh

### Summary
- Api call to docdo-freemarker-webapp-server
- Single file process.

### Run docdoc
- require jq
  - install-jq https://stedolan.github.io/jq/download/
  - $ brew install jq
- set value - hard-coding or environment
  - Token generates by web application.
  ```
  token="d1-76f9a278053739d15e828ff387ab84186..."
  backup_path="$(eval echo "~")/data/developer/docdo-bak/$(date +'%Y%m%d%H%M%S')"
  ```
- cmd run
  - $ docdoc.sh gen PROFILE-ID PROJECT-NAME FILE-PATH
  - run $ docdoc.sh gen 1001 dokdo test-file.java

### Run docdoc with IDE
- intellij external tool
  - setting > tools > external tools
  ```
  program: docdoc.sh
  arguments: gen 1001(PROFILE-ID) dokdo(PROJECT-NAME) $FilePath$
  ```
- vscode external tool https://marketplace.visualstudio.com/items?itemName=lihui.vs-external-tools
  ```
  "vs-external-tools.externalCommand1.command": "docdoc.sh",
  "vs-external-tools.externalCommand1.args": ["gen", "1001(PROFILE-ID)", "dokdo(PROJECT-NAME)", "$(ItemPath)"]
  ```
- visual studio community 2019 for Mac
  ```
  command: docdoc.sh
  arguments: gen 1001(PROFILE-ID) dokdo(PROJECT-NAME) ${FileDir}/${FilePath}
  ```
- eclipse external tool
  ```
  run: docdoc.sh
  work-dir: ${project_loc}
  args: gen 1001(PROFILE-ID) dokdo(PROJECT-NAME) ${selected_resource_loc}
  ```
- make a run-external-tool shortcut (ex: cmd+shift+f11.)

### Try docdo-client to docdo-freemarker-server
- 0: run docdoc with template-file.
- 1: run docdoc with source-file.
- 2: repeatable for work.
