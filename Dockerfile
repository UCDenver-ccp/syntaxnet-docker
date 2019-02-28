FROM tensorflow/syntaxnet:latest

COPY scripts/context.pbtxt /opt/tensorflow/syntaxnet/syntaxnet/models/parsey_mcparseface/
COPY models/craft/brain_pos /opt/tensorflow/syntaxnet/syntaxnet/models/brain_pos/
COPY models/craft/brain_parser /opt/tensorflow/syntaxnet/syntaxnet/models/brain_parser/
COPY scripts/context1 /opt/tensorflow/syntaxnet/syntaxnet/models/brain_pos/greedy/128-0.08-3600-0.9-0/
COPY scripts/context2 /opt/tensorflow/syntaxnet/syntaxnet/models/brain_parser/structured/200x200-0.02-100-0.9-0/
COPY scripts/docker-entrypoint.sh scripts/demo_first_only.sh scripts/demo_second_only.sh scripts/parser_eval.py /opt/tensorflow/syntaxnet/syntaxnet/

RUN mkdir /syntaxnet-input && \
    chmod 755 /opt/tensorflow/syntaxnet/syntaxnet/*.sh

ENTRYPOINT ["/opt/tensorflow/syntaxnet/syntaxnet/docker-entrypoint.sh"]

