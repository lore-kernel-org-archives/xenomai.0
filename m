Received: from redirect.mail.gandi.net (relay12.mail.gandi.net [217.70.178.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98E1E1DE3BE
	for <xenomai@lists.linux.dev>; Sun, 20 Jul 2025 10:47:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.178.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753008451; cv=none; b=dErdA/3vFskZjCLv+f14Lbx2m2nYykPzXHQ7yUz7JRmX1gtNZ97WP5IvpKg+3KMr/+1oMgmhHsmOTS93jsvXeodrpZMLALy9Ul1/6vYixT60FwhRUUsfyqvsrXW84DQY/a9eVNoufDlMwQtN+cxW2ZG4GhwzKhu8hS178DiqouE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753008451; c=relaxed/simple;
	bh=7T4UmPxWF3hSWenvaR7LWVE1ExSGnC3YDZZYQPXcU8w=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=PegMNx+tVmpOWORXKERzcb4GdaoxrLQkp72L+KIL6e3ScPFOR8+x7vE1C36lkyrAe2E0cLqvpGntpvEoIdcfW8g/C6DZWEhmbdoUjj/wCkAyBtfJBB0G9pjTJrjPDKhSJTZWdUwXo4xF5HaOOkQTTIbZslkG7D3a0Z1mnoBU1BU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=redirect.mail.gandi.net; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=w7Wu5ruZ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=e+TrRVpZ; arc=none smtp.client-ip=217.70.178.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redirect.mail.gandi.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="w7Wu5ruZ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="e+TrRVpZ"
Received: from spool.mail.gandi.net (spool1.mail.gandi.net [217.70.178.210])
	by relay12.mail.gandi.net (Postfix) with ESMTPS id 6573143780
	for <xenomai@lists.linux.dev>; Sun, 20 Jul 2025 10:47:26 +0000 (UTC)
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
	by spool.mail.gandi.net (Postfix) with ESMTPS id DD836941B75
	for <xenomai@xenomai.org>; Sun, 20 Jul 2025 10:47:25 +0000 (UTC)
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1753008445;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ANWoogU7kBBZFJXWHTAlyNcWlCwd/ZfUPzBFIAyZehI=;
	b=w7Wu5ruZFGwOqp7it3tXXteBEKIWBOprt2uL9Hcl6oPOWrZxZdil4/iAQxHmWBldpzAU3O
	ZQsMpXlddStAxyQ9coVQUam3X2ep1utRzfk1TdWFDkD0lbFb9o4tVkkmx23/GAkFerPOi4
	PgzQxgP+hRMYB10tKvInolgWAfaoe24FFL0TZBjZIG8xRs9wL6PC26GNJefcXlvFR9IyYr
	6O6apjbemjTcR0uzerDrGmqZOWI5c4vwYgn/NVi5FiMiYAAEKU0YATGGiFNEdgWbxlhGh0
	w4PVLiJdLzzuduICJmOebSe19ZS922t8l8quLfzjfucyHniEJQmddXuicOcYPQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1753008445;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ANWoogU7kBBZFJXWHTAlyNcWlCwd/ZfUPzBFIAyZehI=;
	b=e+TrRVpZ4Aw3Y0AoXDbJCmp1H6ianIJdnWhcFJHGcPgqnyFhOZ8JxVuyzQrDF+4/WfGCbW
	0icJxHeyKrA9VsAQ==
To: Phil Auld <pauld@redhat.com>
Cc: Jan Kiszka <jan.kiszka@siemens.com>, Henning Schild
 <henning.schild@siemens.com>, Peter Zijlstra <peterz@infradead.org>,
 x86@kernel.org, linux-kernel@vger.kernel.org, Ingo Molnar
 <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Guenter Roeck
 <linux@roeck-us.net>, xenomai@xenomai.org, guocai.he.cn@windriver.com,
 pauld@redhat.com
Subject: Re: sched: Unexpected reschedule of offline CPU#2!
In-Reply-To: <87frervq1o.ffs@tglx>
References: <20190729101349.GX31381@hirez.programming.kicks-ass.net>
 <alpine.DEB.2.21.1907291235580.1791@nanos.tec.linutronix.de>
 <20190729104745.GA31398@hirez.programming.kicks-ass.net>
 <20190729205059.GA1127@roeck-us.net>
 <alpine.DEB.2.21.1908161217380.1873@nanos.tec.linutronix.de>
 <20190816193208.GA29478@roeck-us.net>
 <alpine.DEB.2.21.1908172219470.1923@nanos.tec.linutronix.de>
 <20210727100018.19d61165@md1za8fc.ad001.siemens.net>
 <745f219e-1593-4fbd-fa7f-1719ef6f444d@siemens.com> <8734mg92pt.ffs@tglx>
 <20250709134401.GA675435@lorien.usersys.redhat.com> <87frervq1o.ffs@tglx>
Date: Sun, 20 Jul 2025 12:47:24 +0200
Message-ID: <87a54zuojn.ffs@tglx>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain
X-GND-Status: LEGIT
Authentication-Results: spool.mail.gandi.net;
	dkim=pass header.d=linutronix.de header.s=2020 header.b=w7Wu5ruZ;
	dkim=pass header.d=linutronix.de header.s=2020e header.b=e+TrRVpZ;
	dmarc=pass (policy=none) header.from=linutronix.de;
	spf=pass (spool.mail.gandi.net: domain of tglx@linutronix.de designates 2a0a:51c0:0:12e:550::1 as permitted sender) smtp.mailfrom=tglx@linutronix.de
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdeikeellecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkgggtsehttdertddttddtnecuhfhrohhmpefvhhhomhgrshcuifhlvghigihnvghruceothhglhigsehlihhnuhhtrhhonhhigidruggvqeenucggtffrrghtthgvrhhnpefhgeekieeftedthefggfdufeevveetkedugefgjeeigeeffeegvddtvefhffffffenucfkphepvddujedrjedtrddujeekrddvuddtpddvrgdtrgemhedutgdtmedtmeduvdgvmeehhedtmeemudenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvudejrdejtddrudejkedrvddutddphhgvlhhopehsphhoohhlrdhmrghilhdrghgrnhguihdrnhgvthdpmhgrihhlfhhrohhmpehtghhlgieslhhinhhuthhrohhnihigrdguvgdpnhgspghrtghpthhtohepuddprhgtphhtthhopeigvghnohhmrghisehlihhsthhsrdhlihhnuhigrdguvghv

On Sat, Jul 19 2025 at 23:17, Thomas Gleixner wrote:
> On Wed, Jul 09 2025 at 09:44, Phil Auld wrote:
>> Hi Thomas,
>>
>> On Tue, Sep 03, 2024 at 05:27:58PM +0200 Thomas Gleixner wrote:
>>> On Tue, Jul 27 2021 at 10:46, Jan Kiszka wrote:
>>> 
>>> Picking up this dead thread again.
>>
>> Necro-ing this again...
>>
>> I keep getting occasional reports of this case. Unfortunately
>> though, I've never been able to reproduce it myself.
>>
>> Did the below patch ever go anywhere?
>
> Nope. Guocai said it does not work and I have no reproducer either to
> actually look at it deeper and there was further debug data provided.

Obviously:

        no further debug data was provided, so I can only tap in the
        dark.

