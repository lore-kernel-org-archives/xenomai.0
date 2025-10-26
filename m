Received: from mslow3.mail.gandi.net (mslow3.mail.gandi.net [217.70.178.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FC2D347C7
	for <xenomai@lists.linux.dev>; Sun, 26 Oct 2025 20:10:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.178.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761509452; cv=none; b=ozTBbc03vnxE6i/lxq+IwSZ2a3hRkRHgQ46XMxdD1h7Ke5EQltJB+9Tf4+qnUMM4Yx9X68j9yM6Sp148t/Drw+aJyl6eRZf7hM961HSBrcO/cmajFDJ1T09Q8n9J/9WL4+8e1uIDhPS6phGG7/zvn0uf5AtD9EuGp2WWw7B+sVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761509452; c=relaxed/simple;
	bh=5BeWn33Vmybev78Ie1w+MLGd3jwbuoOOEzitK952tDE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=lGyBF0wvpUQxHZSXqGmZam2+oW5lar9Aic1YTl6SVpC4IOfgZH+oAmTnn+ADktbnJWlbMSrdZYK7Wps5+vr2DecpKlM4IS+TI40U+cZHuCbzHHGdJ7pXGjD9wWg+nuC+cqYfSTYdTOLupjBnGJcqsPmkUiJxF22WFEffHekEpJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org; spf=pass smtp.mailfrom=xenomai.org; dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b=P1IkzOct; arc=none smtp.client-ip=217.70.178.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xenomai.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b="P1IkzOct"
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::221])
	by mslow3.mail.gandi.net (Postfix) with ESMTP id 82F7E581334
	for <xenomai@lists.linux.dev>; Sun, 26 Oct 2025 20:05:05 +0000 (UTC)
Received: by mail.gandi.net (Postfix) with ESMTPSA id BDFB0443D2;
	Sun, 26 Oct 2025 20:04:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xenomai.org; s=gm1;
	t=1761509098;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Jx3++tpF/LKGQcuxRh8u7YLn0m11PzQJ8nOt6VfB2Ns=;
	b=P1IkzOct5ywPPcleAZER0Dmh/pWeAV5PMxT3ws+694ukdXwXZInP+rNIu/6E8xU+11uz2l
	hPpenMRhsnQK6iDmbLObKrSnwcQv8jTB8y9PyiMu8b+OI+Vrx9gkuMqROtYh2B3BbPbzEd
	v3/Dafn4loFYESd8dV+XdxUHHayeemxZq05oWdx8iF6RiAp4DCVGUEYTcq8PeyqTT7GVGV
	Ry3gpEUp75ZxN7zWQnuEgPfRH9IRAje0KseapTNIqs225DfEl75SE0taGgdVG2v0qns3bF
	BBp/NHBp/cI3DEML/aG7XrWncHV1e+Xtdlr0CjDgntUhfeHzbbBh1nse9exKTQ==
From: Philippe Gerum <rpm@xenomai.org>
To: =?utf-8?Q?=C5=81ukasz?= Majewski <lukma@nabladev.com>
Cc: Giulio Moro <giulio@bela.io>,  Xenomai <xenomai@lists.linux.dev>
Subject: Re: Unexpected switches to in-band
In-Reply-To: <20251023155439.0170f987@wsk> (=?utf-8?Q?=22=C5=81ukasz?=
 Majewski"'s message of
	"Thu, 23 Oct 2025 15:54:39 +0200")
References: <d3f7d465-e914-bf4d-be69-7e42fe288064@bela.io>
	<20251009151737.0d03b211@wsk>
	<20676160-4572-d92d-4b33-ff4255946345@bela.io>
	<87qzv9sa9c.fsf@xenomai.org> <87ikgls9kh.fsf@xenomai.org>
	<f916d01d-2bd0-cdfd-2e9e-562968a9934f@bela.io>
	<20251020094705.2ac256f2@wsk>
	<9d2bacac-8d70-f083-e926-21beee2207c2@bela.io>
	<87o6q1ad07.fsf@xenomai.org> <20251023155439.0170f987@wsk>
User-Agent: mu4e 1.12.12; emacs 30.2
Date: Sun, 26 Oct 2025 21:04:52 +0100
Message-ID: <87a51djuor.fsf@xenomai.org>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: rpm@xenomai.org


Hi =C5=81ukasz,

=C5=81ukasz Majewski <lukma@nabladev.com> writes:

> Hi Philippe,
>
>> Giulio Moro <giulio@bela.io> writes:
>>=20
>> > =C5=81ukasz Majewski wrote on 20/10/2025 02:47:
>> >=20=20
>> >> Could you share which version of libevl do you use?=20=20
>> >
>> > I was using the latest release of libevl that was compatible with
>> > the kernel UAPI. Sorry I haven't provided more details on the
>> > issue; I am focusing on building an image around 6.1 for a deadline
>> > coming up next month so I haven't been able to get into tracing yet.
>> >
>> > The only additional finding I have so far is that there seems to be
>> > something on the Linux side that "breaks real-time" which affects
>> > both linux and evl. In the below list, "evl bad" means that the
>> > above mentioned ISW are observed. "Linux bad" means that I see a
>> > disproportionate number of underruns under stress on a Linux program
>> > running with SCHED_FIFO and priority 95 with a period of 360us. I
>> > understand "disproportionate" is a very subjective term but, to give
>> > an idea, over a 10 minutes test I get a couple of underruns with
>> > "linux good" and I get hundreds of underruns with "linux good"
>> >
>> > v6.12.y-evl-rebase: evl bad, linux bad
>> > v6.11.y-evl-rebase: evl bad, linux untested
>> > v6.10.y-evl-rebase: evl bad, linux untested
>> > v6.9.y-evl-rebase: evl bad, linux bad
>> > v6.6.y-evl-rebase: evl bad, linux bad
>> > v6.3.y-evl-rebase: evl bad, linux bad on startup only
>> > v6.2.y-evl-rebase: libevl r42, evl good, linux good
>> > v6.1.y-cip-evl-rebase: libevl master, evl good, linux good
>> >
>> > Not sure if this is of any help; I hope to be able to get back on
>> > this soon. Best,
>> > Giulio=20=20
>>=20
>> If someone could send me the relevant portion of a trace file with a
>> 'latspot' tracepoint triggered on a latmus run, I could investigate
>> this issue. I'd need the function tracer active on all CPUs, with all
>> traces dumped to a single trace file ('evl trace -ef' should do).
>>=20
>
> Please find tar'ed output for the trace(s).
>
> Please, however be aware that - I've fall back to 6.6 (as it is the
> version in which I can reproduce the issue in the fastest way).
>
> Customer also reported, that they can reproduce with their SW stack the
> issue on 6.1-slts and 6.12, but it takes considerably longer than for
> 6.6 (in which I can use simple programs to "allocate" memory).
>

Ok, but 6.6 is definitely unmaintained Dovetail-wise, and has been so
for several months now. So although this issue was observed with
maintained releases too, debugging a current issue on an obsolete code
base is a fragile process nevertheless.

> I've used pretty standard set of ftrace CONFIG_* options enabled.
>
> However, it seems like there is a "hole" around the time when in-band
> switch has been reported (in dmesg) and in ftrace output.
>
> I'm going to do the same with all available tracers enabled.
>
> Last but not least, the latspot event is not present in my ftrace
> output (although I've enabled all the CONFIG_EVL*DEBUG options).
>
> Is there any special set of options to required for EVL tracig?
>

Yes, you need to enable the evl/evl_latspot tracepoint.
See [1].

> Tars with logs:
> https://nextcloud.swupdate.org/index.php/s/FgiMsHG9xG8frk3
> https://nextcloud.swupdate.org/index.php/s/XcW75xsQPMXm3zg

Ok, first observation, the logs reveal that we are in an OOM situation:
the kernel strategy is best-effort there, to keep the system in the best
possible state while sacrificing processes. But honestly, although the
VM_LOCKED pages are unevictable by definition, there are quite a few
spots in the mm which might trigger the OOM reaper, including the
inability to allocate page table information, insert new pages and so
on. Although all the memory of an oob application is committed, with its
VMAs populated once libevl has issued mlockall(), I genuinely don't know
how this fares with an OOM situation.

Anyway, I still see a common pattern between the two set of traces, the
unwanted inband switch happens during what seems to be time holes
(assuming that traces of all CPUs are merged into each log):

[  285.166640] EVL: timer-responder:754 switching in-band [pid=3D756, excpt=
=3D14, user_pc=3D0x7be4dc59d5fe]
   <idle>-0       [022] *..1.   148.913052: rcu_dyntick: Start 1 0 0x8ec
   <idle>-0       [014] dN.1.   172.761906: rcu_dyntick: End 0 1 0x39c

[  172.317009] EVL: timer-responder:743 switching in-band [pid=3D745, excpt=
=3D14, user_pc=3D0x7036049465fe]
   <idle>-0       [022] *..1.   148.913052: rcu_dyntick: Start 1 0 0x8ec
   <idle>-0       [014] dN.1.   172.761906: rcu_dyntick: End 0 1 0x39c

A lot can be done in 24 =C2=B5s on such class of hardware, so either some
traces are missing, or something happens at hardware level which the
kernel does not know about, as it may be seen on x86 with some
uncooperative BIOS (e.g. SMIs, thermal events come to mind). Hopefully
this is not the case, but then we need to make sure that some traces are
indeed missing. If such time hole is confirmed though, then the issue
Giulio is seeing might be different.

[1] https://v4.xenomai.org/core/commands/index.html#evl-trace-command

--=20
Philippe.
