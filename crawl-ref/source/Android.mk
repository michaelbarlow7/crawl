LOCAL_PATH := $(call my-dir)

#####################################################################
# build sqlite3                                          
# as per instructions here http://www.roman10.net/how-to-compile-sqlite-for-android-using-ndk/
#####################################################################
include $(CLEAR_VARS)
SQLITE_DIR := contrib/sqlite
LOCAL_C_INCLUDES := $(LOCAL_PATH)/$(SQLITE_DIR)
LOCAL_MODULE:=sqlite3
LOCAL_SRC_FILES:=$(SQLITE_DIR)/sqlite3.c
include $(BUILD_STATIC_LIBRARY)
#####################################################################
# build lua	
#####################################################################
include $(CLEAR_VARS)
LUA_DIR := contrib/lua/src
LOCAL_ARM_MODE  := arm
LOCAL_MODULE    := lua
LOCAL_C_INCLUDES := $(LOCAL_PATH)/$(LUA_DIR)
LOCAL_SRC_FILES := $(LUA_DIR)/lapi.c \
	$(LUA_DIR)/lauxlib.c \
	$(LUA_DIR)/lbaselib.c \
	$(LUA_DIR)/lcode.c \
	$(LUA_DIR)/ldblib.c \
	$(LUA_DIR)/ldebug.c \
	$(LUA_DIR)/ldo.c \
	$(LUA_DIR)/ldump.c \
	$(LUA_DIR)/lfunc.c \
	$(LUA_DIR)/lgc.c \
	$(LUA_DIR)/linit.c \
	$(LUA_DIR)/liolib.c \
	$(LUA_DIR)/llex.c \
	$(LUA_DIR)/lmathlib.c \
	$(LUA_DIR)/lmem.c \
	$(LUA_DIR)/loadlib.c \
	$(LUA_DIR)/lobject.c \
	$(LUA_DIR)/lopcodes.c \
	$(LUA_DIR)/loslib.c \
	$(LUA_DIR)/lparser.c \
	$(LUA_DIR)/lstate.c \
	$(LUA_DIR)/lstring.c \
	$(LUA_DIR)/lstrlib.c \
	$(LUA_DIR)/ltable.c \
	$(LUA_DIR)/ltablib.c \
	$(LUA_DIR)/ltm.c \
	$(LUA_DIR)/lundump.c \
	$(LUA_DIR)/lvm.c \
	$(LUA_DIR)/lzio.c \
	$(LUA_DIR)/print.c
 
include $(BUILD_STATIC_LIBRARY)
#include $(BUILD_SHARED_LIBRARY)

#####################################################################
#            start building app                                     #
#####################################################################
include $(CLEAR_VARS)
RLTILES_DIR := rltiles

# Crawl files are in .cc format
LOCAL_CPP_EXTENSION=.cc
# Need to include the rtiles folder, sqlite, lua and curses
LOCAL_C_INCLUDES := $(LOCAL_PATH)/rltiles \
$(LOCAL_PATH)/rltiles/tool \
$(LOCAL_PATH)/prebuilt \
$(LOCAL_PATH)/$(SQLITE_DIR) \
$(LOCAL_PATH)/$(LUA_DIR) \
$(LOCAL_PATH)/curses
# Loading the sqlite and lua libraries
LOCAL_STATIC_LIBRARIES:=libsqlite3 liblua
# loading zlib and logging functions
LOCAL_LDLIBS := -lz -llog

# These flags are on by default in the original Makefile (-fsigned-char needed to guard against segfaults)
LOCAL_CFLAGS += -DCLUA_BINDINGS -DWIZARD -DASSERTS -fsigned-char

# This is basically all the .cc files in the 'source' folder
CRAWLSRC = ability.cc \
	abyss.cc \
	acquire.cc \
	act-iter.cc \
	actor.cc \
	actor-los.cc \
	adjust.cc \
	AppHdr.cc \
	areas.cc \
	arena.cc \
	artefact.cc \
	attack.cc \
	attitude-change.cc \
	beam.cc \
	behold.cc \
	bitary.cc \
	bloodspatter.cc \
	branch.cc \
	butcher.cc \
	chardump.cc \
	cio.cc \
	cloud.cc \
	clua.cc \
	cluautil.cc \
	colour.cc \
	command.cc \
	coord.cc \
	coord-circle.cc \
	coordit.cc \
	crash.cc \
	ctest.cc \
	dactions.cc \
	database.cc \
	dbg-asrt.cc \
	dbg-maps.cc \
	dbg-scan.cc \
	dbg-util.cc \
	decks.cc \
	delay.cc \
	describe.cc \
	describe-god.cc \
	describe-spells.cc \
	dgl-message.cc \
	dgn-delve.cc \
	dgn-event.cc \
	dgn-height.cc \
	dgn-layouts.cc \
	dgn-overview.cc \
	dgn-proclayouts.cc \
	dgn-shoals.cc \
	dgn-swamp.cc \
	directn.cc \
	dlua.cc \
	domino.cc \
	dungeon.cc \
	end.cc \
	english.cc \
	errors.cc \
	evoke.cc \
	exclude.cc \
	exercise.cc \
	fearmonger.cc \
	feature.cc \
	fight.cc \
	files.cc \
	fineff.cc \
	fontwrapper-ft.cc \
	food.cc \
	format.cc \
	fprop.cc \
	game-options.cc \
	geom2d.cc \
	ghost.cc \
	glwrapper.cc \
	glwrapper-ogl.cc \
	god-abil.cc \
	god-blessing.cc \
	god-companions.cc \
	god-conduct.cc \
	god-item.cc \
	god-menu.cc \
	god-passive.cc \
	god-prayer.cc \
	god-wrath.cc \
	hash.cc \
	hints.cc \
	hiscores.cc \
	initfile.cc \
	invent.cc \
	item-name.cc \
	item-prop.cc \
	item-use.cc \
	items.cc \
	jobs.cc \
	json.cc \
	kills.cc \
	l-colour.cc \
	l-crawl.cc \
	l-debug.cc \
	l-dgn.cc \
	l-dgnbld.cc \
	l-dgnevt.cc \
	l-dgngrd.cc \
	l-dgnit.cc \
	l-dgnlvl.cc \
	l-dgnmon.cc \
	l-dgntil.cc \
	l-feat.cc \
	l-file.cc \
	l-food.cc \
	l-global.cc \
	l-item.cc \
	l-los.cc \
	l-mapgrd.cc \
	l-mapmrk.cc \
	l-moninf.cc \
	l-mons.cc \
	l-option.cc \
	l-spells.cc \
	l-subvault.cc \
	l-travel.cc \
	l-view.cc \
	l-wiz.cc \
	l-you.cc \
	lang-fake.cc \
	lev-pand.cc \
	libgui.cc \
	libutil.cc \
	libandroid.cc \
	loading-screen.cc \
	los.cc \
	los-def.cc \
	losglobal.cc \
	losparam.cc \
	lookup-help.cc \
	luaterp.cc \
	macro.cc \
	main.cc \
	makeitem.cc \
	mapdef.cc \
	map-knowledge.cc \
	mapmark.cc \
	maps.cc \
	melee-attack.cc \
	menu.cc \
	message.cc \
	message-stream.cc \
	misc.cc \
	mon-abil.cc \
	mon-act.cc \
	mon-behv.cc \
	mon-cast.cc \
	mon-clone.cc \
	mon-death.cc \
	mon-ench.cc \
	mon-gear.cc \
	mon-grow.cc \
	mon-info.cc \
	mon-movetarget.cc \
	mon-pathfind.cc \
	mon-pick.cc \
	mon-place.cc \
	mon-poly.cc \
	mon-project.cc \
	mon-speak.cc \
	mon-tentacle.cc \
	monster.cc \
	mon-transit.cc \
	mon-util.cc \
	movement.cc \
	mutation.cc \
	nearby-danger.cc \
	newgame.cc \
	ng-init.cc \
	ng-input.cc \
	ng-restr.cc \
	ng-setup.cc \
	ng-wanderer.cc \
	notes.cc \
	orb.cc \
	ouch.cc \
	outer-menu.cc \
	output.cc \
	package.cc \
	pattern.cc \
	pcg.cc \
	perlin.cc \
	place.cc \
	place-info.cc \
	playable.cc \
	player-act.cc \
	player.cc \
	player-equip.cc \
	player-reacts.cc \
	player-stats.cc \
	potion.cc \
	prompt.cc \
	quiver.cc \
	randbook.cc \
	random.cc \
	random-var.cc \
	ranged-attack.cc \
	ray.cc \
	religion.cc \
	rot.cc \
	scroller.cc \
	shopping.cc \
	shout.cc \
	show.cc \
	showsymb.cc \
	skill-menu.cc \
	skills.cc \
	sound.cc \
	species.cc \
	spl-book.cc \
	spl-cast.cc \
	spl-clouds.cc \
	spl-damage.cc \
	spl-goditem.cc \
	spl-miscast.cc \
	spl-monench.cc \
	spl-other.cc \
	spl-pick.cc \
	spl-selfench.cc \
	spl-summoning.cc \
	spl-tornado.cc \
	spl-transloc.cc \
	spl-util.cc \
	spl-wpnench.cc \
	spl-zap.cc \
	sprint.cc \
	sqldbm.cc \
	stairs.cc \
	startup.cc \
	stash.cc \
	state.cc \
	status.cc \
	stepdown.cc \
	store.cc \
	stringutil.cc \
	syscalls.cc \
	tags.cc \
	target.cc \
	teleport.cc \
	terrain.cc \
	throw.cc \
	tilebuf.cc \
	tilefont.cc \
	tilepick.cc \
	tiletex.cc \
	tileview.cc \
	tileweb.cc \
	tileweb-text.cc \
	timed-effects.cc \
	transform.cc \
	traps.cc \
	travel.cc \
	tutorial.cc \
	ui.cc \
	uncancel.cc \
	unicode.cc \
	version.cc \
	view.cc \
	viewchar.cc \
	viewgeom.cc \
	viewmap.cc \
	wcwidth.cc \
	windowmanager-sdl.cc \
	wizard.cc \
	wiz-dgn.cc \
	wiz-dump.cc \
	wiz-fsim.cc \
	wiz-item.cc \
	wiz-mon.cc \
	wiz-you.cc \
	worley.cc \
	xom.cc \
	dgn-irregular-box.cc \
\
$(RLTILES_DIR)/tiledef-dngn.cc  $(RLTILES_DIR)/tiledef-feat.cc  $(RLTILES_DIR)/tiledef-floor.cc  \
$(RLTILES_DIR)/tiledef-gui.cc  $(RLTILES_DIR)/tiledef-icons.cc  $(RLTILES_DIR)/tiledef-main.cc  \
$(RLTILES_DIR)/tiledef-player.cc  $(RLTILES_DIR)/tiledef-unrand.cc  $(RLTILES_DIR)/tiledef-wall.cc \
\
prebuilt/levcomp.lex.cc prebuilt/levcomp.tab.cc \

#Removed from above
# libunix.cc changed to libandroid.cc
# tilecell.cc tiledgnbuf.cc
# tiledoll.cc tilemcache.cc tilepick-p.cc tilereg.cc tilereg-abl.cc tilereg-cmd.cc\
# tilereg-crt.cc tilereg-dgn.cc tilereg-doll.cc tilereg-grid.cc tilereg-inv.cc \
# tilereg-map.cc tilereg-mem.cc tilereg-menu.cc tilereg-mon.cc tilereg-msg.cc \
# tilereg-skl.cc tilereg-spl.cc tilereg-stat.cc tilereg-tab.cc tilereg-text.cc tilereg-grid.cc\
# tilereg-popup.cc tilereg-title.cc tilesdl.cc  tileweb-text.cc \

LOCAL_MODULE    := crawl

LOCAL_SRC_FILES := $(CRAWLSRC)

include $(BUILD_SHARED_LIBRARY)
#include $(BUILD_EXECUTABLE)
