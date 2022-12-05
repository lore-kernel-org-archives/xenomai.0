Received: from mta-64-226.siemens.flowmailer.net (mta-64-226.siemens.flowmailer.net [185.136.64.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F3E26125
	for <xenomai@lists.linux.dev>; Mon,  5 Dec 2022 17:44:31 +0000 (UTC)
Received: by mta-64-226.siemens.flowmailer.net with ESMTPSA id 20221205174424d05672341c89431292
        for <xenomai@lists.linux.dev>;
        Mon, 05 Dec 2022 18:44:24 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=icrW8rvzXXAdgWVZ75tnut5HkhLRi+cdPE6+0IkyGUQ=;
 b=hhvQlhRknAL0MCpS2HDzATDcavEhsGgaKpCCntCtTWvTW26Lf2CIskOGL5W8HSLQZmh+6I
 3TgNeMWixJZDZvTmGB8KH3+kBYoBU+14TVIv4nM8/hgJK0wSHwmN8J7mBu/56o+LET7P1wSN
 8x1iTIGnvEuy/EROZO+zsRO4wWEg0=;
Message-ID: <81c9d46ba3ce0b513985bcb37c9688097004346b.camel@siemens.com>
Subject: Re: [PATCH v2 2/3] switchtest: test multiple secondary switch cases
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: "T. Schaffner" <tobias.schaffner@siemens.com>, xenomai@lists.linux.dev
Cc: jan.kiszka@siemens.com
Date: Mon, 05 Dec 2022 18:44:23 +0100
In-Reply-To: <20221205152104.3555474-3-tobias.schaffner@siemens.com>
References: <20221205152104.3555474-1-tobias.schaffner@siemens.com>
	 <20221205152104.3555474-3-tobias.schaffner@siemens.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-68982:519-21489:flowmailer

On Mon, 2022-12-05 at 16:21 +0100, T. Schaffner wrote:
> From: Tobias Schaffner <tobias.schaffner@siemens.com>
>=20
> Switches to secondary mode do not only occur when a relax is explicitly
> called via the cobalt api but also e.g. when a linux syscall is called in
> primary mode.
>=20
> Signed-off-by: Tobias Schaffner <tobias.schaffner@siemens.com>
> ---
>  testsuite/switchtest/switchtest.c | 117 ++++++++++++++++++++----------
>  1 file changed, 79 insertions(+), 38 deletions(-)
>=20
> diff --git a/testsuite/switchtest/switchtest.c b/testsuite/switchtest/swi=
tchtest.c
> index f8a37da79..12516186b 100644
> --- a/testsuite/switchtest/switchtest.c
> +++ b/testsuite/switchtest/switchtest.c
> @@ -34,7 +34,9 @@
>  #include <semaphore.h>
>  #include <setjmp.h>
>  #include <getopt.h>
> +#include <asm/unistd.h>
>  #include <asm/xenomai/features.h>
> +#include <asm/xenomai/syscall.h>
>  #include <asm/xenomai/uapi/fptest.h>
>  #include <cobalt/trace.h>
>  #include <rtdm/testing.h>
> @@ -75,6 +77,14 @@ typedef enum {
>  	UFPS =3D 4	 /* use the FPU while in secondary mode. */
>  } fpflags;
> =20
> +#define TASK_SWITCH_MODES 3
> +
> +enum task_switch_mode {
> +	TASK_SWITCH_PREVIOUS =3D 0,
> +	TASK_SWITCH_NEXT =3D 1,
> +	TASK_SWITCH_MODE =3D 2
> +};
> +
>  struct cpu_tasks;
> =20
>  struct task_params {
> @@ -297,6 +307,57 @@ static int printout(const char *fmt, ...)
>  #define check_fp_result(__expected)	\
>  	fp_regs_check(fp_features, __expected, printout)
> =20
> +static void _assert_primary_mode(char const *calling_func)
> +{
> +	if (cobalt_thread_mode() & (XNRELAX|XNWEAK)) {
> +		fprintf(stderr,
> +			"Switch to primary mode failed in %s.",
> +			calling_func);
> +		clean_exit(EXIT_FAILURE);
> +	}
> +}
> +
> +#define assert_primary_mode() _assert_primary_mode(__func__)
> +
> +static void _assert_secondary_mode(char const *calling_func)
> +{
> +	if (!(cobalt_thread_mode() & (XNRELAX))) {
> +		fprintf(stderr,
> +			"Switch to secondary mode failed in %s.",
> +			calling_func);
> +		clean_exit(EXIT_FAILURE);
> +	}
> +}

Just a very minor thing: I (personally) would prefer to bail out if
everything is OK. Applies here and above. Simply inverse the condition.
Nice side effect: fprintf fits into one line. I guess Jan will decide
;-)

static void _assert_secondary_mode(char const *calling_func)
{
	if ((cobalt_thread_mode() & (XNRELAX)))
		return;

	fprintf(stderr, "Switch to secondary mode failed in %s.", calling_func);
	clean_exit(EXIT_FAILURE);
}


> +
> +#define assert_secondary_mode() _assert_secondary_mode(__func__)
> +
> +static void switch_to_primary_mode(void)
> +{
> +	cobalt_thread_harden();
> +	assert_primary_mode();
> +}
> +
> +static void switch_to_secondary_mode(void)
> +{
> +	cobalt_thread_relax();
> +	assert_secondary_mode();
> +}
> +
> +static void switch_to_secondary_mode_by_using_linux_syscall(void)
> +{
> +	syscall(__NR_gettid);
> +	assert_secondary_mode();
> +}
> +
> +#define SWITCH_FUNC_COUNT 4
> +
> +static void (*switch_funcs[SWITCH_FUNC_COUNT]) (void) =3D {
> +	switch_to_secondary_mode,
> +	switch_to_primary_mode,
> +	switch_to_secondary_mode_by_using_linux_syscall,
> +	switch_to_primary_mode,
> +};
> +
>  static void *sleeper_switcher(void *cookie)
>  {
>  	struct task_params *param =3D (struct task_params *) cookie;
> @@ -354,13 +415,13 @@ static void *sleeper_switcher(void *cookie)
>  		if (tasks_count =3D=3D 1)
>  			continue;
> =20
> -		switch (i % 3) {
> -		case 0:
> +		switch (i % TASK_SWITCH_MODES) {
> +		case TASK_SWITCH_PREVIOUS:
>  			/* to =3D=3D from means "return to last task" */
>  			rtsw.to =3D rtsw.from;
>  			break;
> =20
> -		case 1:
> +		case TASK_SWITCH_NEXT:
>  			if (++to =3D=3D rtsw.from)
>  				++to;
>  			if (to > tasks_count - 1)
> @@ -440,24 +501,6 @@ static void *fpu_stress(void *cookie)
>  	return NULL;
>  }
> =20
> -static void switch_to_primary_mode(void)
> -{
> -	cobalt_thread_harden();
> -	if (cobalt_thread_mode() & (XNRELAX|XNWEAK)) {
> -		perror("Switch to primary mode failed.");
> -		clean_exit(EXIT_FAILURE);
> -	}
> -}
> -
> -static void switch_to_secondary_mode(void)
> -{
> -	cobalt_thread_relax();
> -	if (!(cobalt_thread_mode() & (XNRELAX))) {
> -		perror("Switch to secondary mode failed.");
> -		clean_exit(EXIT_FAILURE);
> -	}
> -}
> -
>  static void *rtup(void *cookie)
>  {
>  	struct task_params *param =3D (struct task_params *) cookie;
> @@ -493,13 +536,13 @@ static void *rtup(void *cookie)
>  	for (;;) {
>  		unsigned expected, fp_val;
> =20
> -		switch (i % 3) {
> -		case 0:
> +		switch (i % TASK_SWITCH_MODES) {
> +		case TASK_SWITCH_PREVIOUS:
>  			/* to =3D=3D from means "return to last task" */
>  			rtsw.to =3D rtsw.from;
>  			break;
> =20
> -		case 1:
> +		case TASK_SWITCH_NEXT:
>  			if (++to =3D=3D rtsw.from)
>  				++to;
>  			if (to > tasks_count - 1)
> @@ -574,13 +617,13 @@ static void *rtus(void *cookie)
>  	for (;;) {
>  		unsigned expected, fp_val;
> =20
> -		switch (i % 3) {
> -		case 0:
> +		switch (i % TASK_SWITCH_MODES) {
> +		case TASK_SWITCH_PREVIOUS:
>  			/* to =3D=3D from means "return to last task" */
>  			rtsw.to =3D rtsw.from;
>  			break;
> =20
> -		case 1:
> +		case TASK_SWITCH_NEXT:
>  			if (++to =3D=3D rtsw.from)
>  				++to;
>  			if (to > tasks_count - 1)
> @@ -656,13 +699,13 @@ static void *rtuo(void *cookie)
>  	for (;;) {
>  		unsigned expected, fp_val;
> =20
> -		switch (i % 3) {
> -		case 0:
> +		switch (i % TASK_SWITCH_MODES) {
> +		case TASK_SWITCH_PREVIOUS:
>  			/* to =3D=3D from means "return to last task" */
>  			rtsw.to =3D rtsw.from;
>  			break;
> =20
> -		case 1:
> +		case TASK_SWITCH_NEXT:
>  			if (++to =3D=3D rtsw.from)
>  				++to;
>  			if (to > tasks_count - 1)
> @@ -679,6 +722,7 @@ static void *rtuo(void *cookie)
>  		    (mode =3D=3D COBALT_SECONDARY && param->fp & UFPS)) {
>  			fp_regs_set(fp_features, expected);
>  		}
> +
>  		err =3D ioctl(fd, RTTST_RTIOC_SWTEST_SWITCH_TO, &rtsw);
>  		while (err =3D=3D -1 && errno =3D=3D EINTR)
>  			err =3D ioctl(fd, RTTST_RTIOC_SWTEST_PEND, &param->swt);
> @@ -700,14 +744,11 @@ static void *rtuo(void *cookie)
>  		}
> =20
>  		/* Switch between primary and secondary mode */
> -		if (i % 3 =3D=3D 2) {
> -			if (mode =3D=3D COBALT_PRIMARY) {
> -				switch_to_secondary_mode();
> -				mode =3D COBALT_SECONDARY;
> -			} else {
> -				switch_to_primary_mode();
> -				mode =3D COBALT_PRIMARY;
> -			}
> +		if (i % TASK_SWITCH_MODES =3D=3D TASK_SWITCH_MODE) {
> +			uint switch_iteration =3D (i / TASK_SWITCH_MODES %
> +				SWITCH_FUNC_COUNT);
> +			switch_funcs[switch_iteration]();
> +			mode =3D !mode;
>  		}
> =20
>  		if(++i =3D=3D 4000000)

