Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE1933E1236
	for <xenomai@lists.linux.dev>; Tue, 28 Jul 2026 10:09:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785233369; cv=none; b=I8hqQD3J6bCVDzh1gg7suuddrH7JIlHRVQRve+FDjtpm+jo5O+QQWKRqnyY6Tf5PFN7ZkiopoX4lxLe6bOoCH3W/5KVD0+PrG32sxrTBI2QdhJ9KBytuDehHrvivcPJ6SL+3ax+eBLTzhJ0V/yyOpL4YH+lkqdAYPp4ZURcpSp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785233369; c=relaxed/simple;
	bh=+M7E3wuyu9+bcbu7quWi3iU7zjyHhsS9pCbT0M+YcE8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=AxAMgy6LZIVBs8MskB4zzxpfHmlm5TMEaLSCNvycq8A8U4VQJC3gFd7YiBEmXjtC9nMGD1qKDAsiToKtQqUvXOUQfMuRni5p2MAIDZ8Adkn8CkbxbiyVVUkJeRJv51w64SQluRHWHxiRAaOkH2OCwC7jlKDA2HPknaKJac8joeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org; spf=pass smtp.mailfrom=xenomai.org; dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b=FVNukhe8; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xenomai.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b="FVNukhe8"
Received: by mail.gandi.net (Postfix) with ESMTPSA id EF5BF3E9BC;
	Tue, 28 Jul 2026 10:09:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xenomai.org; s=gm1;
	t=1785233362;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=d8ZniJVan6uZhadpC21R9tRItn+0BqYGlQHHy9nNmqM=;
	b=FVNukhe8ujfp5NjxBAfatTa9HoLboZFssNucyr5f1Tuk5lgzZUjq3CGmJyik9AIu8tyvcN
	wWkyxvsbHFfO1IBk7++R8O4dfbXoHHJ4YdOWEim1S7QNI2jQ1dqbqOuHw6u7exDFPtFCPf
	2CStDSEZrAx0Ng6aEsqRFn/ujgAJ3E9lDcrvpjBnCZ6okFgNramEgZ9bueG9GdpLZA4Q/0
	q7WSkmvD8vkWApw5IIadL1yAdEqrxGQivULsPBqXH+nG2nNUCwy7GqjQqSeSPcgtJMZdcm
	UKQPJaDvAAXbt4DgZg62KtGm9jq1uReRwceRbNFai2+jHmU4vUGO3jQKIODW+A==
From: Philippe Gerum <rpm@xenomai.org>
To: Hannes Diethelm <hannes.diethelm@gmail.com>
Cc: xenomai@lists.linux.dev
Subject: Re: EVL: Latency issues probably connected to amdgpu driver
In-Reply-To: <0ff32dee-f482-4af1-9365-94f00f79f592@gmail.com> (Hannes
	Diethelm's message of "Tue, 28 Jul 2026 08:15:39 +0200")
References: <a40b9b01-230e-4043-a76c-7afdfff1ae77@gmail.com>
	<87zezc61ab.fsf@xenomai.org>
	<0ff32dee-f482-4af1-9365-94f00f79f592@gmail.com>
User-Agent: mu4e 1.12.12; emacs 30.2
Date: Tue, 28 Jul 2026 12:09:21 +0200
Message-ID: <87se53v31q.fsf@xenomai.org>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: rpm@xenomai.org
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: dmFkZTE2+5EG4J8SQqwFjHOuB8yNFyAQiYz/RQS1jZEnUN/JBqUqb0LQNppO0Ghhleoq8fcij6C5WKrmIbem9Ny+jYMzQ0mhfokzmuVIlHFPUR2Ew/MLCXUhBU5VIZ02R7sG1yWHjuqIPsSdKwHsxTv6Bqjd1h5/f83WV9+dyjBv8ko2axaRZtwOPDkzWibbBAC/lpBeRxXZZAHdKjQSNcE/rKVm4/2UKk9Iaxim2DtIoZjSUGBBzj6qUnQkFJPjgYULM1XPZXp6cUQs3Z6xNrdix2o3G0N7qIwFRT7z8tO/09dSsrWLq5/gpSAxnYb0VWdyqu7U7EYtpkvvJWNdFNHvAPDLeySreGt9M67QwLV/AVGTwqwxBxRudbaUMN7p1mY8WipKmrgtTzxXw/0Uu5iBMxy7WOI/QySzMJkeYFc/SPXjVPBkCQUG1uTAy0Gu7vWfm6v352iQWGTL16tlRDIC0D3mK5OvYkLkB3Hd75ka7c5HGVbYNSs3dWaHhGyj4/F9GHAQ+flYUE05gTWIjD25apbKN4LfNUFVBu4aqJKWFzRa1aBhazDqxbEMBPCQykc4T8tQ8mSDAMMERhjNkO+EOMN1LXkZACn9yJvxPFvDbF0ao62dYyHvDSf5PyGgbpR8kIin75k+kRjvKqcFACmLoCqtNzvGjrqFGopIeyi5YXS1zw

Hannes Diethelm <hannes.diethelm@gmail.com> writes:

> Am 27.07.26 um 14:54 schrieb Philippe Gerum:
>> Hannes Diethelm <hannes.diethelm@gmail.com> writes:
>>=20
>>> Hello
>>>
>>> This is not a new issue and also probably not an evl issue but I try it=
 anyway
>>> here.
>>>
>>> I have latency spikes as soon the GPU has something to do. The best way=
 to reproduce
>>> it so far is watching YouTube in Firefox where it happens withing 5-10 =
min.
>>>
>>> It is the same with Xenomai4 or PREEMT_RT while with Xenomai4, the spik=
es are
>>> somewhat smaller (~100 us vs ~150 us).
>>>
>>> If the GPU stays idle, the latency is ~1us idle / ~2us with stress-ng, =
quite good.
>>> Moving windows around / open close increases it to ~3-4us.
>>>
>>> My first theory was, that probably the copy CPU <> GPU is creating the =
issue with
>>> keeping memory or cache busy. So i cripple the PCI to Gen1x1 with:
>>>
>>> amdgpu.pcie_gen_cap=3D0x00010000 amdgpu.pcie_lane_cap=3D0x00010000
>>>
>>> Interestingly, the latency is way worse, up to 500us just moving some w=
indows around,
>>> so it might be something locking up the EVL core while copying. However=
, as much as I
>>> understand how dovetail works, this should be impossible?
>>>
>>> Do you have any hints how to debug / fix this issue?
>> Looking at the ftrace logs (thanks for this btw, that's exactly what
>> we
>> need to chase such kind of issues), I see some unexplained ~140 =C2=B5s
>> latency bump right after programming the LAPIC deadline timer.
>> test2_all:
>>            <idle>-0       [003] *.~1.   834.920082: lapic_next_deadline =
<-evl_program_proxy_tick
>>            <idle>-0       [003] *.~1.   834.920083: do_trace_write_msr <=
-lapic_next_deadline
>>            <idle>-0       [003] *.~1.   834.920083: write_msr: 6e0, valu=
e 278dc7d4cab
>>            <idle>-0       [003] *.~1.   834.920222: evl_timer_shot: latm=
us_pulse_handler at 834.920317 (delay: 94 us, 37780 cycles)
>> Since there is not reason for such MSR update to cause such latency
>> peak
>> and no smoking gun is visible from any CPU around this spot either, I'd
>> suspect an issue with some kind of power management activity. AMD GPUs
>> have pstates, any luck with any tweak mentioned by [1]?
>> [1] https://docs.kernel.org/admin-guide/pm/amd-pstate.html
>>=20
>
> [1] is for amd cpu's. [2] would be the GPU
>

Yep, confusing typo. The idea was that we might have some pstate
shenanigan occurring as the CPU stalls, waiting for the GPU to complete
some batch.

> By using intel_idle.max_cstate=3D1 cpufreq.off=3D1, most CPU power saving=
 should be disabled. But
> I might have missed a flag. powertop shows constant frequency and only C0=
/C1 activity.
>

Ok, so the pstate assumption does not hold.

> However, I would expect that CPU power saving generates spikes
> depending on CPU activity. But I have spikes depending on the GPU activit=
y.
>

IMHO, the way GPUs and CPUs may interact via the interconnect makes it
difficult to precisely assess which is to be charged for the latency.

> Even moving the mouse around on the desktop is immediately visible in the=
 latency. Just only
> increasing it by ~1-2us while stress-ng stressing the CPU has less influe=
nce.
>
> I did some more tests with
> amdgpu.pcie_gen_cap=3D0x00010000 amdgpu.pcie_lane_cap=3D0x00010000
> This cap's the PCIE speed for the GPU. Interestingly, if I add these flag=
s,
> latency is way worse. Moving the mouse can generate ~200us delays. Watchi=
ng YouTube,
> its up to 500us.
>
> Without these options:
> LnkSta:	Speed 8GT/s, Width x8
>
> With them:
> LnkSta:	Speed 2.5GT/s (downgraded), Width x1 (downgraded)
>
> It feels like: GPU needs to copy some data -> freeze whole CPU and copy -=
> done
>

This seems to point to a CPU stall, waiting for the GPU to complete some
task.

> Attached the results, this time with 1ms period so I don't get overruns.
>
> test10 with evl trace -eirq
> test11 with evl trace -e
>
> [2] https://www.kernel.org/doc/html/v4.20/gpu/amdgpu.html
>
>
> [2. application/x-xz; testresults2.tar.xz]...

          <idle>-0       [003] *.~1.   513.339298: evl_timer_shot: latmus_p=
ulse_handler at 513.340060 (delay: 763 us, 304611 cycles)
          ...
          /* CPU3 enters idle state, so hard irqs are on */
          <idle>-0       [003] *..1.   513.338085: cpu_idle: state=3D1 cpu_=
id=3D3
          ...
          <idle>-0       [003] *..1.   513.339197: handle_irq_pipelined_pre=
pare <-arch_pipeline_entry
          <idle>-0       [003] *.~1.   513.339239: arch_handle_irq <-arch_p=
ipeline_entry
          <idle>-0       [003] *.~1.   513.339269: irq_to_desc <-arch_handl=
e_irq
=20=20=20=20=20=20=20=20=20=20
Yep, at any rate, the traces clearly point at an hardware related stall.

--=20
Philippe.
