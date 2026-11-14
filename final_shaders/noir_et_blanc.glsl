// Filtre noir et blanc pour F3D (option --final-shader)
// Exemple d'apprentissage : ne pas copier-coller dans une contribution (voir AI_POLICY.md).
//
// F3D appelle la fonction pixel() une fois pour CHAQUE pixel de l'image finale.
//   uv     : position du pixel, de (0,0) en bas a gauche a (1,1) en haut a droite
//   source : l'image deja rendue par F3D (une texture, qu'on lit avec texture())
// pixel() renvoie la couleur finale du pixel : vec4(rouge, vert, bleu, alpha), chaque valeur entre 0 et 1.

vec4 pixel(vec2 uv)
{
  // 1. Lire la couleur d'origine du pixel a cette position
  vec4 couleur = texture(source, uv);

  // 2. Calculer sa luminosite (un seul nombre entre 0 = noir et 1 = blanc).
  //    L'oeil est plus sensible au vert qu'au rouge, et bien moins au bleu :
  //    on fait donc une moyenne ponderee (poids standard Rec. 601) plutot que (r+g+b)/3.
  float gris = dot(couleur.rgb, vec3(0.299, 0.587, 0.114));

  // 3. Variante "noir et blanc pur" : decommente la ligne suivante.
  //    step(seuil, gris) vaut 0.0 si gris < seuil, sinon 1.0 -> chaque pixel devient tout noir ou tout blanc.
  //    Le seuil depend de la scene : les rendus F3D sont plutot sombres, 0.5 donne une image presque
  //    toute noire, 0.3 marche bien sur WaterBottle.glb. Essaie plusieurs valeurs !
  // gris = step(0.3, gris);

  // 4. Mettre la meme valeur dans rouge, vert et bleu = du gris. On garde l'alpha d'origine.
  return vec4(vec3(gris), couleur.a);
}
