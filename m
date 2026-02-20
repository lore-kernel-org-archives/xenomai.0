Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AA1C19D093
	for <xenomai@lists.linux.dev>; Fri, 20 Feb 2026 08:16:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771575369; cv=none; b=f6gQlR6xf4sGMnNmbiFGxqyysUYHandw29iBf1bxxpWY2AMEcKXO/26W3+eWXDz1hm0q1wQuxTmKaM/nHxfYzuiSgfcFmygoRT161Xb62Xi0CekWOPcL17wCzRMbD2EpW1MvYERWniQsuoSwD6Hw3eDHIWOPis2aQ0zl8x5NBnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771575369; c=relaxed/simple;
	bh=PYcA/NZzQB+uYY39Zg5sGauFRd54FyvFMmSd/0p80qY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=f/o6nqdXPgmwVHc6wv+kFygzWcTm85YlsCmpEljClkEJ3wUQEIAlX1TC6dLEbPw+VUY3q6D02n3Z3Dz3PkM9fNWJu+vmYWVY8aHY0S6WYaSBfwYJT3frO2MAwIdrjFRDx5iZblLl7WNUHtx/nTysk7rvFZk/Nf70MUlTAoMoJFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org; spf=pass smtp.mailfrom=xenomai.org; dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b=XC922gH+; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xenomai.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b="XC922gH+"
Received: by mail.gandi.net (Postfix) with ESMTPSA id B9DCA41B1D;
	Fri, 20 Feb 2026 08:16:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xenomai.org; s=gm1;
	t=1771575365;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mei3ViaoqaYcfaWBCv6BKPhCOZvevwtCtcUoHhSoFIc=;
	b=XC922gH+apiaKEnsYjxFqfZgAxHn12nWFH+9k72y2rjIxKzzKuTYy6C3qvWqZaRWM2eDy7
	wEAOVM1NPohlNY+n1HllVbfxvB9p7ZIvMlbZrgGmc3yDo9kVwILGz790A3XNggRe2NS5km
	Ui4HmCxI2RHkog1iddQ9ZIFefh5jUx2ykWrLvHAydjxCB8KKQEVH3LePBST1v6sNv6T+Lk
	q67Bd0A4JrQzFMuJel5Ihw6Nxafww6/a5YXcOOruXWPQE75OieodIWGStpQq2IqWyFiUzX
	XmdPHUVU49Z3hFv4gSq/259VSDk1b1XDQcKGlcp5uMdctmEBQvmFkahS9oQz3Q==
From: Philippe Gerum <rpm@xenomai.org>
To: Florian Bezdeka <florian.bezdeka@siemens.com>
Cc: Jan Kiszka <jan.kiszka@siemens.com>,  Xenomai <xenomai@lists.linux.dev>
Subject: Re: [PATCH Dovetail v2 1/2] dovetail: genirq: Add
 request_percpu_irq_affinity_flags()
In-Reply-To: <d4944aa75e5874d6a7566fc7be0fc5560a4b8ab0.camel@siemens.com>
	(Florian Bezdeka's message of "Thu, 19 Feb 2026 22:49:11 +0100")
References: <20260217-wip-flo-v6-19-dovetail-rebase-v2-0-45fc326a166a@siemens.com>
	<20260217-wip-flo-v6-19-dovetail-rebase-v2-1-45fc326a166a@siemens.com>
	<982c1b8b306d2abd81c88bc4669035957b664f2e.camel@siemens.com>
	<1d10a103-975b-44c8-89cd-7ac0d059f4cd@siemens.com>
	<e2650ecb681d004bdc97f48ac0afaf235bdc9521.camel@siemens.com>
	<87jyw83biv.fsf@xenomai.org>
	<d4944aa75e5874d6a7566fc7be0fc5560a4b8ab0.camel@siemens.com>
User-Agent: mu4e 1.12.12; emacs 30.2
Date: Fri, 20 Feb 2026 09:16:00 +0100
Message-ID: <87342vj0e7.fsf@xenomai.org>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: rpm@xenomai.org
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvvdejleefucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhgffffkgggtgfesthhqredttderjeenucfhrhhomheprfhhihhlihhpphgvucfivghruhhmuceorhhpmhesgigvnhhomhgrihdrohhrgheqnecuggftrfgrthhtvghrnhepveegudejhedtheeihfelfeffleffleeitdelgfelhfduhedvtdeljeekteeghefhnecukfhppedvrgdtudemvgdtrgemudelsgemfegtugdtmeelkeelrgemhegtgegsmegsjehffhemsggrfhenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvrgdtudemvgdtrgemudelsgemfegtugdtmeelkeelrgemhegtgegsmegsjehffhemsggrfhdphhgvlhhopehphihrohdpmhgrihhlfhhrohhmpehrphhmseigvghnohhmrghirdhorhhgpdhqihgupeeuleffveetgeduueduffdpmhhouggvpehsmhhtphhouhhtpdhnsggprhgtphhtthhopeefpdhrtghpthhtohepgigvnhhomhgriheslhhishhtshdrlhhinhhugidruggvvhdprhgtphhtthhopehjrghnrdhkihhsiihkrgesshhivghmvghnshdrtghomhdprhgtphhtthhopehflhhorhhirghnrdgsvgiiuggvkhgrsehsihgvmhgvnhhsrdgtohhm
X-GND-State: clean
X-GND-Score: -100

Florian Bezdeka <florian.bezdeka@siemens.com> writes:

> On Thu, 2026-02-19 at 18:10 +0100, Philippe Gerum wrote:
>> Florian Bezdeka <florian.bezdeka@siemens.com> writes:
>>=20
>> > On Wed, 2026-02-18 at 08:30 +0100, Jan Kiszka wrote:
>> > > On 18.02.26 00:05, Florian Bezdeka wrote:
>> > > > On Tue, 2026-02-17 at 23:54 +0100, Florian Bezdeka wrote:
>> > > > > cobalt / evl are currently using __request_percpu_irq() for sett=
ing up
>> > > > > OOB IRQs. In 6.19 the signature of __request_percpu_irq() has be=
en
>> > > > > updated and 7.0 will remove the function entirely, so we need a
>> > > > > replacement.
>> > > > >=20
>> > > > > All other variants (like the upcoming request_percpu_irq_affinit=
y())
>> > > > > are missing the flags parameter which we require.
>> > > > >=20
>> > > > > This could be backported to all supported dovetail versions. That
>> > > > > would allow co-kernels to switch to the new API unconditionally.
>> > > > >=20
>> > > > > Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
>> > > > > ---
>> > > > >  include/linux/interrupt.h |  5 +++++
>> > > > >  kernel/irq/manage.c       | 10 ++++++++++
>> > > > >  2 files changed, 15 insertions(+)
>> > > > >=20
>> > > > > diff --git a/include/linux/interrupt.h b/include/linux/interrupt=
.h
>> > > > > index bf0511b438c65e119af917763ce92a8f3bfb4c4c..6cd8ad02ffbd87f7=
1869d6737fbc8c1ae477c1ee 100644
>> > > > > --- a/include/linux/interrupt.h
>> > > > > +++ b/include/linux/interrupt.h
>> > > > > @@ -213,6 +213,11 @@ request_percpu_irq_affinity(unsigned int ir=
q, irq_handler_t handler,
>> > > > >  				    devname, affinity, percpu_dev_id);
>> > > > >  }
>> > > > >=20=20
>> > > > > +int request_percpu_irq_affinity_flags(unsigned int irq, irq_han=
dler_t handler,
>> > > > > +				      unsigned long flags, const char *devname,
>> > > > > +				      const cpumask_t *affinity,
>> > > > > +				      void __percpu *dev_id);
>> > > > > +
>> > > > >=20
>> > > >=20
>> > > > Would be nice to get some feedback here. The affinity parameter is
>> > > > currently not in use, but would allow us to provide it in the futu=
re.
>> > > > Not sure if that will be necessary...
>> > > >=20
>> > >=20
>> > > This is what I was wondering as well... When would one need that? Ma=
ybe
>> > > in the context of confining Xenomai to a subset of physical CPUs? Wo=
uld
>> > > be good to check that again.
>> >=20
>> > @Philippe: Any thoughts?
>> >=20
>> > I would like to complete the 6.19 port on Xenomai side. This is a
>> > blocker right now.
>> >=20
>>=20
>> To me this is a no-brainer, given that __request_percpu_irq() requires
>> an affinity mask, having request_percpu_irq_affinity_flags() is the only
>> sane way to set all the properties of a per-cpu interrupt, including
>> flags and affinity, in one go. In any case, callers who don't care about
>> such affinity can pass NULL.
>>=20
>
> Thanks for the confirmation.=C2=A0
>
> I will add the series now to the wip/flo/v6.19-dovetail-rebase branch
> and continue with the Xeno 3 adaptions. evl will need the same changes.
> Philippe, can you look into that or should I try to reserve some cycles?
>
> The Xeno 3 testsuite is already passing on that branch.

Ok. I'll handle the x4 updates.

--=20
Philippe.
