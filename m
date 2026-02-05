Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F02142749CF
	for <xenomai@lists.linux.dev>; Thu,  5 Feb 2026 17:47:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770313680; cv=none; b=EiO/9FBG5Ws2wGguQ0DPk1kYZwRDIdiku56wBUss36H6p8eZ9GCnftxjJSuj+U0EPHCY9sSAqeksZj/76iqgBnga4PXbjZytvMXOahLnrSEL8YOwYiRn1APVvwQPltahNfVodGP3OMSCuGhks4OX59JpXlE8p/S+B5oWurSdRX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770313680; c=relaxed/simple;
	bh=qCR3Hdxru1f3F7DKZv0B0U1Fo9MdbO2H/BKQpY/S4Ec=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=A49SnSj0vwAtnulx5fHTESrhAoYG+7NjHkUu0Keag8p8VZEqwUNAl6+LPpmDGSyjNsa30axr3K1G5RAMpDvltkqBFG0MZkRbc5b9B4s5TL3WmMiuZJK3c3RHyzazdBwpgrNGjhhcemU3Wx79qm+/2hfx/WgM9h84rc5eJVe6w5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org; spf=pass smtp.mailfrom=xenomai.org; dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b=ieZAHlNv; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xenomai.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b="ieZAHlNv"
Received: by mail.gandi.net (Postfix) with ESMTPSA id 6A251443B8;
	Thu,  5 Feb 2026 17:47:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xenomai.org; s=gm1;
	t=1770313672;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ODxmg1srWuaimQJD50ltB5IqKa8TfsafuTfn4sDjkLk=;
	b=ieZAHlNvN7ZtNDXgHrvm7PNW+BJirHtESDlOf4sS64LVHB6e1JDIio1WdjUSC3X5AoDD8l
	EeWAIfaa6GANgwWMHJGQv8dsvl19C+mc/cmBeEcJ66bDQ4N+qq/ySWfEHQRMZHZYu3W1kw
	RvDUQ2LvQaTvR6S5J8mTuAMY+D3nHwnrDnmleXgQid6g4F6U4bX5taFMwGD5fLDK3FlFUU
	1AQsHnF/w+EhyOIHyszbwulVBS/NQ2E0WnNuvmjRsA6brrph0BA6bIBl4UJeCYvtAIbhCT
	3PRb6vTPksGxLHa5aXHRklCN0DdwckA5MKMDPtnDTvGVR5z+Z4hEPenKZ2GndQ==
From: Philippe Gerum <rpm@xenomai.org>
To: "Steub, Peter" <Peter.Steub@baumueller.com>
Cc: "xenomai@lists.linux.dev" <xenomai@lists.linux.dev>
Subject: Re: evl_demote_thread() leaves dev file of the tread
In-Reply-To: <09cd2de3c2514bfb8d80ebf969a8eaf3@baumueller.com> (Peter Steub's
	message of "Thu, 5 Feb 2026 08:41:14 +0000")
References: <09cd2de3c2514bfb8d80ebf969a8eaf3@baumueller.com>
User-Agent: mu4e 1.12.12; emacs 30.2
Date: Thu, 05 Feb 2026 18:47:51 +0100
Message-ID: <875x8b9j5k.fsf@xenomai.org>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain
X-GND-Sasl: rpm@xenomai.org
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddukeehleegucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhgffffkgggtsehttdertddtredtnecuhfhrohhmpefrhhhilhhiphhpvgcuifgvrhhumhcuoehrphhmseigvghnohhmrghirdhorhhgqeenucggtffrrghtthgvrhhnpeeulefggfehtdefgeekgfffudetkeekhfehudehfeeigffgjeekkeelfeekjeeuveenucffohhmrghinhepghhithhlrggsrdgtohhmnecukfhppedvrgdtudemvgdtrgemudelsgemfegtugdtmeelkeelrgemhegtgegsmegsjehffhemsggrfhenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvrgdtudemvgdtrgemudelsgemfegtugdtmeelkeelrgemhegtgegsmegsjehffhemsggrfhdphhgvlhhopehphihrohdpmhgrihhlfhhrohhmpehrphhmseigvghnohhmrghirdhorhhgpdhqihgupeeitedvhedugeegfeeukedpmhhouggvpehsmhhtphhouhhtpdhnsggprhgtphhtthhopedvpdhrtghpthhtohepgigvnhhomhgriheslhhishhtshdrlhhinhhugidruggvvhdprhgtphhtthhopefrvghtvghrrdfuthgvuhgssegsrghumhhuvghllhgvrhdrtghomh

"Steub, Peter" <Peter.Steub@baumueller.com> writes:

> In my application I have a fallback solution to kill a oob thread, if the regular way of closing the thread fails and a timeout runs out. 
> I do this by calling evl_demote_thread() and pthread_cancel() afterwards. This seems to work, evl_demote_thread() gives me a 0 returnvalue, and the thread is gone after pthread_cancel(). 
>
> When I create a new thread, and try to put it in oob mode with the same name using evl_attach_self(), I get EEXIST (-17) from evl_attach_self().
> Am I doing it wrong? Is there another way to do a detach from outside the thread? Do I need to do something more then evl_demote_thread() to really get rid of the thread?
>
> I am on evl 0.52 right now.

== TL;DR:

Assuming tfd is the file descriptor obtained from the
evl_attach_{thread/self]() call, you should use the following sequence
to respawn the target thread multiple times, possibly within a short
time window:

pthread_cancel(tid);
pthread_join(tid, NULL);
close(tfd);


== Long story:

The lifetime of all so-called EVL "elements" (e.g. threads, monitors,
proxies, observables etc) is managed by the regular VFS. Each of them is
represented by a virtual device in the kernel, therefore we can get any
number of regular file descriptors referring to such device. As long as
a valid file descriptor refers to the device, the associated element
cannot go stale.

For this reason, closing all file descriptors referring to an element is
required to release the device along with other resources attached to
the element in the core, allowing for the final disposal to take
place. Failing to do so prevents the creation of another instance with
the same name in the same class of elements.

This is now illustrated by the unit test which was added to the -next
branch a short time ago [1].

[1]
https://gitlab.com/Xenomai/xenomai4/libevl/-/commit/a54d987dd3dee297f579078720fd648ce12a77b3

-- 
Philippe.
