open Opium
open Lwt.Infix

let storage = Hashtbl.create 10

let generate_short_url () =
  let characters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789" in
  let len = String.length characters in
  let generate_char () = characters.[Random.int len] in
  String.init 6 (fun _ -> generate_char ())

let shorten_url original_url =
  let short_url = generate_short_url () in
  Hashtbl.add storage short_url original_url;
  short_url

let redirect_handler req =
  let open Lwt.Syntax in
  let%lwt () = Lwt_unix.sleep 1.0 in  (* Simulate some processing time *)
  let short_url = param req "short_url" in
  match Hashtbl.find_opt storage short_url with
  | Some(original_url) ->
    let redirect_url = Uri.of_string original_url in
    let headers = Cohttp.Header.init_with "location" (Uri.to_string redirect_url) in
    respond ~headers ~status:`Moved_permanently ~body:`Empty ()
  | None ->
    respond ~status:`Not_found ~body:"Short URL not found" ()

let main_handler req =
  match App.param req "url" with
  | Some(original_url) ->
    let short_url = shorten_url original_url in
    respond ~body:(`String short_url) ()
  | None ->
    respond ~status:`Bad_request ~body:"Missing 'url' parameter" ()

let () =
  App.empty
  |> App.post "/shorten" main_handler
  |> App.get "/:short_url" redirect_handler
  |> App.run_command
