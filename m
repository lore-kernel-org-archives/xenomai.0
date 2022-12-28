Received: from mta-65-225.siemens.flowmailer.net (mta-65-225.siemens.flowmailer.net [185.136.65.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CA4F10E9
	for <xenomai@lists.linux.dev>; Wed, 28 Dec 2022 09:34:47 +0000 (UTC)
Received: by mta-65-225.siemens.flowmailer.net with ESMTPSA id 20221228085428506a82a2f0af36d31a
        for <xenomai@lists.linux.dev>;
        Wed, 28 Dec 2022 09:54:28 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=pn3RPbGUVDn1ZNBLtXVm44dht7+IX3QxaGxXC/p/e/Y=;
 b=PFnhP4yZi1AquijBHZKBO/lbGSFvZS+5W8F2osIyK39xNsEB0dtFYjWz5Ba7dSlMQp/A5Y
 PEG5N7Inonktop3BvohqhhVOqi6Hvy30jr7EW1gfWDrWcpeR9XOqyOTauwoGPm6CntASgzT8
 3TquEqN2KDeIZ+eUCmTFUOy8j6yZE=;
Message-ID: <4b5782203a0c3165aaa05055db94a5d58ecd5aa7.camel@siemens.com>
Subject: Re: Re: some kernel exceptions
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: Yxian Yao <yxianyao@126.com>
Cc: "xenomai@lists.linux.dev" <xenomai@lists.linux.dev>
Date: Wed, 28 Dec 2022 09:54:27 +0100
In-Reply-To: <54aadb13.294f.1855739927d.Coremail.yxianyao@126.com>
References: <44d3d245.e8a.1854d5dc672.Coremail.yxianyao@126.com>
	 <9da33db3ae41a25ec71926bbbd7f49dc5c19e8a6.camel@siemens.com>
	 <f723fb1a211933a3782a87a993aae17098535c5d.camel@siemens.com>
	 <54aadb13.294f.1855739927d.Coremail.yxianyao@126.com>
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

On Wed, 2022-12-28 at 13:34 +0800, Yxian Yao wrote:
>=20
> Hi Florian,
> > >=20
> > > [    0.214734] ACPI: x2apic entry ignored
> >=20
> > CONFIG_X86_X2APIC is enabled in your kernel configuration?
> Yes, it's OK now after CONFIG_X86_X2APIC is enabled.

Great. Thanks for reporting back.

This means that at least HP stopped testing their firmware without
x2apic support in the OS. There should be "fallbacks" available on the
platform but for some reason Linux never reaches the point where it
would/could enable them.

Maybe recent Linux versions handle that case better but the firmware
still has to provide correct values in the hardware description (ACPI
tables on x86).

>=20
> Thanks.
>=20

