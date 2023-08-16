Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB700322A
	for <xenomai@lists.linux.dev>; Wed, 16 Aug 2023 12:41:50 +0000 (UTC)
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-4fe2de785e7so10446334e87.1
        for <xenomai@lists.linux.dev>; Wed, 16 Aug 2023 05:41:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sigma-star.at; s=google; t=1692189708; x=1692794508;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HTg3kFV3Lzpos6vrpnMQlBAGgsBeHrtQU+85cHEbKo4=;
        b=Wo1Ade8WAvHBdiYaRa2UkHNDMS/5r0qsdr+goiB1GCHLzSItF5g79V1IUtAfrFiHJT
         ygzSAEJ7Wb59iuZhwJDd4bxDrtg9vImuSeo0f/DIqYgI0UHW5jIf4J6ej/WTfnA+94oM
         AopXtdDyCqJh5R5CQ0iW72UMeuR+oRdygOGHgRfhnVyPcwHwuqPqtBILuV52xpIDOBUI
         gS4l1316hmxBIOdENukbbC+0Bur16kjIYSmGQZ4jI/OR35whD/xt0Ke1ne0y3BqYqw2z
         fbD431107sxaQwf4Z77fhhs2dg3jnkjMmcH/6qs3xZOjcKymscpqFGGgZ4f7UaRG4KjJ
         bS9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692189708; x=1692794508;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HTg3kFV3Lzpos6vrpnMQlBAGgsBeHrtQU+85cHEbKo4=;
        b=DIg0YHeeP68mVhkohy0GsRw0Y1xTCF9cbOSO+LieXJIQ3Kg4gDzZ3pUw+F/8KO8R3r
         3HF/dS7J0ELHdJ2yhUD6V13cOwZCUn8z3Kvk8WWiJavL4oDe7b7hmRdYJanKZAdX73SO
         c9Jt1sqDbBsd3C5/lSYJ9bUpd2NBuudqEWn3k6MroyN7rsiKmqr1tznslck6CCjX00Kd
         PdNjE/lNGDuo4PCR1dQwp2Tc4wYYwVU4M0OYTodKIv34SB8MrPBmC9hHuBo9Q3NW15ch
         El3oCkOXKOllX7xrFzPg2He1aD5fyDh1X7a7zGvA0X8qL9srOJZgQciB7YVFY4X+tAyE
         L/NA==
X-Gm-Message-State: AOJu0YxVkjgsmderjIysTjUxWmi8XsrPSsLrPXig8Af7wZBKDYQuI1rA
	c1NaxOLyzZ4QkiEOaZud2k5a5w==
X-Google-Smtp-Source: AGHT+IEtFtlDv1CvL76UxTqYzEuCuK1OJEcatByZ1+l2RGqtP7binuSCYGtEyNHtOMZkMYR6UDqDiA==
X-Received: by 2002:a05:6512:104e:b0:4fa:da4f:636f with SMTP id c14-20020a056512104e00b004fada4f636fmr1770419lfb.32.1692189708261;
        Wed, 16 Aug 2023 05:41:48 -0700 (PDT)
Received: from mail ([82.150.214.1])
        by smtp.gmail.com with ESMTPSA id o8-20020a170906288800b0099cc15f09a0sm8396457ejd.55.2023.08.16.05.41.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Aug 2023 05:41:47 -0700 (PDT)
Date: Wed, 16 Aug 2023 14:41:46 +0200
From: Aaron Marcher <aaron@sigma-star.at>
To: Florian Bezdeka <florian.bezdeka@siemens.com>
Cc: xenomai@lists.linux.dev, richard@nod.at, jan.kiszka@siemens.com
Subject: Re: [PATCH 01/10] testsuite: Fully integrate alchemytests into smokey
Message-ID: <20230816124146.pz5xymkd7di6kxbd@mail>
Mail-Followup-To: Aaron Marcher <aaron@sigma-star.at>,
	Florian Bezdeka <florian.bezdeka@siemens.com>,
	xenomai@lists.linux.dev, richard@nod.at, jan.kiszka@siemens.com
References: <20230720145150.24607-1-aaron@sigma-star.at>
 <20230724135239.10579-1-aaron@sigma-star.at>
 <20230724135239.10579-2-aaron@sigma-star.at>
 <c8b63b8bf2c3d4f803d6049d874e9a37f5dac284.camel@siemens.com>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <c8b63b8bf2c3d4f803d6049d874e9a37f5dac284.camel@siemens.com>

Hi,

> IMHO includes can be cleaned up. Can't spot a usage of error.h,
> libgen.h, stdbool.h and unistd.h (at least).
> 
> Applies to more locations within this series.

Oh, missed that one. Thanks for the note, will fix.

> The following applies here and on several other places of this series:
> 
> Do we really want to have a test plugin for each sub-test? I would have
> expected one plugin for each "test class", so basically one for each
> sub folder in testsuite/smokey.
> 
> Each module could then call all the sub-tests and report back which one
> actually failed - if any.

Hm, I will have a look if that is easily changeable, as I had some
troubles with linking the Smokey plugins together initially when trying to
create a plugin for each "class" (which was planned originally).

> Btw: I think Jan already reported that: I have to disable the
> vxworkstests_task2 test as it fails CI runs here.

I think Jan posted a fix already afterwards?

Best regards,
Aaron

-- 
sigma star gmbh | Eduard-Bodem-Gasse 6, 6020 Innsbruck, AUT
UID/VAT Nr: ATU 66964118 | FN: 374287y

On Thu, Aug 10, 2023 at 09:07:09AM +0200, Florian Bezdeka wrote:
> On Mon, 2023-07-24 at 15:52 +0200, Aaron Marcher wrote:
> > This is the very first step to have the alchemy tests embedded
> > into our testsuite.
> > 
> > Build them using Xenomai's build system and hook them up using
> > Smokey. Every test binary has it's own respective testcase in the
> > testsuite.
> > 
> > Signed-off-by: Richard Weinberger <richard@nod.at>
> > Signed-off-by: Aaron Marcher <aaron@sigma-star.at>
> > ---
> 
> [snip]
> 
> > 
> > diff --git a/testsuite/smokey/alchemytests/alchemytests.c b/testsuite/smokey/alchemytests/alchemytests.c
> > new file mode 100644
> > index 000000000..ee8d1703b
> > --- /dev/null
> > +++ b/testsuite/smokey/alchemytests/alchemytests.c
> > @@ -0,0 +1,56 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +#include <error.h>
> > +#include <libgen.h>
> > +#include <smokey/smokey.h>
> > +#include <stdbool.h>
> > +#include <stdio.h>
> > +#include <stdlib.h>
> > +#include <string.h>
> > +#include <unistd.h>
> 
> IMHO includes can be cleaned up. Can't spot a usage of error.h,
> libgen.h, stdbool.h and unistd.h (at least).
> 
> Applies to more locations within this series.
> 
> > +
> > +#define TEST(name)								   \
> > +	smokey_test_plugin(name, SMOKEY_NOARGS, "Run external test");		   \
> > +	static int run_##name(struct smokey_test *t, int argc, char *const argv[]) \
> > +	{									   \
> > +		return __run_extprog(t, argc, argv);				   \
> > +	}
> > +
> > +static int __run_extprog(struct smokey_test *t, int argc, char *const argv[])
> > +{
> > +	int ret;
> > +	char *tst_path;
> > +
> > +	ret = asprintf(&tst_path, "%s/%s --cpu-affinity=0", XENO_TEST_DIR, t->name);
> > +	if (ret == -1)
> > +		return -ENOMEM;
> > +
> > +	ret = system(tst_path);
> > +	free(tst_path);
> > +
> > +	return ret;
> > +}
> > +
> > +TEST(alchemytests)
> > +TEST(alchemytests_alarm1)
> > +TEST(alchemytests_buffer1)
> > +TEST(alchemytests_event1)
> > +TEST(alchemytests_heap1)
> > +TEST(alchemytests_heap2)
> > +TEST(alchemytests_mq1)
> > +TEST(alchemytests_mq2)
> > +TEST(alchemytests_mq3)
> > +TEST(alchemytests_mutex1)
> > +TEST(alchemytests_pipe1)
> > +TEST(alchemytests_sem1)
> > +TEST(alchemytests_sem2)
> > +TEST(alchemytests_task1)
> > +TEST(alchemytests_task2)
> > +TEST(alchemytests_task3)
> > +TEST(alchemytests_task4)
> > +TEST(alchemytests_task5)
> > +TEST(alchemytests_task6)
> > +TEST(alchemytests_task7)
> > +TEST(alchemytests_task8)
> > +TEST(alchemytests_task9)
> > +TEST(alchemytests_task10)
> > +
> 
> The following applies here and on several other places of this series:
> 
> Do we really want to have a test plugin for each sub-test? I would have
> expected one plugin for each "test class", so basically one for each
> sub folder in testsuite/smokey.
> 
> Each module could then call all the sub-tests and report back which one
> actually failed - if any.
> 
> Btw: I think Jan already reported that: I have to disable the
> vxworkstests_task2 test as it fails CI runs here.
> 
> Best regards,
> Florian
> 
