Received: from mta-64-226.siemens.flowmailer.net (mta-64-226.siemens.flowmailer.net [185.136.64.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DCFA3BFAEB
	for <xenomai@lists.linux.dev>; Mon,  6 Jul 2026 07:38:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783323529; cv=none; b=THx8XnFyRv4rllqU8hcSnamwRxkpAXhnvs3lt0CTweF9/WbthcXOQUBA/6krsrls6V6nfiFqxKx9/13+X0tuAJF8Bc8tccNi+NbUKD/WwoftQfkJMrUEC9gahxASYxjYgTmlt3PNjFmERmLke7oEs3jXQWlSXGhMYzb7vrT/JnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783323529; c=relaxed/simple;
	bh=NUIUDLqhg9ix2sopcC4NBjLA7ljmm057uMgrWchQ4uo=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=p6qqHf+SSZwkdZVxQmmIZq7EvP600mrZfeUDLiB1rIqjeYx2KeAL7OdGeRc8w2Slo8KNo2JLDdgT4d2uBpPKIFsPqMKcmjZH3FxW10GICZrut7p6d9+cW8fxJcMPcXoHLAMbs/qOg+ugvzHBhdZYr/5GqZukMvoTt34/4xJSJvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=ohXi3JF2; arc=none smtp.client-ip=185.136.64.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="ohXi3JF2"
Received: by mta-64-226.siemens.flowmailer.net with ESMTPSA id 202607060738269e1f04e3ef00020724
        for <xenomai@lists.linux.dev>;
        Mon, 06 Jul 2026 09:38:27 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=NfUitqzJ5Hl25Ktg0Dq96v1XJ8KwKmYVLFG0ggCz8Fw=;
 b=ohXi3JF2T/ZtsYRo2H1RxpKpwB5AWrEwI8JiGd+ZPxJL+b9LbF1/T4H3ZpA2c8kBaqYFNH
 741rig+Ca8xRUV3Y5y1KefCNQwoe4o6q79/T5Ir80JX8aBIoo+mZM+4yhh72e+bSk2zkpVJU
 crGcKF5lY1S31wvkjuw8hWvLvesg8RZpnca9QZLxK5eX0KQHHvpgIMcOJ1vyfWpR/r3471Uh
 rsRMxtOc2vALRnPfvdGDvudYqpkDhYv9+k4K4ELsG2DyIlQ7lXq3Krwr8yiNEFl39yT2vhSW
 OF6rw7iiajikx5JxYNrEaghnUhDWbSU/g+Nso0h6y9JxYeYLwmEMBNYw==;
Message-ID: <08cea22b06a502fb97101869738f0873eec8de12.camel@siemens.com>
Subject: Re: [PATCH dovetail v9 00/11] riscv: Add dovetail support
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: rpm@xenomai.org, Tobias Schaffner <tobias.schaffner@siemens.com>
Cc: jan.kiszka@siemens.com, xenomai@lists.linux.dev
Date: Mon, 06 Jul 2026 09:38:26 +0200
In-Reply-To: <20260703152738.129122-1-tobias.schaffner@siemens.com>
References: <20260703152738.129122-1-tobias.schaffner@siemens.com>
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

On Fri, 2026-07-03 at 17:27 +0200, Tobias Schaffner wrote:
> Hi all,
>=20
> this series introduces initial support for Dovetail on RISC-V.
>=20
> Feedback, suggestions, and especially reviews are very welcome.
>=20
> Changes since v1:
>  * Disable independent irq/softirq stack usage when pipelining
>  * Drop KVM changes as long as they can not be properly tested
>=20
> Changes since v2:
>  * Rework trap handling
>=20
> Changes since v3:
>  * Included the IRQ pipelining patches to have all riscv specific
>    patches included
>  * Rebased to dovetail/v6.18.y-dovetail-rebase
>  * Merged most of the fixes
>  * Fixed IRQ Stack handling and enabled IRQ_STACKS again
>=20
> Changes since v4:
>  * Rebased to dovetail/v7.0.y-dovetail-rebase
>  * Applied suggestions from the last patch set
>  * Added starfive-visionfive2 board support
>  * Introduced raw console device based on sbi debug console
>  * Reworked pipelined irq handling
>=20
> Changes since v5:
>  * Rebased to tip of dovetail/v7.0.y-dovetail-rebase
>  * Applied suggestions from the last patch set
>  * Use mark_trap_entry/exit_raw for kernel mode exception paths which
>    use irq_nmi_entry/exit for now, as the nmi irq handlers expect hard
>    irqs to stay off. This may be be subject to further optimization at
>    a later stage, but I do not see any negative impact latency wise in
>    my tests.
>=20
> Changes since v6:
> Address the review comments from the last patch set:
>  * Keep the virtual irq state in sync with the hard irq state in trap
>    handlers
>  * Fix irq_nesting imbalance when running with disabled IRQ_STACKS
>=20
> Changes since v7:
>  * Simplify Trap handling
>  * Rebase to wip/flo/v7.1-dovetail-rebase
>=20
> Changes since v8:
>  * Further simplify trap handling adressing Florians suggestions and
>    recent fixes to irq-entry-common

Minor:

 - Changelog in reverse order, newest first
 - Enumeration of changed patches, so we don't have to review all
   of them again.



Philippe, how do we proceed here? Do you want me to update the +riscv
branches that we have for 7.1 and than take over from there? Or should
we move it to the 7.2 cycle?

Same question for 7.1: How do we proceed as 7.2-rc1 is out...=20
