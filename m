Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C631C1FDF
	for <xenomai@lists.linux.dev>; Wed, 17 May 2023 07:30:17 +0000 (UTC)
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-965ab8ed1c0so53667166b.2
        for <xenomai@lists.linux.dev>; Wed, 17 May 2023 00:30:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sigma-star.at; s=google; t=1684308616; x=1686900616;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PmPWMdtFZeAWOlAJOmbfENd7A4xDWa0z7SfyeRyg2go=;
        b=vogSoCyCDK1ZVVmAF1nceatqXhs3aFKycLySltIvGzTpB1zCllX4q+vaixUvfy5HBp
         MrMl3Op7gYzsvRYLfRUwLyHw/M4RPAKPRQ3ghfo0UYgDNLGDdLfpXiW2taDzFO7DFNL8
         16MvQp0DJa/TzDExKmmuizQZiIMTYrpajbxPKzQqe1rJrgXjndF+gM4Z3Ggjomea/8x4
         EvOxLNA7uRc0xOLF/0j3ggyNvWIO6AyTpqQlXwCvW8dGzXf3XM1sXKa+A1B7slcEjJyg
         tGUnclX+FnFjXv5u+stLlJdJtpdXf2mSr74fKvLXs1JmI8hLaIa8864IM0BIrZKbbHTE
         vc7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684308616; x=1686900616;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PmPWMdtFZeAWOlAJOmbfENd7A4xDWa0z7SfyeRyg2go=;
        b=GGHez6+02Utn2i6a4l+fmP2PFJHNzBf2qtXeiNElQp78/sYjkGDLsLYA2wjvqvd2ZD
         YJ8dCHh0ZB6guunLw8X8HXivppFEmPiItXfA0vlKUjBaaqMLL0LsF3pZ/EIEbD6mrIZm
         BAEcDmauvRoiMhJs+pB5cfeE0LDJjU7v3cIad7eRRRcCHrWUwho2hhUw/PTmClXMj80C
         fHnnGwSbijqHTOA1t+omcavZDiaZMuf2WVPGfhKFxoEK365TH0jbr/AAWceocrZtGETQ
         mx25TTU4+CW3/RIuOTY0ml5GqtkPjEUzxiJpEqFowEfeFBF6RN2gomU0/QJtuQWsfisP
         6Byw==
X-Gm-Message-State: AC+VfDxQZM05ETTRp/nKE7eGDdfvneJzsSsO9Kn6XwDy+3qSE007o+ZH
	AQpYxqScj0Q51oYKsMcsoXLj5A==
X-Google-Smtp-Source: ACHHUZ40XBs/wCm2DobH2zRcurkGKtN14dDkGdJDSYJZetfuudMz3AzjPLyGVxdHA4EEwmG0KEPbbw==
X-Received: by 2002:a17:906:db07:b0:94f:6058:4983 with SMTP id xj7-20020a170906db0700b0094f60584983mr31697246ejb.76.1684308615798;
        Wed, 17 May 2023 00:30:15 -0700 (PDT)
Received: from mail ([82.150.214.1])
        by smtp.gmail.com with ESMTPSA id d21-20020a170906c21500b00965fdb90801sm11971682ejz.153.2023.05.17.00.30.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 May 2023 00:30:15 -0700 (PDT)
Date: Wed, 17 May 2023 09:30:14 +0200
From: Aaron Marcher <aaron@sigma-star.at>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: xenomai@lists.linux.dev, richard@nod.at
Subject: Re: [PATCH v3 0/11] Revive alchemy, pSOS and VxWorks tests
Message-ID: <20230517073014.ygkkfjuxd3lzksr6@mail>
Mail-Followup-To: Aaron Marcher <aaron@sigma-star.at>,
	Jan Kiszka <jan.kiszka@siemens.com>, xenomai@lists.linux.dev,
	richard@nod.at
References: <20220413215819.22954-1-richard@nod.at>
 <20230406103341.2914-1-aaron@sigma-star.at>
 <8ee4086e-580d-3d15-cade-4d983c86e402@siemens.com>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <8ee4086e-580d-3d15-cade-4d983c86e402@siemens.com>

Hi Jan,

I tried integrating the tests into the smokey framework like other ones
in the repository. However, the linked tests never show up when listing
using `smokey -l`.

I made sure to place them in the `testsuite/smokey` directory, correctly
link them into the testsuite like the other tests and call
`smokey_test_plugin()` along with a run function spawning the tests.

Do you have any hints for me what to watch out for when integrating the
tests so that they correctly show up?

Thanks,
Aaron

-- 
sigma star gmbh | Eduard-Bodem-Gasse 6, 6020 Innsbruck, AUT
UID/VAT Nr: ATU 66964118 | FN: 374287y

On Sun, Apr 16, 2023 at 09:32:49AM +0200, Jan Kiszka wrote:
> On 06.04.23 12:33, Aaron Marcher wrote:
> > This patch series is an attempt to integrate the currently abandoned
> > alchemy, pSOS and VxWorks tests into Xenomai's test suite.
> > Since each test assumes running as own process a test driver is needed
> > which executes each tests separately.
> > The driver makes use of the smokey framework.
> 
> ...but it does hook up with smokey, thus will not run as part of
> xeno-test and our CI. Please fix that - after either resolving the
> remaining broken tests or disabling them for now. It should be easy to
> spawn the new tests as separate processes from a smokey instance and
> visualize their results as part of smokey.
> 
> Thanks,
> Jan
> 
> -- 
> Siemens AG, Technology
> Competence Center Embedded Linux
