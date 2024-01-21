package websocket;

import com.google.gson.Gson;
import jakarta.websocket.Encoder;
import jakarta.websocket.EndpointConfig;
import model.Message;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public class MessageEncoder implements Encoder.Text<Message> {
    private static final Logger LOGGER = LoggerFactory.getLogger(MessageDecoder.class);

    private static final Gson gson = new Gson();

    @Override
    public String encode(Message message) {
        return gson.toJson(message);
    }

    @Override
    public void init(EndpointConfig endpointConfig) {
        LOGGER.info("Message encoder servlet was initialized");
    }

    @Override
    public void destroy() {
        LOGGER.info("Message encoder servlet was destroyed");
    }
}
