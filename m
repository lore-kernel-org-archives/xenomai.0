Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65631156F3
	for <xenomai@lists.linux.dev>; Fri,  5 May 2023 13:31:41 +0000 (UTC)
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-3f315712406so99515615e9.0
        for <xenomai@lists.linux.dev>; Fri, 05 May 2023 06:31:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smile-fr.20221208.gappssmtp.com; s=20221208; t=1683293499; x=1685885499;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=81BP512LCfKbpB6vCdmP9ewfxC1wcMaMMNdOXv0dZKg=;
        b=OtXSiveZ0TSLEDmBrpHntTQ8niRuOpvHY/PkHPXJZKmu3PKbxgrBrAs6JLbsixQQLt
         lMWxfGkGc3ONdbRjnx07c2yY2moh2MSU12PR/pTl5hMxBYAEvFURY4a0c9j2CkTEgCxH
         B9ga8bHj6d5v1jFykyNC3oIC0ZyvnuiFLIOA/m3hpLoetOG7Wi3U+mc193mKMGDk96nJ
         PY24R92Irg3IL1SX25q/+7E8x8FnBeg1stKfQA4sNYH0XLxK29dvZ96XE1PC60iBj+Ft
         EZN1dk5f7av12kGvR7woldGyVJXkGQpDJKxZHMi7BF4oX89S+JnG9C5tM4KGopiOlcVf
         lfIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683293499; x=1685885499;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=81BP512LCfKbpB6vCdmP9ewfxC1wcMaMMNdOXv0dZKg=;
        b=W4F3rLdvJnnXJJNdnBxkwGGI8vj0M1JIszlr0s2dUCTFy0/poz2za/uU+cNTIFP6om
         3iCBlg29ZG2o2qUUFho28m+gxxSb7ukQe52ZG3vGzvJnGbwo09xTJ6Af7N2NRsJBbpQw
         IZcaS+d1aU0j2zxIvD+FbefafS5K1TuYYVXgTefFjd/wM1z29A/DamCmYL9OCxz2zphb
         r0xW8qoMNV0ZWOHxgTAt1H4dN4r2JzHuim2qNovZUezUN2ltGB3d0J8feDR3KpMqjJ6D
         7FHgGwbwEjSQYwh/QsZOkfPu2UbAUWYG0uxukOdL/4ZY+oOsFvIPMVD/mzqRwxnQmYf4
         piPg==
X-Gm-Message-State: AC+VfDxzSXtl0w89QerSXUruriXsaxdkGGZA8VsAsayIrHQurH7+FaCl
	6lAOi/OJwUtpY/50wrd9q8V7A30dyMX54SJXpZA=
X-Google-Smtp-Source: ACHHUZ6TaAb0PU9EHeoBN5HJNEetOsxprSHUk4C7bBeupRwMeO1gFuJ1wxCAHDcJKUfmaK6KL5eVmg==
X-Received: by 2002:a05:600c:21cf:b0:3f1:9b77:f56d with SMTP id x15-20020a05600c21cf00b003f19b77f56dmr1342716wmj.5.1683293499254;
        Fri, 05 May 2023 06:31:39 -0700 (PDT)
Received: from [192.168.101.56] (i19-lef02-th2-212-194-241-67.ft.lns.abo.bbox.fr. [212.194.241.67])
        by smtp.gmail.com with ESMTPSA id k12-20020a7bc40c000000b003f175b360e5sm8047646wmi.0.2023.05.05.06.31.38
        for <xenomai@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 May 2023 06:31:38 -0700 (PDT)
Message-ID: <5ffe60b2-e0fe-2569-b8f7-30ce08592665@smile.fr>
Date: Fri, 5 May 2023 15:31:38 +0200
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: Question about a freeze under Xenomai 3.2.1
Content-Language: fr, en-US
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
From: Julien Aube <julien.aube@smile.fr>
In-Reply-To: <8060f103-6222-6df9-d478-bbac2b8807d9@siemens.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


Le 05/05/2023 à 15:21, Jan Kiszka a écrit :
>> I had an issue like this some time ago, also with a Zynq 7000, Linux Dovetail 5.15, Xenomai 3.2 and a Buildroot build.  Processes would freeze after executing
>> some kind of delay e.g. sleep(). It looked like the default timer for the Zynq did not generate timer events for the proxy tick interrupts. I'm now trying a setup with
>> the Zynq global timer as source of events. That seems to run Ok so far.
>>
> Now I recall: There is very likely some adaptation needed for that
> default timer /wrt dovetail. Someone would have to dig into the details,
> looking left and right on other board/SoC enablements.
>

Thank you .

I'll have a look on this. I've never plunged this far in the internal of 
xenomai, I just used it so far.
If I find something it may end up to a possible patch for zynq support.


Julien

