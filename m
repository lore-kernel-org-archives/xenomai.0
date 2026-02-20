Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4647533C197
	for <xenomai@lists.linux.dev>; Fri, 20 Feb 2026 10:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771582669; cv=none; b=BrqxiR3Dv89Tlq6oOVXlEVNHerw90vJwtEsEgrj28KqE2yZq55/eUvHIR2QnebFRNmDcw5TtCGlgYtoakIsfhhN834qD4USzagD5qB2KTtuq2+NpKZd5mxKxQdbyukM5I60mwNHL77hocNvEKFX4tm3/NDIxNyxeOUhIXWl8irA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771582669; c=relaxed/simple;
	bh=Z8zF8f2GR4lctn7dyMT1sC212npgd/Cn73Xa3s2ZJtE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=b7Xrf++Gz9BPRj2WQIF9ktLGokLBItaVv0bklzs3DENqPYSn846TFJ4sb8B6lSvzI0XfmrbFAMe7lzsge4EZ7exszmnp5TDHolnuLZKCq3qduOGol6b3LxiOYrXskQmtJ2swwdbuqOUbev6Vi9qJrKy8F8jyJq5D6nG6FL9JdwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org; spf=pass smtp.mailfrom=xenomai.org; dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b=fje5Ch48; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xenomai.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b="fje5Ch48"
Received: by mail.gandi.net (Postfix) with ESMTPSA id 8D39D41DF8;
	Fri, 20 Feb 2026 10:17:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xenomai.org; s=gm1;
	t=1771582665;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Z8zF8f2GR4lctn7dyMT1sC212npgd/Cn73Xa3s2ZJtE=;
	b=fje5Ch48q/QK9mQStHjuo23oUk10l7PAHIWT2Skmoc8RV6zNmUkNmfKfCbbrIm3oixQr9h
	SPn7EZE9OXZEflsASgT1iGf0e39jeL8OsSAYC8qeHWmLwqrmASxfJSgtu96cFjDTz9IX+X
	omrAX3xm58X2iCn/6MNEBK9+AXEZWNIoXE2cx4KTUsMiwpYwu5uATLVwCnHGIajVzwSTtw
	AAwTLUwIrQvN0Fo5IDNVMWEjWPRCRlWaosJEN/H0tnkdgo6nQU+R+OX1JyAJ1KH1Dz6wv1
	xLii3Es5hniHI8uu97hhD9nlU50Q0p9Di6tc9LuPHrF9LVWvaEPxSZge84CE3w==
From: Philippe Gerum <rpm@xenomai.org>
To: Tobias Schaffner <tobias.schaffner@siemens.com>
Cc: xenomai@lists.linux.dev,  Jan Kiszka <jan.kiszka@siemens.com>
Subject: Re: evl: ptrace continue without hardware singlestepping support
In-Reply-To: <87o6ljhgml.fsf@xenomai.org> (Philippe Gerum's message of "Fri,
	20 Feb 2026 11:08:18 +0100")
References: <40a86435-758d-49c5-8ae3-078ea32b5e0f@siemens.com>
	<87o6ljhgml.fsf@xenomai.org>
User-Agent: mu4e 1.12.12; emacs 30.2
Date: Fri, 20 Feb 2026 11:17:45 +0100
Message-ID: <87ikbrhg6u.fsf@xenomai.org>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: rpm@xenomai.org
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvvdekudejucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhgffffkgggtgfesthhqredttderjeenucfhrhhomheprfhhihhlihhpphgvucfivghruhhmuceorhhpmhesgigvnhhomhgrihdrohhrgheqnecuggftrfgrthhtvghrnhepveegudejhedtheeihfelfeffleffleeitdelgfelhfduhedvtdeljeekteeghefhnecukfhppedvrgdtudemvgdtrgemudelsgemfegtugdtmeelkeelrgemhegtgegsmegsjehffhemsggrfhenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvrgdtudemvgdtrgemudelsgemfegtugdtmeelkeelrgemhegtgegsmegsjehffhemsggrfhdphhgvlhhopehphihrohdpmhgrihhlfhhrohhmpehrphhmseigvghnohhmrghirdhorhhgpdhqihgupeekffefleffgedufffhkedpmhhouggvpehsmhhtphhouhhtpdhnsggprhgtphhtthhopeefpdhrtghpthhtohepjhgrnhdrkhhishiikhgrsehsihgvmhgvnhhsrdgtohhmpdhrtghpthhtohepgigvnhhomhgriheslhhishhtshdrlhhinhhugidruggvvhdprhgtphhtthhopehtohgsihgrshdrshgthhgrfhhfnhgvrhesshhivghmvghnshdrtghomh
X-GND-State: clean
X-GND-Score: -100

Philippe Gerum <rpm@xenomai.org> writes:

> Tobias Schaffner <tobias.schaffner@siemens.com> writes:
>
>> Hi Philippe,
>>
>> the RISC-V port has an open issue regarding OOB synchronization of
>> threads in the EVL ptrace implementation, which leads to a deadlock
>> when running the ptrace-sync test.
>>
>> RISC-V currently does not support hardware-based single stepping, and
>> GDB=E2=80=99s behavior on `continue` with multiple threads is different.
>>
>> If hardware single stepping is available, GDB single-steps the hitter
>> with PTRACE_SINGLESTEP and continues the other threads with
>> PTRACE_CONT. All threads are continued and can pass the
>> evl_wait_event() barrier in handle_ptstop_event(). The hitter breaks
>> again and is finally continued.
>>
>> In contrast, if hardware single stepping is not available, GDB adds a
>> breakpoint to the next instruction, wakes only the hitter with
>> PTRACE_CONT, and waits for it to make its step before waking its
>> siblings. However, the hitter is not able to make its step because it
>> waits in the kernel for its siblings in evl_wait_event(), which are
>> not going to be woken by GDB until the hitter makes its step.
>>
>> The attached strace files show the behavior of GDB on both
>> architectures when continuing the breaking worker thread in
>> `ptrace.c`.
>>
>> Jan already pointed out that there may be a general problem with
>> expecting GDB to always continue all threads, and I think he is
>> right. Changing the scheduler-locking mode in All-Stop Mode [1], as
>> well as switching to Non-Stop Mode [2], should lead to similar issues.
>>
>
> Stop mode would be an issue if the synchronization fully happened on
> PTCONT, but the evl core requires threads to wait on the sync barrier

s/to wait on/to be awaited for/

--=20
Philippe.
