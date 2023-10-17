Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CFF63D3AF
	for <xenomai@lists.linux.dev>; Tue, 17 Oct 2023 13:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-32caaa1c493so4544004f8f.3
        for <xenomai@lists.linux.dev>; Tue, 17 Oct 2023 06:14:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697548471; x=1698153271;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FHA3TlNc6IgrUVIljKtHeutLlmGdMWY6jBew/YgbR/8=;
        b=cDnOoIRThettUaXZUWGtItNxIycHLRy1o7RUgzLQMUEWt0rCdidxaY7/jFCrZTw7Ep
         /jk+ddPfGMB22M8//tY6AuJqn66zzQaRA0jQV08HCV0EgQquOkZ6k302cG2o2FDFplEJ
         MlMEf2yERlOurMekb3wvxWkzCUYRPeKJYKlticj4ftT7yHdOjb+zFkz0raZvJpFXGkIo
         sq6fdbq5MpwWkWpZDNu9pICFpAZZ4P0uQhABIln0YO1+u6nkRvI3mpFqK+36ccCUsxpb
         dgMQF3lzCUJkce94we4PX2OHqzwvc50DVx3GgD2sOg5RRDz586v8QhfOSKFwDryJePaa
         vtiw==
X-Gm-Message-State: AOJu0Yzf/SAj4Dhs9EA8lFfMQPqIaGp5TJWxN4rAOh1hb/I1U6gIg0OD
	SSbQ2CWw+n7Euc+UDOruR//6QkVGNRncTg==
X-Google-Smtp-Source: AGHT+IFx7yKYt34HEO7ULh7z6RygQHI6cIeujmOAmnVT0VjpaIRcNUSscjjCGZZnp6+Pfj61WKgJAQ==
X-Received: by 2002:adf:db42:0:b0:329:6be4:e199 with SMTP id f2-20020adfdb42000000b003296be4e199mr1985259wrj.13.1697548470937;
        Tue, 17 Oct 2023 06:14:30 -0700 (PDT)
Received: from pyro ([2a01:e0a:19b:3cd0:989a:5c4b:b7ff:baf])
        by smtp.gmail.com with ESMTPSA id a2-20020adfb502000000b0031984b370f2sm1672450wrd.47.2023.10.17.06.14.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Oct 2023 06:14:30 -0700 (PDT)
References: <b349a125-28b7-4b1c-b02a-d87a115d28b1@siemens.com>
User-agent: mu4e 1.8.11; emacs 28.3
From: Philippe Gerum <rpm@xenomai.org>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Xenomai <xenomai@lists.linux.dev>
Subject: Re: Missing v5.10.195-dovetail2-rebase?
Date: Tue, 17 Oct 2023 15:12:52 +0200
In-reply-to: <b349a125-28b7-4b1c-b02a-d87a115d28b1@siemens.com>
Message-ID: <87fs292xxq.fsf@xenomai.org>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain


Jan Kiszka <jan.kiszka@siemens.com> writes:

> Hi Philippe,
>
> I've seen you tagged "genirq: irq_pipeline: do not request IPI on
> uniprocessor" via v5.15.129-dovetail2-rebase and
> v6.1.54-dovetail2-rebase, but there is no tag on the 5.10 side -
> intentionally?
>

Yes, I noticed an unrelated DMA issue with CONFIG_IMX_SDMA_OOB. Working
on it.

-- 
Philippe.
