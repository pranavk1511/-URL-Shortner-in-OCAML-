# Use an official OCaml image as a base
FROM ocaml/opam2:alpine

# Set the working directory in the container
WORKDIR /app

# Copy the Opium OCaml application source code to the container
COPY . .

# Install dependencies using opam
RUN opam install -y opium lwt

# Build the OCaml application
RUN dune build

# Expose the port that Opium will listen on
EXPOSE 3000

# Define the command to run the application
CMD ["_build/default/url_shortener.exe"]
