import {Socket} from "phoenix"

let socket = new Socket("/socket")
socket.connect()

let chatInput   = $(".chat-input")
let messages    = $(".messages")
let room_id     = chatInput.data("roomId")

let channel = socket.channel("rooms:" + room_id, {})

chatInput.on("keypress", event => {
  if (event.keyCode === 13){
    channel.push("sendMessage", {
      body: chatInput.val(),
      room_id: room_id
    })
    chatInput.val("")
    event.preventDefault()
  }
})

channel.on("receiveMessage", message => {
  messages.append(`<p>${message.body}</p>`)
})

channel.join()
  .receive("ok", resp => { console.log("Joined successfully", resp) })
  .receive("error", resp => { console.log("Unable to join", resp) })

export default socket
