package websocket;

import com.google.gson.Gson;
import jakarta.websocket.Decoder;
import jakarta.websocket.EndpointConfig;
import model.Message;



public class MessageDecoder implements Decoder.Text<Message>{

    private static final Gson gson = new Gson();

    @Override
    public Message decode(String s) {
        Message message = gson.fromJson(s, Message.class);
        return message;
    }

    @Override
    public boolean willDecode(String s) {
        return (s != null);
    }

    @Override
    public void init(EndpointConfig endpointConfig) {
        // Custom initialization logic
    }

    @Override
    public void destroy() {
        // Close resources
    }
}
/*
* {
*   "from": "name",
*   "to": "name"
*   "content": {
*     "message_theme": "text",
*     "message_content": "text"
*     }
* }
*
* */