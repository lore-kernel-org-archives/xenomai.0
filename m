Received: from mta-64-226.siemens.flowmailer.net (mta-64-226.siemens.flowmailer.net [185.136.64.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DA9B23372C
	for <xenomai@lists.linux.dev>; Tue,  9 Sep 2025 14:04:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757426670; cv=none; b=aRya4nzC/jLmNvG2bkBJAhqoTkdvAm6ElXEKX8uHs4D0VAx/FR/0nzJLbObk8fW6fNVKWmOzVU7T120DyyP1T6rwemiklOrocuund21olFkaxXMYPsTxNiAT0HZrdWA5aPEDNxNOPJ3+NcNDJa0ODp6AGefgua0pHBag5+jbBUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757426670; c=relaxed/simple;
	bh=1sUGMClo3RQ4H2Xj+8L09q1/uyRlrrf8rTPp8xB8RPo=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=jBKg8Rk1y7A1bgpvyKsZphLEYkodzOxCSR0YKjLeHft2LFmY/Zi0LwOJ6PiGlumQRovv/aFCPIxzl/V+E9W0QnlSJ9INi5zryDvi1q8Hx9cpeDKF5XirYPTUlToG1fDNjKznhdRdxE+URxMvxQMKLgtUkuLuyvwdLloLRg+E2QA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=fckVeUjx; arc=none smtp.client-ip=185.136.64.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="fckVeUjx"
Received: by mta-64-226.siemens.flowmailer.net with ESMTPSA id 20250909140422369b0ab91400020736
        for <xenomai@lists.linux.dev>;
        Tue, 09 Sep 2025 16:04:22 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=ERLKg3pwk4vYuGVjfw1biuNkMLhQIMa6orhWb5qJSPw=;
 b=fckVeUjxqKTEOsObmCsBi0M2I1uyNs3Fz9SgF8BC/zC3n0xanpz9BKQ9QJ7HoN3B5K/gpn
 eM8etfdtUeQ230r3CPPH3xVWZSFtWYNbAMA2WTd2AUlEF/iVpOD7Vb8qVQRLcNjGT6bgz7Zj
 RXuXswMUDVfYmewbbATLS+DgUv7YcOn2G2+ZlVxGNtqCkAsujhTg0qnU3rTq+ZMlQQljRRUb
 pXamezM9SEjmMrjQ47K41y5nFXiUfglyC+ot83VMZAPOdIj0w0HVUfZ60cPgf1jL9a3Me4EL
 3wMdTEtFkcTTefdPRh+09W7Kng93Wy7JOjCcK++GXVdYrZq9+8yU/jFQ==;
Message-ID: <40bf171b01249a27dca7cf550df09d555235a65c.camel@siemens.com>
Subject: Re: [RFC Dovetail 6.16]: Lockdep warning, IRQ while holding
 pci_config_lock
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai@lists.linux.dev
Date: Tue, 09 Sep 2025 16:04:20 +0200
In-Reply-To: <87v7lt6npv.fsf@xenomai.org>
References: <2d7bbdc839cb0f78ddb979b35d491a8f4fb9d0c8.camel@siemens.com>
		<87a53582y0.fsf@xenomai.org> <871poh82tx.fsf@xenomai.org>
	 <87v7lt6npv.fsf@xenomai.org>
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

On Mon, 2025-09-08 at 16:08 +0200, Philippe Gerum wrote:
> However, that one should be turned into an hybrid lock. Not nice because
> then we are going to disable hard irqs while fiddling with CPU masks,
> but this would happen at irq startup exclusively. This said, that hidden
> global lock looks pretty weird.
>=20
> int irq_setup_affinity(struct irq_desc *desc)
> {
> 	struct cpumask *set =3D irq_default_affinity;
> 	int node =3D irq_desc_get_node(desc);
>=20
> 	static DEFINE_RAW_SPINLOCK(mask_lock);

Two questions:=C2=A0

- How would I technically do that? There is no
  DEFINE_HYBRID_SPINLOCK(). Right?
  hybrid_spin_lock_init()?

- Seems I'm missing something... Why would a migration to a hybrid
  lock help in that case? irq_setup_affinity() should not be called
  from pipeline entry code. With the migration done, we would disable
  hard IRQs, but that does not protect us from a remote CPU entering
  a code path where the reported locks are involved.

FYI: This is the last issue that I plan to address before finally
posting the hyper-v stuff. After that I could look into the forward
port to 6.17.
