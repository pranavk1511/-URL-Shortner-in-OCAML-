# URL Shortener Service

This is a simple URL shortener service implemented in OCaml using the Opium web framework.

## Table of Contents

- [Features](#features)
- [Installation](#installation)
- [Usage](#usage)
- [Endpoints](#endpoints)
- [Dependencies](#dependencies)
- [License](#license)

## Features

- Shorten long URLs to a unique short URL.
- Redirect to the original URL using the short URL.

## Installation

1. Ensure you have OCaml and OPAM installed on your machine.
2. Install the Opium library using OPAM:

   ```bash
   opam install opium
   ```
## Usage
Run the compiled executable:

./url_shortener
The server will start on http://127.0.0.1:3000.

## Endpoints

### Shorten URL

- **Endpoint:** `POST /shorten`
- **Request Body:**
  ```json
  {
    "url": "original_url_here"
  }

- **Response:**
```json
{
  "short_url": "generated_short_url_here"
}

```

### Redirect to Original URL

- **Endpoint:** `GET /:short_url`
- **Response:**
  - Redirects to the original URL if the short URL is found.
  - Returns a `404 Not Found` response if the short URL is not found.

## Dependencies

- Opium: [https://opam.ocaml.org/packages/opium/](https://opam.ocaml.org/packages/opium/)
- Lwt: [https://opam.ocaml.org/packages/lwt/](https://opam.ocaml.org/packages/lwt/)

## License

This project is licensed under the MIT License.
