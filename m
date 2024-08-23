Received: from mta-64-226.siemens.flowmailer.net (mta-64-226.siemens.flowmailer.net [185.136.64.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 064E11BF3A
	for <xenomai@lists.linux.dev>; Fri, 23 Aug 2024 09:46:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724406396; cv=none; b=ghH6Iij2Gs/KuWnM1kHXnx7PhTegjfFZypWTbB6Vssa1M499Ft4I+rDNlovbx60JrKzcL+u8I6cNgRCmi83o974Hwz1O3blq42ObmJR7bymQFdxhCYHhjQb9lsDDnp0N+JCegMSeLIfg2Z0QJL9gRgdspgc4gcNXXG8lqRGtw4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724406396; c=relaxed/simple;
	bh=TkLeNsRQXeGoMPeQuEUkB05EEx52bMOVk5458YY7K/s=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=rj1wXlQKFC5Hd9mG3ZJvc4DZlCM861QoJKzOyPePOSgYLa6BJBM5d75GOM+qZPfrorJyWjmgYzlkh8Z3fFUFdKAEDwvN4Gri6TpUGfPjVUAUI+7T8dT6eXGW13PbYHPLf8HLpz0fp44NQARJmsZwzRSyn6vekvAJKZJvO3abBRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=ewlDBBUK; arc=none smtp.client-ip=185.136.64.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="ewlDBBUK"
Received: by mta-64-226.siemens.flowmailer.net with ESMTPSA id 20240823094626762180596c3763f20e
        for <xenomai@lists.linux.dev>;
        Fri, 23 Aug 2024 11:46:27 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=nbh772SMt5r6fZv4ryjgJFxDU/C2INC4hPBDGUxdSiI=;
 b=ewlDBBUKodXETdNZVZbd3SbSZ3Ix3EeYY8yQQOJyQj28gBZZCUAXWCMFyxh7rCcM+FbuSK
 WjYuuFahaVMYkL0dHB1f6/gfCHgLhnux+xm3yJArkxa29kVAYcy7SqmZ+30YBU4bcrQw4ou4
 URBdBSxg1987Kk6Sski+6JoWOk3sayB7EtPyIsBVZKXcmPCKFiy0T4+hqyulynrDvoKR264w
 6s3qYx3rKTZKLhKCsc2No/8R1QefrLyOW8FRHHI6fUd1sxTDo7DE9y0peDgoSLG3VD+FjMW8
 qoW5dTHw7fbpB/orTxq63086y9J71omcmzMAalw0IL4mTTTn4a8BSW6A==;
Message-ID: <de2281e483ce9403c6637e3ee485b6c75450e70d.camel@siemens.com>
Subject: Re: [PATCH dovetail 6.10] x86: dovetail: Allow multiple HV guest
 extensions to be enabled
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai@lists.linux.dev
Date: Fri, 23 Aug 2024 11:46:25 +0200
In-Reply-To: <20240823091858.3355791-1-florian.bezdeka@siemens.com>
References: <20240823091858.3355791-1-florian.bezdeka@siemens.com>
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

On Fri, 2024-08-23 at 11:18 +0200, Florian Bezdeka wrote:
> do_sysvec_inband() assumed that only one of CONFIG_ACRN_GUEST and
> CONFIG_KVM_GUEST is active at the same time. If both were enabled we
> run into a compile issue:
>=20
> arch/x86/kernel/irq_pipeline.c: In function 'do_sysvec_inband':
> arch/x86/kernel/irq_pipeline.c:160:9: error: duplicate case value
>    160 |         case HYPERVISOR_CALLBACK_VECTOR:
>        |         ^~~~
> arch/x86/kernel/irq_pipeline.c:154:9: note: previously used here
>    154 |         case HYPERVISOR_CALLBACK_VECTOR:
>        |         ^~~~
>=20
> As only one hypervisor (HV) can be active at the same time, but support
> for more than one can be compiled in, we have to migrate from a build
> time decision to a runtime based one.
>=20
> We introduce sysvec_install() macro - like modern kernels already do -
> and call a dovetail specific pipelined_sysvec_install() before
> registering the IDT gate.

@Philippe: Feel free to drop this ^^ paragraph for the 6.10 version. It
only applies to the backport versions (6.6 and below). Sorry for
that...

>=20
> All HYPERVISOR_CALLBACK_VECTOR related callsites of alloc_intr_gate()
> have been migrated to sysvec_install(). sysvec_install() is able to
> distinguish between the low level entry point (asm_ variant) and the
> higher entry point (__ variant).
>=20
> The trampoline function (pipeline_hv_callback()) is needed to statisfy
> type checks done by run_sysvec_on_irqstack_cond().
>=20
> Reported-by: Ionut Nechita <ionut.nechita@intel.com>
> Closes: https://lore.kernel.org/xenomai/PH0PR11MB59498BE915597AEF0B5BBB30=
F4B42@PH0PR11MB5949.namprd11.prod.outlook.com/
> Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
> ---

