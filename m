Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B40EA24A078
	for <xenomai@lists.linux.dev>; Tue, 21 Jul 2026 20:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784664946; cv=none; b=fPswxX6JuUC6XLmmR978tw6zLhQ/v22tKQbZyuA1UPMQ+hQKQZBaG2wrSCQJE879fCqKHQudqduykRZsXrNKvBtnybdNG8pO+nvYnK0cBeqC7j3vJ64Pkwti0RNWU4o63Sy7e4dN5WQYIF040VhuQqrxKM2DcUGGLnasdu3FMHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784664946; c=relaxed/simple;
	bh=Z8eBEZ2oYzGxx/H+z+VcR598Lpc9sIc+H5wNe8iVdRo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=SLXE/4w0a40aqLuZgl+kGkwzbieFrMdNyTiZp9GuDwPks1m3HaPuwbTB9LHj+cMukfrdE8eh+6u08Yrd75WpQTGSpcm1PtFO0ef9v77iEmaFw99ch0BKRcP5j9IXuz2w8nN9NV3ti4j3iG1SzYIPVCorzrDXJv9PSt/+PMMFSLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org; spf=pass smtp.mailfrom=xenomai.org; dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b=NIhuFs+c; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xenomai.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b="NIhuFs+c"
Received: by mail.gandi.net (Postfix) with ESMTPSA id 16B343F545;
	Tue, 21 Jul 2026 20:15:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xenomai.org; s=gm1;
	t=1784664936;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=//VDJpcPBnZU3u+/LH+vKPNKdz7BVwI9iN8Zi7cX3S4=;
	b=NIhuFs+cJtvnnLOreUqevqQ55viahFUb5vCPH5u9VDLhEkmWg8Xek1f7zg8h4upeop9vek
	6/64GDmICyDBgaVzsEEx5oIzA7fATF5RDRA5eNKSa+oukodsQdc5zOYmxGrJhOfTbBxvA1
	ohYs8XrXMO7QPNDUb8bzgDqOD4YdqmaIy2qbMnSIzMR3OTztmqf0glsEOPyrewsoTuIFIC
	oDqs4d526YlqVoUU9gKLTsnE7IauAEl5TMZDXZEkhIdlW3wOszqraSP+FY7z9N4o8eAu2w
	zoR5LWiPbt7DnW1Vq7JVfbgCn4nR9e4Z/GaAnozu+iSjlAoICM1PEUQGaSh2VA==
From: Philippe Gerum <rpm@xenomai.org>
To: Hannes Diethelm <hannes.diethelm@gmail.com>
Cc: xenomai@lists.linux.dev
Subject: Re: [PATCH 1/1] tidbits: net-udp: solicit new client for server mode
In-Reply-To: <11409ae1-be7b-4003-8d40-f5e1cb34d2ec@gmail.com> (Hannes
	Diethelm's message of "Mon, 20 Jul 2026 22:03:52 +0200")
References: <20260528194459.6117-1-hannes.diethelm@gmail.com>
	<20260528194459.6117-2-hannes.diethelm@gmail.com>
	<87a4te64vn.fsf@xenomai.org> <874ijm62yu.fsf@xenomai.org>
	<3216fbd8-3ee4-46f7-851b-0f3b48c38572@gmail.com>
	<87ik7d86kn.fsf@xenomai.org>
	<6c0d9a13-732b-49c5-886b-3dda8b1f5cab@gmail.com>
	<87o6gmzlpn.fsf@xenomai.org>
	<13bb8457-8148-4758-84d5-1ab324e978bd@gmail.com>
	<8733xd20u3.fsf@xenomai.org>
	<11409ae1-be7b-4003-8d40-f5e1cb34d2ec@gmail.com>
User-Agent: mu4e 1.12.12; emacs 30.2
Date: Tue, 21 Jul 2026 22:15:35 +0200
Message-ID: <87jyqodrq0.fsf@xenomai.org>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain
X-GND-Sasl: rpm@xenomai.org
X-GND-Cause: dmFkZTGu2Ly2QEBUYbXmDGR7hEWsmC1VpofN2NrhJ2mJzuSl08RDpt+fN4tsPMGyU5Ue5mYkvLiTAQCHpkLfboEmnGborNiSRY8uC1/opwQtwy5O4O57uQEpuSnDjToU3ch+IxpulESIe8TMmxGNeLHyJjAOw42mfBwx0x+y4BOM+6l50IJKiPHJVyGXDOWHEsCf5P7UhczM9P3vVg+jhIMp+2f5j1502A/MoSQ5IJ3iZ2ITKKs48xDv4TuEBYpYdvZLk3I7yPirU46GIDBa8LmgCKEQS2s7VQq1QJh+N8Uz715bjMdBRaNwp4h6HPsNVNvj+LgVHvHUxQTcQa7c0/FUjuHBEjrucW2ml8EbOjRyFjh9YpD2cJuJvNLYGUkqbBi4/hyuBjvoxAkmXw2CZP+0rML5Ll2zpEVZxTyL2U5D1wQfYUj6MCfmDHH+2euU5jqlXRr3xPtsmHDKaMq5z2fI/xXivQzm375VxF2jzGWbaW81ux9b3g3GGlC53iIXfLKOkFRNwReHQ+etdbXVxZ4vwXWInufkW5K311s1PiTtNjl1KiEpEZw/et+ujyxdTiWhPV68B5zb6nVs6QOCofB1qzFPwcGFhu/SV4HLH/pVawNOgSEpotdR/ASZoLkqISrIzOTnuvYW6pO+KZUODz9NrbuHl9l3uIOAbXIWDk1M7J5d4A
X-GND-State: clean
X-GND-Score: -100

Hannes Diethelm <hannes.diethelm@gmail.com> writes:

> Am 20.07.26 um 16:27 schrieb Philippe Gerum:
>
> An option would be either to support of oob_ioctl() for SIOCGARP. Or create something like
> evl_net_routeinfo(s, addr) returning flags would make probing obsolete.
>

Not entirely. The issue with solely having SIOCGARP or any probe-only
explicit request is that you would have to pair two syscalls at each
transmit at least, one to probe for the sender address before possibly
soliciting that peer if absent from the oob cache, another one for
sending the message eventually. i.e., for every packet:

    ioctl(SIOCGARP)
         !ATF_COM? -> evl_net_solicit()
    oob_sendmsg(..., 0)

OTOH, with the latest attempt to address this issue, we can send a
probe-only request by passing MSG_PROBE (EHOSTUNREACH), or a request
that does not attempt to defer transmit to the inband stage on probe
failure by passing MSG_DONTWAIT (EWOULDBLOCK). i.e., for every packet

redo:
    oob_sendmsg(..., MSG_DONTWAIT)
         EWOULDBLOCK?
               oob_sendmsg(..., MSG_PROBE)
                  EHOSTUNREACH?
                      evl_net_solicit()
                      goto redo
                  otherwise assume ENOMEM
         otherwise all done

IOW, using a proper combination of MSG_DONTWAIT and MSG_PROBE in the
right sequence would either succeed to send the packet immediately on
the first oob_sendmsg() call, otherwise fail on memory shortage or
missing route from the oob cache. In the latter case, which could only
happen once for each new peer under normal circumstances, we could
disambiguate the EWOULDBLOCK status using an explicit probe.

A better way to do this in a single step unambiguously would require the
addition of another operation flag, like MSG_DONTDEFER, preventing the
deferral to inband on failed probe and causing oob_sendmsg() to return
with a specific error code. e.g. something as simple as the following
would cover all requirements:

     oob_sendmsg(..., MSG_DONTDEFER) -> EADDRNOTAVAIL on failed probe.

Now, we might also piggyback off of MSG_OOB instead of defining yet
another operation flag, as a way to say "oob only, don't relay to
inband", but I'm still pondering whether this would be nicely witty or
utterly confusing..

-- 
Philippe.
