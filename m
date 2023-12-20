Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2165F1F5E4
	for <xenomai@lists.linux.dev>; Wed, 20 Dec 2023 09:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QYTNAdyQ"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-28b71490fbbso1837964a91.0
        for <xenomai@lists.linux.dev>; Wed, 20 Dec 2023 01:00:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703062818; x=1703667618; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RaL0Lckxt4LL63v0/7jDL5rqePG+WWCU8UYK/axTnoc=;
        b=QYTNAdyQ9llfVdaZKuxjqi5XxPkJM+RrWydj45jzZd1atTVktAJuso5Hd7yRftwc79
         +2Z2IaPdY2vLJqO6we4Dbn/XlGi13/fep4Fr+JSM4Q+YSyM3ONbzNGvfRkob4YRoXIQN
         b6Tw7mxN6SLBReoCAzCHyWVfmyltDEPYW+PLl4NHaEC/mcZgvZkefdUzZkN/tZCsZGaC
         HpIlw8lFQlnoVsPIv+HY5mxao9GstIkhMTVhICDozDJNIMRZiVuUhzoDQqO93i3BdHVY
         lr5/wZ9itNt/nmfkyA6RlrTMgMlm3kojrOyqsCAle1bqhlowHAiSDkc+lzsMbEyUlEl/
         0j9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703062818; x=1703667618;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RaL0Lckxt4LL63v0/7jDL5rqePG+WWCU8UYK/axTnoc=;
        b=doqcg4unHEn12gy53ZWtHyjd++DzpLEfnGNfzPARxrSW7PpuIvbRbbAVVuREuOFLZT
         Bb+vopq0rjhV1QlNAlwHQ0mcU+uNshUo2a74l+JtwUuYEevrZKMTkoHylX7rggkrvPzK
         4+DPsNHv8uNVjrwYR//c0fWXeYmIG2rhue+x3VZ7STJSICVW7QSpIVePyS7co0cLSBlw
         yS6F0iLp5Rw/kyPWEOkZsptKIh+uDqq4PahaBnpXG8QjpbrhJI/80zTVEJ65smkc+pYB
         chG/kQrEbsp8hUn7e1l8TPe6TNLVzxn+r7082FQj80KpEwcn/69QI1HVtarj/LQlWuK+
         v9Hw==
X-Gm-Message-State: AOJu0YxJXPMZycchz+o9px3llraa3MwuZfj768j0JubnoeDetQxBxxZl
	14zL6WGvcwvEsyoTGJz+afN71QlMWETbkejOCNQ=
X-Google-Smtp-Source: AGHT+IFx3cSnZVB95QR/mku5Z8dmRRv96wcgH40hlONDWcHd0u/csFRyv6c9ecvjkOMlmh4ZwEhBwW/6uzljIUrrgPk=
X-Received: by 2002:a17:90a:5b0f:b0:28b:bc0d:b861 with SMTP id
 o15-20020a17090a5b0f00b0028bbc0db861mr1258403pji.34.1703062817657; Wed, 20
 Dec 2023 01:00:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <CAH0t8y2Y6OP0g1c6duLKK6GnEjd2AYtsBfGJp_GKUprz+-kz7Q@mail.gmail.com>
 <e7624208-3436-44ce-b46e-eeb8e73d9f27@siemens.com> <398875541.48372669.1702980839753.JavaMail.zimbra@telenet.be>
In-Reply-To: <398875541.48372669.1702980839753.JavaMail.zimbra@telenet.be>
From: =?UTF-8?B?VGFtw6FzIFBhw6Fs?= <paal.tam@gmail.com>
Date: Wed, 20 Dec 2023 10:00:06 +0100
Message-ID: <CAH0t8y0Ck3A9A311Qy9qEXaXNFK3fmVrjycDQOB7tTyB_k_q9Q@mail.gmail.com>
Subject: Re: rt_e1000e and Intel i219
To: g.strobbe@telenet.be
Cc: xenomai <xenomai@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Gino,

Thank you very much!
Just for sure. I should apply these patches on the Linux kernel source
tree, and the result is the xenomai driver source, that I need to copy
into the xenomai master source directory, by overwriting the files
already there. Am I right?
Does the v6.4-dovetail-rebase Linux source tree that I should choose
as a starting point?

Best Regards,
Tamas



<g.strobbe@telenet.be> ezt =C3=ADrta (id=C5=91pont: 2023. dec. 19., K, 11:1=
4):
>
> Hi Tamas,
>
> Please find attached the latest version of those patches.
> They were created against the v6.4-rc5 kernel.
>
> Best Regards,
> Gino
>
> ----- On Dec 18, 2023, at 5:49 PM, Jan Kiszka jan.kiszka@siemens.com wrot=
e:
>
> > On 18.12.23 13:33, Tam=C3=A1s Pa=C3=A1l wrote:
> >> Dear All,
> >>
> >> The current version of the rt_e1000e driver does not support any Intel
> >> i219 network device. I found a mailing about this from 2019. This one:
> >>
> >> https://www.mail-archive.com/xenomai@xenomai.org/msg16000.html
> >>
> >> The "unofficial" patches (created by Gino Strobbe), that upgrades the
> >> rt_e1000e driver should be there as attachement, but I could not
> >> download it. Probably when the mailing list had been moved to the
> >> archive server, something happened with those attachements.
> >>
> >> Does anybody has those patches? If yes, could you please them send me.
> >>
> >
> > I'm afraid, those are lost in the unfortunate settings of the old
> > mailing list.
> >
> > But given their age and the source kernel, it would be better to resync
> > the driver against a recent version anyway.
> >
> > Jan
> >
> > --
> > Siemens AG, Technology
> > Linux Expert Center
