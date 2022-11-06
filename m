Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8531E2F4D
	for <xenomai@lists.linux.dev>; Sun,  6 Nov 2022 19:11:03 +0000 (UTC)
Received: by mail-wr1-f49.google.com with SMTP id j15so13446561wrq.3
        for <xenomai@lists.linux.dev>; Sun, 06 Nov 2022 11:11:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qxJWqHn/vWXT2mj0eNC97cKafhelYMk6Kb8tGpWUGUE=;
        b=T9+4HHeLVSJe9+8m4/5uQZKgRd5VO99DJDvSWA0UcrmbDUOGX/maPnFSWHTqdMK7VG
         f/VRgSMw03sn9xPH0GItCsgtNowL9lM9KacZU7r2N8VzetFSm/XUSv/IVwdS/xJVdz1+
         +/2aWtZsH8HOigRx+thAqbm0sgPzijrOetxi1R7BDRAL2RYwtgccIrVYvzB+W48E941P
         qm9la99bf5PL5AxMCPwydXFl2IZ28+Y+H8d0CroaqXyGrLC5P53mOdParKa75TkHyTEH
         hiARrEDSANqIUfZLUhEzzkZoOhC+Dp+QqgeEDSMO0BQys9Ls+Ajr4SKCa55y/V0lQMNv
         OACw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=qxJWqHn/vWXT2mj0eNC97cKafhelYMk6Kb8tGpWUGUE=;
        b=qzO8HfaRLAK7Eo37x5OfN9EqcES4rDdJyooY5IWHsVgVJcqiTYNnKtvLaIIBmBZXuo
         ZM6QCxelPaXQDdIAqTxP1gxpJz+20VEeWp21kcuqgl3Igh4AR8FNsMYC1yk2YAVOrxlK
         04uyoRuwqdbAZ1Um7JGPbT8bCf25EKbhGpjGnp+Q6CbnkarlRQUNcF8m6nJCqtwF7Yv9
         FE9WpVzptWsb8ATrl4zny7silWX7qOOLL9mhCKBME1Ta7q0OwexKZAIZmI+YaVwnHuue
         rkE19DpR2niVCZOUZKuZQYRdNTjYbQjhPYrOPqC8Ljd/ZZ210buuD2qT1gs2R5zz35kf
         MowQ==
X-Gm-Message-State: ACrzQf2VABZXntrhopitITKoSWLCITQlHhrxug4LGj5mn3piPKnKCakI
	FGywn3M3tzKgpdxJwxY7s2SWwQQr21k=
X-Google-Smtp-Source: AMsMyM4uCK2cSzyi0O804FyooPFCtAB1LmoaoYw1/L0nj3/uC3Ijqmk+CZMZKnT1VkqYT19Nd+fxUg==
X-Received: by 2002:adf:e199:0:b0:236:b24b:aaf9 with SMTP id az25-20020adfe199000000b00236b24baaf9mr489949wrb.394.1667761861818;
        Sun, 06 Nov 2022 11:11:01 -0800 (PST)
Received: from [192.168.42.52] (91-114-219-213.adsl.highway.telekom.at. [91.114.219.213])
        by smtp.gmail.com with ESMTPSA id ck17-20020a5d5e91000000b002383e977920sm5277920wrb.110.2022.11.06.11.11.01
        for <xenomai@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 06 Nov 2022 11:11:01 -0800 (PST)
Message-ID: <49fb01fa-abda-46eb-cf47-31d48810d7eb@gmail.com>
Date: Sun, 6 Nov 2022 20:11:00 +0100
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Content-Language: en-US
To: xenomai@lists.linux.dev
From: Robert Berger <xenomai.list@gmail.com>
Subject: cyclictest vs. latmus
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi,

I run some test cases with cyclictest and cyclictest built for xenomai 3 
for a couple of years now and want to switch to xenomai 4/evl.

Looks like I managed to compile an evl kernel and the evllib and I use 
latmus instead of cyclictest (not sure if I'm doing that correctly) and 
also I compare the results against cyclictest (not sure it's right to do 
that they way I'm doing it).

Anyways, sorry for the lengthy document I came of with[1] with 
histograms and questions.

Here are my questions, which you can find in a nicer formatted way in 
the doc[1].

= evl Kernel - CONFIG_PREEMPT_NONE - cyclictest =

My understanding is, that evl works similar to xenomai 3, meaning that 
you need to compile/link an application against libevl for evl to kick 
in. I would expect figures 15 and 16 on page 10 to look like figures 3
and 4 on page 4.

What’s odd is

*) the outlier in the graph without load is bigger than the one with 
load (1.3 ms vs. 550 us), which should be the opposite

*) the outlier in the graph with load should be like the one in figure 4 
which is around 10 ms, but it is more like 550 us - please note that the
kernel config contains CONFIG_PREEMPT_NONE=y and CONFIG_EVL=y
Does this observation imply, that an evl kernel modifies the behavior of 
the "vanilla" Linux scheduler for processes which should run on the 
"standard/vanilla" Linux scheduler?

= evl Kernel - CONFIG_EVL - latmus =

I am not quite sure if/how latmus compares to cyclictest. Ideally I 
would like to compare histograms produced by latmus against those I 
produce with cyclictest.

Let’s have a look at graphs 17 and 18 on page 11.

*) the outlier in the graph without load is bigger than the one with 
load (780 us vs. 700 us), which should be the opposite

*) xenomai 3 with cyclictest compiled for xenomai - figures 13 and 14 on 
page 9 performs significantly better than evl with latmus
**) no load outlier: xenomai 3(cyclictest): 26 us - evl(latmus): 780 us
**) load outlier: xenomai 3(cyclictest): 65 us - evl(latmus): 700 us

*) a preempt-rt patched kernel with cyclictest - figures 9 and 10 on 
page 7 performs significantly
better than evl with latmus
**) no load outlier: preempt-rt(cyclictest): 120 us - evl(latmus): 780 us
**) load outlier: preempt-rt(cyclictest): 119 us - evl(latmus): 700 us

*) a vanilla kernel with CONFIG_PREEMPT with cyclictest - figures 7 and 
8 on page 6 performs similar
to evl with latmus
**) no load outlier: preempt-rt(cyclictest): 880 us - evl(latmus): 780 us
**) load outlier: preempt-rt(cyclictest): 720 us - evl(latmus): 700 us

Please check the .pdf here[1] for more details:

[1] 
https://drive.google.com/drive/folders/1_5PZ_4sQxvL5MbiQU1Y1kUXC5IjF5SSX?usp=sharing

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
