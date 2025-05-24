import { Unity, useUnityContext } from "react-unity-webgl";
import { useCallback, useEffect, useState } from "react";

function Game3(): JSX.Element {
    const [isGameOver, setIsGameOver] = useState<boolean>(false);
    const [userName, setUserName] = useState<string | undefined>(undefined);
    const [score, setScore] = useState<number | undefined>(undefined);
    const [name, setName] = useState("");

    const { unityProvider, sendMessage, addEventListener, removeEventListener } = useUnityContext({
        loaderUrl: "/BuildGame3.loader.js",
        dataUrl: "/BuildGame3.data",
        frameworkUrl: "/BuildGame3.framework.js",
        codeUrl: "/BuildGame3.wasm",
    });

    const handleGameOver = useCallback((...parameters: any[]): void => {
        const [userName, score] = parameters;
        if (typeof userName === "string" && typeof score === "number") {
            setIsGameOver(true);
            setUserName(userName);
            setScore(score);
        }
    }, []);

    useEffect(() => {
        addEventListener("GameOver", handleGameOver);
        return () => {
            removeEventListener("GameOver", handleGameOver);
        };
    }, [addEventListener, removeEventListener, handleGameOver]);

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

                    {isGameOver && (
                    <p>{`Game Over ${userName}! Has conseguido ${score} puntos.`}</p>
                )}
                </div>
            </div>
            );
}

export default Game3;