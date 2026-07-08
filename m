Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDBC4407CE1
	for <xenomai@lists.linux.dev>; Wed,  8 Jul 2026 09:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783501239; cv=none; b=gQMdldK/+v+C78s0Ih1l/egFMRh9hqNEQn06kE1zhkGr24db1G3EpBWyradTMtkzy6mnm6OA5M43rPxbxFIUxb84Nd6SQMC6cZkVxj4M6sDO+wkKzY0L/jNSWVzOmSYYjrWH2wsqnWTMBRioayXHopUCI/faErOyLe+3Zu6I4rA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783501239; c=relaxed/simple;
	bh=ko0Hjs8FZbxYKsiUx3WeGGWdq7FGpRkfU7Yet8KPTZI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Vc6l0WhPZfjS9bNcuzE1iPlwJBnKNdynAsaX+VQeINvL9+to+Uq3OXkOFzW2C0fwb92GqE/dTmpJiKcHp8C0XzMauAsYYwNNJPaIV0PJapgRr9vngEptzegT0P+tdV1EHgooqIcIhckV6N+R/rYUrxlGl2zILfGyR9u+oVNKB6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org; spf=pass smtp.mailfrom=xenomai.org; dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b=F2slkePz; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xenomai.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b="F2slkePz"
Received: by mail.gandi.net (Postfix) with ESMTPSA id 996773EB8B;
	Wed,  8 Jul 2026 09:00:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xenomai.org; s=gm1;
	t=1783501234;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=G0CKLFZHntnQ7FXXEFo0qsJIFTbp2Z1mRHIjDtVD7+E=;
	b=F2slkePzbQa9Do01bma/Q3DO9p1j5qrxblliWDZAjkdDOXLzXvFE80vHPtvIVtnWC883ce
	6pzwRfbvUwEZoem71wLQ22A1DJ5U4eqhI4oLkAioLHfYWnkt6rpjaXTkvbGIvhiWJ/viYB
	Im+1XgB3yPoww5xfWmZKkoPaiUIzk1C+wtWTBipk4ma6bIWo4yILwzmaHOKyJf2kcMcFA4
	OxXJAt4Pp5lrUBR1i1LVfdEKEjonlEBReLv48AJbnj++Nx8RkY5uBcdJnH9Sppg+IbLgkH
	TyqDAwrNGQ7ake6p2Si+Qmp4CK25wz3RdCmyiFpKVdCIXlY//fH4XwCycwBUDw==
From: Philippe Gerum <rpm@xenomai.org>
To: Tobias Schaffner <tobias.schaffner@siemens.com>
Cc: Jan Kiszka <jan.kiszka@siemens.com>,  xenomai@lists.linux.dev,
  florian.bezdeka@siemens.com
Subject: Re: [PATCH xenomai-images] ci: do not skip tests on vm that have
 been relaxed
In-Reply-To: <901c6221-f432-4d90-9b13-95bda2e3fe79@siemens.com> (Tobias
	Schaffner's message of "Wed, 8 Jul 2026 09:51:13 +0200")
References: <20260703114846.24710-1-tobias.schaffner@siemens.com>
	<f0b9873b-ce17-4cee-8ea0-4b0ec260e8f1@siemens.com>
	<88e281b1-54a6-41c7-9df4-61376a38c181@siemens.com>
	<e7debecd-2490-40e8-8223-4e076d39165f@siemens.com>
	<27d44aef-6dd8-4323-b24b-70f0770a9f49@siemens.com>
	<901c6221-f432-4d90-9b13-95bda2e3fe79@siemens.com>
User-Agent: mu4e 1.12.12; emacs 30.2
Date: Wed, 08 Jul 2026 11:00:33 +0200
Message-ID: <87tsq9lutq.fsf@xenomai.org>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: rpm@xenomai.org
X-GND-Cause: dmFkZTFlntvjqdE7PALx10mNx9Uio/1bOU3tBXVfFiNsz+/aTO8UnNcifOVU5HVWfXikTf/tvoQyAhwUCRO4NVl8jyEhfSuqlECQdR41JP3IBMz//cIrWNshlk6lXiA+m2moOdxgt/V77ySH/5mc0MHq9NxDubNgxiKNKSEhGsWI9OOzLfjsXrLxBwrXc9NsWc27eMb3h39imS6aKOUFshpdWMhKFkQGIFrgFJEGcTGm9ZtFMxMKrzqNbE9imTYD1cW0asJGUS7wxuXifhfEufcHDGpSQw6lwFx7+qt5K0ynqMdaXmjlnPbLApiyDaGQVjfbxdDKAvTV2PbvcO+y2Ll/W/JxMyQt874YiX5MHmRSeruTbOzBb3qMpz04L5yvvfq70q9dwC5rSsdvq0D/gawW9LTg80Q05MY7q9Gaa7GeZmTR0q7yXARQli3m91Kbq4oO97eKrm4G2hsGudFmmP1ZaWHn4Ze9tgn8+xDqtB3tUquafcFQbfRh1cb8EuVzR7RECeGTFV2XFCLxxtHB/vaEpPUiuCbskO+wEBXI7WY0LXzYoFbZqwuChdvbUmK3ZN3GwmZiP8/ZVUVoXvQXt50a7LCO524FeGNLl9wlZNGaaJmVWhv7e2EmoMjdFJN5JyggAALXtqV51azTlRr/l9qbHsY3yipBcumUGMVnrWbzUHnHYA
X-GND-State: clean
X-GND-Score: -100

Tobias Schaffner <tobias.schaffner@siemens.com> writes:

> Hi Philippe,
>
> On 7/7/26 13:21, Jan Kiszka wrote:
>> On 03.07.26 16:00, Tobias Schaffner wrote:
>>>
>>>
>>> On 7/3/26 14:07, Jan Kiszka wrote:
>>>> On 03.07.26 13:54, Tobias Schaffner wrote:
>>>>> Hi all,
>>>>>
>>>>> in some of my test runs the sched-tp-overrun test was failing with:
>>>>> 2026-06-23T17:25:44 ../tests/sched-tp-overrun.c:119: FAILED:
>>>>> evl_read_observable(tfd, &nf, 1) (=3DResource temporarily unavailable)
>>>>> 2026-06-23T17:25:44 ** sched-tp-overrun: BROKEN
>>>>>
>>>>> I only see this on virtual targets.
>>>>> e.g.: https://code.siemens.com/ebsy/debian/xenomai-images/-/
>>>>> jobs/393605372
>>>>> Mostly on arm but also saw this on qemu-amd64 in one of my recent run=
s.
>>>>>
>>>>
>>>> Maybe improper/missing synchronization during test startup? Or when is
>>>> this hit?
>>>
>>>
>>> Does not look like a synchronization problem to me.
>>> The key part of the test failure is this combination:
>>>
>>> /*
>>> * Trigger an overrun condition by staying busy for longer
>>> * than the duration of our allotted time window.
>>> */
>>> for (;;) {
>>>  =C2=A0=C2=A0=C2=A0=C2=A0evl_read_clock(EVL_CLOCK_MONOTONIC, &now);
>>>  =C2=A0=C2=A0=C2=A0=C2=A0if (timespec_sub_ns(&now, &start) > OVERRUN_TI=
ME)
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break;
>>> }
>>>
>>> /*
>>> * Now check whether we received the overrun event as
>>> * expected. Since non-blocking input is enabled, a lack of
>>> * notification would amount to an error (EAGAIN).
>>> */
>>> __Tcall_assert(ret, evl_read_observable(tfd, &nf, 1));
>>>
>>>
>>> The OVERRUN_TIME of 200us seems to be not enough to trigger the overrun
>>> or in some cases or at least the message was not send in time.
>>>
>>> I suspected the issue to be time stealing but saw the fixup parts of the
>>> tp scheduler trying to handle missed time frames. I think we just have
>>> to increase the overrun time but not sure how much to still keep the
>>> fixup parts tested. I guess these code paths are only exercised on
>>> virtual targets.
>>>
>> So, do you want to drop tp-overrun from this patch for now, or how
>> to
>> proceed?
>
>
> @Philippe:
> What is your opinion on this? Do we want to also relax the overrun
> time here?
>

The whole test requires a certain degree of timeliness from the platform
it runs on, typically the TP schedule which is being tested might be off
only because of dramatic slowdowns, which would be considered as
pathological on real hardware although understandable in a vm. So I
would simply disable the test in a virtualized environment, because
relaxing the thresholds would end up making the test pointless.

--=20
Philippe.
