import {Unity, useUnityContext} from "react-unity-webgl";

function Game3() {
    const { unityProvider, sendMessage } = useUnityContext({
        loaderUrl: "/Game.loader.js",
        dataUrl: "/Game.data",
        frameworkUrl: "/Game.framework.js",
        codeUrl: "/Game.wasm",
    });

    let name: string = "Gabriel";
    function handleSceneStart() {
        sendMessage("SceneManager", "ReloadScene");
    }
    function sendName() {
        sendMessage("SceneManager", "ChangeText", name);
    }
    return (
        <>
            <div className="centered-container">
                <div className="centered-content">
                    <h1 className="centered-title">Game3</h1>
                    <Unity unityProvider={unityProvider} className="centered-unity" />

                    <div className="centered-content">
                        <button onClick={handleSceneStart}>Reload</button>
                        <button onClick={sendName}>Send Name</button>
                    </div>
                </div>
            </div>

        </>
    );
}


export default Game3