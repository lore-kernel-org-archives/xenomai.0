Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47EF72D030
	for <xenomai@lists.linux.dev>; Tue, 17 Oct 2023 17:24:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-40836ea8cbaso5101695e9.0
        for <xenomai@lists.linux.dev>; Tue, 17 Oct 2023 10:24:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697563495; x=1698168295;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D4q2IdZ1ntLJx20gLTZXn5YrbOh+FUPXoqsm63XG6YQ=;
        b=uVdr4j4dv5sOFT8JzroMdKZ0zbibgJquly19FQEXCfn2Y40nAw/5ZGSYeedxlyIs3N
         nNzavvQGt5SE1LPXesCLWO+Z1K2+KZNZsI1hvWizmpAuzgUZxGquUm/I+xFtfQHgBZZn
         aPrmSkIHmfjkhjGSFExc1BAKjffT7KpEYjixGIeft7NlwHpq5lIT+jnUc1B+LEa14eSK
         tcul/njgxMbhiTJODjVVoNrEBQnbtC6YNKLzTS/3045BnMSfaSt0sIv5VTV7WAG/wZ7P
         7rOnspYkwSQcYjThkANH9zcs2oZyyM4z1IoH1DuQyVmt1NR4/gD8na+Og7iDlSH/Hbm3
         o73w==
X-Gm-Message-State: AOJu0YydzwQ7XkgUq+uiIPX1NJDN48ENq8nfoLQXLUzbcSUKh4Sik5NR
	rMuJKIUOpZ+9yGD80tixzDEfB9uNM4Dx5A==
X-Google-Smtp-Source: AGHT+IFUpuqO9ZU9xoXfiZO2Fd+WEZs6iFxIGai0j80ruE2yz5XufdqqRHosot6vhEbqsZcY7Swe1w==
X-Received: by 2002:a05:600c:470c:b0:406:7d74:a29b with SMTP id v12-20020a05600c470c00b004067d74a29bmr2122326wmo.13.1697563495202;
        Tue, 17 Oct 2023 10:24:55 -0700 (PDT)
Received: from pyro ([2a01:e0a:19b:3cd0:989a:5c4b:b7ff:baf])
        by smtp.gmail.com with ESMTPSA id t15-20020a05600c450f00b004064288597bsm2434480wmo.30.2023.10.17.10.24.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Oct 2023 10:24:54 -0700 (PDT)
References: <b349a125-28b7-4b1c-b02a-d87a115d28b1@siemens.com>
 <87fs292xxq.fsf@xenomai.org>
User-agent: mu4e 1.8.11; emacs 28.3
From: Philippe Gerum <rpm@xenomai.org>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Xenomai <xenomai@lists.linux.dev>
Subject: Re: Missing v5.10.195-dovetail2-rebase?
Date: Tue, 17 Oct 2023 19:06:03 +0200
In-reply-to: <87fs292xxq.fsf@xenomai.org>
Message-ID: <87bkcx2mc9.fsf@xenomai.org>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain


Philippe Gerum <rpm@xenomai.org> writes:

> Jan Kiszka <jan.kiszka@siemens.com> writes:
>
>> Hi Philippe,
>>
>> I've seen you tagged "genirq: irq_pipeline: do not request IPI on
>> uniprocessor" via v5.15.129-dovetail2-rebase and
>> v6.1.54-dovetail2-rebase, but there is no tag on the 5.10 side -
>> intentionally?
>>
>
> Yes, I noticed an unrelated DMA issue with CONFIG_IMX_SDMA_OOB. Working
> on it.

The tag has landed. However, the recent fix to support stacked irqchips
[1] uncovered a nasty issue which dates back to the dark ages, with a
(fortunately) not-so-common practice of relaying _hardware_ irq events
from oob to inband using irq_post_inband(), so that the same IRQ handler
can implement a two-step handling. This does not affect synthetic irqs,
only real/device-originated ones, observed with fasteoi so
far. Introducing the explicit deferral status (IRQS_DEFERRED) in irq
descriptors revealed the problem. IOW, this is no regression, rather an
ancient bug who crawled out from under a rock.

Fortunately, I have a real use case at hand (imx-dma). Working on
providing a sane replacement for the current open-coded way.

[1] b9132dbc8c31c genirq: irq_pipeline: fix irq flow handling with stacked irqchips

-- 
Philippe.
