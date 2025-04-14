import {Unity, useUnityContext} from "react-unity-webgl";

function Game3() {
    const { unityProvider } = useUnityContext({
        loaderUrl: "/Game.loader.js",
        dataUrl: "/Game.data",
        frameworkUrl: "/Game.framework.js",
        codeUrl: "/Game.wasm",
    });



    return (
        <>
            <div className="centered-container">
                <div className="centered-content">
                    <h1 className="centered-title">Game3</h1>
                    <Unity unityProvider={unityProvider} className="centered-unity" />


                </div>
            </div>

        </>
    );
}


export default Game3