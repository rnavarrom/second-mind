CREATE SCHEMA IF NOT EXISTS secondmind;

CREATE EXTENSION IF NOT EXISTS vector;

CREATE TYPE secondmind.document_type AS ENUM ('pdf',
'txt');
CREATE TYPE secondmind.message_type AS ENUM ('human',
'llm');

CREATE TABLE IF NOT EXISTS secondmind.chat (
	chat_id serial PRIMARY KEY,
	title TEXT,
	created TIMESTAMPTZ NOT NULL DEFAULT now(),
	last_access TIMESTAMPTZ NOT NULL
);

CREATE TABLE IF NOT EXISTS secondmind.document (
	document_id serial PRIMARY KEY,
	title TEXT NOT NULL,
	author TEXT NOT NULL,
	created_at TIMESTAMPTZ NOT NULL DEFAULT now(),
	document_type secondmind.document_type NOT NULL
);

CREATE TABLE IF NOT EXISTS secondmind.chat_document(
	chat_id INTEGER NOT NULL REFERENCES secondmind.chat(chat_id),
	document_id INTEGER NOT NULL REFERENCES secondmind.document(document_id),
	PRIMARY KEY(chat_id, document_id)
);

CREATE TABLE IF NOT EXISTS secondmind.chunk (
	chunk_id serial PRIMARY KEY,
	chunk_index INTEGER NOT NULL,
	text TEXT NOT NULL,
	tokens INTEGER NOT NULL,
	embedding VECTOR(384),
	document_id INTEGER NOT NULL REFERENCES secondmind.document(document_id),
	UNIQUE(document_id, chunk_index)
);

CREATE TABLE IF NOT EXISTS secondmind.message (
	message_id serial PRIMARY KEY,
	message_index INTEGER NOT NULL,
	created_at TIMESTAMP NOT NULL,
	text TEXT NOT NULL,
	tokens INTEGER NOT NULL,
	message_type secondmind.message_type NOT NULL,
	chat_id INTEGER NOT NULL REFERENCES secondmind.chat(chat_id) NOT NULL,
	UNIQUE(chat_id, message_index)
);