FROM tensorflow/syntaxnet:latest

COPY scripts/context.pbtxt /opt/tensorflow/syntaxnet/syntaxnet/models/parsey_mcparseface/
COPY scripts/process_documents.sh scripts/demo_first_only.sh scripts/demo_second_only.sh scripts/parser_eval.py /opt/tensorflow/syntaxnet/syntaxnet/

RUN mkdir /syntaxnet-input && \
    chmod 755 /opt/tensorflow/syntaxnet/syntaxnet/*.sh

CMD ["/opt/tensorflow/syntaxnet/syntaxnet/process_documents.sh"]

