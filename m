Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8CF22BEFF6
	for <xenomai@lists.linux.dev>; Mon, 20 Oct 2025 07:47:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.251.229.89
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760946442; cv=none; b=YuE0+d0C4Fw9Vqm07ZCapFChB8v02WotwSQ+CitSup93eXBhxxnnZ/I3WEcyBLykA2NG3J8PKRGWN/dvc3h0FqFl/qjfi7iCzX7efKNfQnJDj0szkJTdwogiO35U43Uz1gNyAT9JO24tfPdw6M2xF5ZKXHr/BLLNT9A96pGCGzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760946442; c=relaxed/simple;
	bh=8YojIFxQUmS+KAC5DXYuLOU4aiJAww9xcqI3QF6znzk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Vwme6iZT6COi4ehv7WiTXMJV+6/PSpzBwWcXngapPPjjDd48R7yjVKyVnoCThfoQZFiEUQinFBFaI3BLc1HL5q9HVdUNz3rDXYhchSoDan86jtxbKPPQlJR4fIyrZ2ayBoRYbhn9ua08SswEsxIPbWtvq+BleWdXkhLjRYdI3no=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nabladev.com; spf=pass smtp.mailfrom=nabladev.com; dkim=pass (2048-bit key) header.d=nabladev.com header.i=@nabladev.com header.b=EiMEJlxi; arc=none smtp.client-ip=178.251.229.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nabladev.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nabladev.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nabladev.com header.i=@nabladev.com header.b="EiMEJlxi"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 676011087C3;
	Mon, 20 Oct 2025 09:47:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1760946427;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=yrHXRFy909em5tveFa/KAiL/BtFxLP8QnxsaGpqCt4U=;
	b=EiMEJlxiX7FKrdgQ95+varGke0BscNiAyYPotoEDStX0P2cg8z6jW8EfvGDwESXGf2+k1n
	eFiH4QGaRdRQdvfOms8QyGkvDaHTEA4/lvTcgRU5LXH/3ud8dXLmpEeoE81JBfFMhRcGtt
	BVWsoHBcIK031/Cbfs9AJP+S8edJB3t3mQ7f18r9NZ+MDbLKbY2mj5F4E5zANjwG0MputQ
	kFjkCQLDGDiv8QBVKfJOZliY00fpR4dU5fzTvcy65Qnqjfj6LEG4rfBBv6DN9xwQCOUaS4
	76G2rdLJT/Q0CXOTRaiAOdrGElLsX4pGoeDY2c1anJEzhVe2mUd/KK7wISkDzA==
Date: Mon, 20 Oct 2025 09:47:05 +0200
From: =?UTF-8?B?xYF1a2Fzeg==?= Majewski <lukma@nabladev.com>
To: Giulio Moro <giulio@bela.io>
Cc: Philippe Gerum <rpm@xenomai.org>, Xenomai <xenomai@lists.linux.dev>
Subject: Re: Unexpected switches to in-band
Message-ID: <20251020094705.2ac256f2@wsk>
In-Reply-To: <f916d01d-2bd0-cdfd-2e9e-562968a9934f@bela.io>
References: <d3f7d465-e914-bf4d-be69-7e42fe288064@bela.io>
	<20251009151737.0d03b211@wsk>
	<20676160-4572-d92d-4b33-ff4255946345@bela.io>
	<87qzv9sa9c.fsf@xenomai.org>
	<87ikgls9kh.fsf@xenomai.org>
	<f916d01d-2bd0-cdfd-2e9e-562968a9934f@bela.io>
Organization: Nabla
X-Mailer: Claws Mail 3.19.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

Hi Giulio,

> I realised that gitlab's v6.12.y-evl-rebase and v6.1.y-cip-evl-rebase
> can boot as-is on the PocketBeagle 2 and so I'll keep using those for
> tests going forward, without any third-party patches.
> 
> >> Ok, so it looks like both of you observe the same issue, which
> >> seems to be arch-independent. Checking the code which takes care
> >> of preventing COW for oob-enabled processes (a behavior which may
> >> cause unwanted minor faults in a tricky way), I stumbled upon a
> >> really bad bug. Could you check whether the patch below helps?
> >>
> >> diff --git a/include/linux/sched/coredump.h
> >> b/include/linux/sched/coredump.h index 73de18353e79..c6b1efcbd833
> >> 100644 --- a/include/linux/sched/coredump.h
> >> +++ b/include/linux/sched/coredump.h
> >> @@ -91,7 +91,7 @@ static inline int get_dumpable(struct mm_struct
> >> *mm) 
> >>   #define MMF_VM_MERGE_ANY	30
> >>   #define MMF_VM_MERGE_ANY_MASK	(1 << MMF_VM_MERGE_ANY)
> >> -#define MMF_DOVETAILED		31	/* mm belongs to
> >> a dovetailed process */ +#define MMF_DOVETAILED
> >> 18	/* mm belongs to a dovetailed process */ 
> >>   #define MMF_TOPDOWN		31	/* mm searches top
> >> down by default */ #define MMF_TOPDOWN_MASK	(1 <<
> >> MMF_TOPDOWN)  
> 
> Tried that on top of  v6.12.y-evl-rebase , it doesn't seem to fix the
> problem, neither for latmus nor for our application.
> 
> > Note: this issue only affects kernels from v6.10 and on  
> 
> I can confirm that on v6.1.y-cip-evl-rebase I don't see that issue,
> even though MMF_DOVETAILED is 31 also there.

Could you share which version of libevl do you use?

-- 
Best regards,

Lukasz Majewski

--
Nabla Software Engineering GmbH
HRB 40522 Augsburg
Phone: +49 821 45592596
E-Mail: office@nabladev.com
Geschftsfhrer : Stefano Babic
