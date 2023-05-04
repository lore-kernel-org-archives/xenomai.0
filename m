Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF1472F48
	for <xenomai@lists.linux.dev>; Thu,  4 May 2023 15:50:48 +0000 (UTC)
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-3f192c23fffso5134225e9.3
        for <xenomai@lists.linux.dev>; Thu, 04 May 2023 08:50:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smile-fr.20221208.gappssmtp.com; s=20221208; t=1683215447; x=1685807447;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=R5bSnUO3l4ie4EvxNZDyyYOCPZEw0C6ICNh7/BKukEc=;
        b=Huex3Z7oYwDEofqfl+yuRgIqVVYGTC10s9xI93qgtLYEg74eW+IOcC4za9ab43Icjl
         UG74IAAjRsQOLczBnRVMeja8oLcrwlh+rSec/pGZWtCjtvm4aoNLnErnIO4N37S+l25n
         HEl+fwkGvnzgarQqTcz+k8BJgYna9KYbzHujysCFz93fCk8F10ElV4+ieR9wJVnoxqGx
         YEFQ/Qu2xkpsMKKZNvOeLND5lJleP++9KKp13MCv8jz1NqUQvWUAlbQMKLjCRrjsDKlL
         FKmsCpfBpzYl0O9sUFz8zw4c9tYAvhLmlBmpHKFSmVmnGnhAbfu3ajJsvf+iSbfhRa/m
         kkBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683215447; x=1685807447;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=R5bSnUO3l4ie4EvxNZDyyYOCPZEw0C6ICNh7/BKukEc=;
        b=J5Dx5OYEiKB2/ZOG+bKOujU+AhnW4Nd7BTq6tux34wnMifgeMg2ikdT3m6v2oKcoJe
         hmrmfki2r0EES0F04yWzuzJB6iAU5hbEXL3lgjNPXxqAWhQdujavOXSKEiFhuXe7mnrP
         0Ul8Dzasn15bTX+DN2hj2ai775tjwiY2Za6RqhyUX55ZrVjIyjb6Ixz8iHlz3t2XWpmy
         0ohJckwPgQnZYPWT2EQ9niq4l0VVWCgX37QYSUKMcOSIj+H60UJWcExbL+1i38UdMU5q
         9x6s/4CgqgvdHkMOJ1TtI2Mu2JFQ4B1In2gJ6IykaeiQ8qlaPD9F0VJu87ln9j4EOhpQ
         jZBA==
X-Gm-Message-State: AC+VfDxe70IWAQ7ifSzI0TLkk+9C1aTDOFRf9E0zliUv78HIFfaNE3S1
	6MRKq3ne9LRFddWHem6Tppw3uRRe/lEuhrNS5MA=
X-Google-Smtp-Source: ACHHUZ6Z0fsgrca3C3DMSG4ydysowRfmxfA0OoxfNo2f0NGSlM4EZu0Be/msYYyK4h7aEhAZfZLyIw==
X-Received: by 2002:a7b:c399:0:b0:3f1:6527:df05 with SMTP id s25-20020a7bc399000000b003f16527df05mr86412wmj.22.1683215446832;
        Thu, 04 May 2023 08:50:46 -0700 (PDT)
Received: from [192.168.101.56] (i19-lef02-th2-212-194-241-67.ft.lns.abo.bbox.fr. [212.194.241.67])
        by smtp.gmail.com with ESMTPSA id l9-20020a7bc449000000b003f2390bdd0csm5263473wmi.32.2023.05.04.08.50.45
        for <xenomai@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 May 2023 08:50:46 -0700 (PDT)
Message-ID: <0e065176-74b8-b02a-29c2-30eb34a79cdb@smile.fr>
Date: Thu, 4 May 2023 17:50:45 +0200
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: Question about a freeze under Xenomai 3.2.1
Content-Language: fr
To: xenomai@lists.linux.dev
References: <5a8afa1e-d6d7-df9f-2895-6832ffa9673f@smile.fr>
 <189dee91-923f-131a-ccae-0afcccd06107@siemens.com>
 <7dfbe0c0-161f-0977-4332-75575f1a17ce@smile.fr>
 <9a48d273-5ebd-f557-7941-8532b7ec4b67@siemens.com>
 <5523da9b-bb44-a1be-9e54-bcad21867eb6@smile.fr>
 <CALLqZ8TeAeeu++UP499YS_XPwVYw05eMEYf-K7HPmyhXHBoACg@mail.gmail.com>
From: Julien Aube <julien.aube@smile.fr>
In-Reply-To: <CALLqZ8TeAeeu++UP499YS_XPwVYw05eMEYf-K7HPmyhXHBoACg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Le 04/05/2023 à 17:00, Greg Gallagher a écrit :
> I think we saw this issue a while ago.  I can't remember if a proper
> patch was submitted.  Let me take a look at my setup here.  I test
> ipipe on both zynq7000 and Ultrascale boards.  I had a dovetail
> environment to test zynq 7000 since there were some small issues
> reported in the past. I should have some time to boot something
> similar this weekend and see.
>
> -Greg

Thanks for your help.
As an additional test I tried a RedPitaya that I own (very useful tool 
btw) , based on a 7010. Same issue occurs in the same setup.

Interesting to know that some issues occurs in the past. I'll try to see 
if I can find some insights in the mailing list archive.

Julien

