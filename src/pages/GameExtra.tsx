import React from 'react';

const GameExtra: React.FC = () => {
    return (
      <div style={{
        display: 'flex',
        justifyContent: 'center',
        alignItems: 'center',
        height: '100vh' // Ocupa toda la altura de la ventana
      }}>
        <div style={{ position: 'relative', width: '50%', paddingBottom: '50%' }}>
          <iframe
            src="/Construct/index.html"
            title="Construct 2 Game"
            style={{
              position: 'absolute',
              top: 0,
              left: 0,
              width: '100%',
              height: '100%',
              border: 'none',
            }}
            allowFullScreen
          />
        </div>
      </div>
    );
  };
  
  export default GameExtra;