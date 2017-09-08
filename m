From: Philippe Gerum <rpm@xenomai.org>
References: <1504766189.59b0e8edb9f7a@mail.inbox.lv>
 <ae84bec2-afdb-3cf0-031c-b8db97387f59@xenomai.org>
 <1504779380.59b11c7427039@mail.inbox.lv>
 <49358bd0-9902-ded1-8aa8-f2e91c73980f@xenomai.org>
 <1504864455.59b268c7f133b@mail.inbox.lv>
 <4a0c3249-bcdf-ea09-5b6e-bad3431ddc4d@xenomai.org>
Message-ID: <2f293611-9ca8-9988-24a5-0f952874576e@xenomai.org>
Date: Fri, 8 Sep 2017 15:13:09 +0200
MIME-Version: 1.0
In-Reply-To: <4a0c3249-bcdf-ea09-5b6e-bad3431ddc4d@xenomai.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
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
To: Andris <andrlv@inbox.lv>
Cc: xenomai@xenomai.org

On 09/08/2017 02:57 PM, Philippe Gerum wrote:
> On 09/08/2017 11:54 AM, Andris wrote:
>> Subject: Re: [Xenomai] Application command line
>> arguments(parameters) reordering problem
>> Date: 8 September 2017 at 12:06:50
>> From:  Philippe Gerum <rpm@xenomai.org>
>> To:  Andris <andrlv@inbox.lv>
>>> On 09/07/2017 12:16 PM, Andris wrote:
>>>> Thanks!
>>>> But this patch resolve problem only if all
>> command line arguments starts
>>>> with "--", but if command line is with mixed
>> arguments, for example:
>>>> ./app -p 250 --enable-feature 1
>>>> then the problem still exist.
>>
>>> Just checked, it does not here. Are you sure?
>>
>> Yes, parameters are reordered, first always is
>> parameter starting with "--".
>> argv[0]: app
>> argv[1]: --enable-feature
>> argv[2]: 1
>> argv[3]: -p
>> argv[4]: 250
>>
>> But this possibly is not a problem.
>>
> 
> Ok, the whole thing needs a review. I'll follow up on this.
> 
> Thanks,
> 

Please try this patch:

commit 5c3a997983d7b1fe29d225075ddb94f2c63ee016
Author: Philippe Gerum <rpm@xenomai.org>
Date:   Fri Sep 8 12:08:05 2017 +0200

    boilerplate/setup: do not alter order of parameters
    
    - firstly, keep short options in parsed vector
    - secondly, disable getopt's parameter shuffling

diff --git a/lib/boilerplate/setup.c b/lib/boilerplate/setup.c
index 731504f..f749828 100644
--- a/lib/boilerplate/setup.c
+++ b/lib/boilerplate/setup.c
@@ -232,10 +232,10 @@ fail:
 	return -EINVAL;
 }
 
-static inline char **prep_args(int argc, char *const argv[], int *largcp)
+static inline char **prep_args(int argc, char *const argv[])
 {
-	int in, out, n, maybe_arg, lim;
-	char **uargv, *p;
+	char **uargv;
+	int n;
 
 	uargv = malloc(argc * sizeof(char *));
 	if (uargv == NULL)
@@ -247,43 +247,18 @@ static inline char **prep_args(int argc, char *const argv[], int *largcp)
 			return NULL;
 	}
 
-	lim = argc;
-	in = maybe_arg = 0;
-	while (in < lim) {
-		if ((uargv[in][0] == '-' && uargv[in][1] != '-') ||
-		    (maybe_arg && uargv[in][0] != '-')) {
-			p = strdup(uargv[in]);
-			for (n = in, out = in + 1; out < argc; out++, n++) {
-				free(uargv[n]);
-				uargv[n] = strdup(uargv[out]);
-			}
-			free(uargv[argc - 1]);
-			uargv[argc - 1] = p;
-			if (*p == '-')
-				maybe_arg = 1;
-			lim--;
-		} else {
-			in++;
-			maybe_arg = 0;
-		}
-	}
-
-	*largcp = lim;
-
 	return uargv;
 }
 
-static inline void pack_args(int *argcp, int *largcp, char **argv)
+static inline void pack_args(int *argcp, char **argv)
 {
 	int in, out;
 
 	for (in = out = 0; in < *argcp; in++) {
 		if (*argv[in])
 			argv[out++] = argv[in];
-		else {
+		else
 			free(argv[in]);
-			(*largcp)--;
-		}
 	}
 
 	*argcp = out;
@@ -376,7 +351,7 @@ void xenomai_usage(void)
         fprintf(stderr, "--help				display help\n");
 }
 
-static int parse_base_options(int *argcp, int *largcp, char **uargv,
+static int parse_base_options(int *argcp, char **uargv,
 			      const struct option *options,
 			      int base_opt_start)
 {
@@ -395,7 +370,7 @@ static int parse_base_options(int *argcp, int *largcp, char **uargv,
 
 	for (;;) {
 		lindex = -1;
-		c = getopt_long(*largcp, uargv, "", options, &lindex);
+		c = getopt_long(*argcp, uargv, "-", options, &lindex);
 		if (c == EOF)
 			break;
 		if (lindex == -1)
@@ -442,13 +417,14 @@ static int parse_base_options(int *argcp, int *largcp, char **uargv,
 		 * (including any companion argument), pack_args()
 		 * will expunge all options we have already handled.
 		 *
-		 * NOTE: this code relies on the fact that only long
-		 * options with double-dash markers can be parsed here
-		 * after prep_args() did its job (we do not support
-		 * -foo as a long option). This is aimed at reserving
-		 * use of short options to the application layer,
-		 * sharing only the long option namespace with the
-		 * Xenomai core libs.
+		 * NOTE: only options with double-dash prefix may have
+		 * been recognized by getopt_long() as Xenomai
+		 * ones. This reserves short options to the
+		 * application layer, sharing only the long option
+		 * namespace with the Xenomai core libs. In addition,
+		 * the user can delimit the start of the application
+		 * arguments, preceeding them by the '--' separator on
+		 * the command line.
 		 */
 		n = optind - 1;
 		if (uargv[n][0] != '-' || uargv[n][1] != '-')
@@ -457,14 +433,14 @@ static int parse_base_options(int *argcp, int *largcp, char **uargv,
 		uargv[n][0] = '\0'; /* Clear the option switch. */
 	}
 
-	pack_args(argcp, largcp, uargv);
+	pack_args(argcp, uargv);
 
 	optind = 0;
 
 	return 0;
 }
 
-static int parse_setup_options(int *argcp, int largc, char **uargv,
+static int parse_setup_options(int *argcp, char **uargv,
 			       const struct option *options)
 {
 	struct setup_descriptor *setup;
@@ -472,7 +448,11 @@ static int parse_setup_options(int *argcp, int largc, char **uargv,
 
 	for (;;) {
 		lindex = -1;
-		c = getopt_long(largc, uargv, "", options, &lindex);
+		/*
+		 * We want to keep the original order of parameters in
+		 * the vector, disable getopt's parameter shuffling.
+		 */
+		c = getopt_long(*argcp, uargv, "-", options, &lindex);
 		if (c == EOF)
 			break;
 		if (lindex == -1)
@@ -498,7 +478,7 @@ static int parse_setup_options(int *argcp, int largc, char **uargv,
 		uargv[n][0] = '\0'; /* Clear the option switch. */
 	}
 
-	pack_args(argcp, &largc, uargv);
+	pack_args(argcp, uargv);
 
 	optind = 0;
 
@@ -507,8 +487,8 @@ static int parse_setup_options(int *argcp, int largc, char **uargv,
 
 static void __xenomai_init(int *argcp, char *const **argvp, const char *me)
 {
-	int ret, largc, base_opt_start;
 	struct setup_descriptor *setup;
+	int ret, base_opt_start;
 	struct option *options;
 	struct service svc;
 	char **uargv;
@@ -528,7 +508,7 @@ static void __xenomai_init(int *argcp, char *const **argvp, const char *me)
 	 * will be expunged from Xenomai's base options as we discover
 	 * them.
 	 */
-	uargv = prep_args(*argcp, *argvp, &largc);
+	uargv = prep_args(*argcp, *argvp);
 	if (uargv == NULL) {
 		ret = -ENOMEM;
 		goto fail;
@@ -552,7 +532,7 @@ static void __xenomai_init(int *argcp, char *const **argvp, const char *me)
 	 * Parse the base options first, to bootstrap the core with
 	 * the right config values.
 	 */
-	ret = parse_base_options(argcp, &largc, uargv,
+	ret = parse_base_options(argcp, uargv,
 				 options, base_opt_start);
 	if (ret)
 		goto fail;
@@ -600,7 +580,7 @@ setup:
 			}
 		}
 		
-		ret = parse_setup_options(argcp, largc, uargv, options);
+		ret = parse_setup_options(argcp, uargv, options);
 		if (ret)
 			goto fail;
 
-- 
Philippe.

