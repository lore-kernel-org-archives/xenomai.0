MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Message-ID: <1506327207.59c8baa75e074@mail.inbox.lv>
Date: Mon, 25 Sep 2017 11:13:27 +0300
From: Andris <andrlv@inbox.lv>
References: <1504766189.59b0e8edb9f7a@mail.inbox.lv>
 <ae84bec2-afdb-3cf0-031c-b8db97387f59@xenomai.org>
 <1504779380.59b11c7427039@mail.inbox.lv>
 <49358bd0-9902-ded1-8aa8-f2e91c73980f@xenomai.org>
 <1504864455.59b268c7f133b@mail.inbox.lv>
 <4a0c3249-bcdf-ea09-5b6e-bad3431ddc4d@xenomai.org>
 <2f293611-9ca8-9988-24a5-0f952874576e@xenomai.org>
In-Reply-To: <2f293611-9ca8-9988-24a5-0f952874576e@xenomai.org>
Subject: Re: [Xenomai] Application command line arguments(parameters)
 reordering problem
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai@xenomai.org

> Please try this patch:

> commit 5c3a997983d7b1fe29d225075ddb94f2c63ee016
> Author: Philippe Gerum <rpm@xenomai.org>
> Date: Fri Sep 8 12:08:05 2017 +0200


Thanks! It seems that now it works as expected.



> boilerplate/setup: do not alter order of parameters

> - firstly, keep short options in parsed vector
> - secondly, disable getopt's parameter shuffling

> diff --git a/lib/boilerplate/setup.c
b/lib/boilerplate/setup.c
> index 731504f..f749828 100644
> --- a/lib/boilerplate/setup.c
> +++ b/lib/boilerplate/setup.c
> @@ -232,10 +232,10 @@ fail:
> return -EINVAL;
> }

> -static inline char **prep_args(int argc, char
*const argv[], int *largcp)
> +static inline char **prep_args(int argc, char
*const argv[])
> {
> - int in, out, n, maybe_arg, lim;
> - char **uargv, *p;
> + char **uargv;
> + int n;

> uargv =3D malloc(argc * sizeof(char *));
> if (uargv =3D=3D NULL)
> @@ -247,43 +247,18 @@ static inline char
**prep_args(int argc, char *const argv[], int *largcp)
> return NULL;
> }

> - lim =3D argc;
> - in =3D maybe_arg =3D 0;
> - while (in < lim) {
> - if ((uargv[in][0] =3D=3D '-' && uargv[in][1] !=3D
'-') ||
> - (maybe_arg && uargv[in][0] !=3D '-')) {
> - p =3D strdup(uargv[in]);
> - for (n =3D in, out =3D in + 1; out < argc; out++,
n++) {
> - free(uargv[n]);
> - uargv[n] =3D strdup(uargv[out]);
> - }
> - free(uargv[argc - 1]);
> - uargv[argc - 1] =3D p;
> - if (*p =3D=3D '-')
> - maybe_arg =3D 1;
> - lim--;
> - } else {
> - in++;
> - maybe_arg =3D 0;
> - }
> - }
> -
> - *largcp =3D lim;
> -
> return uargv;
> }

> -static inline void pack_args(int *argcp, int
*largcp, char **argv)
> +static inline void pack_args(int *argcp, char
**argv)
> {
> int in, out;

> for (in =3D out =3D 0; in < *argcp; in++) {
> if (*argv[in])
> argv[out++] =3D argv[in];
> - else {
> + else
> free(argv[in]);
> - (*largcp)--;
> - }
> }

> *argcp =3D out;
> @@ -376,7 +351,7 @@ void xenomai_usage(void)
> fprintf(stderr, "--help display help\n");
> }

> -static int parse_base_options(int *argcp, int
*largcp, char **uargv,
> +static int parse_base_options(int *argcp, char
**uargv,
> const struct option *options,
> int base_opt_start)
> {
> @@ -395,7 +370,7 @@ static int
parse_base_options(int *argcp, int *largcp, char
**uargv,

> for (;;) {
> lindex =3D -1;
> - c =3D getopt_long(*largcp, uargv, "", options,
&lindex);
> + c =3D getopt_long(*argcp, uargv, "-", options,
&lindex);
> if (c =3D=3D EOF)
> break;
> if (lindex =3D=3D -1)
> @@ -442,13 +417,14 @@ static int
parse_base_options(int *argcp, int *largcp, char
**uargv,
> * (including any companion argument), pack_args()
> * will expunge all options we have already handled.
> *
> - * NOTE: this code relies on the fact that only
long
> - * options with double-dash markers can be
parsed here
> - * after prep_args() did its job (we do not support
> - * -foo as a long option). This is aimed at
reserving
> - * use of short options to the application layer,
> - * sharing only the long option namespace with the
> - * Xenomai core libs.
> + * NOTE: only options with double-dash prefix
may have
> + * been recognized by getopt_long() as Xenomai
> + * ones. This reserves short options to the
> + * application layer, sharing only the long option
> + * namespace with the Xenomai core libs. In
addition,
> + * the user can delimit the start of the
application
> + * arguments, preceeding them by the '--'
separator on
> + * the command line.
> */
> n =3D optind - 1;
> if (uargv[n][0] !=3D '-' || uargv[n][1] !=3D '-')
> @@ -457,14 +433,14 @@ static int
parse_base_options(int *argcp, int *largcp, char
**uargv,
> uargv[n][0] =3D '\0'; /* Clear the option switch. */
> }

> - pack_args(argcp, largcp, uargv);
> + pack_args(argcp, uargv);

> optind =3D 0;

> return 0;
> }

> -static int parse_setup_options(int *argcp, int
largc, char **uargv,
> +static int parse_setup_options(int *argcp, char
**uargv,
> const struct option *options)
> {
> struct setup_descriptor *setup;
> @@ -472,7 +448,11 @@ static int
parse_setup_options(int *argcp, int largc, char
**uargv,

> for (;;) {
> lindex =3D -1;
> - c =3D getopt_long(largc, uargv, "", options,
&lindex);
> + /*
> + * We want to keep the original order of
parameters in
> + * the vector, disable getopt's parameter
shuffling.
> + */
> + c =3D getopt_long(*argcp, uargv, "-", options,
&lindex);
> if (c =3D=3D EOF)
> break;
> if (lindex =3D=3D -1)
> @@ -498,7 +478,7 @@ static int
parse_setup_options(int *argcp, int largc, char
**uargv,
> uargv[n][0] =3D '\0'; /* Clear the option switch. */
> }

> - pack_args(argcp, &largc, uargv);
> + pack_args(argcp, uargv);

> optind =3D 0;

> @@ -507,8 +487,8 @@ static int
parse_setup_options(int *argcp, int largc, char
**uargv,

> static void __xenomai_init(int *argcp, char
*const **argvp, const char *me)
> {
> - int ret, largc, base_opt_start;
> struct setup_descriptor *setup;
> + int ret, base_opt_start;
> struct option *options;
> struct service svc;
> char **uargv;
> @@ -528,7 +508,7 @@ static void
__xenomai_init(int *argcp, char *const **argvp,
const char *me)
> * will be expunged from Xenomai's base options
as we discover
> * them.
> */
> - uargv =3D prep_args(*argcp, *argvp, &largc);
> + uargv =3D prep_args(*argcp, *argvp);
> if (uargv =3D=3D NULL) {
> ret =3D -ENOMEM;
> goto fail;
> @@ -552,7 +532,7 @@ static void
__xenomai_init(int *argcp, char *const **argvp,
const char *me)
> * Parse the base options first, to bootstrap the
core with
> * the right config values.
> */
> - ret =3D parse_base_options(argcp, &largc, uargv,
> + ret =3D parse_base_options(argcp, uargv,
> options, base_opt_start);
> if (ret)
> goto fail;
> @@ -600,7 +580,7 @@ setup:
> }
> }

> - ret =3D parse_setup_options(argcp, largc, uargv,
options);
> + ret =3D parse_setup_options(argcp, uargv, options);
> if (ret)
> goto fail;

> --
> Philippe.
~~~~~~~~~~~~~~~~~~~
Best regards,
Andris


