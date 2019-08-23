# Libsodium_binding

The repository contains:

   - The project file libsodium.gpr.

   - The librairy directory lib.

   - The common directory which contains:

        - The libsodium_binding package, a low-level binding in Ada made from the files generated using the Ada spec dump compiler.

        - The libsodium_interface package, a higher level binding in SPARK which uses libsodium_binding.

   - include , a directory which holds the headers of libsodium.

   - libsodium_body, a directory which holds the bodies.

   - outside_src, a directory which holds the headers that were removed from include, to fix a problem of double definition.

   - thin_binding, a directory which holds the binding generated using the Ada spec dump compiler.

   - The test directory which holds tests for each group of functions.

   - A testsuite which verifies the same tests as the ones in the test directory.

   - The examples directory, with examples that use different groups of programs together. It also holds a program where a Nonce is used twice, and as expected it fails at proof stage.

outside_src and thin_binding are not used for the binding, but I let them in the repository because it shows what I changed from the original libsodium sources and the Ada generated binding.

This project is a library project so directory lib is the only thing necessary.

For more information, consult the blog post "Secure use of cryptographic libraries: spark binding for libsodium" on blog.adacore.com (September 2019), and Libsodium documentation: https://libsodium.gitbook.io/doc/
