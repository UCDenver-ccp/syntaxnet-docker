# syntaxnet-docker
A Docker container set up to process a directory of sentences files using SyntaxNet

### Build the container
```bash
docker build -t ucdenverccp/syntaxnet:latest .
```

### Process a directory of files
Files are expected to contain sentences (one per line). To process a directory of files, map the directory on the host to the `/syntaxnet-input` directory in the container using the `--volume, -v` parameter.
```bash
docker run --rm -v /path/on/host/to/sentence/files/directory:/syntaxnet-input ucdenverccp/syntaxnet:latest
```

SyntaxNet output will be written to the same directory. Output files will be appended with the `.conll` suffix. 


