Subject: Re: [Next][PATCH] utils: add kernel .config check utility
References: <20210924032341.17190-1-hongzhan.chen@intel.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <51bb4747-d129-f588-57c2-e6472463e5a9@siemens.com>
Date: Tue, 5 Oct 2021 16:27:22 +0200
MIME-Version: 1.0
In-Reply-To: <20210924032341.17190-1-hongzhan.chen@intel.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Hongzhan Chen <hongzhan.chen@intel.com>, xenomai@xenomai.org, Philippe Gerum <rpm@xenomai.org>

On 24.09.21 05:23, Hongzhan Chen via Xenomai wrote:
> To check a kernel configuration for common issues which may increase
> latency.
> 
> Signed-off-by: Hongzhan Chen <hongzhan.chen@intel.com>
> 
> diff --git a/configure.ac b/configure.ac
> index 480a94768..2bf8eece3 100644
> --- a/configure.ac
> +++ b/configure.ac
> @@ -1017,6 +1017,7 @@ AC_CONFIG_FILES([ \
>  	utils/net/rtnet \
>  	utils/net/rtnet.conf \
>  	utils/net/Makefile \
> +	utils/chkkconf/Makefile \
>  	demo/Makefile \
>  	demo/posix/Makefile \
>  	demo/posix/cyclictest/Makefile \
> diff --git a/doc/asciidoc/Makefile.am b/doc/asciidoc/Makefile.am
> index 8e33c7281..2bacb7c10 100644
> --- a/doc/asciidoc/Makefile.am
> +++ b/doc/asciidoc/Makefile.am
> @@ -7,6 +7,7 @@ HTML_DOCS = 					\
>  	html/asciidoc-icons			\
>  	html/asciidoc-icons/callouts		\
>  	html/man1/autotune			\
> +	html/man1/chkkconf			\
>  	html/man1/clocktest			\
>  	html/man1/corectl			\
>  	html/man1/dohell			\
> @@ -36,6 +37,7 @@ TXT_DOCS =				\
>  
>  MAN1_DOCS = 			\
>  	man1/autotune.1		\
> +	man1/chkkconf.1 	\
>  	man1/clocktest.1 	\
>  	man1/corectl.1	 	\
>  	man1/cyclictest.1 	\
> diff --git a/doc/asciidoc/man1/chkkconf.adoc b/doc/asciidoc/man1/chkkconf.adoc
> new file mode 100644
> index 000000000..46debae63
> --- /dev/null
> +++ b/doc/asciidoc/man1/chkkconf.adoc
> @@ -0,0 +1,106 @@
> +// ** The above line should force tbl to be a preprocessor **
> +// Man page for corectl
> +//

I think we have...

> +// Copyright (C) 2015 Philippe Gerum <rpm@xenomai.org>
> +//
> +// You may distribute under the terms of the GNU General Public
> +// License as specified in the file COPYING that comes with the
> +// Xenomai distribution.
> +//
> +//
> +AUTOTUNE(1)

...a couple of copy&paste mistakes here. In fact, in-tree
doc/asciidoc/man1/corectl.adoc has a similiar problem.

> +==========
> +:doctype: manpage
> +:revdate: 2021/09/23
> +:man source: Xenomai
> +:man version: {xenover}
> +:man manual: Xenomai Manual
> +
> +NAME
> +----
> +chkkconf - Check kernel .config
> +
> +SYNOPSIS
> +---------
> +*chkkconf* [ options ]
> +
> +DESCRIPTION
> +------------
> +*chkkconf* is a utility to check kernel .config for common issues
> +which may increase latency.

I think the tool itself is not limited to latency checks per se. It's
the default check list that makes Xenomai/Dovetail-specific latency
checks, right?

As the tool has a Xenomai list built in, it would be good to mention
that in the documentation. Alternatively, we could define and install
some default checklist file under a neutral name and make that
Xenomai-specific in the context of the installation via Xenomai.

> +
> +OPTIONS
> +--------
> +*chkkconf* accepts the following options:
> +
> +*--file*:: Specify a regular .config file. If none is specified,
> +the command defaults to reading /proc/config.gz on the current
> +machine. If this fails because any of CONFIG_IKCONFIG or
> +CONFIG_IKCONFIG_PROC was disabled in the running kernel, the
> +command fails.
> +
> +*--check-list*:: Specify a file that contains a series of single-line
> +assertions which are tested against the contents of the kernel
> +configuration. Each assertion follows the BNF-like syntax below:
> +
> +- assertion   : expr conditions
> +            | "!" expr conditions
> +
> +- expr        : symbol /* matches =y and =m */
> +            | symbol "=" tristate
> +
> +- tristate  : "y"
> +          | "m"
> +          | "n"
> +
> +- conditions  : dependency
> +            | dependency arch
> +
> +- dependency  : "if" symbol       /* true if set as y/m */
> +
> +- arch        : "on" cputype
> +
> +- cputype     : $(uname -m)
> +
> +For instance:
> +
> +- CONFIG_FOO must be set whenever CONFIG_BAR is unset can be written as
> +CONFIG_FOO if !CONFIG_BAR.
> +
> +- CONFIG_FOO must not be set can be written as !CONFIG_FOO, or
> +conversely CONFIG_FOO=n.
> +
> +- CONFIG_FOO must be built as module on aarch32 or aarch64 can be
> +written as CONFIG_FOO=m on aarch.
> +
> +- CONFIG_FOO must not be built-in on aarch64 if CONFIG_BAR is set can be
> +written as !CONFIG_FOO=y if CONFIG_BAR on aarch.
> +
> +Assertions in the check list may apply to a particular CPU architecture.
> +Normally, the command should be able to figure out which architecture
> +the kernel configuration file applies to by inspecting the first lines,
> +looking for the “Linux/” pattern. However, you might have to specify
> +this information manually to the command using the -a option if the file
> +referred to by the -f option does not contain such information.
> +The architecture name (cputype) should match the output of $(uname -m)
> +or some abbreviated portion of it. However, arm64 and arm are automatically
> +translated to aarch64 and aarch32 when found in an assertion or passed to
> +the -a option.
> +
> +*--arch*:: Specify CPU architecture that you want to check for.
> +
> +*--hash-size*:: Set the hash table size.
> +
> +*--quiet*:: Suppress output.
> +
> +*--help*::
> +Display a short help.
> +
> +VERSIONS
> +--------
> +*chkkconf* appeared in Xenomai 3.2 for checking kernel .config.
> +
> +AUTHOR
> +-------
> +*chkkconf* was written by Philippe Gerum <rpm@xenomai.org> and ported
> +by Hongzhan Chen <hongzhan.chen@intel.com> from xenomai4.
> diff --git a/utils/Makefile.am b/utils/Makefile.am
> index 81dbfda7c..4de6434a9 100644
> --- a/utils/Makefile.am
> +++ b/utils/Makefile.am
> @@ -2,3 +2,4 @@ SUBDIRS = hdb
>  if XENO_COBALT
>  SUBDIRS += analogy autotune can net ps slackspot corectl
>  endif
> +SUBDIRS += chkkconf
> diff --git a/utils/chkkconf/Makefile.am b/utils/chkkconf/Makefile.am
> new file mode 100644
> index 000000000..81fe8e982
> --- /dev/null
> +++ b/utils/chkkconf/Makefile.am
> @@ -0,0 +1,19 @@
> +
> +data_DATA = kconf-checklist.xeno
> +
> +CCLD = $(top_srcdir)/scripts/wrap-link.sh $(CC)
> +
> +sbin_PROGRAMS = chkkconf
> +
> +chkkconf_SOURCES = checkconfig.c
> +
> +chkkconf_CPPFLAGS = 		\
> +	$(XENO_USER_CFLAGS)	\
> +	-I$(top_srcdir)/include
> +
> +chkkconf_LDFLAGS = @XENO_AUTOINIT_LDFLAGS@ $(XENO_POSIX_WRAPPERS)
> +
> +chkkconf_LDADD =					\
> +	 @XENO_CORE_LDADD@			\
> +	 @XENO_USER_LDADD@			\
> +	-lpthread -lrt
> diff --git a/utils/chkkconf/checkconfig.c b/utils/chkkconf/checkconfig.c
> new file mode 100644
> index 000000000..bce87f8b3
> --- /dev/null
> +++ b/utils/chkkconf/checkconfig.c
> @@ -0,0 +1,356 @@
> +/*
> + * SPDX-License-Identifier: MIT
> + *
> + * Copyright (C) 2020 Philippe Gerum  <rpm@xenomai.org>
> + */
> +
> +#include <unistd.h>
> +#include <getopt.h>
> +#include <stdbool.h>
> +#include <ctype.h>
> +#include <stdlib.h>
> +#include <stdio.h>
> +#include <string.h>
> +#include <search.h>
> +#include <error.h>
> +#include <errno.h>
> +#include <sys/utsname.h>
> +
> +#define DEFAULT_KCONFIG    "/proc/config.gz"
> +#define DEFAULT_CHECKLIST  "/usr/xenomai/share/kconf-checklist.xeno"
> +
> +#define short_optlist "@hqf:L:a:H:"
> +
> +static int hash_size = 16384;
> +
> +static bool quiet;
> +
> +static const struct option options[] = {
> +	{
> +		.name = "file",
> +		.has_arg = required_argument,
> +		.val = 'f',
> +	},
> +	{
> +		.name = "check-list",
> +		.has_arg = required_argument,
> +		.val = 'L',
> +	},
> +	{
> +		.name = "arch",
> +		.has_arg = required_argument,
> +		.val = 'a',
> +	},
> +	{
> +		.name = "hash-size",
> +		.has_arg = required_argument,
> +		.val = 'H',
> +	},
> +	{
> +		.name = "quiet",
> +		.has_arg = no_argument,
> +		.val = 'q',
> +	},
> +	{
> +		.name = "help",
> +		.has_arg = no_argument,
> +		.val = 'h',
> +	},
> +	{ /* Sentinel */ }
> +};
> +
> +static char *hash_config(FILE *kconfp)
> +{
> +	char buf[BUFSIZ], *sym, *val, *arch = NULL;
> +	ENTRY entry, *e;
> +	int ret;
> +
> +	ret = hcreate(hash_size);
> +	if (!ret)
> +		error(1, errno, "hcreate(%d)", hash_size);
> +
> +	while (fgets(buf, sizeof(buf), kconfp)) {
> +		if (*buf == '#') {
> +			sscanf(buf, "# Linux/%m[^ ]", &arch);
> +			continue;
> +		}
> +		ret = sscanf(buf, "%m[^=]=%ms\n", &sym, &val);
> +		if (ret != 2)
> +			continue;
> +		if (strncmp(sym, "CONFIG_", 7))
> +			continue;
> +		if (strcmp(val, "y") && strcmp(val, "m"))
> +			continue;
> +		entry.key = sym;
> +		entry.data = NULL;
> +		e = hsearch(entry, FIND);
> +		if (e)
> +			continue; /* uhh? */
> +		entry.data = val;
> +		if (!hsearch(entry, ENTER))
> +			error(1, ENOMEM, "h-table full -- try -H");
> +	}
> +
> +	return arch;
> +}
> +
> +static char *next_token(char **next)
> +{
> +	char *p = *next, *s;
> +
> +	for (;;) {
> +		if (!*p) {
> +			*next = p;
> +			return strdup("");
> +		}
> +		if (!isspace(*p))
> +			break;
> +		p++;
> +	}
> +
> +	s = p;
> +
> +	if (!isalnum(*p) && *p != '_') {
> +		*next = p + 1;
> +		return strndup(s, 1);
> +	}
> +
> +	do {
> +		if (!isalnum(*p) && *p != '_') {
> +			*next = p;
> +			return strndup(s, p - s);
> +		}
> +	} while (*++p);
> +
> +	*next = p;
> +
> +	return strdup(s);
> +}
> +
> +static const char *get_arch_alias(const char *arch)
> +{
> +	if (!strcmp(arch, "arm64"))
> +		return "aarch64";
> +
> +	if (!strcmp(arch, "arm"))
> +		return "aarch32";
> +
> +	return arch;
> +}
> +
> +static int apply_checklist(FILE *checkfp, const char *cpuarch)
> +{
> +	char buf[BUFSIZ], *token, *next, *sym, *val;
> +	int lineno = 0, failed = 0;
> +	bool not, notcond;
> +	const char *arch;
> +	ENTRY entry, *e;
> +
> +	while (fgets(buf, sizeof(buf), checkfp)) {
> +		lineno++;
> +		next = buf;
> +
> +		token = next_token(&next);
> +		if (!*token || !strcmp(token, "#")) {
> +			free(token);
> +			continue;
> +		}
> +
> +		not = *token == '!';
> +		if (not) {
> +			free(token);
> +			token = next_token(&next);
> +		}
> +
> +		sym = token;
> +		if (strncmp(sym, "CONFIG_", 7))
> +			error(1, EINVAL,
> +				"invalid check list symbol '%s' at line %d",
> +				sym, lineno);
> +
> +		token = next_token(&next);
> +		val = NULL;
> +		if (*token == '=') {
> +			free(token);
> +			val = next_token(&next);
> +			token = next_token(&next);
> +		}
> +
> +		if (!strcmp(token, "if")) {
> +			free(token);
> +			token = next_token(&next);
> +			notcond = *token == '!';
> +			if (notcond) {
> +				free(token);
> +				token = next_token(&next);
> +			}
> +			if (strncmp(token, "CONFIG_", 7))
> +				error(1, EINVAL,
> +					"invalid condition symbol '%s' at line %d",
> +					token, lineno);
> +			entry.key = token;
> +			entry.data = NULL;
> +			e = hsearch(entry, FIND);
> +			free(token);
> +			if (!((e && !notcond) || (!e && notcond)))
> +				continue;
> +			token = next_token(&next);
> +		}
> +
> +		if (!strcmp(token, "on")) {
> +			free(token);
> +			token = next_token(&next);
> +			arch = get_arch_alias(token);
> +			if (strncmp(cpuarch, arch, strlen(arch))) {
> +				free(token);
> +				continue;
> +			}
> +		}
> +
> +		free(token);
> +
> +		entry.key = sym;
> +		entry.data = NULL;
> +		e = hsearch(entry, FIND);
> +
> +		if (val && !strcmp(val, "n"))
> +			not = !not;
> +
> +		if (e && (not || (val && strcmp(val, e->data)))) {
> +			if (!quiet)
> +				printf("%s=%s\n", sym, (const char *)e->data);
> +			failed++;
> +		} else if (!e && !not) {
> +			if (!quiet)
> +				printf("%s=n\n", sym);
> +			failed++;
> +		}
> +
> +		free(sym);
> +		if (val)
> +			free(val);
> +	}
> +
> +	return failed;
> +}
> +
> +static void usage(char *arg0)
> +{
> +	fprintf(stderr, "usage: %s [options]:\n", basename(arg0));
> +	fprintf(stderr, "-f --file=<.config>     Kconfig file to check [=/proc/config.gz]\n");
> +	fprintf(stderr, "-L --check-list=<file>  configuration check list [=$datarootdir/kconf-checklist.xeno]\n");
> +	fprintf(stderr, "-a --arch=<cpuarch>     CPU architecture assumed\n");
> +	fprintf(stderr, "-H --hash-size=<N>      set the hash table size [=16384]\n");
> +	fprintf(stderr, "-q --quiet              suppress output\n");
> +	fprintf(stderr, "-h --help               this help\n");
> +}
> +
> +int main(int argc, char *const argv[])
> +{
> +	const char *kconfig = DEFAULT_KCONFIG, *check_list = NULL,
> +		*defarch, *arch = NULL, *p;
> +	FILE *kconfp, *checkfp;
> +	struct utsname ubuf;
> +	int c, ret;
> +	char *cmd;
> +
> +	opterr = 0;
> +
> +	for (;;) {
> +		c = getopt_long(argc, argv, short_optlist, options, NULL);
> +		if (c == EOF)
> +			break;
> +
> +		switch (c) {
> +		case 0:
> +			break;
> +		case 'f':
> +			kconfig = optarg;
> +			break;
> +		case 'L':
> +			check_list = optarg;
> +			break;
> +		case 'a':
> +			arch = optarg;
> +			break;
> +		case 'H':
> +			hash_size = atoi(optarg);
> +			if (hash_size < 16384)
> +				hash_size = 16384;
> +			break;
> +		case 'q':
> +			quiet = true;
> +			break;
> +		case 'h':
> +			usage(argv[0]);
> +			return 0;
> +		case '@':
> +			printf("check kernel configuration\n");
> +			return 0;
> +		default:
> +			usage(argv[0]);
> +			return 1;
> +		}
> +	}
> +
> +	if (optind < argc) {
> +		usage(argv[0]);
> +		return 1;
> +	}
> +
> +	/*
> +	 * We may be given a gzipped input file. Finding gunzip on a
> +	 * minimalist rootfs (e.g. busybox) may be more likely than
> +	 * having the zlib development files available from a common
> +	 * cross-toolchain. So go for popen-ing gunzip on the target
> +	 * instead of depending on libz on the development host.
> +	 */
> +	if (!strcmp(kconfig, "-")) {
> +		kconfp = stdin;
> +	} else {
> +		p = strstr(kconfig, ".gz");
> +		if (!p || strcmp(p, ".gz")) {
> +			kconfp = fopen(kconfig, "r");
> +		} else {
> +			if (access(kconfig, R_OK))
> +				error(1, errno, "cannot access %s%s",
> +					kconfig,
> +					strcmp(kconfig, DEFAULT_KCONFIG) ? "" :
> +					"\n(you need CONFIG_IKCONFIG_PROC enabled)");
> +			ret = asprintf(&cmd, "gunzip -c %s", kconfig);
> +			if (ret < 0)
> +				error(1, ENOMEM, "asprintf()");
> +			kconfp = popen(cmd, "r");
> +			free(cmd);
> +		}
> +		if (kconfp == NULL)
> +			error(1, errno, "cannot open %s for reading", kconfig);
> +	}
> +
> +	defarch = hash_config(kconfp);
> +
> +	if (check_list == NULL)
> +		check_list = DEFAULT_CHECKLIST;
> +
> +	if (access(check_list, R_OK))
> +		error(1, errno, "cannot access %s", check_list);
> +
> +	checkfp = fopen(check_list, "r");
> +	if (checkfp == NULL)
> +		error(1, errno, "cannot open %s for reading", check_list);
> +
> +	if (arch == NULL) {
> +		if (defarch) {
> +			arch = get_arch_alias(defarch);
> +		} else {
> +			ret = uname(&ubuf);
> +			if (ret)
> +				error(1, errno, "utsname()");
> +			arch = ubuf.machine;
> +		}
> +	} else {
> +		arch = get_arch_alias(arch);
> +	}
> +
> +	return apply_checklist(checkfp, arch);
> +}
> diff --git a/utils/chkkconf/kconf-checklist.xeno b/utils/chkkconf/kconf-checklist.xeno
> new file mode 100644
> index 000000000..0f7071309
> --- /dev/null
> +++ b/utils/chkkconf/kconf-checklist.xeno
> @@ -0,0 +1,50 @@
> +# Kconfig check list for dovetail-based xenomai
> +#
> +# This file contains assertions testing a set of configuration
> +# settings from a kernel .config file, which are fed to evl-check.
> +# Any failed assertion is reported.
> +#
> +#
> +# check_list  : assertion
> +# 	      | check_list assertion
> +#
> +# assertion   : expr conditions
> +# 	      | "!" expr conditions
> +#
> +# expr	    : symbol /* matches =y and =m */
> +# 	    | symbol "=" tristate
> +#
> +# tristate  : "y"
> +# 	    | "m"
> +# 	    | "n"
> +#
> +# conditions  : dependency
> +# 	      | dependency arch
> +#
> +# dependency  : "if" symbol	/* true if set as y/m */
> +#
> +# arch	    : "on" cputype
> +#
> +# cputype   : $(uname -m)
> +#
> +# <arch> should match $(uname -m) or some abbreviated portion
> +# of it.
> +#
> +# e.g.
> +# "CONFIG_FOO must be set whenever CONFIG_BAR is UNset"
> +# translates to: CONFIG_FOO if !CONFIG_BAR
> +# "CONFIG_FOO must not be set"
> +# translates to: !CONFIG_FOO, or conversely CONFIG_FOO=n
> +# "CONFIG_FOO must be built as module on aarch32 or aarch64"
> +# translates to: CONFIG_FOO=m on aarch
> +
> +CONFIG_CPU_FREQ_DEFAULT_GOV_PERFORMANCE=y if CONFIG_CPU_FREQ
> +CONFIG_DEBUG_HARD_LOCKS=n
> +CONFIG_ACPI_PROCESSOR_IDLE=n
> +CONFIG_LOCKDEP=n
> +CONFIG_DEBUG_LIST=n
> +CONFIG_DEBUG_VM=n
> +CONFIG_DEBUG_PER_CPU_MAPS=n
> +CONFIG_KASAN=n
> +CONFIG_DEBUG_ENTRY=n
> +CONFIG_FTRACE=n
> 

Does this already reflect everything we have in our Kconfig menus so far?

That said, this is sure a valuable addition!

Jan

-- 
Siemens AG, T RDA IOT
Corporate Competence Center Embedded Linux

