Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 995DE34DCD9
	for <xenomai@lists.linux.dev>; Thu, 19 Feb 2026 17:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771521007; cv=none; b=FCe3nZvzTKW/wCHF3Yf11Ygqnmxs6B2oK8etb+qgFn9hSQCfw0vCvc+/yzMORBgw63MuKBBqB7Th2ZDnGsrK7pXKSTR/yMIbbwduV2TPbX75qIBxar+6j/qlFhAVujUSYurH/P+mYLxE5qZaU/fh45bRsm4bSwO6l4BZutSZlBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771521007; c=relaxed/simple;
	bh=PntBoUk6KTNIVOW3r3dUHAOXzLDiVnkbmZKarIEw9+U=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=OnkqslsVmF/UtWRKxByY5a9KCrKPBn8xRUobm3o/3Bq3SlFvRnmLM16J/HyBFeaZ+THjzBWo3K6o+wv3bs4tlVAy2w2Kx8tDXiljlzX/cEOzVny1kGmynOAIbvJhG6R/L+OEFWXanpSAoihvOfd5tMK2kd2ffUWsl2hlhmnG2i4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org; spf=pass smtp.mailfrom=xenomai.org; dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b=Fzsb8TIH; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xenomai.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b="Fzsb8TIH"
Received: by mail.gandi.net (Postfix) with ESMTPSA id 703A4201A0;
	Thu, 19 Feb 2026 17:10:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xenomai.org; s=gm1;
	t=1771521001;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BwqTL4DiVg99UHcEJFuZnyFoMrhDM9vy/HxnLe7424k=;
	b=Fzsb8TIHJqwEUhB2zqrK7htzRSV0Jfu/ZfkFqJJyJIgyA1ft2mzSULD3r7aRyor5hVd/J8
	FreCQmMe8N9l4Adp+2QBxptPieUAPX7lIdLZLLVNrZpw1yy1lpA1CBSqoUx1CS/wbpN6YR
	Q7fjxbKISf2ahayAz9/l1QNAd7AJ/lLTlKxDROVpHfy4dFRxbxzMeap3/4tJgq90UxK/sK
	1dNJe8zVB6MgUdpq4UUAI9NLrEm/5uM2f8Dw3Z2IH8g0N4oVjcyvgdggJOplRLfCpTgaZG
	OvRf2noQujMyUnX4MJxK4tK6UmlzrnHUrJoMxMBYdekTXqJBeGsTCN4GFGiBww==
From: Philippe Gerum <rpm@xenomai.org>
To: Florian Bezdeka <florian.bezdeka@siemens.com>
Cc: Jan Kiszka <jan.kiszka@siemens.com>,  Xenomai <xenomai@lists.linux.dev>
Subject: Re: [PATCH Dovetail v2 1/2] dovetail: genirq: Add
 request_percpu_irq_affinity_flags()
In-Reply-To: <e2650ecb681d004bdc97f48ac0afaf235bdc9521.camel@siemens.com>
	(Florian Bezdeka's message of "Thu, 19 Feb 2026 17:38:46 +0100")
References: <20260217-wip-flo-v6-19-dovetail-rebase-v2-0-45fc326a166a@siemens.com>
	<20260217-wip-flo-v6-19-dovetail-rebase-v2-1-45fc326a166a@siemens.com>
	<982c1b8b306d2abd81c88bc4669035957b664f2e.camel@siemens.com>
	<1d10a103-975b-44c8-89cd-7ac0d059f4cd@siemens.com>
	<e2650ecb681d004bdc97f48ac0afaf235bdc9521.camel@siemens.com>
User-Agent: mu4e 1.12.12; emacs 30.2
Date: Thu, 19 Feb 2026 18:10:00 +0100
Message-ID: <87jyw83biv.fsf@xenomai.org>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain
X-GND-Sasl: rpm@xenomai.org
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvvdeitdelucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhgffffkgggtsehttdertddtredtnecuhfhrohhmpefrhhhilhhiphhpvgcuifgvrhhumhcuoehrphhmseigvghnohhmrghirdhorhhgqeenucggtffrrghtthgvrhhnpedvlefhvdehkeduheevleegiedtueejgfekhfeijeefvdeijeekgeeigfejhfekgeenucfkphepvdgrtddumegvtdgrmedulegsmeeftggutdemleeklegrmeehtgegsgemsgejfhhfmegsrghfnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvdgrtddumegvtdgrmedulegsmeeftggutdemleeklegrmeehtgegsgemsgejfhhfmegsrghfpdhhvghlohepphihrhhopdhmrghilhhfrhhomheprhhpmhesgigvnhhomhgrihdrohhrghdpqhhiugepjedtfeetgedvtddutedtpdhmohguvgepshhmthhpohhuthdpnhgspghrtghpthhtohepfedprhgtphhtthhopeigvghnohhmrghisehlihhsthhsrdhlihhnuhigrdguvghvpdhrtghpthhtohepjhgrnhdrkhhishiikhgrsehsihgvmhgvnhhsrdgtohhmpdhrtghpthhtohepfhhlohhrihgrnhdrsggviiguvghkrgesshhivghmvghnshdrtghomh
X-GND-State: clean

Florian Bezdeka <florian.bezdeka@siemens.com> writes:

> On Wed, 2026-02-18 at 08:30 +0100, Jan Kiszka wrote:
>> On 18.02.26 00:05, Florian Bezdeka wrote:
>> > On Tue, 2026-02-17 at 23:54 +0100, Florian Bezdeka wrote:
>> > > cobalt / evl are currently using __request_percpu_irq() for setting up
>> > > OOB IRQs. In 6.19 the signature of __request_percpu_irq() has been
>> > > updated and 7.0 will remove the function entirely, so we need a
>> > > replacement.
>> > > 
>> > > All other variants (like the upcoming request_percpu_irq_affinity())
>> > > are missing the flags parameter which we require.
>> > > 
>> > > This could be backported to all supported dovetail versions. That
>> > > would allow co-kernels to switch to the new API unconditionally.
>> > > 
>> > > Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
>> > > ---
>> > >  include/linux/interrupt.h |  5 +++++
>> > >  kernel/irq/manage.c       | 10 ++++++++++
>> > >  2 files changed, 15 insertions(+)
>> > > 
>> > > diff --git a/include/linux/interrupt.h b/include/linux/interrupt.h
>> > > index bf0511b438c65e119af917763ce92a8f3bfb4c4c..6cd8ad02ffbd87f71869d6737fbc8c1ae477c1ee 100644
>> > > --- a/include/linux/interrupt.h
>> > > +++ b/include/linux/interrupt.h
>> > > @@ -213,6 +213,11 @@ request_percpu_irq_affinity(unsigned int irq, irq_handler_t handler,
>> > >  				    devname, affinity, percpu_dev_id);
>> > >  }
>> > >  
>> > > +int request_percpu_irq_affinity_flags(unsigned int irq, irq_handler_t handler,
>> > > +				      unsigned long flags, const char *devname,
>> > > +				      const cpumask_t *affinity,
>> > > +				      void __percpu *dev_id);
>> > > +
>> > > 
>> > 
>> > Would be nice to get some feedback here. The affinity parameter is
>> > currently not in use, but would allow us to provide it in the future.
>> > Not sure if that will be necessary...
>> > 
>> 
>> This is what I was wondering as well... When would one need that? Maybe
>> in the context of confining Xenomai to a subset of physical CPUs? Would
>> be good to check that again.
>
> @Philippe: Any thoughts?
>
> I would like to complete the 6.19 port on Xenomai side. This is a
> blocker right now.
>

To me this is a no-brainer, given that __request_percpu_irq() requires
an affinity mask, having request_percpu_irq_affinity_flags() is the only
sane way to set all the properties of a per-cpu interrupt, including
flags and affinity, in one go. In any case, callers who don't care about
such affinity can pass NULL.

-- 
Philippe.
