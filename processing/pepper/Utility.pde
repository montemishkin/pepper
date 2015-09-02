/* Notes:
 *
 */


// the right kind of modulo
int mod(float n, float m) {
  return int(n) - (int(m) * floor(n / m));
}


