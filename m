Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 457EBA23
	for <xenomai@lists.linux.dev>; Thu, 13 Jun 2024 16:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718294962; cv=none; b=jKtpGLXWWYYACW3y6rbfqp+N8QAw2zxli9zNE1uvEsZLENikIue9o1px7JOEYFhmuVtL4wixIIp91F/XMHTV14bdHOIeV5agqrboBskgyQqRA+kAMUTr2MnRthKd0N8hPpeVanh3fqGEDzVmsZj0skH2gdekJnSu1io7eKvhL44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718294962; c=relaxed/simple;
	bh=1XlG3CR0xpDqPqMh87D+GrDZX5VejYOXn1Sz5BA+hVk=;
	h=References:From:To:Cc:Subject:Date:In-reply-to:Message-ID:
	 MIME-Version:Content-Type; b=ZLk7URXL1L83knQFv3XixULEedFpPbLAimjeZ3wk58wB4XBdw6tlF+HrqGipwv7BrnBBE/4W3d+Q4ywnxlI8n/9xNkFw5zxkZN0cN2/SFfVlaZ7LfFpWFq1r8AVW05+n3Ppxm5rHkoYAKOYv88K8Hvx7AeY5LxYiiRdp5JoHAIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a6e349c0f2bso177397266b.2
        for <xenomai@lists.linux.dev>; Thu, 13 Jun 2024 09:09:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718294958; x=1718899758;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vXWpTvblqs5qlMfWhv7cMBMgUihwxO9lxFVhCz5Ndlk=;
        b=ChHoS7IGxzWzA+1jWkLIJL2RYle1XZHTxyhtvyz/b6Tti/0+gw0aF7A/PpIayXuJfD
         Zt873qBwn2DHqPkLkbN1bv0vi8xqCCnfgWTZQV6vWI1f0x0hqFv9IdPihGIE01eaoDVE
         6+mcN/Vk3vFDxWD6WRH5sNi5EUv2j+pUAEmSwSr0lnkq/58giwTbdiKml27Xv154YgW9
         awTX48/QEF6u4gS3SQZsrqbDWfOEI5Xug8tochNHpAnh+186SwxFLTgfOmglLh2n5uUi
         VDqwsvICRfRYO9xYFEW/UYhwkmNHIVECWKJEsGOHXX8ahcotGIVYcy3vGK3As9aHXGjt
         9d3g==
X-Forwarded-Encrypted: i=1; AJvYcCWG4zkk6keZqZUeo/aXb5ZjNCAklcyeFkydhHGWOMQIqEKfDN0FcCt8A5v1kk5p3i53HUMq75s+7NfAuvLtK3VFU5WfcGjBpw==
X-Gm-Message-State: AOJu0YxZyX/a6uLxbdPFzdROcM5JCSSzxJUjSwv+UMEYA5Q01YEsW9OO
	XuqNHx1QCVBMIpWg0ZXJfWAtmYsShHk6eoTLyDW8l2dy7mn4zRenqlCLiA==
X-Google-Smtp-Source: AGHT+IGxhMeb16meifDx7j7T6fDh4MS2aBiS3r5Wd3jkrSS7E96ENbAhGSmG/KvUNovC9mqjtkKlkQ==
X-Received: by 2002:a17:906:57c2:b0:a6f:eb8:801a with SMTP id a640c23a62f3a-a6f60dc51c7mr12125966b.56.1718294958076;
        Thu, 13 Jun 2024 09:09:18 -0700 (PDT)
Received: from pyro ([2a01:e0a:19b:3cd0:989a:5c4b:b7ff:baf])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6f57552633sm83467066b.191.2024.06.13.09.09.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jun 2024 09:09:17 -0700 (PDT)
References: <20240613134557.4013044-1-tobias.schaffner@siemens.com>
 <20240613134557.4013044-2-tobias.schaffner@siemens.com>
 <87frtgrker.fsf@xenomai.org>
 <fb5efca7-cba3-4115-86be-0b719c5a74b4@siemens.com>
User-agent: mu4e 1.10.5; emacs 29.3
From: Philippe Gerum <rpm@xenomai.org>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Tobias Schaffner <tobias.schaffner@siemens.com>, xenomai@lists.linux.dev
Subject: Re: [libevl][PATCH 1/4] Copy dohell from Xenomai 3
Date: Thu, 13 Jun 2024 17:55:02 +0200
In-reply-to: <fb5efca7-cba3-4115-86be-0b719c5a74b4@siemens.com>
Message-ID: <877cesrfir.fsf@xenomai.org>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain


Jan Kiszka <jan.kiszka@siemens.com> writes:

> On 13.06.24 16:23, Philippe Gerum wrote:
>> 
>> Tobias Schaffner <tobias.schaffner@siemens.com> writes:
>> 
>>> Dohell is used as the default load generator in Xenomai 3. Add it to
>>> libevl to be able to stress the system while testing evl.
>>>
>> 
>> dohell is obsolete. Let's move to stress-ng or something alike for x4.
>> 
>
> See my comment on patch 3: If you can name a configuration of stress-ng
> that stresses a co-kernel more than what dohell does, we can take it.
> Otherwise, I would strongly recommend to not do less hell over here.
>

The most important stress dohell applies is basically hackbench and a dd
loop trashing the D-cache. The latter can be obtained with a combo of
VM+I/O tests from stress-ng. So basically, the whole issue boils down to
having hackbench on board, provided we cannot generate the same load
profile with stress-ng with a CPU bound stressor. Besides, I never saw
any added value in running ltp tests compared to a combo of stress-ng
stressors when it comes to latency testing.

We obviously don't want to throw less hell, but throwing more obsolete
stuff is not an option either. So that's a NAK for v4 ATM, I'll gather
more information about how we could leverage stress-ng in order to
compare to dohell. This is worth a shot.

-- 
Philippe.
