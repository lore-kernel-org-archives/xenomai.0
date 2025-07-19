Received: from mslow4.mail.gandi.net (mslow4.mail.gandi.net [217.70.178.250])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 551A12F4A
	for <xenomai@lists.linux.dev>; Sat, 19 Jul 2025 21:31:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.178.250
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752960665; cv=none; b=lYyraDhhUeIjEMdKejcHl9P95CSpSnsyciTSVY5neqojPnZAvizAxSqIHnsdeTWDF7xkjKIknDY0jkiGa+fJlnJTSV/tykfFhCT668sHcQdakWAxu43MPu2iTPZi/ee4yqRTUvU1AB39GuH5RPL+rH4Mm8zd81fIhcMBtplgtkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752960665; c=relaxed/simple;
	bh=J9eoBaDQVC0xDb6mwaI4YMmNU6lqSGRDVuceK9AR/Ok=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=e9MfMoiOEMrdzWKBWKaL41q5DcdIbLoWM4qkCLfIniVAqwo1mzrSH1VMoD6PJzLRNA12esHq9BH6axohiZosMP4aCDZamiGHvmy2IDAqHbB+EZNAljnoLJjXK95wKPQfAjljNVMzXcKgcwwUjS1JG7YDBkAXO5/zUWeVZJ4S+Dk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=redirect.mail.gandi.net; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=UCMEkicg; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=taVGBjyM; arc=none smtp.client-ip=217.70.178.250
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redirect.mail.gandi.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="UCMEkicg";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="taVGBjyM"
Received: from redirect.mail.gandi.net (relay11.mail.gandi.net [IPv6:2001:4b98:dc4:8::231])
	by mslow4.mail.gandi.net (Postfix) with ESMTP id DB06E600216
	for <xenomai@lists.linux.dev>; Sat, 19 Jul 2025 21:17:33 +0000 (UTC)
Received: from spool.mail.gandi.net (spool1.mail.gandi.net [217.70.178.210])
	by relay11.mail.gandi.net (Postfix) with ESMTPS id 7DFEF43C64
	for <xenomai@lists.linux.dev>; Sat, 19 Jul 2025 21:17:26 +0000 (UTC)
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	by spool.mail.gandi.net (Postfix) with ESMTPS id F2ACA941B36
	for <xenomai@xenomai.org>; Sat, 19 Jul 2025 21:17:25 +0000 (UTC)
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1752959844;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=oFcvEnugLvV2961ov3yXEloBN8oXe/mIU9Hb11/Ub8s=;
	b=UCMEkicgRAaJYnzgEfRr/kshTFiJNmDSuqaiklmZ3YCWBUMQ8glH9uJAleXe4tzVD1/sUV
	sPJGhF+0BDF56tO31AFN12dEvDsDROEhUaW9Lpe4wdPIArYXgjU2Gp7FlA3MudDaXshyHO
	ZsrH8W5OXPUV6w8cSzuQDioCiiFFrrsxhMc6E40TrQecE4xYEufdKCEUeHLgGTxRYY3nvz
	TbOH7e2EPY8U31RGWFiYifOgt/CglO8QXKLYTjVcxmKbHFNBohvkO/ehNA/ZbGHsvQz2AZ
	e15Vb8k3iVGtF9sXlR8t9j2OMvCIrKhnu4iuMQ1uBe0y10UUctLSDtXxDOI+OQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1752959844;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=oFcvEnugLvV2961ov3yXEloBN8oXe/mIU9Hb11/Ub8s=;
	b=taVGBjyMHxwLgnAyTHFS5ZDZ4iRVx0QOFSdXB93CS7SyJJdzzzf79T++weQ7MiZAOyhuST
	r6m49xRxciYi8vAQ==
To: Phil Auld <pauld@redhat.com>
Cc: Jan Kiszka <jan.kiszka@siemens.com>, Henning Schild
 <henning.schild@siemens.com>, Peter Zijlstra <peterz@infradead.org>,
 x86@kernel.org, linux-kernel@vger.kernel.org, Ingo Molnar
 <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Guenter Roeck
 <linux@roeck-us.net>, xenomai@xenomai.org, guocai.he.cn@windriver.com,
 pauld@redhat.com
Subject: Re: sched: Unexpected reschedule of offline CPU#2!
In-Reply-To: <20250709134401.GA675435@lorien.usersys.redhat.com>
References: <20190729101349.GX31381@hirez.programming.kicks-ass.net>
 <alpine.DEB.2.21.1907291235580.1791@nanos.tec.linutronix.de>
 <20190729104745.GA31398@hirez.programming.kicks-ass.net>
 <20190729205059.GA1127@roeck-us.net>
 <alpine.DEB.2.21.1908161217380.1873@nanos.tec.linutronix.de>
 <20190816193208.GA29478@roeck-us.net>
 <alpine.DEB.2.21.1908172219470.1923@nanos.tec.linutronix.de>
 <20210727100018.19d61165@md1za8fc.ad001.siemens.net>
 <745f219e-1593-4fbd-fa7f-1719ef6f444d@siemens.com> <8734mg92pt.ffs@tglx>
 <20250709134401.GA675435@lorien.usersys.redhat.com>
Date: Sat, 19 Jul 2025 23:17:23 +0200
Message-ID: <87frervq1o.ffs@tglx>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain
X-GND-Status: LEGIT
Authentication-Results: spool.mail.gandi.net;
	dkim=pass header.d=linutronix.de header.s=2020 header.b=UCMEkicg;
	dkim=pass header.d=linutronix.de header.s=2020e header.b=taVGBjyM;
	dmarc=pass (policy=none) header.from=linutronix.de;
	spf=pass (spool.mail.gandi.net: domain of tglx@linutronix.de designates 193.142.43.55 as permitted sender) smtp.mailfrom=tglx@linutronix.de
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdeijeeflecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkgggtsehttdertddttddtnecuhfhrohhmpefvhhhomhgrshcuifhlvghigihnvghruceothhglhigsehlihhnuhhtrhhonhhigidruggvqeenucggtffrrghtthgvrhhnpefhgeekieeftedthefggfdufeevveetkedugefgjeeigeeffeegvddtvefhffffffenucfkphepvddujedrjedtrddujeekrddvuddtpdduleefrddugedvrdegfedrheehnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvddujedrjedtrddujeekrddvuddtpdhhvghlohepshhpohholhdrmhgrihhlrdhgrghnughirdhnvghtpdhmrghilhhfrhhomhepthhglhigsehlihhnuhhtrhhonhhigidruggvpdhnsggprhgtphhtthhopedupdhrtghpthhtohepgigvnhhomhgriheslhhishhtshdrlhhinhhugidruggvvh

On Wed, Jul 09 2025 at 09:44, Phil Auld wrote:
> Hi Thomas,
>
> On Tue, Sep 03, 2024 at 05:27:58PM +0200 Thomas Gleixner wrote:
>> On Tue, Jul 27 2021 at 10:46, Jan Kiszka wrote:
>> 
>> Picking up this dead thread again.
>
> Necro-ing this again...
>
> I keep getting occasional reports of this case. Unfortunately
> though, I've never been able to reproduce it myself.
>
> Did the below patch ever go anywhere?

Nope. Guocai said it does not work and I have no reproducer either to
actually look at it deeper and there was further debug data provided.

> It seems to be stable in my testing with the addition of
> an "extern" in asm/cpu.h to get it to build.

I don't see why it wouldn't be stable, but as it does not seem to solve
the issue merging it as is does not make sense.

Thanks,

        tglx
