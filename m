References: <1504766189.59b0e8edb9f7a@mail.inbox.lv>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <ae84bec2-afdb-3cf0-031c-b8db97387f59@xenomai.org>
Date: Thu, 7 Sep 2017 11:14:13 +0200
MIME-Version: 1.0
In-Reply-To: <1504766189.59b0e8edb9f7a@mail.inbox.lv>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
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
To: Andris <andrlv@inbox.lv>, xenomai@xenomai.org

On 09/07/2017 08:36 AM, Andris wrote:
>    Hi!
>    I found that if I build user space application as Xenomai application
>    and command line arguments(parameters) have format --parameter-first
>    <value> --parameter-second <value> --parameter-X <value> (for example,
>    --enable-some-feature 1 --test-period 500), then main function get
>    these parameters not in the same order as in command line, but somehow
>    reordered.

<snip>

>    2) Pass parameters with "--parameter-name <value>" (just pass some
>    latency application unsupported parameters)
>    ./latency --test-period 500 --enable-some-feature 1
>    main: input arguments: argc=5
>    main: argv[0]=/home/install/xenomai/testsuite/latency/.libs/latency
>    main: argv[1]=--test-period
>    main: argv[2]=--enable-some-feature
>    main: argv[3]=500
>    main: argv[4]=1
>    Why main function get these parameters reordered?
> Is this Xenomai bug?

Xenomai uses getopt_long() internally, which unexpectedly alters the argument vector. The fine print that relates to this behavior can be found in this excerpt from the getopt_long() man page:
"If there are no more option characters, getopt[_long]() returns -1.  Then optind is the index in argv of the first argv-element that is not an option."

To do that, getopt_long() reorganizes the arguments, moving all unhandled non-option words which do not start with a dash to the end of the vector, then sets optind to point at the head of this pack. This does not work particularly well when one has to parse the same vector multiple times, each time with a different set of options... Well, it looks like we need the patch below. If this works for your tests, I'll get it merged for 3.0.6.

Thanks,

diff --git a/lib/boilerplate/setup.c b/lib/boilerplate/setup.c
index 731504f..2f224e3 100644
--- a/lib/boilerplate/setup.c
+++ b/lib/boilerplate/setup.c
@@ -376,6 +376,34 @@ void xenomai_usage(void)
         fprintf(stderr, "--help				display help\n");
 }
 
+static int do_getopt(int argc, char **argv,
+		     const struct option *options,
+		     int *lindexp)
+{
+	char **_argv;
+	int c, n;
+
+	/*
+	 * getopt_long() reorders the argument vector after reaching
+	 * its end, moving all unhandled non-option words (i.e. not
+	 * prefixed by a dash) after command switches, then pointing
+	 * optind at the beginning of this pack. We don't want to
+	 * alter the user vector this way, so always work on a copy.
+	 */
+
+	_argv = malloc(sizeof(char *) * argc);
+	if (_argv == NULL)
+		return -ENOMEM;
+
+	for (n = 0; n < argc; n++)
+		_argv[n] = argv[n];
+
+	c = getopt_long(argc, _argv, "", options, lindexp);
+	free(_argv);
+
+	return c < 0 ? 0 : c;
+}
+
 static int parse_base_options(int *argcp, int *largcp, char **uargv,
 			      const struct option *options,
 			      int base_opt_start)
@@ -395,8 +423,10 @@ static int parse_base_options(int *argcp, int *largcp, char **uargv,
 
 	for (;;) {
 		lindex = -1;
-		c = getopt_long(*largcp, uargv, "", options, &lindex);
-		if (c == EOF)
+		c = do_getopt(*largcp, uargv, options, &lindex);
+		if (c < 0)
+			return c;
+		if (!c)
 			break;
 		if (lindex == -1)
 			continue;
@@ -472,8 +502,10 @@ static int parse_setup_options(int *argcp, int largc, char **uargv,
 
 	for (;;) {
 		lindex = -1;
-		c = getopt_long(largc, uargv, "", options, &lindex);
-		if (c == EOF)
+		c = do_getopt(largc, uargv, options, &lindex);
+		if (c < 0)
+			return ret;
+		if (!c)
 			break;
 		if (lindex == -1)
 			continue; /* Not handled here. */
-- 
Philippe.

