Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8580A2D631
	for <xenomai@lists.linux.dev>; Fri,  3 Nov 2023 14:36:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sigma-star.at
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sigma-star.at
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sigma-star.at header.i=@sigma-star.at header.b="mjNTQXxX"
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-543c3756521so3476014a12.2
        for <xenomai@lists.linux.dev>; Fri, 03 Nov 2023 07:36:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sigma-star.at; s=google; t=1699022189; x=1699626989; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uyihoXEywowj/Zq9yzF9GrhZ1cfAt1ZgCOkVS6CGiZs=;
        b=mjNTQXxXB++Ttxu8K5a8VtshmU3iUNxBsxbL37N9SROVjFgyxvj8WKDQkqg+yDA9A7
         rZUYclM9QPWwHO891h0jWZMTp4frCCkiHiHlsr7ouYW4ZCYblNDNxtMCeXfsLaDMERVT
         3fuqkvxluGVsx4Co6/2s9Q3kcfmAB1YHseOTT1KmZvAOVBjxEAj2QjeCF2fzBKkHVedX
         bCJxs1hK30Xh4c5Vs/pL2jQO9E0pXf1LLXdu8TyHak6M1rbXYuk084kd6Ijt5Z9TUUpJ
         ypgru3Hv0sq4OdIQEEvEmjRbhpxqsomoXZX9GvjGHQaatxJVIg683NltPSRIpd7clwoj
         PtBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699022189; x=1699626989;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uyihoXEywowj/Zq9yzF9GrhZ1cfAt1ZgCOkVS6CGiZs=;
        b=mc6mougxvxiBi72cJmpNRvSRHMHd29L2ysHNg5HSSpJoetM1BfVneLasUvkUxBt/NJ
         yeHeVly0E/KV8P7C/MNZUhr8ijSYIIun9SUr8Rj/UptTe2LFSIN0VD1FMx/Jrpn1y7qP
         7dD61aw9QPeDXMvJOy6CTDVaMWHGypCA/PoFOOzb/MK85+zxRj+ktKzNpEEwLp/Kn6wK
         2nSE9tUIZHJXjhdZRG1y0nBFVD7pv+yGXG4rtt1N8sSyK7m+giFsEfWs2h4QUWW9OIen
         x9OKcSfQgnKqDeqR+se4xy/oj8bDS79bmyQpp8sb4sd9vM2SAq5uXefmoC4tF+gYLMPa
         w7Gw==
X-Gm-Message-State: AOJu0YwJdL1PxPhsG7GJMHIeGL4e2cfkOd/qmX9d6EGk1q92kYkO8lDF
	H+dMmtfwbPRPSUU35U+0+lgnEA==
X-Google-Smtp-Source: AGHT+IF7SFTIiEcQFTDzGdgmBQarQYRrpvTeMp6WRB/Z23FXvuGLzIdXF8pEDKpV0oxV5cjCkEvNDg==
X-Received: by 2002:a50:bb08:0:b0:53f:72a7:5ae with SMTP id y8-20020a50bb08000000b0053f72a705aemr17480849ede.12.1699022189527;
        Fri, 03 Nov 2023 07:36:29 -0700 (PDT)
Received: from mail (212-186-60-23.cable.dynamic.surfer.at. [212.186.60.23])
        by smtp.gmail.com with ESMTPSA id q22-20020a50cc96000000b0053d9cb67248sm1033736edi.18.2023.11.03.07.36.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Nov 2023 07:36:29 -0700 (PDT)
Date: Fri, 3 Nov 2023 15:36:29 +0100
From: Aaron Marcher <aaron@sigma-star.at>
To: Florian Bezdeka <florian.bezdeka@siemens.com>
Cc: xenomai@lists.linux.dev
Subject: Re: [PATCH 0/6] Minor testsuite cleanups
Message-ID: <20231103143629.j4mk6qihavilejdm@mail>
Mail-Followup-To: Aaron Marcher <aaron@sigma-star.at>,
	Florian Bezdeka <florian.bezdeka@siemens.com>,
	xenomai@lists.linux.dev
References: <20231030-flo-cleanup-testsuite-v1-0-0fb7bbd2d45f@siemens.com>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231030-flo-cleanup-testsuite-v1-0-0fb7bbd2d45f@siemens.com>

Hi Florian,

thanks for the cleanups on my changes.
Reviewed-by: Aaron Marcher <aaron@sigma-star.at>

Best regards,
Aaron

-- 
sigma star gmbh | Eduard-Bodem-Gasse 6, 6020 Innsbruck, AUT
UID/VAT Nr: ATU 66964118 | FN: 374287y

On Thu, Nov 02, 2023 at 03:41:41PM +0100, Florian Bezdeka wrote:
> Hi all, 
> 
> this is the result of the analysis of our recent CI logs. Seems that we
> did not properly report failing tests and continued with test execution,
> hiding some real (but still minor) issues.
> 
> Best regards,
> Florian
> 
> Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
> ---
> Florian Bezdeka (6):
>       testsuite: vxworkstests: Do not try to call nonexistent binary
>       testsuite: smokey: Refactor smokey_run_extprog()
>       testsuite: smokey/spitest: Fix --keep-going in combination with --verbose
>       testsuite: alchemytests: Skip pipe test if kernel support is missing
>       testsuite: vxworkstests: Skip tests if low resolution clock not enabled
>       testsuite: psostests: Skip tests if low resolution clock not enabled
> 
>  include/smokey/smokey.h                      |   3 +-
>  lib/smokey/helpers.c                         |  14 +++-
>  testsuite/smokey/alchemytests/alchemytests.c |  74 +++++++++---------
>  testsuite/smokey/alchemytests/pipe-1.c       |   8 +-
>  testsuite/smokey/main.c                      |   5 +-
>  testsuite/smokey/psostests/psostests.c       | 109 +++++++++++++--------------
>  testsuite/smokey/vxworkstests/vxworkstests.c |  64 ++++++++--------
>  testsuite/spitest/spitest.c                  |   5 +-
>  8 files changed, 142 insertions(+), 140 deletions(-)
> ---
> base-commit: 14470d7d58dbfe7210cfa93f03e241a38d9fa798
> change-id: 20231030-flo-cleanup-testsuite-bc6ea7f6dc31
> 
> Best regards,
> -- 
> Florian Bezdeka <florian.bezdeka@siemens.com>
