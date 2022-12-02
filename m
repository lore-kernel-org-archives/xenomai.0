Received: from mta-64-226.siemens.flowmailer.net (mta-64-226.siemens.flowmailer.net [185.136.64.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A34E62FB2
	for <xenomai@lists.linux.dev>; Fri,  2 Dec 2022 14:08:21 +0000 (UTC)
Received: by mta-64-226.siemens.flowmailer.net with ESMTPSA id 2022120213580462b853ebc22a3fa210
        for <xenomai@lists.linux.dev>;
        Fri, 02 Dec 2022 14:58:04 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=dxe/9v4pb/w/+fp7eUUChug9lK/UtoWkk2tFF4JS+v8=;
 b=h4WB0uxA7iCIw4drzml3PthXK/LpiheAiF2vH01pRg951ZWe0lEqt8khdrMHRiv6jYqseE
 gpIBS9oDY4f1kuYIbb4qVSeNkETT+8HmrCAi6FHBAKxwbYRY82UP9J2tokgHG7c/KcxQpwmr
 1s3NDSJtTQp/6vN1FzKQZjIsuROZU=;
Message-ID: <dbd666bf96f96801d9c73795ba6d14f252661fd8.camel@siemens.com>
Subject: Re: [PATCH 3/5] switchtest: test multiple secondary switch cases
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: "T. Schaffner" <tobias.schaffner@siemens.com>, xenomai@lists.linux.dev
Cc: jan.kiszka@siemens.com
Date: Fri, 02 Dec 2022 14:58:03 +0100
In-Reply-To: <dc5803331d4b4197017d91a9cadfed61ab122eec.camel@siemens.com>
References: <20221130141134.2503172-1-tobias.schaffner@siemens.com>
	 <20221130141134.2503172-4-tobias.schaffner@siemens.com>
	 <dc5803331d4b4197017d91a9cadfed61ab122eec.camel@siemens.com>
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

On Wed, 2022-11-30 at 15:37 +0100, Florian Bezdeka wrote:
> On Wed, 2022-11-30 at 15:11 +0100, T. Schaffner wrote:
> > +static void switch_to_secondary_mode_by_fault_in_xenomai_syscall(void)
> > +{
> > +	XENOMAI_SYSCALL2(sc_cobalt_sem_timedwait64, NULL, NULL);
> > +	assert_secondary_mode();
> > +}
>=20
> Let me revisit this one here. I guess we should not fault at all. Seems
> you re-detected a bug. I had some problems with that while working on
> the first round y2038 stuff and decided to keep it as it always was.
>=20
> Will have to check where the fault actually happens. Maybe it's
> acceptable to trigger the fault with NULL. (At least it seems to be
> handled correctly)
>=20
> Open question: If we would not trigger a fault, how to handle that one
> of your test requirements goes away...
>=20

Done today. You should not expect the sc_cobalt_sem_timedwait64 to
fault when the first parameter is NULL. That's more a "bug". It's still
correctly handled but a primary =3D> secondary transition by involving
the page fault handler is a overkill here (IMHO).

Can't we extend the switchtest uapi like you did with the new
switch_mode flag that you introduced? Something like a new
trigger_fault flag should be doable, no?

I guess that would do it:
	int tmp;
	if (trigger_fault)
		cobalt_copy_from_user(&tmp, 0xdeadbeefUL,
sizeof(tmp));

That would keep the switchtest utility decoupled from stuff like y2038
syscalls. I would highly recommend decoupling.

Best regards,
Florian
