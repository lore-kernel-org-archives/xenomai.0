Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0563182A7
	for <xenomai@lists.linux.dev>; Wed,  3 Jan 2024 09:07:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-40d88f9e602so21017765e9.3
        for <xenomai@lists.linux.dev>; Wed, 03 Jan 2024 01:07:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704272872; x=1704877672;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MMRSreWalp3FDF3WNBXutiAbbHTxJx+hKdT/DTGgdZE=;
        b=Iam/ACMvtVmLm2UnSWrLP9D3AeIwYi47IBhFLXSWhVprcCY9pSMLHyNoclJuRl2tLy
         wC1yoxr24y8L1lljNgLz8/lgE3x9sjcrsvetFRy4PyZ/YzPKPwxjx8eu+96mWG83cK0o
         CF5+pz9zxj+x24zhBWC6LQ21CzDaZ9zrf6nbIsvWgHchD7cwRF7vtlFfKevsOiBGTiay
         E8rMtQYxTVAElRLaWUn8XpwZGrKX6FUINjNZj1/GAhw6Ziry+ZQY6rwPwH8SZXJy0+xL
         +8HNyG6wo11i3NqeY9gmVZ1t8+jm84J+1KL6TDeonr2XIEzBgTvroD6Khy2QbAqAUfIB
         qFYQ==
X-Gm-Message-State: AOJu0YzLBuyLALCViGqU1KK+dzODkwgkXSLL1fd+aSVNc6xnsaBUhMkk
	3oXycWmcTWjtGuJfmvAL7RKfgANwYWTaeg==
X-Google-Smtp-Source: AGHT+IEW6LixNpBwILCVTZ+VjhOHFSCHgUShId9JnwfA24vFiEy/FPXEfHtrsSLLvVgcHL0v/mspew==
X-Received: by 2002:a05:600c:2201:b0:40c:2d7e:6f72 with SMTP id z1-20020a05600c220100b0040c2d7e6f72mr9446724wml.118.1704272871756;
        Wed, 03 Jan 2024 01:07:51 -0800 (PST)
Received: from pyro ([2a01:e0a:19b:3cd0:989a:5c4b:b7ff:baf])
        by smtp.gmail.com with ESMTPSA id v6-20020a05600c444600b0040d5f3ef2a2sm1670488wmn.16.2024.01.03.01.07.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jan 2024 01:07:51 -0800 (PST)
References: <76d5ecd7-ff91-4973-ade0-a1a63fdbd9cc@siemens.com>
 <ca68187b-b9e8-4200-9090-81f768b1b5cb@siemens.com>
User-agent: mu4e 1.10.5; emacs 29.1
From: Philippe Gerum <rpm@xenomai.org>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Xenomai <xenomai@lists.linux.dev>
Subject: Re: [libevl][PATCH] build: Reject building for i386
Date: Wed, 03 Jan 2024 10:07:40 +0100
In-reply-to: <ca68187b-b9e8-4200-9090-81f768b1b5cb@siemens.com>
Message-ID: <87bka2wzrx.fsf@xenomai.org>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain


Jan Kiszka <jan.kiszka@siemens.com> writes:

> On 17.12.23 17:22, Jan Kiszka wrote:
>> From: Jan Kiszka <jan.kiszka@siemens.com>
>> 
>> This architecture is not supported but we were silently converting it
>> into 64-bit x86.
>> 
>> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
>> ---
>>  meson.build | 7 +++++--
>>  1 file changed, 5 insertions(+), 2 deletions(-)
>> 
>> diff --git a/meson.build b/meson.build
>> index bbde902..fdb2e55 100644
>> --- a/meson.build
>> +++ b/meson.build
>> @@ -46,12 +46,15 @@ pthread_dep = dependency('threads')
>>  
>>  # Do some architecture name remapping
>>  libevl_arch = host_machine.cpu_family()
>> +if libevl_arch == 'x86'
>> +    error('i386 not supported')
>> +endif
>>  if libevl_arch == 'x86_64'
>> -   libevl_arch = 'x86'
>> +    libevl_arch = 'x86'
>>  endif
>>  
>>  if libevl_arch == 'aarch64'
>> -   libevl_arch = 'arm64'
>> +    libevl_arch = 'arm64'
>>  endif
>>  
>>  post_install = find_program('post-install.sh',
>
> As you are merging already, don't forgot this one as well. Minor but
> possibly still helpful for newbies.
>

Merged, thanks.

-- 
Philippe.
