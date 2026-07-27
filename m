Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA27D3FF1B8
	for <xenomai@lists.linux.dev>; Mon, 27 Jul 2026 12:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785156866; cv=none; b=OJT6T2jYG8JPp2vnwVHbPKTRbGR6p/XRWnYvN3NVzv5yoXDzoYtK/RvJMmxpH7yHFsmHm/HrLnLR1jfxil0pV4tz8gGLT1Oc0hKy66nYQZCqwBmUPtxpW2u/coXMWa/FNKFwaUVLGDCP1gUAi0oHfMoYI5RyDZ2ytzYgP8V14S8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785156866; c=relaxed/simple;
	bh=FjxM6axXD1BXdYuo/WvPOYqUlIEclZ6de8pNXt/98pQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=OJ1U9lu3u1Ab8FcEeyWidTKUErDgDoz9DakqdQddLOeN51/WO9VftEjjwh0gD+2ERnT9hLxS8//HQBt76JMnZVwpEcneJBXU6tEaozfXTIOFXIQQavn7v4LZP5ftGA9wetvVJneQj4MAq6wY3MWDe1T3xwbAaV4LLq9oidmg3SU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org; spf=pass smtp.mailfrom=xenomai.org; dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b=HWFl8rw0; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xenomai.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b="HWFl8rw0"
Received: by mail.gandi.net (Postfix) with ESMTPSA id 74C343EC1E;
	Mon, 27 Jul 2026 12:54:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xenomai.org; s=gm1;
	t=1785156861;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lQeprT8ObthBY6ZGf1FbFlpux9dPKk7VDd2Y1ANSe5Q=;
	b=HWFl8rw0MK9ppU54BraX7hr1V+IVvnOoO4OPnQV5it8+GDmCbIXgGu/n6yOuwHDPARZQON
	AJPRfPtX6grMr6LqlbEQN8dvHNl/lMQvuNHC9Ad77rgBfNswou3Sep+0C8VZY1V/okYh9b
	yT0LtcLLFXgy0PtvvWuaB1w511m/joDJnmLXrjbcFk7G7091yNnLRMwtcDLT25QZjXTqKy
	AvTnO03hkr2XOuAenJ0cMcyZlO8eBKxuDFmD8i47JxLSoUOYZCyGywcgebbKCoIVS0j7b5
	Zfj7UCGawiYkPt3RTli2qJisd+zXkZ297Zf4kClC8TLTcZIamwNDv5biPOI5RA==
From: Philippe Gerum <rpm@xenomai.org>
To: Hannes Diethelm <hannes.diethelm@gmail.com>
Cc: xenomai@lists.linux.dev
Subject: Re: EVL: Latency issues probably connected to amdgpu driver
In-Reply-To: <a40b9b01-230e-4043-a76c-7afdfff1ae77@gmail.com> (Hannes
	Diethelm's message of "Sat, 25 Jul 2026 16:45:46 +0200")
References: <a40b9b01-230e-4043-a76c-7afdfff1ae77@gmail.com>
User-Agent: mu4e 1.12.12; emacs 30.2
Date: Mon, 27 Jul 2026 14:54:20 +0200
Message-ID: <87zezc61ab.fsf@xenomai.org>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: rpm@xenomai.org
X-GND-Score: -100
X-GND-Cause: dmFkZTEgILHs3aycXatnQMmhgn3q1Toq4q4ezwQ9J0g1h3iZOhS1lVAQpqbqj5k0ynKGBxGT5thIo4abUHKD9dLOvMbA8s1rVLr4EfcBrlLjI0mYRVli1LAvboLsgbHRFkVsrMJML5FG2xrJZwBFdJd6VfAMWlurUMpznouL/l0uii0zeBi2NSV4QaWJPXpiZj+EXImxsf2yxPfzjhclanSmpbF9R+c/6MiAPdO/iBEOk3AZc/bGwFE16IHYFTIeB+bsqA6DLn2JXQKC+dohodPpdmby3kXwBM2rIfdmhs4e6vD5Sj+tI1K0mOErrL2KyCPXylMygnheBRs75lixAP7Ajk5bRNC3hCMUNV8TUe6FkZ5jWODOEXPTKfSk5RntRcKV4hAyr9cbSRuckJyK2+DhewVrKqiNcAfMbF3yYuQDx0qdYH1JgxcsDVXy6TbpOV2vD9naXoCTxT5Mr/Sj1gYd77a7RTaC915CsNAbDQpiYDHhPFeWL7Oixj3/Q1ow+JFoQ7eq8GiH2jEbpA3wfatPGIP/52RMu3+/20xoqpGnAEbrmDoI5H/3yGBIm/zFJDvyoRh44MuOrG4gmMJWit5Ox+DVfeGhGjcL2uilrU+GNdsP5+T7CmjQWn6ViKL0qOx/3Vr8uAdu94b9H20gsOf2FUWj03WdzWk9YGUvYNkgj2YFQg
X-GND-State: clean

Hannes Diethelm <hannes.diethelm@gmail.com> writes:

> Hello
>
> This is not a new issue and also probably not an evl issue but I try it a=
nyway
> here.
>
> I have latency spikes as soon the GPU has something to do. The best way t=
o reproduce
> it so far is watching YouTube in Firefox where it happens withing 5-10 mi=
n.
>
> It is the same with Xenomai4 or PREEMT_RT while with Xenomai4, the spikes=
 are
> somewhat smaller (~100 us vs ~150 us).
>
> If the GPU stays idle, the latency is ~1us idle / ~2us with stress-ng, qu=
ite good.
> Moving windows around / open close increases it to ~3-4us.
>
> My first theory was, that probably the copy CPU <> GPU is creating the is=
sue with
> keeping memory or cache busy. So i cripple the PCI to Gen1x1 with:
>
> amdgpu.pcie_gen_cap=3D0x00010000 amdgpu.pcie_lane_cap=3D0x00010000
>
> Interestingly, the latency is way worse, up to 500us just moving some win=
dows around,
> so it might be something locking up the EVL core while copying. However, =
as much as I
> understand how dovetail works, this should be impossible?
>
> Do you have any hints how to debug / fix this issue?

Looking at the ftrace logs (thanks for this btw, that's exactly what we
need to chase such kind of issues), I see some unexplained ~140 =C2=B5s
latency bump right after programming the LAPIC deadline timer.

test2_all:
          <idle>-0       [003] *.~1.   834.920082: lapic_next_deadline <-ev=
l_program_proxy_tick
          <idle>-0       [003] *.~1.   834.920083: do_trace_write_msr <-lap=
ic_next_deadline
          <idle>-0       [003] *.~1.   834.920083: write_msr: 6e0, value 27=
8dc7d4cab
          <idle>-0       [003] *.~1.   834.920222: evl_timer_shot: latmus_p=
ulse_handler at 834.920317 (delay: 94 us, 37780 cycles)

Since there is not reason for such MSR update to cause such latency peak
and no smoking gun is visible from any CPU around this spot either, I'd
suspect an issue with some kind of power management activity. AMD GPUs
have pstates, any luck with any tweak mentioned by [1]?

[1] https://docs.kernel.org/admin-guide/pm/amd-pstate.html

--=20
Philippe.
