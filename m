Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C8002DF3DA
	for <xenomai@lists.linux.dev>; Mon, 20 Jul 2026 18:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784573322; cv=none; b=hyXK7N7txdJ7AKtJo+1iK9Ix/o7OPY/MoVMTFVVLekEr9mPv/JuEORQgYLuWSeDKNy5yJ9aO4ajtx2VICKtidoLYSLx+ADZCiT1FJ40vr84SB9qRaTDQ4PxstXDHs5+HyzWBR+cfhWqS3KupmPdY7OyBaIt5EYgmS9Fe1q5UFc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784573322; c=relaxed/simple;
	bh=Nnn50ktVimYNJmfVMK9zZU9nvqBb6nmCD8lDGPuAT5g=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=uAuULsQ1p3ksr2kgnuvPpP7rmhFh4ITzQaCztHOoKBG5qrmfJEYvZ5pcmk0Sa3uifHf7CJtYkiOY17ed3ZQ9E6ksBfaTGIzRkn5oQuQZxKCmPNP2wRPIrMwWn2xOL/EzCXLbp8pRT9/NgYQt1iqQicwNRVtUbantqSPwiCcDHQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org; spf=pass smtp.mailfrom=xenomai.org; dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b=h5ZTGSzn; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xenomai.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b="h5ZTGSzn"
Received: by mail.gandi.net (Postfix) with ESMTPSA id 6DBBF1F75F;
	Mon, 20 Jul 2026 18:48:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xenomai.org; s=gm1;
	t=1784573309;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ui4UAVNAtlkuEZduYKk5IAs/l4rmcjeDkS5hcThI/Nw=;
	b=h5ZTGSznZn3BdUme7/CUWcaWo+kbg94ZYcZ8Fr1p56tpWseMvydIr44hin8VNRxomYxkJU
	QqiF/Div/4RASDjEhethXAtUIAZZV3iu6e5woKUUlQ6BVxc64vImXd8I1jHe6gEBg0Npxl
	Qh8Z2QEQeKn7kuycR/6YB4h/iutP2mklzJQQAGisKj8dNL1FilGYhiP6jC2NDuK4l41Yvx
	VSWMVxf37UTqWPifdedf7pwfnWhNwd6zHNcJH7kKrY3tV2R9Qqq2BB0+Q/LbEM+xuBbyV/
	N+MAE4dQPHlU2M9HrjM/vtSPyC5WKGzr437rgs99eqrtaK/dUNUBK6SzGP+hDQ==
From: Philippe Gerum <rpm@xenomai.org>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Xenomai <xenomai@lists.linux.dev>
Subject: Re: [libevl][PATCH 2/2] tests: sched-quota-accuracy: Add preempting
 FIFO thread
In-Reply-To: <87o6ghlulu.fsf@xenomai.org> (Philippe Gerum's message of "Wed,
	08 Jul 2026 11:05:17 +0200")
References: <83bfeeef-c3b2-473e-b94f-8d270b0a512c@siemens.com>
	<38c143a3-5021-4617-ab2f-ff3c9f3adc74@siemens.com>
	<87cxxlbik5.fsf@xenomai.org> <87jyrta2c2.fsf@xenomai.org>
	<ef230925-f258-4cf5-9fc1-6426167fc819@siemens.com>
	<255484c0-7955-4bb3-b592-742d4fbd79ed@siemens.com>
	<87o6ghlulu.fsf@xenomai.org>
User-Agent: mu4e 1.12.12; emacs 30.2
Date: Mon, 20 Jul 2026 20:48:27 +0200
Message-ID: <87mrvlebus.fsf@xenomai.org>
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
X-GND-Cause: dmFkZTFo01LEl58AaSoQ8x7xXkjpfGHoMeWW6W8AoUtBmJQAgZryFHPPI4QBzDACn397agUDH9rT4IwrGVMpiEWHIM7UqC1tOZ5z8q3oZNSW3Y16RgOAirfk7+P2qgZFZ4ZlcM/vCMM8hYI5zoArqfMgftwXhp8cHqfcKJmzwvLA0l7aMTH/BRJk3GOCOCTDZoYqYjRfE4AnkT2+gPbDtlq4XIDVScgFNZDedV2oc99On6djGH+oX+j9EGhnJpyvS2Q0yOoTlQJY7zcomA4zMVjnNJirIS96/qOBUv91YebkZJ1NnT7FBH2k2Kf8DTTROSinwiWBpNjU6Wc8i3A7Bs0cBWgikN0FNyLUSnIEuCvB0UPVtCN/3g90GG0tpntgqoir21TfheUrJgzIWYMzcI0EC5m5MmcsAMpcJaa/3nr3+61hBDbho5waHBWJVuzlFgyhKck+nlNFw/YHhmbOeiumJbn3BJarIeYmTMc/Pwro1FQa5ocDaEJm68t5rJVSaNbckenWaGAC7dNNBBr99bhnabdfGgQ/oll2gJa6/7bH1/z62Q989RsLhNvY5NEIRH+a2F0WvQ5NxiNxLES22AC/JBhxW4zgnA3iznSqJs5Pp4/AwO/5Jjwtw/wvNSKb/O50RxPg1HfUyrgjKIemWVcJn+Y4YPSMps0QVFDOrMEpPoKofw

Philippe Gerum <rpm@xenomai.org> writes:

> Jan Kiszka <jan.kiszka@siemens.com> writes:
>
>> On 20.06.26 14:40, Jan Kiszka wrote:
>>> On 20.06.26 13:17, Philippe Gerum wrote:
>>>> Philippe Gerum <rpm@xenomai.org> writes:
>>>>
>>>>> Jan Kiszka <jan.kiszka@siemens.com> writes:
>>>>>
>>>>>> From: Jan Kiszka <jan.kiszka@siemens.com>
>>>>>>
>>>>>> Test that higher-prio SCHED_FIFO threads do not run on the bill of
>>>>>> SCHED_QUOTA threads and that their accounting is not otherwise
>>>>>> disturbed.
>>>>>>
>>>>>
>>>>> This patch introduced a regression when determining the accuracy of the
>>>>> policy with respect to allotting threads the expected runtime budget:
>>>>>
>>>>> root@phytec-mira-evl:~# evl test sched-quota-accuracy
>>>>> sched-quota-accuracy: 494.0%
>>>>>
>>>>> The proper result would rather be close to the following:
>>>>>
>>>>> root@phytec-mira-evl:~# evl test sched-quota-accuracy
>>>>> sched-quota-accuracy: 99.1%
>>>>
>>>> Ok, I guess the fact that the calibration process does not factor in the
>>>> disruptor explains the full breakage we have with the accounting now:
>>>>
>>>> root@phytec-mira-evl:~# evl test sched-quota-accuracy -- -v
>>>> picked CPU1 for execution
>>>> CPU1: calibrating: 893547 loops/sec
>>>> CPU1: new thread group #0, quota sum is 10%
>>>> CPU1: done quota_thread[0], count=150399
>>>> CPU1: done quota_thread[1], count=145636
>>>> CPU1: done quota_thread[2], count=141552
>>>> CPU1: 3 threads: cap=10%, effective=49.0%, disruption=49.6%
>>>> sched-quota-accuracy: 489.7%
>>>>
>>>> Which does not make any sense since the effective value should be capped
>>>> at 10% in the above case, compared to the nominal (full) report which
>>>> should be:
>>>>
>>>> root@phytec-mira-evl:~# evl test sched-quota-accuracy -- -v
>>>> picked CPU1 for execution
>>>> CPU1: calibrating: 899203 loops/sec
>>>> CPU1: new thread group #0, quota sum is 10%
>>>> CPU1: done quota_thread[0], count=26818
>>>> CPU1: done quota_thread[1], count=26709
>>>> CPU1: done quota_thread[2], count=35612
>>>> CPU1: 3 threads: cap=10%, effective=9.9%
>>>> sched-quota-accuracy: 99.1%
>>>>
>>>> Dropping this patch from the -next branch for now.
>>>>
>>> 
>>> I would rather recommend taking a trace and debugging the scheduler -
>>> this could very likely be remaining issue in the quota fix.
>>> 
>>
>> What is the state of this? How can I reproduce the issue you saw? What
>> is specific to the target, what could also be seen over qemu[/kvm]?
>>
>
> The task of writing a proper test for evl is ongoing, the overall sched
> issue is very much on my radar. I'll follow up when this test code is
> available.

You need to pick e5e876da..3e32fa6f from [1] for the kernel bits, and
198a21b7..HEAD from [2] for an improved sched-quota-accuracy test which
also measures the preemption noise, with a significantly simpler
implementation. The topmost commits in [2] also introduce an interface
to the ftrace-based 'evl_trace' event which I used for debugging.

Basically, I merged the gist of our past proposals, refining here and
there as issues were uncovered.

Heavily tested on real hardware, which uncovered a couple of other
serious issues. I plan to write a separate test program for testing the
runtime credit and peak management.

[1]
https://gitlab.com/Xenomai/xenomai4/linux-evl/-/commits/next/v6.12.y-cip-evl-rebase?ref_type=heads

[2] https://gitlab.com/Xenomai/xenomai4/libevl/-/commits/next?ref_type=heads

-- 
Philippe.
