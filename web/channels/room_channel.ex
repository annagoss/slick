defmodule Slick.RoomChannel do
  use Slick.Web, :channel

  require Logger
  # let's add an alias so i don't keep having to type slick.message all the time

  alias Slick.Message

# first thing we want to do is join a channel
# we don't care who is connecting at the moment
# this is always called join
# first thing is the name of the channel
# second thing is any extra info about this channel
def join("rooms:" <> _room_id, payload, socket) do


  # this is where we'd authenticate our user
  # to stop connections we'd use {:error, socket}
  {:ok, socket}

end

# we also want to handle someone sending a message
# when a user sends a message to the server,
# send that message to everyone connected
# handle_in is the way we handle incoming messages
# first part is the message name (it's in the js)
# second part is the info that's sent with it - or the payload
# third part is the websocket itself
def handle_in("sendMessage", payload, socket) do

  # let's save this to the db
  # first thing is to make a blank message
  # then use the data from the payload
  # and save to the repo / database
  %Message{}
  |> Message.changeset(payload)
  |> Slick.Repo.insert

  # send this message to everyone else
  # we're going to use the broadcast! function
  broadcast!(socket, "receiveMessage", payload)

  # tell the socket we've finished
  {:noreply, socket}
end



# we also want to handle people receiving messages
# all we need to do is push that message to that user
def handle_in("receiveMessage", payload, socket) do

# we don't want to filter out the message
# but if we did, this is where we'd do it

# send all the messages filtered using push
push(socket, "receiveMessage", payload)



# let the socket know I'm done
{:noreply, socket}

end

end
