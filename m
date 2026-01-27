Received: from lithops.sigma-star.at (mailout.nod.at [116.203.167.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B50EF33B6C3
	for <xenomai@lists.linux.dev>; Tue, 27 Jan 2026 13:21:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.167.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769520070; cv=none; b=RW7mW9+fYe4cDk8AGvjNfc99GpxOk56bCCtYztDrHFfWlLrA2u41pEJrl+XVL1LxfFYc/mYcDgUZEXsOFEelo/1LyYTP9TCR6NUctjOQvJ1zVqKh7gMKjofGkJ5E5iTReuiugul3KIQMxlyhF7BdqZoBrp7Wv3VsA/82Tg7pm6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769520070; c=relaxed/simple;
	bh=QTo6i/eKTh5+0JBp2KvFXbH/zjHNBZIRS9oI9bKCysk=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=BSlFHbp4LT1yMDmQTzrBrC6z1vowsH10mSl87BzTgXs/rNHFFs1d5KKu0zvsJp6oQ/ZBedzBshe72f7tGVSv7ug/705GrwEzS/D9wHfD4p/vghiCdS0HuF3VptjcbnEOfbLXIovOmA8egp08QcgfXMZIdlsrmjtiyp3SiRZyGkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nod.at; spf=fail smtp.mailfrom=nod.at; arc=none smtp.client-ip=116.203.167.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nod.at
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nod.at
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id 113042CFC87;
	Tue, 27 Jan 2026 14:21:05 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id rhtiy99fvoaz; Tue, 27 Jan 2026 14:21:04 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id F24622CFCAB;
	Tue, 27 Jan 2026 14:21:03 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id dyAcFbSBwIT8; Tue, 27 Jan 2026 14:21:03 +0100 (CET)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
	by lithops.sigma-star.at (Postfix) with ESMTP id D2D532CFC87;
	Tue, 27 Jan 2026 14:21:03 +0100 (CET)
Date: Tue, 27 Jan 2026 14:21:03 +0100 (CET)
From: Richard Weinberger <richard@nod.at>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: xenomai <xenomai@lists.linux.dev>, Philippe Gerum <rpm@xenomai.org>
Message-ID: <988749902.19831.1769520063664.JavaMail.zimbra@nod.at>
In-Reply-To: <71486589.18531.1769510815576.JavaMail.zimbra@nod.at>
References: <1209867549.13389.1769444884253.JavaMail.zimbra@nod.at> <5a4b5aff-fa90-42e1-bdf7-3a42786830bf@siemens.com> <1353891765.13527.1769446729193.JavaMail.zimbra@nod.at> <d953a897-92a8-4a83-ba2c-7d95059b4525@siemens.com> <724391155.14329.1769456288068.JavaMail.zimbra@nod.at> <e0ae25a5-94b3-4d8b-8b92-faf40a5ed2eb@siemens.com> <71486589.18531.1769510815576.JavaMail.zimbra@nod.at>
Subject: Re: CPU Hotplug Splat
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Mailer: Zimbra 8.8.12_GA_3807 (ZimbraWebClient - FF146 (Linux)/8.8.12_GA_3809)
Thread-Topic: CPU Hotplug Splat
Thread-Index: xHlq1OEDYO4ceMwUWjs1GUc7gVx2PKicl/36

----- Urspr=C3=BCngliche Mail -----
> Von: "richard" <richard@nod.at>
> I have v6.12 a try, seems to work. So it's a regression.
> Yes, echo 0 > /sys/devices/system/cpu/cpu1/online is enough to trigger it=
.

There is more fishy. While setting a CPU offline works fine on v6.12,
it seems to confuse the Xenomai CPU scheduler.

If an RT task sleeps, e.g. in rt_task_sleep(), and it's current CPU is
set offline it will never again wake up nor is killable.

It seems to hang indefinite in dovetail_context_switch():

[<0>] dovetail_context_switch+0x8a/0x1b0
[<0>] ___xnsched_run+0x238/0x3d0
[<0>] run_oob_call+0x77/0x120
[<0>] xnthread_suspend+0x342/0x420
[<0>] __cobalt_clock_nanosleep+0x118/0x480
[<0>] CoBaLt_clock_nanosleep+0x90/0x110
[<0>] handle_root_syscall+0x132/0x2e0
[<0>] __pipeline_syscall+0x87/0x1e0
[<0>] pipeline_syscall+0x63/0xf0
[<0>] do_syscall_64+0x92/0x220
[<0>] entry_SYSCALL_64_after_hwframe+0x77/0x7f

Thanks,
//richard
