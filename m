Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B976117D1
	for <xenomai@lists.linux.dev>; Mon,  8 May 2023 17:49:30 +0000 (UTC)
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-3077d134028so2349697f8f.3
        for <xenomai@lists.linux.dev>; Mon, 08 May 2023 10:49:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smile-fr.20221208.gappssmtp.com; s=20221208; t=1683568168; x=1686160168;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :to:subject:from:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fE2DF3WJBFZkysGDOSY31NEmMroNCiCsLFMl4sEbKFQ=;
        b=uMNaw9b+FiuP/iLGlObAkkrN++uZQcHCdMOGBsfI8Ynu9mnD6+WH9nU5ctcDC/tSdG
         11WSjcnyqYKFp4/q3A9e3WSyLjxeClKcJdF4D1RYnnrsDexOEjBfj1INWeL9ewas8yLa
         GXoLkSEOye/B6g4SDd0iRhmNrZD3lEJtU23ACB8J55/jGrdAFT7sxAiWanmdSVvG7/ZU
         16wFsSnntvFXkc88J5eqVCU2baE8UReBxDL+2nmJllPJ0J5ufNN+Wz0MX3eI1pQ0EJcd
         3XuuDvT9FKgeqsuOqq/BGP2c46k8O2SPUgV433hzxgXwBfbzitg0Lmq2alRIWgJB+pkP
         +HvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683568168; x=1686160168;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fE2DF3WJBFZkysGDOSY31NEmMroNCiCsLFMl4sEbKFQ=;
        b=bGF9zDbBUJpXD3PIy6j5XNCTg1H1Hte9d4P3okqkJ04dr1nh6fXnym7BqZ4vpnlXPw
         CkR4qCaMtSK+5C6RpHuXjNHZiyAjQS1fc/iauJDd98OwQCVXN0mACUKfegX39SFhAC5x
         hujDHTnG7+Q3EhZ9WTuUxKdoqujSinD4SggzMdrtNYwmylOvi7JETnJ9ZskTY6YDhQlc
         kMAGPdkGXlF/8dD/hpsQXkiwaH/VOGi7ynl1NiRQiq9m5T1ZltxvjwSwpwxeQ3fdF7q2
         VohWR8eiXmsxYn/ZUKwcRW9zQkUgcRM6M+E5CjBeohr9SfUEomcy1deIFtb3horqcUvY
         vhKg==
X-Gm-Message-State: AC+VfDxjXP4HOi6oYy+Hn/sDGOkwGLMJoYYa6RhNZCVfm8yMxBsivVSF
	H1owg+25XxqPb+ftS0zzxNSf0vceMbJfohvWqEA=
X-Google-Smtp-Source: ACHHUZ5W7mZcLmaiXC0D3oav03paYNIl6SaexnMwArsPuP02f8cmOohSOu9bIvs3cB3F1f3pU1ov/A==
X-Received: by 2002:a05:6000:1148:b0:306:36e7:db27 with SMTP id d8-20020a056000114800b0030636e7db27mr7968405wrx.16.1683568168401;
        Mon, 08 May 2023 10:49:28 -0700 (PDT)
Received: from [192.168.101.56] (i19-lef02-th2-212-194-241-67.ft.lns.abo.bbox.fr. [212.194.241.67])
        by smtp.gmail.com with ESMTPSA id n17-20020a5d4211000000b002f9e04459desm11891072wrq.109.2023.05.08.10.49.27
        for <xenomai@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 May 2023 10:49:28 -0700 (PDT)
Message-ID: <6814fa90-015e-91df-6941-db643e4d4229@smile.fr>
Date: Mon, 8 May 2023 19:49:27 +0200
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
To: "xenomai@lists.linux.dev" <xenomai@lists.linux.dev>
References: <5a8afa1e-d6d7-df9f-2895-6832ffa9673f@smile.fr>
 <189dee91-923f-131a-ccae-0afcccd06107@siemens.com>
 <7dfbe0c0-161f-0977-4332-75575f1a17ce@smile.fr>
 <9a48d273-5ebd-f557-7941-8532b7ec4b67@siemens.com>
 <5523da9b-bb44-a1be-9e54-bcad21867eb6@smile.fr>
 <CALLqZ8TeAeeu++UP499YS_XPwVYw05eMEYf-K7HPmyhXHBoACg@mail.gmail.com>
 <0e065176-74b8-b02a-29c2-30eb34a79cdb@smile.fr>
 <DB7PR10MB2459812A2291AB88A99ECBB5EC729@DB7PR10MB2459.EURPRD10.PROD.OUTLOOK.COM>
 <8060f103-6222-6df9-d478-bbac2b8807d9@siemens.com>
Content-Language: fr
In-Reply-To: <8060f103-6222-6df9-d478-bbac2b8807d9@siemens.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hello,

Le 05/05/2023 à 15:21, Jan Kiszka a écrit :
> On 05.05.23 09:36, Schuman Eelco (DC-AE/ESW5) wrote:
>> Hi,
>>
>>>> I think we saw this issue a while ago.  I can't remember if a proper
>>>> patch was submitted.  Let me take a look at my setup here.  I test
>>>> ipipe on both zynq7000 and Ultrascale boards.  I had a dovetail
>>>> environment to test zynq 7000 since there were some small issues
>>>> reported in the past. I should have some time to boot something
>>>> similar this weekend and see.
>>>>
>>>> -Greg
>> I had an issue like this some time ago, also with a Zynq 7000, Linux Dovetail 5.15, Xenomai 3.2 and a Buildroot build.  Processes would freeze after executing
>> some kind of delay e.g. sleep(). It looked like the default timer for the Zynq did not generate timer events for the proxy tick interrupts. I'm now trying a setup with
>> the Zynq global timer as source of events. That seems to run Ok so far.
>>
> Now I recall: There is very likely some adaptation needed for that
> default timer /wrt dovetail. Someone would have to dig into the details,
> looking left and right on other board/SoC enablements.


With your suggestions I finally had a working setup with SMP:

The culprit shown itself when I printed the original timer that is 
proxied by the timer_proxy,

On the non-SMP kernel the timer is set to "arm_global_timer", while on 
SMP it was set to "local_timer" :


 > IRQ pipeline: high-priority Xenomai stage added.
 > CPU0: proxy tick device registered (333.33MHz)
 > CPU0: proxy original clock: arm_global_timer

vs

 >CPU0: proxy original clock: local_timer
 >CPU1: proxy original clock: local_timer

 From what I understood, there is one timer per CPU , while the 
arm_global_timer is global to the system.

Digging a little more, I found out that the local_timer was implemented 
by the "scutimer" on the zynq7000 platform.
As a first approach, I just disabled this timer in the DTS.

With that the proxy original clock is now arm_glocal_timer for both CPU 
and it work.

However.... I have a bad feeling about this, it look like I did not go 
down to the real issue which is that the scutimer does not
generate timer events as it should.

Eelco , is that how you resolved the situation on your side ?

Many thanks for your help an tips for this issue,

Julien Aube
