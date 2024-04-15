Received: from smtpfb2-g21.free.fr (smtpfb2-g21.free.fr [212.27.42.10])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE1C245959
	for <xenomai@lists.linux.dev>; Mon, 15 Apr 2024 09:49:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.27.42.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713174561; cv=none; b=nGIoBqc+6QLbvuiMcHUa/LcYKbrGRx4/bNWsUSuv9ADeaeEFNoCB+iVQtIppm3bJYrH1+8dhiDWZeBLb/rn3ez8LaXjBrC/UfI3bBHqU+NYa4krREKjb4O/NmwxWwzvnP6R3y/A+0SSUhGGfR7SakyPjXABJpxpXrIMbwPwCfHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713174561; c=relaxed/simple;
	bh=/5o9d89zUSE1crGjRs+2PpaDAqA9XcHNEm5Od1tJ7g8=;
	h=From:In-Reply-To:Content-Type:Date:Cc:To:MIME-Version:Message-ID:
	 Subject; b=u5CH3zkFmpmfl3b9Vt+Qe2MIZsjBvMr1UtrhA56thebVwyaPDsRKnKL5QjZIk9jyxRCtto96qXWkoJWXcgywHHcK1dq5eu0OILjQT6LYKcKXRPEiFTSww2zbffoi/nsqTzGcN1pxpxXxyOF55NAXG9jD1tuJ03L2jOiuLwHwdSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=thom.fr.eu.org; spf=pass smtp.mailfrom=thom.fr.eu.org; arc=none smtp.client-ip=212.27.42.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=thom.fr.eu.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=thom.fr.eu.org
Received: from smtp5-g21.free.fr (smtp5-g21.free.fr [212.27.42.5])
	by smtpfb2-g21.free.fr (Postfix) with ESMTP id 4EA5F4DA04
	for <xenomai@lists.linux.dev>; Mon, 15 Apr 2024 11:49:05 +0200 (CEST)
Received: from mail.thom.fr.eu.org (unknown [IPv6:2a01:e0a:2aa:1dd0::2])
	by smtp5-g21.free.fr (Postfix) with ESMTPS id A7CDA60128;
	Mon, 15 Apr 2024 11:48:55 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mail.thom.fr.eu.org (8.15.2/8.15.2/Debian-22) with ESMTP id 43F9mq882972931;
	Mon, 15 Apr 2024 11:48:52 +0200
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.thom.fr.eu.org 43F9mq882972931
From: =?utf-8?q?Fran=C3=A7ois_Legal?= <devel@thom.fr.eu.org>
In-Reply-To:  <SE2P216MB22790C817B4227CF808B2121E0092@SE2P216MB2279.KORP216.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset="utf-8"
X-Forward: 217.109.173.233, 165.225.204.99
Date: Mon, 15 Apr 2024 11:48:52 +0200
Cc: "xenomai@lists.linux.dev" <xenomai@lists.linux.dev>,
        =?utf-8?q?=C2=B9=C3=9A=C2=B0=C3=A6=C3=88=C3=86(Kyunghoon_Park)_=C3=86=C3=80=C3=80=C3=A5_=C2=B5=C3=8E=C2=BB=C3=AA=C2=B7=C3=8E=C2=BA=C2=B8=C3=86=C2=BD=C2=BD=C2=BA?= <kyunghoon2.park@doosan.com>
To: =?utf-8?q?=C3=80=C3=93=C3=81=C3=98=C2=BC=C3=B6(Junesoo_Im)_=C2=BC=C3=B6=C2=BC=C2=AE_=C2=B5=C3=8E=C2=BB=C3=AA=C2=B7=C3=8E=C2=BA=C2=B8=C3=86=C2=BD=C2=BD=C2=BA?= <junesoo.im@doosan.com>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Message-ID: <11ed-661cf800-11-274d62c0@39899883>
Subject: =?utf-8?q?Re=3A?= Linux system got freezing when "Xenomai App" started (or 
 terminated).
User-Agent: SOGoMail 5.0.1
Content-Transfer-Encoding: quoted-printable
X-Virus-Scanned: clamav-milter 0.103.10 at tls-srv-03
X-Virus-Status: Clean

Le Lundi, Avril 15, 2024 11:23 CEST, =C3=80=C3=93=C3=81=C3=98=C2=BC=C3=B6=
(Junesoo Im) =C2=BC=C3=B6=C2=BC=C2=AE =C2=B5=C3=8E=C2=BB=C3=AA=C2=B7=C3=
=8E=C2=BA=C2=B8=C3=86=C2=BD=C2=BD=C2=BA	<junesoo.im@doosan.com> a =C3=A9=
crit: 
 
> Hello. I am a Linux Application Developer.
> 
> 
> Application uses Xenomai 3.1x.
> The machine environment is 64bit and kernel 5.4.255.
> 
> Repeat machine reboot at 55 second intervals.
> Most of the time it works fine, but sometimes the system freezes.
> The mouse doesn't move and the keyboard doesn't work.
> The screen also freezes.
> There are no special messages in the kernel log.
> The same goes for syslog.
> 
> 
> 
> So I'm running some tests.
> If you test without running the application, there is no problem with=
 the system.
> Problems occur when the application runs.
> However, I don't see any special messages in the application log.
> 
> 
> I haven't found the cause of Freezing yet.
> I am currently viewing the =C2=A1=C2=B0https://v3.xenomai.org/trouble=
shooting/=C2=A1=C2=B1 site.
> I would like to test some of the things mentioned on this site.
> If possible, I would like you to look at this site together.
> 
> 
> This site is talking about Kernel configuration that needs to be remo=
ved.
> "CONFIG=5FKGDB"
> This option is currently enabled, so I removed it and tested it.
> But Freezing occurred.
> A problem has occurred, but should this option be removed?
> 
> 
> This site talks about "Freeze or machine lockup".
> 1. =C2=A1=C2=B0Stack space overflow issue now biting sim real-time ke=
rnel thread?=C2=A1=C2=B1
> 2. =C2=A1=C2=B0Spurious delay/timeout values computed by the applicat=
ion (specifically: too short)=C2=A1=C2=B1
> 3. =C2=A1=C2=B0A case of freeze is a system call called in a loop whi=
ch fails without its return value being properly checked.=C2=A1=C2=B1
> 
> 
> There are three explanations: I have a question about the first one.
> How many threads can the xenomai program create?
> What is the maximum stack size per thread in the xenomai program?
> Our program has at least 22 xenomai threads.
> The stack size is different for each thread. It may have a maximum of=
 8 MB and a minimum of 2 MB.
> 
> 
> 
> The question is complicated and long, but I desperately need help.
> Please, reply.
> Thank you.
 
 
 Hi

have you tried enabling CONFIG=5FXENO=5FOPT=5FWATCHDOG to enable detect=
ion of runaway RT threads.
This might help you diagnosing the problem.

Fran=C3=A7ois

