Received: from mslow1.mail.gandi.net (mslow1.mail.gandi.net [217.70.178.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C58B57B
	for <xenomai@lists.linux.dev>; Tue, 19 Jul 2022 06:43:11 +0000 (UTC)
Received: from relay12.mail.gandi.net (unknown [217.70.178.232])
	by mslow1.mail.gandi.net (Postfix) with ESMTP id 6144CCFB7F
	for <xenomai@lists.linux.dev>; Tue, 19 Jul 2022 06:41:24 +0000 (UTC)
Received: from spool.mail.gandi.net (spool3.mail.gandi.net [217.70.178.212])
	by relay.mail.gandi.net (Postfix) with ESMTPS id 84499200007
	for <xenomai@lists.linux.dev>; Tue, 19 Jul 2022 06:41:16 +0000 (UTC)
X-Envelope-To: xenomai@xenomai.org
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	by spool.mail.gandi.net (Postfix) with ESMTPS id 7EDBCAC0993
	for <xenomai@xenomai.org>; Tue, 19 Jul 2022 06:41:15 +0000 (UTC)
Received: (Authenticated sender: philippe.gerum@sourcetrek.com)
	by mail.gandi.net (Postfix) with ESMTPSA id 240D76000A;
	Tue, 19 Jul 2022 06:41:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xenomai.org; s=gm1;
	t=1658212875;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GpO9EFhpLvc7R5Zv6850+hXY0Nwuzrjw1ZIw9nhVPXM=;
	b=MMoK9nTKcZ5J1PHUez4tgeC0sFp9ydVJsr+6TsjdAC2ZotOmsaXnkhWhHuVrZ0muZ2sYBb
	ZCb86dbN6KLi2Y4NVBCqKlz5fWnbsgDjj6KCX/SppAUFNOC9NDPJNlAjt6isx7pdLb8Oam
	JLndkhG+RSz3NBObmldJQZXou4l8750IBeeqYvcHEUv20h4dh6LfOzIWWtpyzeGqD7kxPX
	n/tOvztOD+GiqkozzQSlEiLPU8sv+xcDZp+QX1sEzBMioBQmJPhL40zT5RAwgAF69EKiXa
	1vBHFtkQN5l4RSBYxOJbZk5WvyNuUoffTARor+Txe34K+2mh0fUdq0xQr9D5QA==
References: <OSZP286MB1823283BC7739F3CF2D76091F68C9@OSZP286MB1823.JPNP286.PROD.OUTLOOK.COM>
User-agent: mu4e 1.6.6; emacs 27.2
From: Philippe Gerum <rpm@xenomai.org>
To: "nihar.unadkat@omron.com" <nihar.unadkat@omron.com>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>
Subject: Re: How to POST an OOB Kernel semaphore to an =?utf-8?B?4oCcaW4g?=
 =?utf-8?B?YmFuZOKAnQ==?= User space
 thread in DOVETAIL/XENOMAI 4
Date: Tue, 19 Jul 2022 08:16:03 +0200
In-reply-to: <OSZP286MB1823283BC7739F3CF2D76091F68C9@OSZP286MB1823.JPNP286.PROD.OUTLOOK.COM>
Message-ID: <875yjttxiu.fsf@xenomai.org>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass (spool3: domain of xenomai.org designates 217.70.183.195 as permitted sender) client-ip=217.70.183.195; envelope-from=rpm@xenomai.org; helo=relay3-d.mail.gandi.net;
Authentication-Results: spool.mail.gandi.net;
	dkim=pass header.d=xenomai.org header.s=gm1 header.b=MMoK9nTK;
	dmarc=none;
	spf=pass (spool.mail.gandi.net: domain of rpm@xenomai.org designates 217.70.183.195 as permitted sender) smtp.mailfrom=rpm@xenomai.org


"nihar.unadkat@omron.com" <nihar.unadkat@omron.com> writes:

> We would like to know how to POST an OOB Kernel semaphore to an =E2=80=9C=
in band=E2=80=9D User space thread. We are currently using PREEMPT-RT up/do=
wn semaphores in and in band IOCTL function with the User space thread maki=
ng the IOCTL calls to the up/down.=20
>
> See the example code below: NOTE everything below this is PREEMPT-RT
>

I'm unsure why you would want to synchronize an in-band thread on an oob
event; is losing the real-time guarantee during such transition ok in
your use case?

Anyway, the common way to trigger in-band actions from an oob event with
Dovetail is by using the regular irq_work() service [1], with the oob
irq handler calling irq_work_queue() on some irq_work descriptor
initialized with an in-band handler. That handler would be allowed to
post a common kernel semaphore for instance, like your preempt-rt based
code does.

e.g.

static void inband_handler(struct irq_work *irq_work)
{
        up(&sem);
}

static DEFINE_IRQ_WORK(inband_work, inband_handler);

static irqreturn_t irq_handler(unsigned int irq, void *dev_id)
{
        irq_work_queue(&inband_work);
}

static long ioctl_handler(struct file *filp, unsigned int cmd, unsigned lon=
g arg)
{
        ...
        down(&sem);
        ...
}

void at_init(void)
{
        request_irq(irq, irq_handler, IRQF_OOB, "irq_to_foo", dev_id);
}

The inband handler is running in interrupt context kernel-wise, on the
lower execution stage though. If you need to call kernel services which
might sleep from such a handler, you would have to chain the irq_work
with a work_struct, calling these services from the latter. EVL provides
such a combo off-the-shelf via the evl_work construct (see
evl_init_work()). Calling up() directly from the inband IRQ handler is
just fine though.
=20=20=20=20=20=20=20
[1] https://evlproject.org/dovetail/pipeline/pipeline_inject/#irq-work

--=20
Philippe.
