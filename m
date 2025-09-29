Received: from mta-64-227.siemens.flowmailer.net (mta-64-227.siemens.flowmailer.net [185.136.64.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3EDB1F37C5
	for <xenomai@lists.linux.dev>; Mon, 29 Sep 2025 21:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759180516; cv=none; b=JrHh7s1kvla2HkfuqMhxn7X0P1vZBTio4KxtZdZ1shXy218/wCh2EqQl67DSEtQm5xeflhdlBlGN/MUAiM8O7cScuUT4xTAHbNvxL7fc/mqejCr5uLFVxc+bLwV4DOMuElS6T20FzF0jf8AYzcHk6jrQgTlcnGu+/PZFBT2zh8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759180516; c=relaxed/simple;
	bh=AuxqUXDTEyvWRjlPYxkCVty+YGTBIphoNGclDQy2QsE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=fDO0dXsDg0XasJmxwSH+Mw15CmY3a5vRGB6R0EPYtY6lLcBYhKUt/vxBRK/LLiTDecwgl1zCREfpDqrjGu+GTIUBqLO6KPJrgohyQo2yPw/6nU3sFFxpVuiPXPzC+UditM0JcgzgMLHzH60rLEGhfJwznlDSknhRjMec8u2TzzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=PxyBhliM; arc=none smtp.client-ip=185.136.64.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="PxyBhliM"
Received: by mta-64-227.siemens.flowmailer.net with ESMTPSA id 202509292115012e8a2462410002078d
        for <xenomai@lists.linux.dev>;
        Mon, 29 Sep 2025 23:15:01 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=+CaV13nCGnmHacR6f/JYRdtHngVyvYUDH+ZCgq2RVfI=;
 b=PxyBhliMRIZxpX/zaHWOcNHIBNeFMDuZSudGPhN4klbSDaJ4mOQhlnviX/Bno9U5kMmaBk
 3BFmc9Sz1CVGzgB1lOJCtp+BgNtAtIxpJwvI7nJHhxv23oJm3H/gB1RzVolvxDgkOhzxGb89
 lhULx4vqZgvLUt91tMxtWmdShxLeCJTyk33khMPvx+U1v7AfyGa/65F3tTpliItkCqJGEFl1
 NUm+BF115fVjCu6PYa2aU2MCUhyOfcxOkN6F+hK2nbGO3iz1QRwAaK/IyCv6iTmjxJujrJGz
 HAMnizd/yrHZE7ELi+P5SewjALI3Tg5dMDGLzYDJr7sueyG6mrCe0cgw==;
Message-ID: <689eb39d04f64799e522453da752d0c367217b62.camel@siemens.com>
Subject: Re: [PATCH RFC Dovetail 6.16 5/5] kernel/irq/chip: Do not call low
 level irq chip hooks directly
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai@lists.linux.dev
Date: Mon, 29 Sep 2025 23:15:00 +0200
In-Reply-To: <87bjmvro65.fsf@xenomai.org>
References: 
	<20250925-wip-flo-cleanups-based-on-6-16-v1-0-8c4ac7b52cd8@siemens.com>
		<20250925-wip-flo-cleanups-based-on-6-16-v1-5-8c4ac7b52cd8@siemens.com>
	 <87bjmvro65.fsf@xenomai.org>
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

On Sun, 2025-09-28 at 10:12 +0200, Philippe Gerum wrote:
> Florian Bezdeka <florian.bezdeka@siemens.com> writes:
>=20
> > irq_mask() and irq_unmask() are tracking a software IRQ state that
> > might run out of sync when bypassing them.
> >=20
> > No functional change.
> >=20
>=20
> Actually, there is. Percpu IRQs are not serialized by the desc->lock, so
> calling mask_irq/unmask_irq in these handlers is unsafe since we may end
> up flipping bits from the irqd state concurrently on multiple CPUs for
> the same descriptor. This is the reason why masking/unmasking was
> open-coded there.  This patch typically breaks my kvm/arm64 fixture at
> boot, not observed on kvm/x86 so far though.
>=20

I clearly missed the serialization part. Wondering why this did not
trigger on any board / kvm test...

Anyway, it's clear that this patch should be dropped.

Do you want me to resend the series with 5/5 dropped?

Florian
