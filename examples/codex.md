# Uso Con Codex

## Opcion recomendada

Si quieres automatizar el arranque en Codex, puedes crear una task que lance `codex.exe` con el contenido de `agents/bootstrap.md` como prompt inicial.

## Idea base

- leer `agents/bootstrap.md`
- extraer el bloque `text`
- lanzar `codex.exe` con ese prompt inicial

## Nota

Esto abre una sesion nueva ya arrancada como Arquitecto. No convierte una conversacion ya abierta.
