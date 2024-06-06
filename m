Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 627A714D29D
	for <xenomai@lists.linux.dev>; Thu,  6 Jun 2024 09:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717664895; cv=none; b=OABAPrbqpTi44vpYD50SJOPb5A6kfXjgxjwB2g43JwngTyrMeoIRQ6rPCTX4uMYwNBt1BmA75jlrdIWlyyCrNeTIbr7i0xuTo6R4vJUg+/98+4gfN7L60OhDkBGHvyLO9ANq5Sq6OI/qOylhI3QqKvvWMbPtvpss5bG7vwewlnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717664895; c=relaxed/simple;
	bh=WphrQ/eSBMoUQtDDqLoe03ilP+2Y2+Y/iHCYzHRg3Ns=;
	h=References:From:To:Cc:Subject:Date:In-reply-to:Message-ID:
	 MIME-Version:Content-Type; b=fCqlFkg2lUOzGN8vVs7+ZP5Yb5uQMTyfTblkr/uI9mIclYAvOs+oTZ2594gT7Cj4/13yfQLEH6LUdE9ko/97t4frLIYCKC/8enh9Il9LqDAFc3OZN+4Nt6gpAKcvZ6Qxtrrnp/AAWJSSUrzmKf9bHJGAmnnmd2bfls84MRpYdeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-35dc7d0387cso898341f8f.1
        for <xenomai@lists.linux.dev>; Thu, 06 Jun 2024 02:08:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717664892; x=1718269692;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
         :subject:cc:to:from:user-agent:references:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=WphrQ/eSBMoUQtDDqLoe03ilP+2Y2+Y/iHCYzHRg3Ns=;
        b=kNx9yALCIG7hCA6RRAyTdeRZ8oojeT0ProXLELBW3pg2kJiZZOmJ4kVJZ/ZjHK4H+v
         xdhGzvd4kHizzGLdTDQCKg8A5iUqU+WPuYCFnD8k0JMlaOjRz7gFSam2wyP4ratl40lW
         5ZDvjJm+gpSM1vk7CCQPM80hyAJyE/T6St4VtNB1e1NxhBNixwumAjSp5ABLUrxLHqm3
         8pasQz6H6eUpjfjBXk8v7aXzJZd2x2+4423vBCC+QKPKkqEfUTkYPqEJmCAEeF+EtuUW
         H+mVDYbsROQ3tT0XJ9KEs7dYsS4LJS5V6dst4z+N+WOuw37WSo7EwAdSIv6PiA+QQNqw
         Zysw==
X-Gm-Message-State: AOJu0YxQmUjgZoMKatQ8EJ0oo6kfticoPSLwEyji1iMw2xNwu+grkZAy
	UYHEeF0zZz4t5kXxuGmowichNDd9OysGf+MGe8o0Zd5/yzmtphjZ
X-Google-Smtp-Source: AGHT+IF/VCJtaNegryEjG7wkcoqP2fqDdgVlvQ+xb17h4yI/rgP9U+DEE2kmKL6heTu6CkombKJrow==
X-Received: by 2002:a05:6000:118e:b0:354:b7da:d3d4 with SMTP id ffacd0b85a97d-35e8ef946e3mr3920722f8f.50.1717664891532;
        Thu, 06 Jun 2024 02:08:11 -0700 (PDT)
Received: from pyro ([2a01:e0a:19b:3cd0:989a:5c4b:b7ff:baf])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4215c2a7799sm14792385e9.27.2024.06.06.02.08.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jun 2024 02:08:11 -0700 (PDT)
References: <1a4aa9f3bfb30fe5b5955fea1486a5fb8b040ff2.camel@siemens.com>
 <87wmn2eawl.fsf@xenomai.org>
 <322a73aecb71efe92feaa607ad1ae745541d7127.camel@siemens.com>
User-agent: mu4e 1.10.5; emacs 29.3
From: Philippe Gerum <rpm@xenomai.org>
To: Florian Bezdeka <florian.bezdeka@siemens.com>
Cc: xenomai@lists.linux.dev, Jan Kiszka <jan.kiszka@siemens.com>
Subject: Re: Dovetail/Xenomai 3: Timer tick locking problem
Date: Thu, 06 Jun 2024 11:04:35 +0200
In-reply-to: <322a73aecb71efe92feaa607ad1ae745541d7127.camel@siemens.com>
Message-ID: <87sexqe8w5.fsf@xenomai.org>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable


Florian Bezdeka <florian.bezdeka@siemens.com> writes:

> On Thu, 2024-06-06 at 10:18 +0200, Philippe Gerum wrote:
>> > [Xenomai] lock 00000000e04e7d2d already unlocked on CPU #3
>> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 last owne=
r =3D kernel/xenomai/pipeline/intr.c:26
>> > (xnintr_core_clock_handler(), CPU #-2)
>>=20
>> Mm, -2 looks pretty bad. This should be either a valid CPU#, or -1 if fr=
ee (~0).
>
> -2 is coming from the "last owner" member, the (current) owner is -1 at
> that time. The lock has been released on CPU 2, but somehow CPU 3 is no
> longer the owner. Right?

Technically, -2 comes from the "owner" member of the lock, sign-inverted
to mark it as released. So CPU #2 was the last owner, which I agree, is
clearly wrong since CPU#3 managed to grab it earlier without releasing
it just yet.

>
> Means CPU 3 was the owner at some point (assuming there is no double
> release), but when it comes to releasing the lock the CPU is no longer
> the owner...

Which indeed makes no sense, unless some membar issue is hiding in the
dark.

--=20
Philippe.
