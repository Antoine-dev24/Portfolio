# Flutter : équivalents Bootstrap

| Flutter | Bootstrap |
|---|---|
| `Row` | `d-flex flex-nowrap` |
| `Column` | `d-flex flex-column` |
| `Wrap` | `d-flex flex-wrap` |
| `Expanded` | `flex-grow-1` |
| `ConstrainedBox` | `style="max-width: …"` (`min-width`, `min-height`, `max-height` aussi) |

## ConstrainedBox

Bootstrap n'a pas de classe pour une taille limite au choix : seuls `mw-100` et `mh-100` existent, et ils limitent à 100 % du parent. Pour une valeur précise, il faut passer par du CSS.

```dart
ConstrainedBox(
  constraints: const BoxConstraints(maxWidth: 720),
  child: Text(experience.title),
)
```

```html
<div style="max-width: 720px">
  <span>Titre du poste</span>
</div>
```
