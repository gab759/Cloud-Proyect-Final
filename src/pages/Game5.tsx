import { Unity, useUnityContext } from "react-unity-webgl";
import { useEffect, useState } from "react";

function Game5() {
    const { unityProvider, sendMessage, unload } = useUnityContext({
        loaderUrl: "/BuildGame5.loader.js",
        dataUrl: "/BuildGame5.data",
        frameworkUrl: "/BuildGame5.framework.js",
        codeUrl: "/BuildGame5.wasm",
    });

    const [name, setName] = useState("");

    function sendName() {
        sendMessage("GameManager", "ChangeText", name);
    }

    function handleSceneStart() {
        sendMessage("GameManager", "ReloadScene");
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
                <h1 className="centered-title">Game5</h1>

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
                        onFocus={() => sendMessage("GameManager", "DisableKeyboardInput")}
                        onBlur={() => sendMessage("GameManager", "EnableKeyboardInput")}
                    />
                    <button onClick={sendName}>Send Name</button>
                    <button onClick={handleSceneStart}>Reload</button>
                </div>
            </div>
        </div>
    );
}

export default Game5;