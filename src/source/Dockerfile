FROM python:3.11


RUN useradd -ms /bin/bash admin
WORKDIR /load/

# Install Poetry
RUN curl -sSL https://install.python-poetry.org | POETRY_HOME=/opt/poetry python && \
    cd /usr/local/bin && \
    ln -s /opt/poetry/bin/poetry && \
    poetry config virtualenvs.create false

# ^^^
# Make sure to update it!

# Copy poetry.lock* in case it doesn't exist in the repo
COPY ./pyproject.toml ./poetry.lock* /load/


# Allow installing dev dependencies to run tests
ARG INSTALL_DEV=false
RUN bash -c "if [ $INSTALL_DEV == 'true' ] ; then poetry install --no-root ; else poetry install --no-root --only main ; fi"

ENV PYTHONPATH=/load

COPY ./prestart.sh /load/

COPY ./load /load/load

RUN chown -R admin:admin /load
RUN chmod 755 /load
USER admin
