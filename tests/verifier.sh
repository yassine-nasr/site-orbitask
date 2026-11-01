#!/usr/bin/env bash
set -euo pipefail

fail() { echo "ERREUR: $1"; exit 1; }
for file in index.html produit.html tarifs.html support.html statut.html style.css; do
  [ -f "$file" ] || fail "Fichier manquant: $file"
done

for file in index.html produit.html tarifs.html support.html statut.html; do
  grep -q '<!doctype html>' "$file" || fail "$file ne contient pas le doctype HTML"
  grep -q 'style.css' "$file" || fail "$file ne charge pas style.css"
  grep -q '__VERSION__' "$file" || fail "$file ne contient pas le marqueur de version"
  grep -q 'href="statut.html"' "$file" || fail "Le menu de $file ne contient pas Statut"
done

grep -q 'Tous les services sont opérationnels' statut.html || fail "Texte de statut absent"
grep -q '80 €' tarifs.html || fail "Offre Équipe annuelle absente"
grep -q 'par utilisateur et par an' tarifs.html || fail "Précision de l'offre Équipe absente"
grep -q '01 23 45 67 89' support.html || fail "Téléphone d'astreinte absent"
grep -q '24 h/24' support.html || fail "Disponibilité de l'astreinte absente"
grep -q 'Rapports' produit.html || fail "Fonctionnalité Rapports absente"
grep -q 'Essayer gratuitement' produit.html || fail "Bouton d'essai absent"
grep -q 'href="tarifs.html"' produit.html || fail "Le bouton d'essai ne mène pas aux tarifs"

# Règle bonus : la couleur des prix ne doit pas être blanche.
if grep -A2 -E '^\\.price[[:space:]]*\\{' style.css | grep -Eiq 'color[[:space:]]*:[[:space:]]*(#fff(fff)?|white)([;[:space:]]|$)'; then
  fail "Le prix ne doit pas être blanc sur le fond clair"
fi

echo "Tous les tests Orbitask sont OK."
