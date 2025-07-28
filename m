Received: from redirect.mail.gandi.net (relay11.mail.gandi.net [217.70.178.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 952BB265CC0
	for <xenomai@lists.linux.dev>; Mon, 28 Jul 2025 13:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.178.231
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753708439; cv=none; b=L4nKgCYdfavg2To22Z4tDp/aaCULiuJmuwk9FBgxtnhM3jHq+s0iBz1ipA3lKYwW5rgA+QOdX4pszoOzUDdQ0mCsRGq/vgVkt8S1h3HE3V9UCMDRyWn8NhRTxUfSbYDZkPqdqkx0MQGAwpdxkKPTWRVYUWua2hzPBXIvmMdS5sE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753708439; c=relaxed/simple;
	bh=rnQAdYSkOSmkh2ESZepaL4/I7ev1FUXTgQe5gsGMi40=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Gy/2ysWiHkHZWFqIf1N+no7cSrt+qIw6j3s73eH4bzQFMQFqTggDRfkyF7dPOHFVP6a97w0tk8H6EsXkiY0qnxFMqK0AB2eloReQeK83VgsNDUrbUzmSZk4svWbXabeJ256a5dbN43SnuDNLWVivwNyV8Y/FyPOFClshPPmT8/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redirect.mail.gandi.net; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TIlzYx7n; arc=none smtp.client-ip=217.70.178.231
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redirect.mail.gandi.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TIlzYx7n"
Received: from spool.mail.gandi.net (spool3.mail.gandi.net [217.70.178.212])
	by relay11.mail.gandi.net (Postfix) with ESMTPS id 6E6D2436A4
	for <xenomai@lists.linux.dev>; Mon, 28 Jul 2025 13:13:49 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by spool.mail.gandi.net (Postfix) with ESMTPS id B450DAC0E95
	for <xenomai@xenomai.org>; Mon, 28 Jul 2025 13:13:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753708427;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pG1arC9sQZZIaXos31tacar34XTTwmcp5owYfE/iX9Y=;
	b=TIlzYx7nVAJnVENSmlhs9v9ZttA22gTkj7UeyeRiC0oJrrY6HkJdJuzzWB5eGtpGpoNzJ1
	6ylZh3MRYoxFvaVrAjmpANNoIXpF0oeH/IPw2HziMRgKbhImLUD4lTHTCf15zONuWPy1a4
	zd/vW8NzT+cnZh9gojQ7z71sYn65XTI=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-680-17ZUJll5OWq_uVGvFoaFmw-1; Mon,
 28 Jul 2025 09:13:44 -0400
X-MC-Unique: 17ZUJll5OWq_uVGvFoaFmw-1
X-Mimecast-MFC-AGG-ID: 17ZUJll5OWq_uVGvFoaFmw_1753708423
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id AFCD3195609F;
	Mon, 28 Jul 2025 13:13:41 +0000 (UTC)
Received: from pauld.westford.csb (unknown [10.22.88.177])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 021D31800B69;
	Mon, 28 Jul 2025 13:13:37 +0000 (UTC)
Date: Mon, 28 Jul 2025 09:13:34 -0400
From: Phil Auld <pauld@redhat.com>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Jan Kiszka <jan.kiszka@siemens.com>,
	Henning Schild <henning.schild@siemens.com>,
	Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
	linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>, Guenter Roeck <linux@roeck-us.net>,
	xenomai@xenomai.org, guocai.he.cn@windriver.com
Subject: Re: sched: Unexpected reschedule of offline CPU#2!
Message-ID: <20250728131334.GB11434@pauld.westford.csb>
References: <20190729205059.GA1127@roeck-us.net>
 <alpine.DEB.2.21.1908161217380.1873@nanos.tec.linutronix.de>
 <20190816193208.GA29478@roeck-us.net>
 <alpine.DEB.2.21.1908172219470.1923@nanos.tec.linutronix.de>
 <20210727100018.19d61165@md1za8fc.ad001.siemens.net>
 <745f219e-1593-4fbd-fa7f-1719ef6f444d@siemens.com>
 <8734mg92pt.ffs@tglx>
 <20250709134401.GA675435@lorien.usersys.redhat.com>
 <87frervq1o.ffs@tglx>
 <87a54zuojn.ffs@tglx>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87a54zuojn.ffs@tglx>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-GND-Status: LEGIT
Authentication-Results: spool.mail.gandi.net;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b=TIlzYx7n;
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	spf=pass (spool.mail.gandi.net: domain of pauld@redhat.com designates 170.10.133.124 as permitted sender) smtp.mailfrom=pauld@redhat.com
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdelvddviecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfhhihhlucetuhhlugcuoehprghulhgusehrvgguhhgrthdrtghomheqnecuggftrfgrthhtvghrnhepueefjeethefhtddtgefhfeelleefgfffgfegleefgfduhefgleevvdfhveffleehnecukfhppedvudejrdejtddrudejkedrvdduvddpheegrddukeeirdduleekrdeifeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvudejrdejtddrudejkedrvdduvddphhgvlhhopehsphhoohhlrdhmrghilhdrghgrnhguihdrnhgvthdpmhgrihhlfhhrohhmpehprghulhgusehrvgguhhgrthdrtghomhdpnhgspghrtghpthhtohepuddprhgtphhtthhopeigvghnohhmrghisehlihhsthhsrdhlihhnuhigrdguvghv

On Sun, Jul 20, 2025 at 12:47:24PM +0200 Thomas Gleixner wrote:
> On Sat, Jul 19 2025 at 23:17, Thomas Gleixner wrote:
> > On Wed, Jul 09 2025 at 09:44, Phil Auld wrote:
> >> Hi Thomas,
> >>
> >> On Tue, Sep 03, 2024 at 05:27:58PM +0200 Thomas Gleixner wrote:
> >>> On Tue, Jul 27 2021 at 10:46, Jan Kiszka wrote:
> >>> 
> >>> Picking up this dead thread again.
> >>
> >> Necro-ing this again...
> >>
> >> I keep getting occasional reports of this case. Unfortunately
> >> though, I've never been able to reproduce it myself.
> >>
> >> Did the below patch ever go anywhere?
> >
> > Nope. Guocai said it does not work and I have no reproducer either to
> > actually look at it deeper and there was further debug data provided.
> 
> Obviously:
> 
>         no further debug data was provided, so I can only tap in the
>         dark.
>

Fair enough, thanks. I did not see the "does not work" part :)


Cheers,
Phil


-- 

