Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEE414C4602
	for <xenomai@lists.linux.dev>; Mon, 19 Oct 2026 14:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792420866; cv=pass; b=UmCw8HSD9BWflNTGgflGsG4KsGYKtkzABhz+JT0s+mvlQ0hdoU/xZ/wc3rSA9zq+WmOMo/dUGSRj/ujnsSi0Wt2/KRC3Tc3KCQuBQPCREqgdJpTiRQRBb0m6H4egngD0f5rhPPfLEGX9LhOTRK5ktiz9iWKmRqecKT0avYHSOvQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792420866; c=relaxed/simple;
	bh=l+FFyDc+dP+ZSUTrcNh3vM0JVJxZ3XRjwV8j4NXdIXs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hagjsdz1Snql5Y6c+HzGwTX92KdbX6cnwFtwpxq2lem7iTLxLZCoOtEAh9asqg03q5FdHwsAdmq32QUaDtazKkJJ5JxG6e5sAl1V484B726kAQGH7+HG39fJZNOtnSU7oJbHgTkGnDxZ3HiL/7Tub+kkUIGXW23HwywXxR04HLA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lmi3d.com; spf=pass smtp.mailfrom=lmitechnologies.com; dkim=pass (1024-bit key) header.d=lmi3d.com header.i=@lmi3d.com header.b=nyy2hLr0; arc=pass smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lmi3d.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lmitechnologies.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lmi3d.com header.i=@lmi3d.com header.b="nyy2hLr0"
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-cc758830601so1505129a12.2
        for <xenomai@lists.linux.dev>; Mon, 19 Oct 2026 07:41:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792420864; cv=none;
        d=google.com; s=arc-20260327;
        b=orvc4F2KTCvBEPZR4sRAd3gIHdUfwQ+zqNzusoABiplJz/HfuOk9UamHZAv4RWHLWo
         svd/L599fI8idaa0rys9++y9/u1Zynm9FcTls7fde/waou+nC6mY0enq9VbtP6IMvpP5
         awe3I7XgaTCMLMSgmYfF0FF9dW4KI6RmJQiKMDFpzzxTBOjm0kQ4Txe/XZ0qQjlN3f33
         Q4e3AgifbgZCqwr1U91QtqGWJOKkYnAaobdeDA8WlkzyhlOazY56R/vXA9A40Mv2miLY
         YvqAWezglLnOKmrU2nUk+7tb/NLjStWWsh79CIFkpaYnQzDqfGj7/rcySaVZ4ESIsQdC
         X3CQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=l+FFyDc+dP+ZSUTrcNh3vM0JVJxZ3XRjwV8j4NXdIXs=;
        fh=QKHGZcrTvPpEJFgnKAfh6GC1slc1hcuBCSC43Kq+Hvk=;
        b=lk65fTRI01gTDalLmRUex0+xuypnbUbx4QUEIMO0xGUniX4xcQaIsMrBpfzVmOVFE3
         IvX+cigcqCOJxdiaiE19bLRc9CfdaOtAH34RjHyTaje/KnhjvKj+KJF0W/GDetUC/+oP
         xDtohdTg5F5uarR800gQlTmLX1LR9tZWog1O/R2qnN9dPwJeQnsg1P5EKQOBFWBQlBVU
         HNsQ5hHx2oE8QPlukFC0KjrKqFUExvMJQYytQLtPZZthuvuD2IhRofHm8PwEgMg3fKk9
         zorTPG8VUU5J9f8qsDzKpQ4VyyFKUJUdaZX5lqsVo1jB4jWlXP94EA2/BDNAWnRsbtb9
         a0lQ==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lmi3d.com; s=google; t=1792420864; x=1793025664; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=l+FFyDc+dP+ZSUTrcNh3vM0JVJxZ3XRjwV8j4NXdIXs=;
        b=nyy2hLr02zwSoBubFubjRgx5AZyZRgOCS8bmCl67I4wKkTsKRmqbAt5uTXUU5af0Oq
         tkgVg6VTe2zwSYEuTTY+zx/+1V1HMExrSM8QWJGIoDqeyZl7y/YLrPSTlyf2VmF88uaH
         bWJIx03XdCHQd3ad00xRq/PF0mLLl5KodXEBA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792420864; x=1793025664;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=l+FFyDc+dP+ZSUTrcNh3vM0JVJxZ3XRjwV8j4NXdIXs=;
        b=gRRZ9LIBiBHv6KgRC/tz2sIB5rYWIvmf+eeEyLvK3njczeTQHW2uDV58NgnRDb/mel
         7U7KdI3My1dEWTLz4y65gTmy5qzJWr32xHW+A7bTJTZQYoiv2aaaOhfx+9473X8iZhov
         dq38nhXINOjV2d5S4qbXaY5AfRN2mBcK/NFizYwl0WZpZfNwiP2v+lPe6AJgRa1tW7N4
         XsXGVa1qYLOV/F+gQWJ6iMR/6FiDFuKVWR0cU/LTfKaJCyUvnybMT1ocYr0yNPFC3f2k
         hQgqdN0cQmq9yXcY+5ZMuC1jTQpmJcMPwpnTRMuJMiKG0uCIExQ0zRmV7tvhPXRfBip0
         tLeA==
X-Forwarded-Encrypted: i=1; AKwUvBw64Tm1rpvyYpOpCwfcGuY/+o6tUSnzP+aWlB/hj++CUqOhFT9KZAg0WzcdSUo4lM/YyeanpcWP@lists.linux.dev
X-Gm-Message-State: AFq9FYJ/LLz0KD7JfDUkOumR1TrEa8UfbiGx5GW2pxCeeDc+Y/CA+qD/
	EmgpBzKz0dG+kejb6vWsfCWWfH2zS9Zd051xrbtwLpCcr94Hb82rSLaYYmoBlXoCcMr6vEpsezF
	cBz+UWNLoVx9/xH2UVv2X/u/ZTgKotbXf2dWCX8i71nLbbNgSL60pLk3jIMiiPrw3Xh07WnuXEY
	4pp+q/4eVg1xv4dUD9wZLdtKHTxJfV6pMxnm2hcUcMSlEYTPBCn+igbpPgv9EECuIacUFz0tMTC
	pJHew90sG+Sz7eFB4k1A5rH6kceuOw=
X-Gm-Gg: AYBFou3lKirqTxNnFNHfPa/V5UlME3fv2qCQlsrMp3baZ8qtLlEzl1bwNKJjQgdQYPh
	BKeflBuXVYZNXQOQ9AMZIlkKTGlizJmcT+rzYeMkX3mk613teK8aDDQb6DVp4aXHLJSbXlR9MU2
	FL4qpxBWjF1wye9SCvfC9iBooiYh/DaWk9YeKmmNw9B9Oiockfw6hjqaf09XoZg3eke6eBsxDJe
	rePvVZU3oEscbd04Y5mgTcAuuO30Ghw+M9psIJPjsdjoDR6iJARQvCTTzr/oFcKmuSKcsrhrfbO
	wLVHgBijmYFUDhVSsM7vZgouhmhurhUmoNoXh5q9i8peaiz/5ZTyGymZZOb4Ec85I0TmcexD4f7
	rGDz5k+WzDi1Bf/3G09+2Jb7dXsXOG24iOiIr+WJx3gf0XVlcX5qq7Z8NF4Rq59bzqRpHQJ1Cy7
	m+zIdwky7F6ltYVmSYIn8UOb7ghYg=
X-Received: by 2002:a05:6a20:20c3:b0:3de:456a:6e07 with SMTP id
 adf61e73a8af0-3e2263d37f6mr6372432637.46.1792420863966; Mon, 19 Oct 2026
 07:41:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260909-wip-flo-v7-2-irq-cleanup-v1-0-825a908785ae@siemens.com> <87fqy3wg6m.fsf@xenomai.org>
In-Reply-To: <87fqy3wg6m.fsf@xenomai.org>
From: Gerte Hoogewerf <ghoogewerf@lmi3d.com>
Date: Mon, 19 Oct 2026 16:46:51 +0200
X-Gm-Features: AclHuK-Pz0uamWTF-X1AmiyFKNJJdXw2ojf6_yqe6WpUlVNeo6AFFYqoZCvzH8E
Message-ID: <CAKndYJES9912iO1fih3Ps55aj5T+udqGSQ-yD4EJG+XMMsH7jw@mail.gmail.com>
Subject: Re: [PATCH Dovetail 0/2] Obsolete marking tick IRQs with IRQF_TIMER
To: Philippe Gerum <rpm@xenomai.org>
Cc: Florian Bezdeka <florian.bezdeka@siemens.com>, Xenomai <xenomai@lists.linux.dev>, 
	Andrew MacPherson <andrew@elk.audio>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Sun, Oct 18, 2026 at 10:45=E2=80=AFAM Philippe Gerum <rpm@xenomai.org> w=
rote:
> Series merged with backports to v6.12.y-cip, v6.18.y, thanks.

I tested 6.18 (5dcafd54) on our end: ZynqMP and Zynq7k. Thanks for the
backports.

Cheers,

--=20


This
email and any attachment(s) it may contain is confidential and is=20
intended
solely for the use of the individual(s) to whom it is addressed.=20
If you are not
the intended recipient of this email, you must not take=20
action based on the
contents, nor distribute, nor expose any part of the=20
content(s) to entities or
person(s) beyond the original distribution list.=20
Please contact the sender and
delete the email if you have received it in=20
error. Thank you.
