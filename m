Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2245D8465
	for <xenomai@lists.linux.dev>; Fri, 29 Sep 2023 12:12:46 +0000 (UTC)
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-313e742a787so370915f8f.1
        for <xenomai@lists.linux.dev>; Fri, 29 Sep 2023 05:12:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sigma-star.at; s=google; t=1695989565; x=1696594365; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1zVB9yFFzw4p6CCLqxx/HUcJv0EZ0Yqz30ComTtG7rU=;
        b=WYtN7fyKo+SUoOQYsYhJZoGTk50SL65iOgaj8i3Amu4oaUmXP+aN/r7gMArUDlxa/V
         ZQ7gqex69Nwm6L6X/ymfSGzKvrXz4xJ6clNOJMr97CI3q2QceBdVx6j6F15sbpIrTPsR
         brb5hDCdB17zplIywlkHxh5x/P0SbpQQ7XFmV7nDYiaaruPLMUdQHcoMQRbfXJ0neywc
         tCady1aTSle77ZvAu+n+YNilYSCJFVjf/aCR4/o+knRGTh8nOFz8cR/y1bvBMcJz2dyF
         beWigIACgPjQfmFsyd0QhoVJe/EGuCiWyuKPwNu8CzEZZHQ8AYa5d1CcPrwWmNid4TMY
         3/Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695989565; x=1696594365;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1zVB9yFFzw4p6CCLqxx/HUcJv0EZ0Yqz30ComTtG7rU=;
        b=viQjLENPDGLxd1mGyF2ctAb8cmd7g5MeaZbXn5xW0A43a9LYPHDUE5lje7IZz/R9o8
         ssz4pJJc/Z0zK907lt1U7bl6oTcbnTSrokDR0cmQLILGyHHHhgDieQaFOBtq+Hfrk2sD
         KnKgonauC0uf2rGpzy/21m2CYqI8mf4bS5JwRe9NYRiwpcjtdygVHDOSvGA6u7Ly79FZ
         wr3HKzKpo78vdr7WerparWA/B1pupu5p2aBy46rErd88f1LruY4y0G0ykmOueuR94AAN
         gwswjCS1Wc4be1r4rGSyrFAYh24YjI5TvVL7hFHQw9OMAerNOR2HuhaGtFDavip5kwaT
         WOhA==
X-Gm-Message-State: AOJu0Ywdv2pLT+nMbpFAJuuwCIdIq7bfpoeiQ9giiUXFF2y6VV42mfiO
	SsA4C4y+uRoWnNVeGKYc7zYxew==
X-Google-Smtp-Source: AGHT+IGR3rpU4ISbELfkyTsOkH2NvtduQ8tfX3mMKRZ+oPd01Zw5telOlxR3lD1Szs6KLeZlxTTSiw==
X-Received: by 2002:a5d:4049:0:b0:323:3b45:c452 with SMTP id w9-20020a5d4049000000b003233b45c452mr3792366wrp.14.1695989564865;
        Fri, 29 Sep 2023 05:12:44 -0700 (PDT)
Received: from mail (212-186-60-23.cable.dynamic.surfer.at. [212.186.60.23])
        by smtp.gmail.com with ESMTPSA id c25-20020adfa319000000b00324853fc8adsm3425203wrb.104.2023.09.29.05.12.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Sep 2023 05:12:44 -0700 (PDT)
Date: Fri, 29 Sep 2023 14:12:43 +0200
From: Aaron Marcher <aaron@sigma-star.at>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: xenomai@lists.linux.dev
Subject: Re: [PATCH 1/1] lib: Drop cpu-affinity=0 from skin-tests helper
Message-ID: <20230929121243.vyurasjmnhsbzxyq@mail>
Mail-Followup-To: Aaron Marcher <aaron@sigma-star.at>,
	Jan Kiszka <jan.kiszka@siemens.com>, xenomai@lists.linux.dev
References: <20230925130311.17757-1-aaron@sigma-star.at>
 <20230925151256.22161-1-aaron@sigma-star.at>
 <20230925151256.22161-2-aaron@sigma-star.at>
 <fb162398-31b5-4b67-9d2c-69955e76b689@siemens.com>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <fb162398-31b5-4b67-9d2c-69955e76b689@siemens.com>

Hi Jan,

should I still rebase the original series into clean commits we can
re-apply to `next` then or do you want to keep it like that?

Aaron

-- 
sigma star gmbh | Eduard-Bodem-Gasse 6, 6020 Innsbruck, AUT
UID/VAT Nr: ATU 66964118 | FN: 374287y

On Mon, Sep 25, 2023 at 05:42:47PM +0200, Jan Kiszka wrote:
> On 25.09.23 17:12, Aaron Marcher wrote:
> > Alchemy, pSos and VxWorks tests assume zero CPU affinity, but we cannot
> > enforce that in general.
> > 
> > Introduces a parameter to control the arguments.
> > 
> > Signed-off-by: Aaron Marcher <aaron@sigma-star.at>
> > ---
> >  include/smokey/smokey.h                      | 2 +-
> >  lib/smokey/helpers.c                         | 8 ++++++--
> >  testsuite/smokey/alchemytests/alchemytests.c | 3 ++-
> >  testsuite/smokey/psostests/psostests.c       | 3 ++-
> >  testsuite/smokey/vxworkstests/vxworkstests.c | 3 ++-
> >  5 files changed, 13 insertions(+), 6 deletions(-)
> > 
> > diff --git a/include/smokey/smokey.h b/include/smokey/smokey.h
> > index 4d0fe011f..3623ba18c 100644
> > --- a/include/smokey/smokey.h
> > +++ b/include/smokey/smokey.h
> > @@ -259,7 +259,7 @@ int smokey_modprobe(const char *name, bool silent);
> >  
> >  int smokey_rmmod(const char *name);
> >  
> > -int smokey_run_extprog(const char *dir, const char *name, int argc, char *const argv[]);
> > +int smokey_run_extprog(const char *dir, const char *name, const char *args);
> >  
> >  #ifdef __cplusplus
> >  }
> > diff --git a/lib/smokey/helpers.c b/lib/smokey/helpers.c
> > index dfd63b409..99cd019aa 100644
> > --- a/lib/smokey/helpers.c
> > +++ b/lib/smokey/helpers.c
> > @@ -411,12 +411,16 @@ int smokey_rmmod(const char *name)
> >  	return err;
> >  }
> >  
> > -int smokey_run_extprog(const char *dir, const char *name, int argc, char *const argv[])
> > +int smokey_run_extprog(const char *dir, const char *name, const char *args)
> 
> Actually, argc/argv were dead vars before...
> 
> >  {
> >  	int ret;
> >  	char *tst_path;
> >  
> > -	ret = asprintf(&tst_path, "%s/%s --cpu-affinity=0", dir, name);
> > +	if (args == NULL)
> > +		ret = asprintf(&tst_path, "%s/%s", dir, name);
> > +	else
> > +		ret = asprintf(&tst_path, "%s/%s %s", dir, name, args);
> > +
> >  	if (ret == -1)
> >  		return -ENOMEM;
> >  
> > diff --git a/testsuite/smokey/alchemytests/alchemytests.c b/testsuite/smokey/alchemytests/alchemytests.c
> > index 5753af423..04f631bac 100644
> > --- a/testsuite/smokey/alchemytests/alchemytests.c
> > +++ b/testsuite/smokey/alchemytests/alchemytests.c
> > @@ -33,12 +33,13 @@ static int run_alchemytests(struct smokey_test *t, int argc, char *const argv[])
> >  		"alchemytests_task9",
> >  		"alchemytests_task10"
> >  	};
> > +	char *args = "--cpu-affinity=0";
> 
> const? Maybe even inline into the call?
> 
> >  
> >  	for (size_t t = 0; t < sizeof(tests) / sizeof(tests[0]); t++)
> >  	{
> >  		int fails = 0;
> >  
> > -		ret = smokey_run_extprog(XENO_TEST_DIR, tests[t], argc, argv);
> > +		ret = smokey_run_extprog(XENO_TEST_DIR, tests[t], args);
> >  		if (ret) {
> >  			fails++;
> >  			if (smokey_keep_going)
> > diff --git a/testsuite/smokey/psostests/psostests.c b/testsuite/smokey/psostests/psostests.c
> > index a54e6ea31..f2a75c841 100644
> > --- a/testsuite/smokey/psostests/psostests.c
> > +++ b/testsuite/smokey/psostests/psostests.c
> > @@ -46,12 +46,13 @@ static int run_psostests(struct smokey_test *t, int argc, char *const argv[])
> >  		"psostests_tm6",
> >  		"psostests_tm7"
> >  	};
> > +	char *args = "--cpu-affinity=0";
> >  
> >  	for (size_t t = 0; t < sizeof(tests) / sizeof(tests[0]); t++)
> >  	{
> >  		int fails = 0;
> >  
> > -		ret = smokey_run_extprog(XENO_TEST_DIR, tests[t], argc, argv);
> > +		ret = smokey_run_extprog(XENO_TEST_DIR, tests[t], args);
> >  		if (ret) {
> >  			fails++;
> >  			if (smokey_keep_going)
> > diff --git a/testsuite/smokey/vxworkstests/vxworkstests.c b/testsuite/smokey/vxworkstests/vxworkstests.c
> > index d3ac891ae..24ea8f0a1 100644
> > --- a/testsuite/smokey/vxworkstests/vxworkstests.c
> > +++ b/testsuite/smokey/vxworkstests/vxworkstests.c
> > @@ -24,12 +24,13 @@ static int run_vxworkstests(struct smokey_test *t, int argc, char *const argv[])
> >  		"vxworkstests_task1",
> >  		"vxworkstests_task2"
> >  	};
> > +	char *args = "--cpu-affinity=0";
> >  
> >  	for (size_t t = 0; t < sizeof(tests) / sizeof(tests[0]); t++)
> >  	{
> >  		int fails = 0;
> >  
> > -		ret = smokey_run_extprog(XENO_TEST_DIR, tests[t], argc, argv);
> > +		ret = smokey_run_extprog(XENO_TEST_DIR, tests[t], args);
> >  		if (ret) {
> >  			fails++;
> >  			if (smokey_keep_going)
> 
> I'm inclined to ask for v2 of the original series. 'next' is not
> 'master', we can still update it.
> 
> Jan
> 
> -- 
> Siemens AG, Technology
> Linux Expert Center
