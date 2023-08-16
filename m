Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14F61101FD
	for <xenomai@lists.linux.dev>; Wed, 16 Aug 2023 12:43:47 +0000 (UTC)
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-51a52a7d859so15533166a12.0
        for <xenomai@lists.linux.dev>; Wed, 16 Aug 2023 05:43:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sigma-star.at; s=google; t=1692189826; x=1692794626;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D925Q1qHITSo+6fcFWIiNfQOcKFDZOz2QpalWbdVtM0=;
        b=NwApiDT7Q6s3o1Hf56r4qCTBCUJZHZv3AXmJhMk21b5+YpLCzigpUY753PsRb7Z/xP
         EKxjdDjjzYa3DB3TiuOeEDywon07Kl1fFRdPa4Dd/3ItFogCcsUaHJECp9imeCB9PN51
         felFfsdzusubWG4DnwJ+5x3qO/5WlYAE0/kzoloEvyKF7PzkGJLygBo+bvjRaLlkNI0E
         L5E11Q5UdCC/SNBaPfTvSsNllK7r2wX0P4pMeEvkOx2C6HrOjac36gwyic97/bJiB1r0
         x/wjmX+TRxzZwzlQbRsYQtrFVtn86Um/mXeJooqB1S+g/96d8nacgv+xb2k6WX88GEqf
         marQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692189826; x=1692794626;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=D925Q1qHITSo+6fcFWIiNfQOcKFDZOz2QpalWbdVtM0=;
        b=eQzbh79v8kwMaGTvEvsc/F2thjEQurpQ2K0JZp9cht6U4CB+NywkoyyTkUq8nYUCVS
         UeBEuhlmDwjS4xy55LX/gq+/RgmInP5VgWDGNvi7AM1Z7SVsQojRMN2nvcOSGb38ZaAC
         V4GPrsm9XMpum+Bn8GsKtMHP20Y07T1r5PLxBYZVcPAmxpWeyUy+JUDtmlnv1fb8xYsE
         KO2vj+bYUybLMB2aWXQd4p6pKoKKMfLjjpMRHw+vsDFCtOGPZ3Fp8HV3Ejh2THRgEUqE
         Mc9XFYbsKkPTshELXj/tvMXN0vNw5U7yCZmrBrw5cy342tTT178RVJsSsHtRZcx2PXGG
         V75w==
X-Gm-Message-State: AOJu0Yzy40qM0scRQ36PkE0Ayvl1JNjNpO0qE7WhSrz+t2d/IIhdzc+j
	ntmHGAfr0CGtO8jt66jsyNQECDN87URFzL/YWUA=
X-Google-Smtp-Source: AGHT+IHl1TcwMKf6R7v4OM8GRimcY0U6dybqikJgcvnue6HzFzQmkUSehK3tY1sz/i7W5NF1gVMF6A==
X-Received: by 2002:a05:6402:27c6:b0:522:28b9:e84c with SMTP id c6-20020a05640227c600b0052228b9e84cmr4739612ede.21.1692189825826;
        Wed, 16 Aug 2023 05:43:45 -0700 (PDT)
Received: from mail ([82.150.214.1])
        by smtp.gmail.com with ESMTPSA id d14-20020aa7ce0e000000b0051bed21a635sm8243569edv.74.2023.08.16.05.43.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Aug 2023 05:43:45 -0700 (PDT)
Date: Wed, 16 Aug 2023 14:43:44 +0200
From: Aaron Marcher <aaron@sigma-star.at>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Florian Bezdeka <florian.bezdeka@siemens.com>, xenomai@lists.linux.dev,
	richard@nod.at
Subject: Re: [PATCH 01/10] testsuite: Fully integrate alchemytests into smokey
Message-ID: <20230816124344.oq7n42fmkuxlswck@mail>
Mail-Followup-To: Aaron Marcher <aaron@sigma-star.at>,
	Jan Kiszka <jan.kiszka@siemens.com>,
	Florian Bezdeka <florian.bezdeka@siemens.com>,
	xenomai@lists.linux.dev, richard@nod.at
References: <20230720145150.24607-1-aaron@sigma-star.at>
 <20230724135239.10579-1-aaron@sigma-star.at>
 <20230724135239.10579-2-aaron@sigma-star.at>
 <c8b63b8bf2c3d4f803d6049d874e9a37f5dac284.camel@siemens.com>
 <1befb87a-cc47-460b-9615-10a04f752062@siemens.com>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1befb87a-cc47-460b-9615-10a04f752062@siemens.com>

Hi,

> Looking at smokey --list, I agree with this: too many test cases to
> browse now. Please rework this on top of 'next'.

As already described in the previous mail, I will have a look what can
be improved. Generally I totally agree that the number of tests is a
little overwhelming atm.

Best regards,
Aaron

-- 
sigma star gmbh | Eduard-Bodem-Gasse 6, 6020 Innsbruck, AUT
UID/VAT Nr: ATU 66964118 | FN: 374287y

On Fri, Aug 11, 2023 at 07:32:56PM +0200, Jan Kiszka wrote:
> On 10.08.23 09:07, Florian Bezdeka wrote:
> > On Mon, 2023-07-24 at 15:52 +0200, Aaron Marcher wrote:
> >> This is the very first step to have the alchemy tests embedded
> >> into our testsuite.
> >>
> >> Build them using Xenomai's build system and hook them up using
> >> Smokey. Every test binary has it's own respective testcase in the
> >> testsuite.
> >>
> >> Signed-off-by: Richard Weinberger <richard@nod.at>
> >> Signed-off-by: Aaron Marcher <aaron@sigma-star.at>
> >> ---
> > 
> > [snip]
> > 
> >>
> >> diff --git a/testsuite/smokey/alchemytests/alchemytests.c b/testsuite/smokey/alchemytests/alchemytests.c
> >> new file mode 100644
> >> index 000000000..ee8d1703b
> >> --- /dev/null
> >> +++ b/testsuite/smokey/alchemytests/alchemytests.c
> >> @@ -0,0 +1,56 @@
> >> +// SPDX-License-Identifier: GPL-2.0
> >> +#include <error.h>
> >> +#include <libgen.h>
> >> +#include <smokey/smokey.h>
> >> +#include <stdbool.h>
> >> +#include <stdio.h>
> >> +#include <stdlib.h>
> >> +#include <string.h>
> >> +#include <unistd.h>
> > 
> > IMHO includes can be cleaned up. Can't spot a usage of error.h,
> > libgen.h, stdbool.h and unistd.h (at least).
> > 
> > Applies to more locations within this series.
> > 
> >> +
> >> +#define TEST(name)								   \
> >> +	smokey_test_plugin(name, SMOKEY_NOARGS, "Run external test");		   \
> >> +	static int run_##name(struct smokey_test *t, int argc, char *const argv[]) \
> >> +	{									   \
> >> +		return __run_extprog(t, argc, argv);				   \
> >> +	}
> >> +
> >> +static int __run_extprog(struct smokey_test *t, int argc, char *const argv[])
> >> +{
> >> +	int ret;
> >> +	char *tst_path;
> >> +
> >> +	ret = asprintf(&tst_path, "%s/%s --cpu-affinity=0", XENO_TEST_DIR, t->name);
> >> +	if (ret == -1)
> >> +		return -ENOMEM;
> >> +
> >> +	ret = system(tst_path);
> >> +	free(tst_path);
> >> +
> >> +	return ret;
> >> +}
> >> +
> >> +TEST(alchemytests)
> >> +TEST(alchemytests_alarm1)
> >> +TEST(alchemytests_buffer1)
> >> +TEST(alchemytests_event1)
> >> +TEST(alchemytests_heap1)
> >> +TEST(alchemytests_heap2)
> >> +TEST(alchemytests_mq1)
> >> +TEST(alchemytests_mq2)
> >> +TEST(alchemytests_mq3)
> >> +TEST(alchemytests_mutex1)
> >> +TEST(alchemytests_pipe1)
> >> +TEST(alchemytests_sem1)
> >> +TEST(alchemytests_sem2)
> >> +TEST(alchemytests_task1)
> >> +TEST(alchemytests_task2)
> >> +TEST(alchemytests_task3)
> >> +TEST(alchemytests_task4)
> >> +TEST(alchemytests_task5)
> >> +TEST(alchemytests_task6)
> >> +TEST(alchemytests_task7)
> >> +TEST(alchemytests_task8)
> >> +TEST(alchemytests_task9)
> >> +TEST(alchemytests_task10)
> >> +
> > 
> > The following applies here and on several other places of this series:
> > 
> > Do we really want to have a test plugin for each sub-test? I would have
> > expected one plugin for each "test class", so basically one for each
> > sub folder in testsuite/smokey.
> > 
> > Each module could then call all the sub-tests and report back which one
> > actually failed - if any.
> > 
> 
> Looking at smokey --list, I agree with this: too many test cases to
> browse now. Please rework this on top of 'next'.
> 
> > Btw: I think Jan already reported that: I have to disable the
> > vxworkstests_task2 test as it fails CI runs here.
> > 
> 
> Fix is in next.
> 
> Jan
> 
> -- 
> Siemens AG, Technology
> Linux Expert Center
> 
