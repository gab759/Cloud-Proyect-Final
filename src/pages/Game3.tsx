import { Unity, useUnityContext } from "react-unity-webgl";
import { useState } from "react";

function Game3() {
    const { unityProvider, sendMessage } = useUnityContext({
        loaderUrl: "/Game.loader.js",
        dataUrl: "/Game.data",
        frameworkUrl: "/Game.framework.js",
        codeUrl: "/Game.wasm",
    });

    const [name, setName] = useState("");

    function handleSceneStart() {
        sendMessage("SceneManager", "ReloadScene");
    }

    function sendName() {
        sendMessage("SceneManager", "ChangeText", name);
    }

    return (
        <div className="centered-container">
            <div className="centered-content">
                <h1 className="centered-title">Game3</h1>
                <Unity unityProvider={unityProvider} className="centered-unity" />

                <div className="centered-content">
                    <input
                        type="text"
                        value={name}
                        onChange={(e) => setName(e.target.value)}
                        placeholder="Enter your name"
                    />
                    <button onClick={sendName}>Send Name</button>
                    <button onClick={handleSceneStart}>Reload</button>
                </div>
            </div>
        </div>
    );
}

export default Game3;