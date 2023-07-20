Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 066B8171A9
	for <xenomai@lists.linux.dev>; Thu, 20 Jul 2023 15:01:41 +0000 (UTC)
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-3fbd33a57dcso8033125e9.0
        for <xenomai@lists.linux.dev>; Thu, 20 Jul 2023 08:01:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sigma-star.at; s=google; t=1689865300; x=1690470100;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OMMQch0DAniyU3us4lEZJiEXpV5Yy2hlWOZ1vEro5bQ=;
        b=SNL9CdB6boa6NyCPt0gABt5aopecmJZJurYE0giE/Li1V/GFqOIaMlf8IZHWVToDRJ
         3FLyeEm1OZKtg0NIUb3OPdSPcmxfN1oX9s/2xMC0BMFkgOLJbmDZnfp5WtBSQUyAnrJh
         rNkROYFQRQ1X0qFeghWHwgnC3ZrS+jdURgH6Qj0DND0kaYnTX62XxqQZENT6IqSg8cwq
         2whu/HhY3v4XKlwcjeX6zGxZxtYKZshZKc2FfU9onYbwp7EJ2hV3nvEkhYQEzaqPFxFU
         g5sDr5I+v61aqxcoYK5KuFj/mJI5VQ98oHfDSzRJhpVOauZXK+mqV5PRJLNTBbCqnbEo
         TTLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689865300; x=1690470100;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OMMQch0DAniyU3us4lEZJiEXpV5Yy2hlWOZ1vEro5bQ=;
        b=haRQ9UJj1x/xdwHTnI54lrWIwmLAfoRLZMZSLF9UAL0xBl8SAtLGvLClSUZL9OXB5o
         HAFAD40o2V55ZUVth/poXoqwwsaWUqAmQ0sHGhLh+FKvzYRKnJvmPscc7VttUMZfdqR4
         UkLcqK6FggKQKCfFf8RxLpOpWpj/tzz3cWfk4OrnsYVm8MNyH0wb17ghSS1KLtTM0ORN
         QkcbxrunrnKbUBocvU4ZK/tBHPnOcvW9//BSRysv/qeh3esHR1nf2Y5oMmsYFwEpC3S6
         n0zMx7XbLHCuLPrE4+IINPQ8H3hCBU9fbZmhV2xLvL95nEeLWME1fOy5Nzys1lbKv/ou
         /XLw==
X-Gm-Message-State: ABy/qLaUJeW5Y8GAhc9csnAqzVeuXczVic95Lr+F3jgnxrAAXJl/3Kuv
	U33Kfd55EcNnzoh9xqKLH52uaFqivhSZIjGoPV0=
X-Google-Smtp-Source: APBJJlEu4HNFo4Qn6yJegEl0aRpty5XWJ7SB2vS4TF7rAGNoWcHyN9TRqc978BdD4KQDfEY7Sw4GAQ==
X-Received: by 2002:a05:600c:21cd:b0:3fb:a46c:7eac with SMTP id x13-20020a05600c21cd00b003fba46c7eacmr1977638wmj.7.1689865299829;
        Thu, 20 Jul 2023 08:01:39 -0700 (PDT)
Received: from mail (212-186-60-23.cable.dynamic.surfer.at. [212.186.60.23])
        by smtp.gmail.com with ESMTPSA id n23-20020a7bcbd7000000b003fa999cefc0sm1357489wmi.36.2023.07.20.08.01.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jul 2023 08:01:39 -0700 (PDT)
Date: Thu, 20 Jul 2023 17:01:38 +0200
From: Aaron Marcher <aaron@sigma-star.at>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: xenomai@lists.linux.dev, richard@nod.at
Subject: Re: [PATCH v4 00/10] Revive alchemy, pSOS and VxWorks tests
Message-ID: <20230720150138.4slgcgcmwtu6z4yk@mail>
Mail-Followup-To: Aaron Marcher <aaron@sigma-star.at>,
	Jan Kiszka <jan.kiszka@siemens.com>, xenomai@lists.linux.dev,
	richard@nod.at
References: <20230406103341.2914-1-aaron@sigma-star.at>
 <20230720145150.24607-1-aaron@sigma-star.at>
 <8128f5be-8891-badd-d83b-c34065438c4e@siemens.com>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <8128f5be-8891-badd-d83b-c34065438c4e@siemens.com>

Hi Jan,

> Thanks for the update! For the lazy maintainer at least: What's new in v4?

sorry for the missing changelog. Here are all major changes since v3:

- Fully integrated all tests into Smokey framework, as discussed
- Disabled some tests with comments, as discussed
- Fixed task-2 in alchemytests
- Fixed task-5 in alchemytests
- Rebased to latest master

Aaron

-- 
sigma star gmbh | Eduard-Bodem-Gasse 6, 6020 Innsbruck, AUT
UID/VAT Nr: ATU 66964118 | FN: 374287y
