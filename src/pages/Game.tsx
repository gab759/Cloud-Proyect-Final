import { Unity, useUnityContext } from "react-unity-webgl";
import { useEffect, useState } from "react";

function Game() {
    const { unityProvider, sendMessage, unload } = useUnityContext({
        loaderUrl: "/BuildGame1.loader.js",
        dataUrl: "/BuildGame1.data",
        frameworkUrl: "/BuildGame1.framework.js",
        codeUrl: "/BuildGame1.wasm",
    });

    const [name, setName] = useState("");

    function sendName() {
        sendMessage("GameController", "ChangeText", name);
    }

    function handleSceneStart() {
        sendMessage("GameController", "ReloadScene");
    }

    // Apagar Unity al salir de la página o desmontar el componente
    useEffect(() => {
        return () => {
            unload(); // Detiene Unity y libera memoria
        };
    }, [unload]);

    return (
        <div className="centered-container">
            <div className="centered-content">
                <h1 className="centered-title">Game</h1>

                <Unity
                    unityProvider={unityProvider}
                    style={{
                        width: "960px",           // Resolución
                        height: "540px",
                        display: "block",
                        margin: "0 auto",
                    }}
                />

                <div className="centered-content">
                    <input
                        type="text"
                        value={name}
                        placeholder="Enter your name"
                        onChange={(e) => setName(e.target.value)}
                        onFocus={() => sendMessage("GameController", "DisableKeyboardInput")}
                        onBlur={() => sendMessage("GameController", "EnableKeyboardInput")}
                    />
                    <button onClick={sendName}>Send Name</button>
                    <button onClick={handleSceneStart}>Reload</button>
                </div>
            </div>
        </div>
    );
}

export default Game;