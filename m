Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E957E10786
	for <xenomai@lists.linux.dev>; Mon, 21 Nov 2022 22:17:12 +0000 (UTC)
Received: by mail-ed1-f42.google.com with SMTP id z18so18194087edb.9
        for <xenomai@lists.linux.dev>; Mon, 21 Nov 2022 14:17:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2LA8IuAEAU+3DPvBoXy+eEEbuGav04oB+uxzYV+HJZ4=;
        b=MTUq6uKS3xAu66tPNd89vGw01SJTP7I3b3EFwFlIRLwlDbH58OL6R4Bj3MhROk5cyX
         25iwao6Mq9vLFfmJR8j+ONA7fNMuxQjyGxrkbMDFDSquWQsDR+r1c1bUc90KBgsQHobB
         y2ZVEsN/J4MLUENpWaDxovu+/dRfkQlN92RY7h6bG0cS7s7A3Qs9eC5t7QW788csv+dh
         JeW0YYMQ6OsEzGxHBaILoWGRtS3k7GBmDGWrvE9tUKoE26Kp+WAr1SvQvBUTiy1w0B6y
         KUuIuAS55isZbfKLjfEzSL231OhMhzwMNlWxtHhtDJ5jrGAyJw+awHs81Yr1DhnJnyco
         s8XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2LA8IuAEAU+3DPvBoXy+eEEbuGav04oB+uxzYV+HJZ4=;
        b=dv2RRIqbbPwwf3xcYx6RB8gvUm3OdH6/nktQXiJBpchi3ps3X5tNGyBDGnKWrIzho2
         sxWqRQhEp++gOvjvw7JiagPP2uWw3RxuicQWHd1iV7WQUWM1zhvHs9slYoxM6FAycahw
         LHE/UozsFh3kbjYh+9keCBMIWLGnXef6nIRjiXZei20zRJ7B0fxMUSQUIclZQqB8baM4
         /ZeqIJ4+DmYsUG+pQNkZDYYU6VWhqBZtsqQ57tyGF1CBO/k0dNNToesqmOAK/EuC6Mm3
         UqfdVJaYhV2k9J0BrhkfM5dwtHHMNPIZKm96GNUUkFsje5+WfKkfTUOPpaR9uO7T/q89
         gQLQ==
X-Gm-Message-State: ANoB5pnRRLEeurPr0Togg9v//ocAGU8idVH1eB1pJ8GQQn0tOKtH/FMn
	BucC/THzeohOXcbO545R/liHCleNVS8=
X-Google-Smtp-Source: AA0mqf5i1KPdVZbHWbkoAWUu7pp8C2zBMvOvwJuBqGb1dlS/UF15aKrYipuDg904eppqXjucHvKCmQ==
X-Received: by 2002:a05:6402:110d:b0:469:dd6:bfee with SMTP id u13-20020a056402110d00b004690dd6bfeemr1369490edv.330.1669069031050;
        Mon, 21 Nov 2022 14:17:11 -0800 (PST)
Received: from [192.168.42.52] (62-46-95-169.adsl.highway.telekom.at. [62.46.95.169])
        by smtp.gmail.com with ESMTPSA id kk18-20020a170907767200b007aed2057eaesm5318741ejc.161.2022.11.21.14.17.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Nov 2022 14:17:10 -0800 (PST)
Message-ID: <41898024-cd35-5e7f-978c-2e8005a12712@gmail.com>
Date: Mon, 21 Nov 2022 23:17:09 +0100
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: cyclictest vs. latmus
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai@lists.linux.dev
References: <49fb01fa-abda-46eb-cf47-31d48810d7eb@gmail.com>
 <87a653p28w.fsf@xenomai.org> <3ef4b7b1-8bd4-edea-9518-1b2efce90cce@gmail.com>
 <87cz9tc0t4.fsf@xenomai.org>
Content-Language: en-US
From: Robert Berger <xenomai.list@gmail.com>
In-Reply-To: <87cz9tc0t4.fsf@xenomai.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

Sorry for the late reply - I was on the road.

My comments are inline.


On 11/11/2022 10:00, Philippe Gerum wrote:

> The latency spikes you observed is related to CPU frequency scaling (see
> [1]), the "performance" governor was not the default one in your
> Kconfig, but the on-demand governor was, leading to dynamic frequency
> adjustment. This should be reported by the following command on your
> system:
> 
> ~ # evl check
> CONFIG_CPU_FREQ_DEFAULT_GOV_PERFORMANCE=n
> CONFIG_FTRACE=y
> 
> CONFIG_FTRACE is also reported because it does have a noticeable impact
> on the latency figures even when no tracer is enabled on ARM, although
> the overhead is still negligible compared to actual latency killers.
> 
> Setting CONFIG_CPU_FREQ_DEFAULT_GOV_PERFORMANCE=y is enough to fix your
> Kconfig as I did here.
> 
> HTH,
> 
> [1] https://evlproject.org/core/caveat/#caveat-cpufreq

Absolutely!

I fixed my kernel config and now the graphs looks like Xenomai 3.

Thanks!

Regards,

Robert

-- 
Robert Berger
Embedded Software Evangelist

Reliable Embedded Systems
Consulting Training Engineering
URL: https://www.reliableembeddedsystems.com

Schedule a web meeting:
https://calendly.com/reliableembeddedsystems/
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
--

