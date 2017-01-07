DROP TABLE IF EXISTS products;
DROP TABLE IF EXISTS collections;

CREATE TABLE collections (
  id SERIAL8 primary key,
  name VARCHAR(255) not null
);

CREATE TABLE products (
  id SERIAL8 primary key,
  name VARCHAR(255) not null,
  type VARCHAR(255),
  price INT8,
  stock INT8,
  url VARCHAR(255),
  collection_id INT8 references collections(id) ON DELETE CASCADE
);
