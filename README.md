## [👋 Mon Discord](https://discord.gg/56vvV4zt3F)

## Installation
- Ajoutez la ressource dans vos ressources
- Dans votre server.cfg -> ensure nsxInput

## Utilisation

```lua
exports['nsxInput']:viewInput(name, label, input, help, resultInput, cancelInput, textarea)
```
- **`name`** **[NECESSAIRE]** Un nom unique qui ne sera pas affiché (identifier de la dialogBox).
- **`label`** **[NECESSAIRE]** Le gros titre de votre input.
- **`input`** **[NECESSAIRE]** Le texte qui va servir d'exemple dans votre zone d'input (placeholder). Il peut être réglé sur "nil" si vous souhaitez le désactiver.
- **`help`** **[NECESSAIRE]** La Description de votre dialogBox
- **`submitFunc()`** **[NECESSAIRE]** La fonction lorsque vous validez le texte (touche ENTREE)
- **`cancelFunc()`** [OPTIONNEL] La fonction lorsque vous annulez votre texte (touche ECHAP)
- **`textarea`** [OPTIONNEL] [BOOLEAN] Si = à true, alors zone de texte étirable (long textes). Si = false, alors orienté textes courts.