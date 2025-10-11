Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88C39DF76
	for <xenomai@lists.linux.dev>; Sat, 11 Oct 2025 16:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760201775; cv=none; b=JlNDFsLrK7Pk7lcPm93FLZjRJ948cpCzhf3OOcrMRueTEbOYni6QrfTMP48I3ymxbYYnCZ1tLKwQvXmjwbaZghcmfl6y1eCK4m69GYBykSRqibvQSdVO/vNGLSqt6xiCPunh72GcKcZxBREViuYXU5sj8UZxTDUUjN80gPzpHA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760201775; c=relaxed/simple;
	bh=eIxqFK5M+rZhVCVRqHSmzKq03K7Zdm854sAqA313c4s=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=tMIaPJCpkQ3fKyNpjO95mHjfaXgtP+jm3ZCErnIu7BhUKiBEBSopTxQfxTRHy7mlWKnOFSjazyJpzsIkjoVe0ilYKDL9ttvcd+uAxPO9/+lnBQ8e+nFE2ixaYh935veElQvLDo5begk5ErWDeEeJU9U4IK3QmdDh5S1WWXDA5Dc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org; spf=pass smtp.mailfrom=xenomai.org; dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b=I5p/rg9/; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xenomai.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b="I5p/rg9/"
Received: by mail.gandi.net (Postfix) with ESMTPSA id 4B6E020492;
	Sat, 11 Oct 2025 16:56:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xenomai.org; s=gm1;
	t=1760201765;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2jAKVGZq9XoMwh2BzzlBg4X4R3GWh1uapZOnxwTEmM0=;
	b=I5p/rg9/ciGlpaN4A4gwN31PlFJDpgVcfjQumxaBw8qZ0acwnFWhe9iiGhDsAxXdDl5erk
	DbtoPdOBsC9G3UMKoORx/5nWgrzbnPJ6WedqDK2cy59RpFHZweovaG3+13Jub/z6OkNGJb
	sBrrBJ7myMtCXQxwe//mVS+t10Iq8/SZh/hTymT1CzgOLeTxoHIgTsbhQ9DjRe6iHO3VO9
	pVYAqqytHWC4KiJN7UozVXx+NTkNFOFNMOUCC7HZeSSiC2Bn5QYGfQRX9uRL7LzVSZ9/TC
	ThFPvT6X+SLRBPTtEAwciScJEYTlxhriGdX96HZ2EH6HCmSyfJuNVm/8RvWocA==
From: Philippe Gerum <rpm@xenomai.org>
To: Giulio Moro <giulio@bela.io>
Cc: =?utf-8?Q?=C5=81ukasz?= Majewski <lukma@nabladev.com>,  Xenomai
 <xenomai@lists.linux.dev>
Subject: Re: Unexpected switches to in-band
In-Reply-To: <f916d01d-2bd0-cdfd-2e9e-562968a9934f@bela.io> (Giulio Moro's
	message of "Sat, 11 Oct 2025 11:47:29 -0500")
References: <d3f7d465-e914-bf4d-be69-7e42fe288064@bela.io>
	<20251009151737.0d03b211@wsk>
	<20676160-4572-d92d-4b33-ff4255946345@bela.io>
	<87qzv9sa9c.fsf@xenomai.org> <87ikgls9kh.fsf@xenomai.org>
	<f916d01d-2bd0-cdfd-2e9e-562968a9934f@bela.io>
User-Agent: mu4e 1.12.12; emacs 30.2
Date: Sat, 11 Oct 2025 18:56:04 +0200
Message-ID: <87a51xs7h7.fsf@xenomai.org>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain
X-GND-Sasl: rpm@xenomai.org

Giulio Moro <giulio@bela.io> writes:

> I realised that gitlab's v6.12.y-evl-rebase and v6.1.y-cip-evl-rebase can boot as-is on the PocketBeagle 2 and so I'll keep using those for tests going forward, without any third-party patches.
>
>>> Ok, so it looks like both of you observe the same issue, which seems to
>>> be arch-independent. Checking the code which takes care of preventing
>>> COW for oob-enabled processes (a behavior which may cause unwanted minor
>>> faults in a tricky way), I stumbled upon a really bad bug. Could you
>>> check whether the patch below helps?
>>>
>>> diff --git a/include/linux/sched/coredump.h b/include/linux/sched/coredump.h
>>> index 73de18353e79..c6b1efcbd833 100644
>>> --- a/include/linux/sched/coredump.h
>>> +++ b/include/linux/sched/coredump.h
>>> @@ -91,7 +91,7 @@ static inline int get_dumpable(struct mm_struct *mm)
>>>     #define MMF_VM_MERGE_ANY	30
>>>   #define MMF_VM_MERGE_ANY_MASK	(1 << MMF_VM_MERGE_ANY)
>>> -#define MMF_DOVETAILED		31	/* mm belongs to a dovetailed process */
>>> +#define MMF_DOVETAILED		18	/* mm belongs to a dovetailed process */
>>>     #define MMF_TOPDOWN		31	/* mm searches top
>>> down by default */
>>>   #define MMF_TOPDOWN_MASK	(1 << MMF_TOPDOWN)
>
> Tried that on top of  v6.12.y-evl-rebase , it doesn't seem to fix the problem, neither for latmus nor for our application.
>
>> Note: this issue only affects kernels from v6.10 and on
>
> I can confirm that on v6.1.y-cip-evl-rebase I don't see that issue, even though MMF_DOVETAILED is 31 also there.

Meanwhile, I've been trying to reproduce on x86 and armv8 (odroid c4)
using the posted recipe, no luck so far. I'll check armv7 as well.

-- 
Philippe.
