Received: from mslow1.mail.gandi.net (mslow1.mail.gandi.net [217.70.178.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E262714AAC
	for <xenomai@lists.linux.dev>; Mon, 10 Jul 2023 19:37:22 +0000 (UTC)
Received: from relay6-d.mail.gandi.net (unknown [IPv6:2001:4b98:dc4:8::226])
	by mslow1.mail.gandi.net (Postfix) with ESMTP id 7B587CA712
	for <xenomai@lists.linux.dev>; Mon, 10 Jul 2023 19:31:48 +0000 (UTC)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 7F241C0002;
	Mon, 10 Jul 2023 19:31:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xenomai.org; s=gm1;
	t=1689017500;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qymw0+jW0sTG/+3cLDCOGx/nneuncDHpdMFdlh8uPts=;
	b=QO5IhDeypB4kccAtIeU7vKAI92Z4CJXHTRKxbA/LbXovTaLLX2FIEABn1uJNUNaUKLEjnp
	4/kWqoFG4mv7XiPvd33Fhnx9WYFJ4XqEhLNZ/Hnx/wxW35Q8/viE9kCT0nc3QW2UDauaNo
	mn8F/5BG/u85kZK0IOi564zN1UTjBsLWqXUjgvHyC4uamJJpk2rLRHNOOIH+20/pxrjmkG
	J+xpLN+r7oEWls4YbNSKK2OOSwBN915vbSydAuQxLQH41Y+36+gITgRjiy30/T/Tzh7Vgt
	A1t7draRuJ5h6bSkU/QFUO0AUJDmQiqYSG2lIe2jLUDjxGLRn/qlyDeMtIrM6w==
References: <ecada31f7d6376ed073cb485bd21457e1358d357.camel@siemens.com>
User-agent: mu4e 1.8.11; emacs 28.2
From: Philippe Gerum <rpm@xenomai.org>
To: Florian Bezdeka <florian.bezdeka@siemens.com>
Cc: xenomai@lists.linux.dev, Jan Kiszka <jan.kiszka@siemens.com>
Subject: Re: dovetail: IO-APIC IRQ storm
Date: Mon, 10 Jul 2023 21:20:57 +0200
In-reply-to: <ecada31f7d6376ed073cb485bd21457e1358d357.camel@siemens.com>
Message-ID: <87ttub8sx1.fsf@xenomai.org>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: rpm@xenomai.org


Florian Bezdeka <florian.bezdeka@siemens.com> writes:

> Hi Philippe,
>
> it seems I'm facing a problem with dovetail on x86 related to IRQs
> routed through the IO-APIC.
>
> Note the=C2=A0stack trace below, it seems that once we ACK the IRQ in
> ioapic_ack_level() by calling __ack_APIC_irq() we immediately get the
> next IRQ.
>
> cat /proc/interrupts delivers (minimized to the relevant IRQ):
>
>           CPU0       CPU1       CPU2       CPU3
> 21:          0       2392          0          0   IO-APIC     21 -fasteoi=
   ahci[0000:00:0d.0], snd_intel8x0
>
> Seems IRQ masking does not work as expected. I have to add more
> debugging code but it looks like an IRQ storm for now. I have the
> following options in mind right now, but there might be more:
>
> - Masking of the AHCI IRQ does not work as expected

The ioapic backend code is unchanged for mask_ioapic_irq() aside of the
conversion to hard spinlocking, so maybe the generic portion there
unexpectedly detecting a masked line, blocking the actual masking?

void mask_irq(struct irq_desc *desc)
{
	if (irqd_irq_masked(&desc->irq_data))
		return;

> - HW IRQs are ON where they should be OFF

It does not seem so. Looking at the backtrace, the kernel would most
likely have entered a deadlock on this instead:

void handle_fasteoi_irq(struct irq_desc *desc)
{
	struct irq_chip *chip =3D desc->irq_data.chip;

	raw_spin_lock(&desc->lock);

- IRQ migration in ioapic_ack_level()? Something unexpected due to
  preparing/completing it? There is some Dovetail-specific code there,
  which defers the migration from oob context to a workqueue.

--=20
Philippe.
