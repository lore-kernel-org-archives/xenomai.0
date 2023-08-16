Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4749B322A
	for <xenomai@lists.linux.dev>; Wed, 16 Aug 2023 12:37:53 +0000 (UTC)
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-51bece5d935so8405591a12.1
        for <xenomai@lists.linux.dev>; Wed, 16 Aug 2023 05:37:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sigma-star.at; s=google; t=1692189472; x=1692794272;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u9gy1wUhbnSKwyMRHbG1Oat1WRjt1ChFH4+kLt91Hbo=;
        b=NB8N3yqUSQrS8wwR1C3rWCd1sxRBZs1gX0BFl6N8p/MEi1ZsPjrcMxt6DVR4ZmYVkC
         HT8BSU3KRX3ZUr8AAMhiiI5/6teKFCcwayZ35sw0fAtBTlzflFSgfap097L83t+iqAto
         e5jbRUdf9p4PlUwl6kqycsAPH2bLF9HrtdoS0wSoqgK/4ELld8mHndEwt65qIJMAOKl3
         +BGM7RHX8hHr7hTP5fyfi23jnWyelTiH9nwWj+6wuKXkAMhHRAKTocQ/PDXHyfnpgiXV
         ro/rXs2p/JYi2JA52b8MW9Pxlc4o3Yi3ou0n5HVLSipQEgozg9sUr9kkB9kYWsPUrY09
         c4kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692189472; x=1692794272;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=u9gy1wUhbnSKwyMRHbG1Oat1WRjt1ChFH4+kLt91Hbo=;
        b=aEI4trhqxZ6/Ygcg1slbRKVnU2fabJgHnb68nrS0d+Y+8HNs4d+716Fdde/fKZt/c/
         VjGuPGWMhHVj8RPtVu165vbk6kYzZrAoSEufsnChGAm8ZDMYanrZWXfxyI62lsaFDbJy
         wLqCAT++d/jD8JEkpKe8nHWnb1+ZVjaiLnYuV0wB5B7gy7rlVj4KW0L6d3TI/s4vTwW7
         3tXrueojC0QzT+51SCkqh/xbO6oQYFY7NxSj2+bNz2jVW/WqCgAMb+jSwC6Oxs7XcA4r
         /Zm6yUEB/CwmUGr+TklH7LYgrNX//iAPyGsPgZX/vn+OGwhFpRKUEWjsVMh8xCb6mNiQ
         6t1Q==
X-Gm-Message-State: AOJu0YwRwiHMAIc3UQMTdibouCvTlVtH15M7+H/1Ine3Aqrp61owAo+M
	B2D2jQGbWLrilItUoanMOQwwjQ==
X-Google-Smtp-Source: AGHT+IGAz00yDRtqzgvz0Ut4sR5RlVKZ9TUsAuuVpby2k8wkXk29ZFIwy2xfg7iCkqAESiaLh1Mu/Q==
X-Received: by 2002:a05:6402:502:b0:525:6772:1595 with SMTP id m2-20020a056402050200b0052567721595mr1406038edv.6.1692189472111;
        Wed, 16 Aug 2023 05:37:52 -0700 (PDT)
Received: from mail ([82.150.214.1])
        by smtp.gmail.com with ESMTPSA id l2-20020a056402344200b00525658b7d3fsm4123013edc.45.2023.08.16.05.37.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Aug 2023 05:37:51 -0700 (PDT)
Date: Wed, 16 Aug 2023 14:37:50 +0200
From: Aaron Marcher <aaron@sigma-star.at>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: xenomai@lists.linux.dev, richard@nod.at
Subject: Re: [PATCH v6 00/10] Revive alchemy, pSOS and VxWorks tests
Message-ID: <20230816123750.lm4dme5bxxlt4ebx@mail>
Mail-Followup-To: Aaron Marcher <aaron@sigma-star.at>,
	Jan Kiszka <jan.kiszka@siemens.com>, xenomai@lists.linux.dev,
	richard@nod.at
References: <1753829974.221010.1690209596711.JavaMail.zimbra@nod.at>
 <20230725082959.5144-1-aaron@sigma-star.at>
 <6b3a57a7-01fb-f40c-ee81-b8aedaf2ca4a@siemens.com>
 <7528f4da-e5eb-4c1b-ae3a-64ea92e20b99@siemens.com>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <7528f4da-e5eb-4c1b-ae3a-64ea92e20b99@siemens.com>

Hi Jan,

sorry for the delay, i was on vacation. Thanks a lot for all the fixes
on my patchseries!

I will create follow-up patches for the remaining tasks from the
following mailing list threads soon.

Regards,
Aaron

-- 
sigma star gmbh | Eduard-Bodem-Gasse 6, 6020 Innsbruck, AUT
UID/VAT Nr: ATU 66964118 | FN: 374287y

On Wed, Aug 09, 2023 at 01:33:50PM +0200, Jan Kiszka wrote:
> On 09.08.23 09:36, Jan Kiszka wrote:
> > On 25.07.23 10:29, Aaron Marcher wrote:
> >> This patch series fully integrates the currently abandoned alchemy, pSOS
> >> and VxWorks tests into Xenomai's testsuite.
> >> For each test, a Smokey testcase is hooked up.
> >>
> >> Changes since v5:
> >> - Improved task-2 fix commit message
> >>
> >> Aaron Marcher (7):
> >>   testsuite: Fully integrate alchemytests into smokey
> >>   testsuite: Fully integrate psostests into smokey
> >>   testsuite: Fully integrate vwworkstests into smokey
> >>   alchemytests: Check pipe-1 asprintf ret value
> >>   alchemytests: Fix task-2
> >>   alchemytests: Fix task-5 logic
> >>   testsuite: disable broken tests
> >>
> >> Richard Weinberger (3):
> >>   testsuite: Remove old alchemytests Makefile
> >>   alchemytests: Fix gcc warning in buffer-1
> >>   alchemytests: Fix gcc warning in task-9
> >>
> >>  configure.ac                                  |   7 +-
> >>  lib/alchemy/testsuite/Makefile                |  70 ---------
> >>  lib/psos/testsuite/Makefile                   |  49 ------
> >>  lib/vxworks/testsuite/Makefile                |  43 -----
> >>  testsuite/smokey/Makefile.am                  |  15 +-
> >>  testsuite/smokey/alchemytests/Makefile.am     | 148 ++++++++++++++++++
> >>  .../smokey/alchemytests}/alarm-1.c            |   1 +
> >>  testsuite/smokey/alchemytests/alchemytests.c  |  56 +++++++
> >>  .../smokey/alchemytests/alchemytests_driver.c |  33 ++++
> >>  .../smokey/alchemytests}/buffer-1.c           |   3 +-
> >>  .../smokey/alchemytests}/event-1.c            |   1 +
> >>  .../smokey/alchemytests}/heap-1.c             |   1 +
> >>  .../smokey/alchemytests}/heap-2.c             |   1 +
> >>  .../smokey/alchemytests}/mq-1.c               |   1 +
> >>  .../smokey/alchemytests}/mq-2.c               |   1 +
> >>  .../smokey/alchemytests}/mq-3.c               |   1 +
> >>  .../smokey/alchemytests}/mutex-1.c            |   1 +
> >>  .../smokey/alchemytests}/pipe-1.c             |   7 +-
> >>  .../smokey/alchemytests}/sem-1.c              |   1 +
> >>  .../smokey/alchemytests}/sem-2.c              |   1 +
> >>  .../smokey/alchemytests}/task-1.c             |   1 +
> >>  .../smokey/alchemytests}/task-10.c            |   1 +
> >>  .../smokey/alchemytests}/task-2.c             |   5 +-
> >>  .../smokey/alchemytests}/task-3.c             |   1 +
> >>  .../smokey/alchemytests}/task-4.c             |   1 +
> >>  .../smokey/alchemytests}/task-5.c             |  11 +-
> >>  .../smokey/alchemytests}/task-6.c             |   1 +
> >>  .../smokey/alchemytests}/task-7.c             |   1 +
> >>  .../smokey/alchemytests}/task-8.c             |   1 +
> >>  .../smokey/alchemytests}/task-9.c             |   3 +-
> >>  testsuite/smokey/psostests/Makefile.am        | 148 ++++++++++++++++++
> >>  .../smokey/psostests}/mq-1.c                  |   1 +
> >>  .../smokey/psostests}/mq-2.c                  |   1 +
> >>  .../smokey/psostests}/mq-3.c                  |   1 +
> >>  testsuite/smokey/psostests/psostests.c        |  69 ++++++++
> >>  testsuite/smokey/psostests/psostests_driver.c |  34 ++++
> >>  .../smokey/psostests}/pt-1.c                  |   1 +
> >>  .../smokey/psostests}/rn-1.c                  |   1 +
> >>  .../smokey/psostests}/sem-1.c                 |   1 +
> >>  .../smokey/psostests}/sem-2.c                 |   1 +
> >>  .../smokey/psostests}/task-1.c                |   1 +
> >>  .../smokey/psostests}/task-2.c                |   1 +
> >>  .../smokey/psostests}/task-3.c                |   1 +
> >>  .../smokey/psostests}/task-4.c                |   1 +
> >>  .../smokey/psostests}/task-5.c                |   1 +
> >>  .../smokey/psostests}/task-6.c                |   1 +
> >>  .../smokey/psostests}/task-7.c                |   1 +
> >>  .../smokey/psostests}/task-8.c                |   1 +
> >>  .../smokey/psostests}/task-9.c                |   1 +
> >>  .../smokey/psostests}/tm-1.c                  |   1 +
> >>  .../smokey/psostests}/tm-2.c                  |   1 +
> >>  .../smokey/psostests}/tm-3.c                  |   1 +
> >>  .../smokey/psostests}/tm-4.c                  |   1 +
> >>  .../smokey/psostests}/tm-5.c                  |   1 +
> >>  .../smokey/psostests}/tm-6.c                  |   1 +
> >>  .../smokey/psostests}/tm-7.c                  |   1 +
> >>  testsuite/smokey/vxworkstests/Makefile.am     |  94 +++++++++++
> >>  .../smokey/vxworkstests}/lst-1.c              |   1 +
> >>  .../smokey/vxworkstests}/msgQ-1.c             |   1 +
> >>  .../smokey/vxworkstests}/msgQ-2.c             |   1 +
> >>  .../smokey/vxworkstests}/msgQ-3.c             |   1 +
> >>  .../smokey/vxworkstests}/rng-1.c              |   1 +
> >>  .../smokey/vxworkstests}/sem-1.c              |   1 +
> >>  .../smokey/vxworkstests}/sem-2.c              |   1 +
> >>  .../smokey/vxworkstests}/sem-3.c              |   1 +
> >>  .../smokey/vxworkstests}/sem-4.c              |   1 +
> >>  .../smokey/vxworkstests}/task-1.c             |   1 +
> >>  .../smokey/vxworkstests}/task-2.c             |   1 +
> >>  testsuite/smokey/vxworkstests/vxworkstests.c  |  46 ++++++
> >>  .../smokey/vxworkstests/vxworkstests_driver.c |  33 ++++
> >>  .../smokey/vxworkstests}/wd-1.c               |   1 +
> >>  71 files changed, 749 insertions(+), 177 deletions(-)
> >>  delete mode 100644 lib/alchemy/testsuite/Makefile
> >>  delete mode 100644 lib/psos/testsuite/Makefile
> >>  delete mode 100644 lib/vxworks/testsuite/Makefile
> >>  create mode 100644 testsuite/smokey/alchemytests/Makefile.am
> >>  rename {lib/alchemy/testsuite => testsuite/smokey/alchemytests}/alarm-1.c (97%)
> >>  create mode 100644 testsuite/smokey/alchemytests/alchemytests.c
> >>  create mode 100644 testsuite/smokey/alchemytests/alchemytests_driver.c
> >>  rename {lib/alchemy/testsuite => testsuite/smokey/alchemytests}/buffer-1.c (97%)
> >>  rename {lib/alchemy/testsuite => testsuite/smokey/alchemytests}/event-1.c (98%)
> >>  rename {lib/alchemy/testsuite => testsuite/smokey/alchemytests}/heap-1.c (98%)
> >>  rename {lib/alchemy/testsuite => testsuite/smokey/alchemytests}/heap-2.c (98%)
> >>  rename {lib/alchemy/testsuite => testsuite/smokey/alchemytests}/mq-1.c (98%)
> >>  rename {lib/alchemy/testsuite => testsuite/smokey/alchemytests}/mq-2.c (98%)
> >>  rename {lib/alchemy/testsuite => testsuite/smokey/alchemytests}/mq-3.c (98%)
> >>  rename {lib/alchemy/testsuite => testsuite/smokey/alchemytests}/mutex-1.c (98%)
> >>  rename {lib/alchemy/testsuite => testsuite/smokey/alchemytests}/pipe-1.c (96%)
> >>  rename {lib/alchemy/testsuite => testsuite/smokey/alchemytests}/sem-1.c (98%)
> >>  rename {lib/alchemy/testsuite => testsuite/smokey/alchemytests}/sem-2.c (97%)
> >>  rename {lib/alchemy/testsuite => testsuite/smokey/alchemytests}/task-1.c (94%)
> >>  rename {lib/alchemy/testsuite => testsuite/smokey/alchemytests}/task-10.c (97%)
> >>  rename {lib/alchemy/testsuite => testsuite/smokey/alchemytests}/task-2.c (95%)
> >>  rename {lib/alchemy/testsuite => testsuite/smokey/alchemytests}/task-3.c (97%)
> >>  rename {lib/alchemy/testsuite => testsuite/smokey/alchemytests}/task-4.c (98%)
> >>  rename {lib/alchemy/testsuite => testsuite/smokey/alchemytests}/task-5.c (98%)
> >>  rename {lib/alchemy/testsuite => testsuite/smokey/alchemytests}/task-6.c (97%)
> >>  rename {lib/alchemy/testsuite => testsuite/smokey/alchemytests}/task-7.c (98%)
> >>  rename {lib/alchemy/testsuite => testsuite/smokey/alchemytests}/task-8.c (97%)
> >>  rename {lib/alchemy/testsuite => testsuite/smokey/alchemytests}/task-9.c (94%)
> >>  create mode 100644 testsuite/smokey/psostests/Makefile.am
> >>  rename {lib/psos/testsuite => testsuite/smokey/psostests}/mq-1.c (97%)
> >>  rename {lib/psos/testsuite => testsuite/smokey/psostests}/mq-2.c (98%)
> >>  rename {lib/psos/testsuite => testsuite/smokey/psostests}/mq-3.c (98%)
> >>  create mode 100644 testsuite/smokey/psostests/psostests.c
> >>  create mode 100644 testsuite/smokey/psostests/psostests_driver.c
> >>  rename {lib/psos/testsuite => testsuite/smokey/psostests}/pt-1.c (96%)
> >>  rename {lib/psos/testsuite => testsuite/smokey/psostests}/rn-1.c (97%)
> >>  rename {lib/psos/testsuite => testsuite/smokey/psostests}/sem-1.c (98%)
> >>  rename {lib/psos/testsuite => testsuite/smokey/psostests}/sem-2.c (97%)
> >>  rename {lib/psos/testsuite => testsuite/smokey/psostests}/task-1.c (95%)
> >>  rename {lib/psos/testsuite => testsuite/smokey/psostests}/task-2.c (98%)
> >>  rename {lib/psos/testsuite => testsuite/smokey/psostests}/task-3.c (96%)
> >>  rename {lib/psos/testsuite => testsuite/smokey/psostests}/task-4.c (97%)
> >>  rename {lib/psos/testsuite => testsuite/smokey/psostests}/task-5.c (98%)
> >>  rename {lib/psos/testsuite => testsuite/smokey/psostests}/task-6.c (98%)
> >>  rename {lib/psos/testsuite => testsuite/smokey/psostests}/task-7.c (97%)
> >>  rename {lib/psos/testsuite => testsuite/smokey/psostests}/task-8.c (98%)
> >>  rename {lib/psos/testsuite => testsuite/smokey/psostests}/task-9.c (98%)
> >>  rename {lib/psos/testsuite => testsuite/smokey/psostests}/tm-1.c (95%)
> >>  rename {lib/psos/testsuite => testsuite/smokey/psostests}/tm-2.c (97%)
> >>  rename {lib/psos/testsuite => testsuite/smokey/psostests}/tm-3.c (97%)
> >>  rename {lib/psos/testsuite => testsuite/smokey/psostests}/tm-4.c (97%)
> >>  rename {lib/psos/testsuite => testsuite/smokey/psostests}/tm-5.c (97%)
> >>  rename {lib/psos/testsuite => testsuite/smokey/psostests}/tm-6.c (95%)
> >>  rename {lib/psos/testsuite => testsuite/smokey/psostests}/tm-7.c (95%)
> >>  create mode 100644 testsuite/smokey/vxworkstests/Makefile.am
> >>  rename {lib/vxworks/testsuite => testsuite/smokey/vxworkstests}/lst-1.c (99%)
> >>  rename {lib/vxworks/testsuite => testsuite/smokey/vxworkstests}/msgQ-1.c (98%)
> >>  rename {lib/vxworks/testsuite => testsuite/smokey/vxworkstests}/msgQ-2.c (98%)
> >>  rename {lib/vxworks/testsuite => testsuite/smokey/vxworkstests}/msgQ-3.c (98%)
> >>  rename {lib/vxworks/testsuite => testsuite/smokey/vxworkstests}/rng-1.c (99%)
> >>  rename {lib/vxworks/testsuite => testsuite/smokey/vxworkstests}/sem-1.c (98%)
> >>  rename {lib/vxworks/testsuite => testsuite/smokey/vxworkstests}/sem-2.c (98%)
> >>  rename {lib/vxworks/testsuite => testsuite/smokey/vxworkstests}/sem-3.c (97%)
> >>  rename {lib/vxworks/testsuite => testsuite/smokey/vxworkstests}/sem-4.c (98%)
> >>  rename {lib/vxworks/testsuite => testsuite/smokey/vxworkstests}/task-1.c (96%)
> >>  rename {lib/vxworks/testsuite => testsuite/smokey/vxworkstests}/task-2.c (98%)
> >>  create mode 100644 testsuite/smokey/vxworkstests/vxworkstests.c
> >>  create mode 100644 testsuite/smokey/vxworkstests/vxworkstests_driver.c
> >>  rename {lib/vxworks/testsuite => testsuite/smokey/vxworkstests}/wd-1.c (97%)
> >>
> > 
> > All applied, just with some whitespace massaging and a reordering of
> > when the build system is actually updated. See next branch for the result.
> > 
> 
> There were also bugs in the makefiles, breaking vxworks and psos build
> on debian bullseye toolchain at least. Updated patches submitted.
> 
> Jan
> 
> -- 
> Siemens AG, Technology
> Linux Expert Center
> 
