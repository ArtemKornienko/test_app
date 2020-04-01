// NOTE: The contents of this file will only be executed if
// you uncomment its entry in "web/static/js/app.js".

// To use Phoenix channels, the first step is to import Socket
// and connect at the socket path in "lib/my_app/endpoint.ex":
import {Socket} from "phoenix"

let socket = new Socket("/socket", {params: {token: window.userToken}})

// When you connect, you'll often need to authenticate the client.
// For example, imagine you have an authentication plug, `MyAuth`,
// which authenticates the session and assigns a `:current_user`.
// If the current user exists you can assign the user's token in
// the connection for use in the layout.
//
// In your "web/router.ex":
//
//     pipeline :browser do
//       ...
//       plug MyAuth
//       plug :put_user_token
//     end
//
//     defp put_user_token(conn, _) do
//       if current_user = conn.assigns[:current_user] do
//         token = Phoenix.Token.sign(conn, "user socket", current_user.id)
//         assign(conn, :user_token, token)
//       else
//         conn
//       end
//     end
//
// Now you need to pass this token to JavaScript. You can do so
// inside a script tag in "web/templates/layout/app.html.eex":
//
//     <script>window.userToken = "<%= assigns[:user_token] %>";</script>
//
// You will need to verify the user token in the "connect/2" function
// in "web/channels/user_socket.ex":
//
//     def connect(%{"token" => token}, socket) do
//       # max_age: 1209600 is equivalent to two weeks in seconds
//       case Phoenix.Token.verify(socket, "user socket", token, max_age: 1209600) do
//         {:ok, user_id} ->
//           {:ok, assign(socket, :user, user_id)}
//         {:error, reason} ->
//           :error
//       end
//     end
//
// Finally, pass the token on connect as below. Or remove it
// from connect if you don't care about authentication.

socket.connect()

let channel = socket.channel("example", {})

channel.join()
  .receive("ok", resp => { console.log("ok, join", resp) })
  .receive("error", resp => { console.log("Unable to join", resp) })
  
document.getElementById("inn_check_btn").addEventListener("click", e => {
  let now_date = '[' + (new Date()).getDate() + '.' + (new Date()).getMonth() + '.' + (new Date()).getFullYear() + ' ' + (new Date()).getHours() + ':' + (new Date()).getMinutes() + ']'
  let payload = {body: document.getElementById("inn_body").value, date: now_date}
  channel.push("new_inn", payload)
    .receive("error", e => console.log(e) )
})


channel.on("new_inn",  (resp) => {
  gen_row(resp)
 })

function gen_row(resp) {
  var inns_table = document.getElementById("inns_table");
  var row = inns_table.insertRow(0);
  var cell1 = row.insertCell(0);
  var cell2 = row.insertCell(1);
  var cell3 = row.insertCell(2);
  cell1.innerHTML = resp.date;
  cell2.innerHTML = resp.body;
  cell3.innerHTML = resp.check_result;
}

export default socket
