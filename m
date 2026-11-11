Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.136.64.226
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794437862;
	b=0DtvGWem/+SPg5IUyXhQwbP+I4QoEcUTFHlOsciRwQw5NpgbzR9fcffOw1g+hU/F0tDe
	 XKcya9wmXJTcbQ/77a8/2fgfxRTgrPKkikWfongwMAFYGTy+CahfbGU5aq5/9gK2mE8jT
	 PzynT5TQshxkGVNwXDaQ/FeKIpRSzd+6tcQIxXk4h8VKPKmEewrWS9tJjGwPq0g8JhRkI
	 KJhwd97NcFKkxbeJWK3U0vYexBOfGPJzAOtIxS3/MYRYtYwLzM02jodxlNaT8ZIkQrTUN
	 PqkDCBdduHrIJTbIyJmlCnuH5nxYnv2O2c8tKy3hzXwIcQLsLE5BORQ3EAV0pZOLVGg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794437862;
	h=DMARC-Filter:Received:DKIM-Signature:Message-ID:Subject:From:To:Cc:
	 Date:In-Reply-To:References:Content-Type:Content-Transfer-Encoding:
	 MIME-Version:X-Flowmailer-Platform:Feedback-ID;
	bh=zmi4LJWD4HOJ7IIRIn8TGA4GHNmFTRWYnwWlJW9MKGQ=;
	b=SnJCfsR0RiYpcrP+WFsEK7R0OKvL8ufwD6f2Un6rnMBho2NIehHGKq7St6cNRwWvaNHp
	 jfOA8Lw6iu5MrUt3aGPvhRJkXewPju5LjyJGi7Vv/+UvIwikQoBNUgUrFlGmCxvkyAxF7
	 h0B3QUg0gz6yjfaIeGNT5f9IW2cjqdRctL3zJ9OXIUC5OQ7pR/Hw3YPgrh5BGxhlGBvm6
	 MJPeevaJC0bkzGzCs8wg8/RdW9/bYRMK/gFQ6NZ/1+aXv+oIYQ5oo0NES31ebdZFRm2JD
	 WtwnUAzuTeGxiwQNLITNh9vnUPv/vhggEuTkxXi5iv81S7vXpHzLt0wfFbJJL3+pyjQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=siemens.com;
	spf=pass smtp.mailfrom=rts-flowmailer.siemens.com;
	dkim=pass header.d=siemens.com header.i=florian.bezdeka@siemens.com header.a=rsa-sha256 header.s=fm1 header.b=aoDc1EpT;
	arc=none smtp.remote-ip=185.136.64.226
Received: from mta-64-226.siemens.flowmailer.net (mta-64-226.siemens.flowmailer.net [185.136.64.226])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A47E606A31C
	for <xenomai@lists.linux.dev>; Wed, 11 Nov 2026 22:57:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3A47E606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.a=rsa-sha256 header.s=fm1 header.b=aoDc1EpT
Received: by mta-64-226.siemens.flowmailer.net with ESMTPSA id 202611112257366ea8c446ec00020750
        for <xenomai@lists.linux.dev>;
        Wed, 11 Nov 2026 23:57:36 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=zmi4LJWD4HOJ7IIRIn8TGA4GHNmFTRWYnwWlJW9MKGQ=;
 b=aoDc1EpTUCZ2yfjKugT3aBL6QPcfIZx3m32tCv697PPjEGRFE0csXr40XfnFXKOuSZzWaf
 B4oFOxIZpFLTBZPK9iflT7BtVV82c7h9rZ+kSy8MFWuj3NZ5Eozn2bWS8y3ktAAGYOzdt+qo
 S4QQB4rqc0HWLmNpWGMuni6p/vVoumbRogJ6VAuqBJJ6BdR0LJFxNAW6d67X/ukHwFqsI1f8
 Mrp7IE5AQAdKxF4aeeiu78VttLDELxCkSgjQ9yE8113Rw/+TkhocbNTWGgQ1K0/Xp6ZJnIqh
 aunLfHwkaAI3nsi1QxEmah9znJazasJzHAw9/Bf2RDsVHRxYatkWWsPg==;
Message-ID: <968e9ff2fb76bc031622f3857a7e1a7373d8d695.camel@siemens.com>
Subject: Re: local_irq_disable_full() in x86's __bad_area_nosemaphore
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: Jan Kiszka <jan.kiszka@siemens.com>, Philippe Gerum <rpm@xenomai.org>
Cc: Xenomai <xenomai@lists.linux.dev>
Date: Wed, 11 Nov 2026 23:57:35 +0100
In-Reply-To: <e5aee699-ea3e-4c02-861f-12f165f2d381@siemens.com>
References: <e5aee699-ea3e-4c02-861f-12f165f2d381@siemens.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Post: <mailto:xenomai@lists.linux.dev>
List-Help: <mailto:xenomai+help@lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
List-Owner: <mailto:xenomai+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-68982:519-21489:flowmailer

On Wed, 2026-11-11 at 13:58 +0100, Jan Kiszka wrote:
> Hi Philippe, hi Florian,
>=20
> I start to love pattern-matching machines:
>=20
> Since 6.19-dovetail, commit 6af591980d1750b29474f001902c7dc58c3f1ba2, we =
have
>=20
> diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
> index b83a06739b511..024a67bd2de6a 100644
> --- a/arch/x86/mm/fault.c
> +++ b/arch/x86/mm/fault.c
> @@ -821,6 +821,8 @@ __bad_area_nosemaphore(struct pt_regs *regs, unsigned=
 long error_code,
> =C2=A0=09=09force_sig_pkuerr((void __user *)address, pkey);
> =C2=A0=09else
> =C2=A0=09=09force_sig_fault(SIGSEGV, si_code, (void __user *)address);
> +
> +=09local_irq_disable_full();
> =C2=A0}
> =C2=A0
> =C2=A0static noinline void
>=20
> The final code is
>=20
> ...
> =09oob_trap_notify(X86_TRAP_PF, regs);
> =09if (!running_inband())
> =09=09goto out;
>=20
> =09if (likely(show_unhandled_signals))
> =09=09show_signal_msg(regs, error_code, address, tsk);
>=20
> =09set_signal_archinfo(address, error_code);
>=20
> =09if (si_code =3D=3D SEGV_PKUERR)
> =09=09force_sig_pkuerr((void __user *)address, pkey);
> =09else
> =09=09force_sig_fault(SIGSEGV, si_code, (void __user *)address);
>=20
> =09local_irq_disable_full();
> out:
> =09oob_trap_unwind(X86_TRAP_PF, regs);
> }
>=20
> Do you remember why? As this was folded into the forward port, this=20
> delta never made it into anything older. If it is valid, we would need=
=20
> some reasoning. But this rather looks like a mismerge to me.

This one needs some more cycles here. It might already start with the
call to cond_reenable_irqs_user() earlier in this function which is
unconditionally enabling hard IRQs, even if the oob stage might be
stalled. The possible in-band migration happens later.

If we leave with hard IRQs enabled, we would corrupt the oob IRQ state.
I need to check the calling context in more detail. Maybe this cannot
happen, maybe it can...

Touching the inband IRQ mask (one part of disable_full()) seems strange
to me - at this stage - especially as Linux does not do any kind of
"restore" here.
