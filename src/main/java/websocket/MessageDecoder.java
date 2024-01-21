package websocket;

import com.google.gson.Gson;
import jakarta.websocket.Decoder;
import jakarta.websocket.EndpointConfig;
import model.Message;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;


public class MessageDecoder implements Decoder.Text<Message>{
    private static final Logger LOGGER = LoggerFactory.getLogger(MessageDecoder.class);

    private static final Gson gson = new Gson();

    @Override
    public Message decode(String s) {
        return gson.fromJson(s, Message.class);
    }

    @Override
    public boolean willDecode(String s) {
        return (s != null);
    }

    @Override
    public void init(EndpointConfig endpointConfig) {
        LOGGER.info("Message decoder servlet was initialized");
    }

    @Override
    public void destroy() {
        LOGGER.info("Message decoder servlet was destroyed");
    }
}
/*
* Example of message,encoded with JSON
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