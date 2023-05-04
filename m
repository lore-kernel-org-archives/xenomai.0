Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DEA77E
	for <xenomai@lists.linux.dev>; Thu,  4 May 2023 13:33:27 +0000 (UTC)
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-3f1950f569eso3894595e9.2
        for <xenomai@lists.linux.dev>; Thu, 04 May 2023 06:33:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smile-fr.20221208.gappssmtp.com; s=20221208; t=1683207205; x=1685799205;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :to:subject:from:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rEzqSGPR8VprgjpDWn6aPer2MGYynGKkZbuLMvdPD54=;
        b=N539GUtBy9ybGRGUlV2wIRwyN37gLPKesbTTCoNRU729mjTGb0wHztWM1sgSVTkzWy
         j5CmMM2Ou5SA0134Lp+8WplKpbwrxAQqnFgSQ0bO5heVckzC4lMrO3enUUBfwQNZ6w8G
         PKU1BVhO30e22HkoSE0XGSa8E6psW5XLnseBRMSiF35tGbfgbVedQ/XKXkCOr17i5CHC
         4sPw1eo00tZovmCFc/U2xrzHo/rrdPJUUzhv9ttMG247oJsLAPGWzgPzbmF9zHh7uafW
         xhbK3EJUXNFq5NXpUInnwcCLqmCxHqR3T5GW3oWFMaBiF3l9+aOHb9D7y+uql03bSlc4
         4WJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683207205; x=1685799205;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rEzqSGPR8VprgjpDWn6aPer2MGYynGKkZbuLMvdPD54=;
        b=OeHLjnhAdKhqZgiliV/qWkGDhLh1lJ7kwjRc4SMOvhHhaYkbLYRFbhqvYqizxa7LQH
         DeFA/+CTmIIF5WWJRykvAQGHPxlr98Y7vldE1EUQWaDzo4d/dCE31JQY8TB8eYW/E5oc
         44iRyH7A8E1TMerCIp3KIqmhPxO0mF20KS3wMVi7GDSHVMe+NcUaYykiEwZRrsSuFydt
         uOaVqIF/9d0FeEB9oy7vaM7+od7G8J+Evo1djeC82J6EbxIl9YBNsKkP/zwrMtTMLEl7
         LetKdEDHEt7gm5ZhcvuIwaWX2eeB25v59jPhIf4lhI18+17BNR9KVD9eV/ldbKF8RPCr
         VB5A==
X-Gm-Message-State: AC+VfDxsM6GWI2fAEglFTRd3M2eDY3FczEZ1B7qmHdqeQs9lJWdRQbhr
	SvLDRSFwGon9OqFyYExu0V/dMf6cK+yUDSQiB78=
X-Google-Smtp-Source: ACHHUZ4UeozHHr/fOBxF+3l3v61owRxOjN3PcwT/wSqu4hATGWnvqGP1NuDidRvu1ILCslL232Ya0g==
X-Received: by 2002:a7b:cb8c:0:b0:3ee:6cdf:c357 with SMTP id m12-20020a7bcb8c000000b003ee6cdfc357mr16273134wmi.20.1683207205126;
        Thu, 04 May 2023 06:33:25 -0700 (PDT)
Received: from [192.168.101.56] (i19-lef02-th2-212-194-241-67.ft.lns.abo.bbox.fr. [212.194.241.67])
        by smtp.gmail.com with ESMTPSA id z10-20020a05600c220a00b003f171234a08sm4956440wml.20.2023.05.04.06.33.24
        for <xenomai@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 May 2023 06:33:24 -0700 (PDT)
Message-ID: <7dfbe0c0-161f-0977-4332-75575f1a17ce@smile.fr>
Date: Thu, 4 May 2023 15:33:24 +0200
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
From: Julien Aube <julien.aube@smile.fr>
Subject: Re: Question about a freeze under Xenomai 3.2.1
To: xenomai@lists.linux.dev
References: <5a8afa1e-d6d7-df9f-2895-6832ffa9673f@smile.fr>
 <189dee91-923f-131a-ccae-0afcccd06107@siemens.com>
Content-Language: fr
In-Reply-To: <189dee91-923f-131a-ccae-0afcccd06107@siemens.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hello,

Le 03/05/2023 à 16:57, Jan Kiszka a écrit :
> Well, 3.2.3 would also work with 5.15.y.


Thanks. Following this comment I tried the kernel 
5.15.109-dovetail1-rebased on all the following tests.
I just had to update a few unrelated things like the DTS.

The behaviour with 5.15 is exactly the same.


> First of all, can you reproduce the issue when disabling Xenomai? And
> when also disabling dovetail? And when using the corresponding LTS
> kernel as is?


Here is what I have tested:

* LTS kernel (5.10.177 & 5.15.109) : works
* Dovetail kernel (5.10.177-dovetail1 & 5.15.109-dovetail1-rebase)  / 
xenomai 3.2.1
     * with CONFIG_DOVETAIL=n + CONFIG_SMP=y : works
     * with CONFIG_DOVETAIL=y + CONFIG_XENOMAI=n + CONFIG_SMP=y : works
     * with CONFIG_DOVETAIL=y + CONFIG_XENOMAI=y + CONFIG_SMP=n : works
     * with CONFIG_DOVETAIL=y + CONFIG_XENOMAI=y + CONFIG_SMP=y : fails

As an additional test, I tried with CONFIG_SMP=y but nr_cpus=1 on the 
cmdline.
In this configuration the failure still happens.


=> For me there is a problem specific to the SMP behaviour, since the 
tests are working fine in the non SMP case.
It might be that I do not understand the full extend of the SMP vs 
xenomai setting though.

As a sidenote I've added all I the debug flags I could think of.
Unfortunaly I can't use KDB since my serial console (usb-based on 
motherboard) does not translate a break correctly and I cannot fall into 
kdb.


Julien



