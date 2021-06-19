/* See LICENSE file for copyright and license details. */

/* appearance */
static const unsigned int borderpx  = 2;        /* border pixel of windows */
const unsigned int gappx            = 10;	/* sets gap size, requires gaps and fullgaps patches */
static const unsigned int snap      = 32;       /* snap pixel */
static const int showbar            = 1;        /* 0 means no bar */
static const int topbar             = 0;        /* 0 means bottom bar */
static const char *fonts[]          = { "undefined medium:size=11" };
static const char dmenufont[]       = "undefined medium:size=9";
static const char col_gray1[]       = "#282a36";
static const char col_gray2[]       = "#bd93f9";
static const char col_gray3[]       = "#6272a4";
static const char col_gray4[]       = "#8be9fd";
static const char col_cyan[]        = "#8be9fd";
/* custom colors */
static const char col_border_norm[] = "#bd93f9";

static const char *colors[][3]      = {
	/*               fg         bg         border   */
	[SchemeNorm] = { col_gray3, col_gray1, col_border_norm },
	[SchemeSel]  = { col_gray4, col_gray3,  col_cyan },
};

/* tagging */
static const char *tags[] = { "一", "二", "三", "四", "五", "六", "七", "八", "九" };

static const Rule rules[] = {
	/* xprop(1):
	 *	WM_CLASS(STRING) = instance, class
	 *	WM_NAME(STRING) = title
	 */
	/* class      instance    title       tags mask     isfloating   monitor */
	{ "Gimp",     NULL,       NULL,       0,            1,           -1 },
	{ "Firefox",  NULL,       NULL,       0,            0,           -1 },
	{ "Chromium", NULL,       NULL,       1,            0,           -1 },
	{ "discord",  NULL,       NULL,       2,            0,           -1 },
	{ "Telegram", NULL,       NULL,       2,            0,           -1 },
	{ "Deluge",   NULL,       NULL,       4,            0,           -1 },
};

/* layout(s) */
static const float mfact     = 0.55; /* factor of master area size [0.05..0.95] */
static const int nmaster     = 1;    /* number of clients in master area */
static const int resizehints = 1;    /* 1 means respect size hints in tiled resizals */

static const Layout layouts[] = {
	/* symbol     arrange function */
	{ "[]=",      tile },    /* first entry is default */
	{ "><>",      NULL },    /* no layout function means floating behavior */
	{ "[M]",      monocle },
};

/* key definitions */
#define MODKEY Mod4Mask
#define TAGKEYS(KEY,TAG) \
	{ MODKEY,                       KEY,      view,           {.ui = 1 << TAG} }, \
	{ MODKEY|ControlMask,           KEY,      toggleview,     {.ui = 1 << TAG} }, \
	{ MODKEY|ShiftMask,             KEY,      tag,            {.ui = 1 << TAG} }, \
	{ MODKEY|ControlMask|ShiftMask, KEY,      toggletag,      {.ui = 1 << TAG} },

/* helper for spawning shell commands in the pre dwm-5.0 fashion */
#define SHCMD(cmd) { .v = (const char*[]){ "/bin/sh", "-c", cmd, NULL } }

/* commands */
static char dmenumon[2] = "0"; /* component of dmenucmd, manipulated in spawn() */
static const char *dmenucmd[] = { "dmenu_run", "-m", dmenumon, "-fn", dmenufont, "-nb", col_gray1, "-nf", col_gray3, "-sb", col_gray1, "-sf", col_gray4, NULL };
//custom
static const char *termcmd[]  = { "urxvtc", NULL };
static const char *browsercmd[] = {"chromium", NULL};
static const char *filemgrcmd[] = {"urxvtc", "-e", "nnn", "-de", NULL};
static const char *discordcmd[] = {"discord", NULL};
static const char *screenshotcmd[] = {"flameshot", "gui", NULL};
static const char *newscmd[] = {"urxvtc", "-e", "newsboat", NULL};
static const char *increasevolumecmd[] = {"pulsemixer", "--change-volume", "+5", NULL};
static const char *decreasevolumecmd[] = {"pulsemixer", "--change-volume", "-5", NULL};
static const char *musiccmd[] = {"urxvtc", "-e", "vimpc", NULL};
static const char *irccmd[] = {"urxvtc", "-e", "weechat", NULL};
static const char *torrentcmd[] = {"deluge", NULL};
static const char *telegramcmd[] = {"telegram-desktop", NULL};
/* custom script, see my scripts repo on gitlab */
static const char *layoutcmd[] = {"cycle-layout", NULL};

static const char **startup_programs[] = {
    browsercmd,
    discordcmd,
    telegramcmd,
    torrentcmd,
};

static Key keys[] = {
	/* modifier                     key        function        argument */
	{ MODKEY,                       XK_d,      spawn,          {.v = dmenucmd } },
	{ MODKEY,                       XK_Return, spawn,          {.v = termcmd } },
	{ MODKEY,                       XK_b,      togglebar,      {0} },
	{ MODKEY,                       XK_j,      focusstack,     {.i = +1 } },
	{ MODKEY,                       XK_k,      focusstack,     {.i = -1 } },
	{ MODKEY,                       XK_v,      incnmaster,     {.i = +1 } },
	{ MODKEY,                       XK_c,      incnmaster,     {.i = -1 } },
	{ MODKEY,                       XK_h,      setmfact,       {.f = -0.01} },
	{ MODKEY,                       XK_l,      setmfact,       {.f = +0.01} },
	{ MODKEY,                       XK_Return, zoom,           {0} },
	{ MODKEY,                       XK_Tab,    view,           {0} },
	{ MODKEY|ShiftMask,             XK_q,      killclient,     {0} },
	{ MODKEY,                       XK_t,      setlayout,      {.v = &layouts[0]} },
	{ MODKEY,                       XK_f,      setlayout,      {.v = &layouts[1]} },
	{ MODKEY|ShiftMask,             XK_m,      setlayout,      {.v = &layouts[2]} },
	{ MODKEY,                       XK_space,  setlayout,      {0} },
	//{ MODKEY|ShiftMask,             XK_space,  togglefloating, {0} },
	{ MODKEY,                       XK_0,      view,           {.ui = ~0 } },
	{ MODKEY|ShiftMask,             XK_0,      tag,            {.ui = ~0 } },
	{ MODKEY,                       XK_comma,  focusmon,       {.i = -1 } },
	{ MODKEY,                       XK_period, focusmon,       {.i = +1 } },
	{ MODKEY|ShiftMask,             XK_comma,  tagmon,         {.i = -1 } },
	{ MODKEY|ShiftMask,             XK_period, tagmon,         {.i = +1 } },
	// custom
	{MODKEY, XK_w, spawn, {.v = browsercmd}},
	{MODKEY, XK_e, spawn, {.v = filemgrcmd}},
	{MODKEY, XK_y, spawn, {.v = discordcmd}},
	{MODKEY, XK_s, spawn, {.v = screenshotcmd}},
	{MODKEY, XK_n, spawn, {.v = newscmd}},
	{MODKEY, XK_m, spawn, {.v = musiccmd}},
	{MODKEY, XK_i, spawn, {.v = irccmd}},
	{MODKEY, XK_u, spawn, {.v = torrentcmd}},
	// volume
	{MODKEY|ShiftMask, XK_comma, spawn, {.v = decreasevolumecmd}},
	{MODKEY|ShiftMask, XK_period, spawn, {.v = increasevolumecmd}},
	// keymaps
	{ShiftMask|MODKEY, XK_space, spawn, {.v = layoutcmd}},

	TAGKEYS(                        XK_1,                      0)
	TAGKEYS(                        XK_2,                      1)
	TAGKEYS(                        XK_3,                      2)
	TAGKEYS(                        XK_4,                      3)
	TAGKEYS(                        XK_5,                      4)
	TAGKEYS(                        XK_6,                      5)
	TAGKEYS(                        XK_7,                      6)
	TAGKEYS(                        XK_8,                      7)
	TAGKEYS(                        XK_9,                      8)
	{ MODKEY|ShiftMask,             XK_e,      quit,           {0} },
};

/* button definitions */
/* click can be ClkTagBar, ClkLtSymbol, ClkStatusText, ClkWinTitle, ClkClientWin, or ClkRootWin */
static Button buttons[] = {
	/* click                event mask      button          function        argument */
	{ ClkLtSymbol,          0,              Button1,        setlayout,      {0} },
	{ ClkLtSymbol,          0,              Button3,        setlayout,      {.v = &layouts[2]} },
	{ ClkWinTitle,          0,              Button2,        zoom,           {0} },
	{ ClkStatusText,        0,              Button2,        spawn,          {.v = termcmd } },
	{ ClkClientWin,         MODKEY,         Button1,        movemouse,      {0} },
	{ ClkClientWin,         MODKEY,         Button2,        togglefloating, {0} },
	{ ClkClientWin,         MODKEY,         Button3,        resizemouse,    {0} },
	{ ClkTagBar,            0,              Button1,        view,           {0} },
	{ ClkTagBar,            0,              Button3,        toggleview,     {0} },
	{ ClkTagBar,            MODKEY,         Button1,        tag,            {0} },
	{ ClkTagBar,            MODKEY,         Button3,        toggletag,      {0} },
};

