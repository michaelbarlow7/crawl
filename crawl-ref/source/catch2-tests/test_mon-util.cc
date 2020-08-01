#include "catch.hpp"

#include "AppHdr.h"

#include "mon-util.h"

TEST_CASE("mons_is_removed() returns correct values", "[single-file]" ) {

    init_monsters();

    SECTION ("mons_is_removed() returns true for removed monster") {
        bool removed = mons_is_removed(MONS_BUMBLEBEE);

        REQUIRE(removed == true);
    }

    SECTION ("mons_is_removed() returns false for current monster") {
        bool removed = mons_is_removed(MONS_BUTTERFLY);

        REQUIRE(removed == false);
    }
}

TEST_CASE("can get names for removed monster types", "[single-file]" ) {
    const auto name = mons_type_name(MONS_BUMBLEBEE, DESC_PLAIN);

    REQUIRE(name == "removed bumblebee");
}
