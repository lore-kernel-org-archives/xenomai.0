Received: from mta-64-228.siemens.flowmailer.net (mta-64-228.siemens.flowmailer.net [185.136.64.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD86A136358
	for <xenomai@lists.linux.dev>; Mon, 16 Jun 2025 21:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750110782; cv=none; b=r6ymUHwrt0jm/vGfAa30gQ5F+JQE/eBzJuUVX/doD9KLmskhV5hwrYsf7Z4z/NT3ApRDpHt9SoEzbBcD31REsiXuWwlecG3khgpOG/XoE0ek79oUF4Mgbfm/RKydgRSPu/QrsGUYoKQiJkNEoQnoqY6/wIxuc0OjSWmuPI4IKUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750110782; c=relaxed/simple;
	bh=i2gD5gDQiEopNjcJTszFcP/2KosNIRtrWpzlL36tOss=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=XuLGeSIDlp1sioz6lG3kd/qhRFQZTfg1Gwc7UaF7OrDWkckcdmZZf9ISfnMgPi5/O1fwzFE7uRcLNc+c5QfrmAKHcZRWkT7dAPxBcJ0UVdQOA6jg9TEBWmnYiHU6g2Nszn1bFQanCjf9SYpTrtV4zYmSf6fb16CTmA+WtYd13lk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=phrfXVy5; arc=none smtp.client-ip=185.136.64.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="phrfXVy5"
Received: by mta-64-228.siemens.flowmailer.net with ESMTPSA id 20250616215254d7a59a92e0efc17f22
        for <xenomai@lists.linux.dev>;
        Mon, 16 Jun 2025 23:52:54 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=i2gD5gDQiEopNjcJTszFcP/2KosNIRtrWpzlL36tOss=;
 b=phrfXVy5FjKZtDY7Ld7SSMjo31jLrz/6skktIx3pXqCjN6HYHOBTuAl6UQ/T+jmIWkxeNq
 OKDl2mOE7VO+5aKk01egIp5oHOQeO+wGwbImPymj1zamIPCu1A/e8TnrNtqZg/CWGILdYzDK
 47RZ/v7IgU6585mQHivXZ+7Db63JWV3Qo1/sdU5oONHnoyBcwQVBVrTotIx5/dxRjv9bLnsR
 ljTlIi43c1Eyke7rfkQ6qLwzfz4qJ5+SldtrNfSwdynLN8pBflMTYhhXzQ1O69PmMR3/8NOp
 eM07jWnj38kw4Qk6ityL2wkGor6Df7JGkHlWSbWBJ7qC/HysjI2HfFRg==;
Message-ID: <725df353f38c43368b69ffe19bdc04716f8a204c.camel@siemens.com>
Subject: Re: Dovetail: Adding support for Hyper-v as hypervisor
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: Philippe Gerum <rpm@xenomai.org>
Cc: Jan Kiszka <jan.kiszka@siemens.com>, xenomai@lists.linux.dev
Date: Mon, 16 Jun 2025 23:52:53 +0200
In-Reply-To: <87zfembowf.fsf@xenomai.org>
References: <954e1b69e7ccb2e1abf7f82d2bcb109e3cd1ac24.camel@siemens.com>
	 <87zfembowf.fsf@xenomai.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-68982:519-21489:flowmailer

On Thu, 2025-06-05 at 09:58 +0200, Philippe Gerum wrote:
> Hi,
>=20
> Florian Bezdeka <florian.bezdeka@siemens.com> writes:
>=20
> > Hi Philippe,
> >=20
> > I'm currently experimenting with hyper-v as Hypervisor for dovetail. So
> > far so good, I'm able to boot the system and the system survives a
> > inband stress test. The necessary modifications can be found at [1].
> >=20
> > But: Running the Xenomai 3 testsuite - especially the gdb test -
> > freezes the system immediately.
> >=20
> > When enabling pipeline and dovetail debug options I get the following
> > splat report. Ideas welcome...
>=20
> Since the splat happens because lockdep mistakenly thinks that we are
> running in hard irq context although we are actually running a
> workqueue, there must be an issue with the tracking of the
> hardirq_context variable. Could there be some imbalance with
> lockdep_hardirq_{enter, exit}() due to some specifics in routing the
> STIMER0 vector?

I'm not sure yet, but yes, the STIMER0 vector seems to be involved
somehow. I end up in irq_post_check(), where the hard_irqs_enabled()
check fails.

Some instrumentation tells me that this happens when the STIMER0 vector
was the last vector handled by the CPU, somehow confused the IRQ
pipeline and the hard IRQ check fails while handling / posting the next
inband IRQ/vector.

Is there a trick available to find the code location that enabled
hard_irqs? Seems I need more instrumentation to get that information.


>=20
> >=20
> >=20
> > Have you - or someone else - ever tried running dovetail on top of
> > hyper-v?
> >=20
>=20
> Nope.
>=20

