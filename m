Received: from mta-65-226.siemens.flowmailer.net (mta-65-226.siemens.flowmailer.net [185.136.65.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3477F1C2E
	for <xenomai@lists.linux.dev>; Thu, 10 Aug 2023 07:07:13 +0000 (UTC)
Received: by mta-65-226.siemens.flowmailer.net with ESMTPSA id 202308100707102cb69cc66ae1e5c7ed
        for <xenomai@lists.linux.dev>;
        Thu, 10 Aug 2023 09:07:10 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=i3lPKte8kUkoAcsZGrROskMyycq+gbfR+76yWjsNHl4=;
 b=cEueQTIVpaMMOhxdyEhessFpdH16hcVUjpbM14ofdh1WTQoocHmEeHllOV9UDSmv5uvm+3
 ly9CMbrzcr67i9nZCIm8yDCOplIlwV1ALqanjDGjpGmwox2cVj2dx+qu4XR0JzUbb5nP+603
 AQP8KuboCI8vx/ghGVYwG+BoORQkQ=;
Message-ID: <c8b63b8bf2c3d4f803d6049d874e9a37f5dac284.camel@siemens.com>
Subject: Re: [PATCH 01/10] testsuite: Fully integrate alchemytests into
 smokey
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: Aaron Marcher <aaron@sigma-star.at>, xenomai@lists.linux.dev
Cc: richard@nod.at, jan.kiszka@siemens.com
Date: Thu, 10 Aug 2023 09:07:09 +0200
In-Reply-To: <20230724135239.10579-2-aaron@sigma-star.at>
References: <20230720145150.24607-1-aaron@sigma-star.at>
	 <20230724135239.10579-1-aaron@sigma-star.at>
	 <20230724135239.10579-2-aaron@sigma-star.at>
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

On Mon, 2023-07-24 at 15:52 +0200, Aaron Marcher wrote:
> This is the very first step to have the alchemy tests embedded
> into our testsuite.
>=20
> Build them using Xenomai's build system and hook them up using
> Smokey. Every test binary has it's own respective testcase in the
> testsuite.
>=20
> Signed-off-by: Richard Weinberger <richard@nod.at>
> Signed-off-by: Aaron Marcher <aaron@sigma-star.at>
> ---

[snip]

>=20
> diff --git a/testsuite/smokey/alchemytests/alchemytests.c b/testsuite/smo=
key/alchemytests/alchemytests.c
> new file mode 100644
> index 000000000..ee8d1703b
> --- /dev/null
> +++ b/testsuite/smokey/alchemytests/alchemytests.c
> @@ -0,0 +1,56 @@
> +// SPDX-License-Identifier: GPL-2.0
> +#include <error.h>
> +#include <libgen.h>
> +#include <smokey/smokey.h>
> +#include <stdbool.h>
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <string.h>
> +#include <unistd.h>

IMHO includes can be cleaned up. Can't spot a usage of error.h,
libgen.h, stdbool.h and unistd.h (at least).

Applies to more locations within this series.

> +
> +#define TEST(name)								   \
> +	smokey_test_plugin(name, SMOKEY_NOARGS, "Run external test");		   \
> +	static int run_##name(struct smokey_test *t, int argc, char *const argv=
[]) \
> +	{									   \
> +		return __run_extprog(t, argc, argv);				   \
> +	}
> +
> +static int __run_extprog(struct smokey_test *t, int argc, char *const ar=
gv[])
> +{
> +	int ret;
> +	char *tst_path;
> +
> +	ret =3D asprintf(&tst_path, "%s/%s --cpu-affinity=3D0", XENO_TEST_DIR, =
t->name);
> +	if (ret =3D=3D -1)
> +		return -ENOMEM;
> +
> +	ret =3D system(tst_path);
> +	free(tst_path);
> +
> +	return ret;
> +}
> +
> +TEST(alchemytests)
> +TEST(alchemytests_alarm1)
> +TEST(alchemytests_buffer1)
> +TEST(alchemytests_event1)
> +TEST(alchemytests_heap1)
> +TEST(alchemytests_heap2)
> +TEST(alchemytests_mq1)
> +TEST(alchemytests_mq2)
> +TEST(alchemytests_mq3)
> +TEST(alchemytests_mutex1)
> +TEST(alchemytests_pipe1)
> +TEST(alchemytests_sem1)
> +TEST(alchemytests_sem2)
> +TEST(alchemytests_task1)
> +TEST(alchemytests_task2)
> +TEST(alchemytests_task3)
> +TEST(alchemytests_task4)
> +TEST(alchemytests_task5)
> +TEST(alchemytests_task6)
> +TEST(alchemytests_task7)
> +TEST(alchemytests_task8)
> +TEST(alchemytests_task9)
> +TEST(alchemytests_task10)
> +

The following applies here and on several other places of this series:

Do we really want to have a test plugin for each sub-test? I would have
expected one plugin for each "test class", so basically one for each
sub folder in testsuite/smokey.

Each module could then call all the sub-tests and report back which one
actually failed - if any.

Btw: I think Jan already reported that: I have to disable the
vxworkstests_task2 test as it fails CI runs here.

Best regards,
Florian

