Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B070C1802B
	for <xenomai@lists.linux.dev>; Tue, 31 Oct 2023 09:35:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-409299277bbso34567885e9.2
        for <xenomai@lists.linux.dev>; Tue, 31 Oct 2023 02:35:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698744950; x=1699349750;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OAWBbVg0qfLu29470X6ohBsw817f+xheONGy2EdDEQ4=;
        b=J0hcsUhHwVWAuekm94ly0FwE9r8TX9XJA08iC8POgCkGwqGw5UorklQcLMJo1HyChO
         Jx/Xa+0RnIy5FukL5jaTC3wBOLlgAS9L8n6eAsUjrbnb1G2BHCbkoyvmK3PBRYrDVLSn
         TdpWdfWwmltTfJhIxcgZ0NNF2Q4lTOB9k6oNGOdsTxCGo50nEZzsQrtvPTFWkg/yUT3I
         JsZbDWHYhh5exyywJceUf8aG8qWW2Vp6uf0ojjXijlxmNBz6ngNym3MHciwUt+2Mrt5F
         fj8RnnrnE95+AwVqBYnPBT0uDfsyZe3ypS6bURyov8ecq1/JcvPWPFYhYpAtfO8g/Hwb
         /EPQ==
X-Gm-Message-State: AOJu0Yy0wwZm1Fi/G/q2jMrbD6N7m2XuJiEGWTWaBjpJgBBaUdQ580/F
	whtQKtk7AJS1lDJmumJxgbnCIdOq/4a83w==
X-Google-Smtp-Source: AGHT+IFIm7r4vN+YZe6PAq+jIxU8/OUrFz2je53JUtLIfWTP4ZOrwlbb6qb98/e5fUxvYRnmasHDnQ==
X-Received: by 2002:a05:600c:4ec6:b0:401:daf2:2735 with SMTP id g6-20020a05600c4ec600b00401daf22735mr10753560wmq.31.1698744949547;
        Tue, 31 Oct 2023 02:35:49 -0700 (PDT)
Received: from pyro ([2a01:e0a:19b:3cd0:989a:5c4b:b7ff:baf])
        by smtp.gmail.com with ESMTPSA id n6-20020a05600c4f8600b0040813e14b49sm1199963wmq.30.2023.10.31.02.35.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Oct 2023 02:35:49 -0700 (PDT)
References: <3eda6fb3c3b5d1c000f7e41205bca2e96e04bc0d.camel@siemens.com>
User-agent: mu4e 1.8.11; emacs 28.3
From: Philippe Gerum <rpm@xenomai.org>
To: Florian Bezdeka <florian.bezdeka@siemens.com>
Cc: xenomai@lists.linux.dev, jan.kiszka@siemens.com
Subject: Re: Dovetail build failure
Date: Tue, 31 Oct 2023 10:31:54 +0100
In-reply-to: <3eda6fb3c3b5d1c000f7e41205bca2e96e04bc0d.camel@siemens.com>
Message-ID: <87wmv3gmmn.fsf@xenomai.org>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain


Florian Bezdeka <florian.bezdeka@siemens.com> writes:

> Hi Philippe,
>
> current CI jobs are failing with the following error. The reason
> resides inside a recently added patch titled 
>
>   dmaengine: bcm2835: dovetail: use IRQ forwarding 
>
> The declaration of the flags variable has been removed but the variable
> is still being used:
>
> 2023-10-30 20:16:40 - INFO     - | ../drivers/dma/bcm2835-dma.c: In function 'bcm2835_dma_callback':
> 2023-10-30 20:16:40 - INFO     - | ../drivers/dma/bcm2835-dma.c:507:17: error: 'flags' undeclared (first use in this function)
> 2023-10-30 20:16:40 - INFO     - |   507 |                 flags = readl(c->chan_base + BCM2835_DMA_CS);
> 2023-10-30 20:16:40 - INFO     - |       |                 ^~~~~
> 2023-10-30 20:16:40 - INFO     - | ../drivers/dma/bcm2835-dma.c:507:17: note: each undeclared identifier is reported only once for each function it appears in
>
> At least 5.10 and 6.1 -rebase branches are affected.
>
> Best regards,
> Florian

Fixed upstream, thanks.

-- 
Philippe.
