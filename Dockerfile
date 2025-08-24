
# syntax=docker/dockerfile:1.7-labs
FROM python:3.11-slim
WORKDIR /app
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt
COPY data ./data
COPY build_index_openai.py ./build_index_openai.py
COPY app.py ./app.py
COPY run.sh ./run.sh
ARG EMBED_MODEL=text-embedding-3-small
ENV MODEL=${EMBED_MODEL}
ARG OPENAI_API_KEY
ENV OPENAI_API_KEY=${OPENAI_API_KEY}
RUN python build_index_openai.py --chunks data/oasis_kb_chunks.csv --out_dir index_openai --model ${MODEL}
EXPOSE 8000
CMD ["./run.sh"]
