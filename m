Received: from mta-65-228.siemens.flowmailer.net (mta-65-228.siemens.flowmailer.net [185.136.65.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 634161D47A4
	for <xenomai@lists.linux.dev>; Wed,  5 Jun 2024 12:23:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.65.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717590212; cv=none; b=lkBPFALtBLpGBsDDc3VH9XIYqw65V7lF14TlLc8Gm8aF2LrBVdR6a+7KncP1srDbDrx5W+f+RgUJTt2pJPCcjrS5w7H7iTjTkq5EcnTjeuYmHPrVSqCMiEevZd5gElV5hsh3iu7SrFCNJwE7aR+QdUXjd85Z4mgoadpFDA5yYy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717590212; c=relaxed/simple;
	bh=EsRvpZHlh0dOkqnSaXwgVmCPcr43Cj+92QR2OauFrrM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=nWleg81n2kD9Whuk0N4zwv9crY3ofJKn7d3zSDOFtE6Go2HHXsIs54Mh6CA5EtK9ZkGperyD1ZPJklU1qesnvB9oSUyl4uHQxcABUJo0qkD9u+ASEcTmQRNIpStReILljc0YdAfTgKsBPZZcA+GL/vxgw0mIwUHFgnpEWdEn8iw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (1024-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=H16Oxpn6; arc=none smtp.client-ip=185.136.65.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="H16Oxpn6"
Received: by mta-65-228.siemens.flowmailer.net with ESMTPSA id 2024060512232378f9e0e3387bbd9e4d
        for <xenomai@lists.linux.dev>;
        Wed, 05 Jun 2024 14:23:23 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=x3wGibJqP2QZLEuehZ9Nd6RNJdvCyPGCHguTCp1QWxo=;
 b=H16Oxpn6MlLt2Hni5as8YVu9MSa9RlqNHTIWidHtncKcuDjvac5kN2iINLR4bjCIFivg4j
 ksvxUVdDzCv4cwCW5Mq6L0SY0J6YBzCQ7/Yg49/J5C6MpLSkXJUtT+V89xXhaUbGPBMwGePv
 i6HcyqLyMq7gORWmF0tBUsI0+D6lQ=;
Message-ID: <9803f96bf9e2da37e224e66fd273c3549697560a.camel@siemens.com>
Subject: Re: [PATCH RFC dovetail 6.9 0/2] Input needed: Boot hang, dovetail
 6.9 as KVM guest
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: xenomai@lists.linux.dev
Cc: Jan Kiszka <jan.kiszka@siemens.com>, Philippe Gerum <rpm@xenomai.org>
Date: Wed, 05 Jun 2024 14:23:21 +0200
In-Reply-To: <b1960ceb203102668cc920aeec3b97e7f7c6387f.camel@siemens.com>
References: 
	<20240531-flo-fix-kvm-guest-for-6-9-v1-0-1c895c256f8d@siemens.com>
	 <b1960ceb203102668cc920aeec3b97e7f7c6387f.camel@siemens.com>
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

On Fri, 2024-05-31 at 21:29 +0200, Florian Bezdeka wrote:
> On Fri, 2024-05-31 at 13:20 +0200, Florian Bezdeka wrote:
> > @Philippe: Any ideas? Which way is correct?
> > Patch 1 references a Linux commit that changed the registering part of
> > the involved IRQ/vector. Is that considered problematic?
> > idt_install_sysvec is now being called with the asm_ prefix as
> > argument...
>=20
> This is understood now. The asm_ prefix is fine, the low level entry
> point has to be passed, we end up in the C world after the usual
> trampoline code.
>=20
> Still open:
> With the first variant I get exactly one IRQ per vCPU during boot. I
> can't see such "spurious" IRQs with the second variant (=3D patch 2
> applied):
>=20
> Taken from /proc/interrupts
> HYP:          1          1          1          1   Hypervisor callback in=
terrupts
>=20
> Can someone enlighten me?

That is also understood now. The special inband handling of that sysvec
is missing in do_sysvec_inband(). Will be part of v2. With that I'm
able to see the "missing spurious interrupts".

Meanwhile I'm quite sure that the second variant is the way to go. I
think we want those async page faults to be handled inband.

>=20
> Best regards and have a nice weekend,
> Florian
>=20
>=20
> --=20
> Siemens AG, Technology
> Linux Expert Center

