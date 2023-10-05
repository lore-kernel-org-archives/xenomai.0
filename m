Received: from relay-ext.wolfram.com (relay.wolfram.com [140.177.205.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3D0A747F
	for <xenomai@lists.linux.dev>; Thu,  5 Oct 2023 14:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=wolfram.com header.i=@wolfram.com header.b="vPxjxMvH";
	dkim=pass (2048-bit key) header.d=wolfram.com header.i=@wolfram.com header.b="INf5GxdN"
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wolfram.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wolfram.com
Received: from relay-10-128.wolfram.com (relay.wolfram.com [10.128.2.101])
	by relay-ext.wolfram.com (Postfix) with ESMTPS id 8E82E60FD
	for <xenomai@lists.linux.dev>; Thu,  5 Oct 2023 09:19:18 -0500 (CDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 relay-ext.wolfram.com 8E82E60FD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=wolfram.com; s=relay;
	t=1696515558; bh=BeTZ2hO+myIwwlEEfVR2Xv4BU8iQhw2/WDh5GRxCq3Y=;
	h=Date:From:To:In-Reply-To:References:From;
	b=vPxjxMvH8rpaXQcMB6mnJpMuevD3dUFHqX6q3yBecSu/94DDibl8DxBTBVBFz7DIo
	 zZiHH+rXBiA85VZ8cbsgaj/XsHXojILAlY9bBIoSuXu6Ox2UUoE6EAFyiVMBw7II4j
	 DkrbePU4OralUqTlNsX7W5DN/A4NqYbu9qEeuTvo=
Received: from wrimail03.wolfram.com (wrimail03.wolfram.com [10.128.1.208])
	by relay-10-128.wolfram.com (Postfix) with ESMTPS id 89FB130004E
	for <xenomai@lists.linux.dev>; Thu,  5 Oct 2023 09:19:18 -0500 (CDT)
Received: from wrimail03.wolfram.com (localhost [127.0.0.1])
	by wrimail03.wolfram.com (Postfix) with ESMTPS id 78ECC100673
	for <xenomai@lists.linux.dev>; Thu,  5 Oct 2023 09:19:18 -0500 (CDT)
Received: from localhost (localhost [127.0.0.1])
	by wrimail03.wolfram.com (Postfix) with ESMTP id 46C0810068F
	for <xenomai@lists.linux.dev>; Thu,  5 Oct 2023 09:19:18 -0500 (CDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 wrimail03.wolfram.com 46C0810068F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wolfram.com;
	s=E3ED0494-3FFA-11EB-8895-C5FFDA13CE33; t=1696515558;
	bh=BeTZ2hO+myIwwlEEfVR2Xv4BU8iQhw2/WDh5GRxCq3Y=;
	h=Date:From:To:Message-ID:MIME-Version;
	b=INf5GxdNnMcqGmAE68Z2QHJKHXr7mpqV7vAueulGTLEVRYaIaJF+CcMEt2YPVGejE
	 zmNX69s95HXhSHNtH8NRiKa3cRI/3KguGrMlksTsPx+ahG/KDSg5SJEH3tRmtVKWcR
	 KQoToAwgh8OqY+oVK9FNtZsPBj/9XM846cGmsV2dXQp9e5AVhNluDwPOyJccYxIiUA
	 4+berqyHPd5EkHE2SsF/ahTlAGc3PCWBJpGm+kheSvTAqGjlCIS+GZK39B2G9i1vGw
	 nnDiM7RWg1/0wAcuAj28R0WE+tZIwKrd6fZ4eP4qrILaXM2avsEq4PESpT1bWOqdPN
	 BNFvzOPhCFWXw==
Received: from wrimail03.wolfram.com ([127.0.0.1])
	by localhost (wrimail03.wolfram.com [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id oq0sUGw1tekT for <xenomai@lists.linux.dev>;
	Thu,  5 Oct 2023 09:19:18 -0500 (CDT)
Received: from wrimail03.wolfram.com (wrimail03.wolfram.com [10.128.1.208])
	by wrimail03.wolfram.com (Postfix) with ESMTP id 09264100673
	for <xenomai@lists.linux.dev>; Thu,  5 Oct 2023 09:19:17 -0500 (CDT)
Date: Thu, 5 Oct 2023 09:19:17 -0500 (CDT)
From: Per Oberg <pero@wolfram.com>
To: xenomai@lists.linux.dev
Message-ID: <1711728904.3619924.1696515557888.JavaMail.zimbra@wolfram.com>
In-Reply-To: <471929520.3420035.1696428900861.JavaMail.zimbra@wolfram.com>
References: <1516654157.3383261.1696409126391.JavaMail.zimbra@wolfram.com> <b1287334-a734-4668-8b41-c02201ca5d9d@siemens.com> <1219904236.3405198.1696424514418.JavaMail.zimbra@wolfram.com> <962e9533-26a2-4a02-a5c8-21791e86fdf3@siemens.com> <471929520.3420035.1696428900861.JavaMail.zimbra@wolfram.com>
Subject: Re: RTNet unable to handle kernel NULL pointer dereference at
 0000000000000068
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [10.10.156.136]
X-Mailer: Zimbra 9.0.0_GA_4485 (ZimbraWebClient - GC117 (Linux)/9.0.0_GA_4478)
Thread-Topic: RTNet unable to handle kernel NULL pointer dereference at 0000000000000068
Thread-Index: 1xrpkXVEyaFVaWdpprMa/DACcw+NSAlHiE6Q


----- Den 4 okt 2023, p=C3=A5 kl 16:15, Per =C3=96berg pero@wolfram.com skr=
ev:

> ----- Den 4 okt 2023, p=C3=A5 kl 15:57, Jan Kiszka jan.kiszka@siemens.com=
 skrev:

> > On 04.10.23 15:01, Per Oberg wrote:
> > > I just had another hickup. This is 100 pct reproducible

> >> To get it up and running I had to remove rtpacket,rttcp,rtudp,rtipv4 a=
nd then
> >> forcibly remove rt_igb driver and then rtnet. This gave me another set=
 of
> > > errors, also listed below.

> > What does "forcibly" mean here? Actually "rmmod --force"? Then you get
> > what you deserve ;).

> Yes, intentionally. I expected that the "rmmod --foce" would reek havok b=
ut I
> thought that perhaphs the actual havok caused could give more pointers to=
 the
> actual problem.
> I wanted to see if I could recover from the first crash (not the one from=
 my
> first email) without rebooting.

> > > [15018.436248] ------------[ cut here ]------------
> >> [15018.436249] [Xenomai] switching rtnet-stack to secondary mode after=
 exception
> > > #6 in kernel-space at 0xffffffffb837064b (pid 1438)
> >> [15018.436258] WARNING: CPU: 0 PID: 1438 at
> > > /usr/src/kernel/kernel/xenomai/rtdm/fd.c:299 __put_fd+0x26b/0x2c0

> > You are not using the latest release, not even of your stable series.
> > This is needlessly risky.

> I am currently updating the kernel and xenomai libraries to see what that=
 can
> do. I could not, however, find any patches that looked relevant for the i=
ssue.

> > There is some imbalance in the reference counter for the socket, and
> > later on are complaints about leaking buffers in the pool. The real
> > problem may rather be that you didn't shut down the interface properly =
-
> > or that we don't do that when pulling the plugs in the order you descri=
be.

> To be clear, the
> "[Xenomai] switching rtnet-stack to secondary mode after exception #6 in
> kernel-space at 0xffffffffb837064b (pid 1438)"
> happens after a fresh reboot, not something I kept alive with artifial li=
fe
> support.

> > Can you reproduce this rather generic issue over latest master as well?

> I'm working on it. Hopefully not.

> > Jan

> > --
> > Siemens AG, Technology
> > Linux Expert Center

> Per =C3=96berg

Now tested on Linux 5.10.191-dovetail and Xenomai 3.2.4.=20
Cannot reproduce the crash anymore

Per =C3=96berg=20
