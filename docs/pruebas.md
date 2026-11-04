Comprobado que el juego se compila con exito, a dia 06/10/2026 en windows 11 26h2

# Practica UT 2.3
* **Prueba:** Interacción con el objetivo.
* **Fallo:** Con `interaction_radius = 5.0`, al pulsar la tecla cerca del objetivo no sumaba puntos por ser un radio muy pequeño.
* **Solución:** Se cambió el valor de `interaction_radius` a `48.0` en el Inspector de `Main`.
* **Resultado:** Al pulsar la tecla cerca del objetivo suma 1 punto y el objetivo cambia de sitio correctamente.
