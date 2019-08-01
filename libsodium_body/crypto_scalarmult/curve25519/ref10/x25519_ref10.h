#ifndef x25519_ref10_H
#define x25519_ref10_H

#include "crypto_scalarmult_curve25519.h"
#include "../scalarmult_curve25519.h"
#define fe_frombytes crypto_scalarmult_curve25519_sandy2x_fe_frombytes
extern struct crypto_scalarmult_curve25519_implementation
    crypto_scalarmult_curve25519_ref10_implementation;

#endif
