# Orbitask — TP Git et GitHub
## Équipe du projet
- Yassine Nasr
- Brahim Nait Mohand

Site vitrine statique utilisé pour le TP « de la pull request à la production ».

## Contenu
- `index.html`, `produit.html`, `tarifs.html`, `support.html`, `statut.html` : pages du site.
- `style.css` : mise en forme.
- `tests/verifier.sh` : tests automatiques.
- `.github/workflows/ci.yml` : tests sur chaque Pull Request et push sur `main`.
- `.github/workflows/deploy.yml` : déploiement GitHub Pages à chaque release publiée.

## Tester en local
Depuis le dossier du projet :

```bash
bash tests/verifier.sh
```

Résultat attendu : `Tous les tests Orbitask sont OK.`

Pour ouvrir le site, double-cliquez sur `index.html` ou utilisez l'extension Live Server de VS Code.

## Mise en place sur GitHub
1. Créez une organisation GitHub et un dépôt public `site-orbitask` depuis le modèle de l'enseignant si celui-ci est obligatoire.
2. Copiez les fichiers de ce projet dans le dépôt.
3. Dans **Settings → Pages**, choisissez **GitHub Actions** comme source.
4. Dans **Settings → Environments → github-pages**, autorisez les tags correspondant à `v*`.
5. Créez une branche, ajoutez les fichiers, puis ouvrez une Pull Request vers `main`.
6. Après fusion, créez une release avec le tag `v1.0.0` et le titre `v1.0.0 · Première version`.
7. Le workflow `Mise en production` déploie le site. Le numéro de release apparaît dans le pied de page.

## Protection de main
Dans **Settings → Rules → Rulesets**, créez une règle active ciblant la branche par défaut :
- Require a pull request before merging : 1 approbation.
- Require status checks to pass : `verifier`.
- Block force pushes.

Ne fusionnez jamais votre propre Pull Request. Une autre personne doit la relire et l'approuver.

## Releases et incident
- `v1.0.0` : première version.
- `v1.1.0` : release de la modification demandée par le marketing (incident simulé).
- `v1.1.1` : correctif après revert de l'incident.

Pour simuler l'incident du TP, changez temporairement la couleur du texte `.price` en blanc dans `style.css`, faites une PR relue, puis publiez `v1.1.0`. Les prix deviennent invisibles sur fond clair. Pour corriger, utilisez **Revert** sur la PR concernée, faites relire et fusionnez la PR de revert, puis publiez `v1.1.1`.

Le test bonus dans `tests/verifier.sh` détecte la couleur blanche sur les prix si elle est définie dans une règle CSS sous la forme `color: white` ou `color: #fff` / `#ffffff`.

## Versionnage sémantique
- Correctif (PATCH) : correction sans nouvelle fonctionnalité, par exemple `1.0.0 → 1.0.1`.
- Mineur (MINOR) : ajout compatible d'une fonctionnalité, par exemple `1.0.0 → 1.1.0`.
- Majeur (MAJOR) : changement incompatible, par exemple `1.0.0 → 2.0.0`.
