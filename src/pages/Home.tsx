import MainBanner from "../common/MainBanner.tsx";
import banner4 from "../assets/images/banner4.jpg";

function Home() {
    return (
        <>
            <MainBanner />
            <div style={{
                display: 'flex',
                flexDirection: 'column',
                alignItems: 'center',
                justifyContent: 'center',
                backgroundColor: '#f4f4f4',
                padding: '20px',
                borderRadius: '10px',
                maxWidth: '500px',
                margin: '20px auto',
            }}>
                <h2 style={{ color: '#333', marginBottom: '10px' }}>Sobre mí</h2>
                <img 
                    src={banner4} 
                    className="d-block w-100" 
                    style={{ borderRadius: '10px', marginBottom: '10px' }} 
                />
                <p><strong>Nombres:</strong> Gabriel Eduardo</p>
                <p><strong>Apellidos:</strong> Cordova Estrella</p>
                <p><strong>Edad:</strong> 18 años</p>
                <p><strong>Carrera:</strong> Diseño y Desarrollo de Simuladores y Videojuegos</p>
            </div>
        </>
    );
}

export default Home;