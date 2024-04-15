Received: from smtp5-g21.free.fr (smtp5-g21.free.fr [212.27.42.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14C7284FB3
	for <xenomai@lists.linux.dev>; Mon, 15 Apr 2024 13:21:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.27.42.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713187294; cv=none; b=DtXZQc7FTTyi63dVxnbJrvOGE2IsdosI0E2L08eTyUMAqTizHiB8Nw/KS0+ywVXsceqxkpp2EF5ZtVVpO3zGPFJ5mATXvSkizp/rHlnnF1QI1bUnqkKkKB0i6Noa/EyyNRXNSpMwXjZ5xleDwckkwrp9JyBP4QG1P/q6LI5s4zQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713187294; c=relaxed/simple;
	bh=YWo8YwzRQ9SvGAJkIJifRvoUwSU/PV46yEIkqbNoljs=;
	h=From:In-Reply-To:Content-Type:Date:Cc:To:MIME-Version:Message-ID:
	 Subject; b=AemiPnvMNZHFHS5ucEeiJkh6AnwX7k/FRHgRuUxjDGtSrhj9DLlG9+hufx6WDZzhlskckqzNVW/AsDSIicN61LmdMYBhfjqDaDXvdPtk2YsGRjLhgWxhSFeMqmL+nWM/NAjYuWovt6rhUfcxtvWZxiiFTV7NX/ggQ0lRJaKxS9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=thom.fr.eu.org; spf=pass smtp.mailfrom=thom.fr.eu.org; arc=none smtp.client-ip=212.27.42.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=thom.fr.eu.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=thom.fr.eu.org
Received: from mail.thom.fr.eu.org (unknown [IPv6:2a01:e0a:2aa:1dd0::2])
	by smtp5-g21.free.fr (Postfix) with ESMTPS id 457BF60141;
	Mon, 15 Apr 2024 15:21:28 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mail.thom.fr.eu.org (8.15.2/8.15.2/Debian-22) with ESMTP id 43FDLR392980806;
	Mon, 15 Apr 2024 15:21:27 +0200
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.thom.fr.eu.org 43FDLR392980806
From: =?utf-8?q?Fran=C3=A7ois_Legal?= <devel@thom.fr.eu.org>
In-Reply-To:  <SL2P216MB2274F54CFDA8A64A60C75671E0092@SL2P216MB2274.KORP216.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset="utf-8"
X-Forward: 82.64.149.25, 147.161.184.113
Date: Mon, 15 Apr 2024 15:21:27 +0200
Cc: "xenomai@lists.linux.dev" <xenomai@lists.linux.dev>,
        =?utf-8?q?=EB=B0=95=EA=B2=BD=ED=9B=88(Kyunghoon_Park)_=ED=8C=80=EC=9E=A5_=EB=91=90=EC=82=B0=EB=A1=9C=EB=B3=B4=ED=8B=B1=EC=8A=A4?= <kyunghoon2.park@doosan.com>
To: =?utf-8?q?=EC=9E=84=EC=A4=80=EC=88=98(Junesoo_Im)_=EC=88=98=EC=84=9D_=EB=91=90=EC=82=B0=EB=A1=9C=EB=B3=B4=ED=8B=B1=EC=8A=A4?= <junesoo.im@doosan.com>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Message-ID: <11eb-661d2a00-1d-4baabc00@149783243>
Subject: =?utf-8?q?RE=3A?= Linux system got freezing when "Xenomai App" started (or   
 terminated).
User-Agent: SOGoMail 5.0.1
Content-Transfer-Encoding: quoted-printable
X-Virus-Scanned: clamav-milter 0.103.10 at tls-srv-03
X-Virus-Status: Clean

Le Lundi, Avril 15, 2024 12:37 CEST, =EC=9E=84=EC=A4=80=EC=88=98(Juneso=
o Im) =EC=88=98=EC=84=9D =EB=91=90=EC=82=B0=EB=A1=9C=EB=B3=B4=ED=8B=B1=EC=
=8A=A4 <junesoo.im@doosan.com> a =C3=A9crit: 
 
> Okay, I answered your question below.
> 
> 
> So you mean xenomai watchdog is already active, but still the system =
hangs ?
> -> Yes. One thing is certain, when testing the device reboot, only sy=
stem hang occurs.
>     At this time, the watchdog did not occur.
> 
> And the system hangs only when you run the RT application ?
> -> Yes. System hang does not occur unless you run the robot program (=
with Xenomai).
>     For reference, the robot program is automatically executed by Lin=
ux rc.local. at start.
> 
> Do your application rely on custom kernel drivers ?
> -> Yes. The robot program has EtherCAT functionality. And the EtherCA=
T function uses "atemsys.ko".
> 
> Is JTAG debugging an option ?
> -> Unfortunately, there isn't any.
> 
> 
> I'll wait for your opinion.
> Thanks.
> Best Regards.
> 
> -----Original Message-----
> From: Fran=C3=A7ois Legal <devel@thom.fr.eu.org> 
> Sent: Monday, April 15, 2024 7:16 PM
> To: =EC=9E=84=EC=A4=80=EC=88=98(Junesoo Im) =EC=88=98=EC=84=9D =EB=91=
=90=EC=82=B0=EB=A1=9C=EB=B3=B4=ED=8B=B1=EC=8A=A4 <junesoo.im@doosan.com=
>
> Cc: xenomai@lists.linux.dev; =EB=B0=95=EA=B2=BD=ED=9B=88(Kyunghoon Pa=
rk) =ED=8C=80=EC=9E=A5 =EB=91=90=EC=82=B0=EB=A1=9C=EB=B3=B4=ED=8B=B1=EC=
=8A=A4 <kyunghoon2.park@doosan.com>
> Subject: RE: Linux system got freezing when "Xenomai App" started (or=
 terminated).
> 
> =EC=A3=BC=EC=9D=98: =EC=9D=B4 =EB=A9=94=EC=9D=BC=EC=9D=80 =EC=99=B8=EB=
=B6=80=EC=97=90=EC=84=9C =EB=B0=9C=EC=86=A1 =EB=90=98=EC=97=88=EC=8A=B5=
=EB=8B=88=EB=8B=A4. =EB=A7=81=ED=81=AC =ED=98=B9=EC=9D=80 =EC=B2=A8=EB=B6=
=80=ED=8C=8C=EC=9D=BC =EC=97=B4=EB=9E=8C =EC=8B=9C =EC=A3=BC=EC=9D=98=ED=
=95=98=EC=8B=9C=EA=B8=B0 =EB=B0=94=EB=9E=8D=EB=8B=88=EB=8B=A4.
> 
> CAUTION: This email is sent by an external account. Please take extra=
 caution when clicking the link or opening the attachment.
> 
> Le Lundi, Avril 15, 2024 12:07 CEST, =EC=9E=84=EC=A4=80=EC=88=98(June=
soo Im) =EC=88=98=EC=84=9D =EB=91=90=EC=82=B0=EB=A1=9C=EB=B3=B4=ED=8B=B1=
=EC=8A=A4 <junesoo.im@doosan.com> a =C3=A9crit:
> 
> > Dear Fran=C3=A7ois Legal.
> >
> >
> > Thank you so much for your quick reply!!
> >
> >
> > I checked "CONFIG=5FXENO=5FOPT=5FWATCHDOG" in your message.
> >
> >
> > (This e-mail type is not HTML. So, I write down some informations.)=
 I 
> > search "CONFIG=5FXENO=5FOPT=5FWATCHDOG" option in kernel's ".config=
" file
> >    -------------------------------------------------
> >    $KERNEL=5FROOT) grep CONFIG=5FXENO=5FOPT=5FWATCHDOG .config
> >    Output> CONFIG=5FXENO=5FOPT=5FWATCHDOG=3Dy
> >    Output> CONFIG=5FXENO=5FOPT=5FWATCHDOG=5FTIMEOUT=3D4
> >
> > Also, Xenomai's watchdog works well.
> > Because Robot program is sometimes terminated by the watchdog.
> >
> > Xenomai watchdog is also a problem, but right now we are focusing o=
n system freezing.
> >
> >
> > Is there anything else you can tell me?
> >
> > Thanks.
> > Best Regards.
> >
> >
> > -----Original Message-----
> > From: Fran=C3=A7ois Legal <devel@thom.fr.eu.org>
> > Sent: Monday, April 15, 2024 6:49 PM
> > To: =EC=9E=84=EC=A4=80=EC=88=98(Junesoo Im) =EC=88=98=EC=84=9D =EB=91=
=90=EC=82=B0=EB=A1=9C=EB=B3=B4=ED=8B=B1=EC=8A=A4 <junesoo.im@doosan.com=
>
> > Cc: xenomai@lists.linux.dev; =EB=B0=95=EA=B2=BD=ED=9B=88(Kyunghoon =
Park) =ED=8C=80=EC=9E=A5 =EB=91=90=EC=82=B0=EB=A1=9C=EB=B3=B4=ED=8B=B1=EC=
=8A=A4 
> > <kyunghoon2.park@doosan.com>
> > Subject: Re: Linux system got freezing when "Xenomai App" started (=
or terminated).
> >
> > =EC=A3=BC=EC=9D=98: =EC=9D=B4 =EB=A9=94=EC=9D=BC=EC=9D=80 =EC=99=B8=
=EB=B6=80=EC=97=90=EC=84=9C =EB=B0=9C=EC=86=A1 =EB=90=98=EC=97=88=EC=8A=
=B5=EB=8B=88=EB=8B=A4. =EB=A7=81=ED=81=AC =ED=98=B9=EC=9D=80 =EC=B2=A8=EB=
=B6=80=ED=8C=8C=EC=9D=BC =EC=97=B4=EB=9E=8C =EC=8B=9C =EC=A3=BC=EC=9D=98=
=ED=95=98=EC=8B=9C=EA=B8=B0 =EB=B0=94=EB=9E=8D=EB=8B=88=EB=8B=A4.
> >
> > CAUTION: This email is sent by an external account. Please take ext=
ra caution when clicking the link or opening the attachment.
> >
> > Le Lundi, Avril 15, 2024 11:23 CEST, =C3=80=C3=93=C3=81=C3=98=C2=BC=
=C3=B6(Junesoo Im) =C2=BC=C3=B6=C2=BC=C2=AE =C2=B5=C3=8E=C2=BB=C3=AA=C2=
=B7=C3=8E=C2=BA=C2=B8=C3=86=C2=BD=C2=BD=C2=BA       <junesoo.im@doosan.=
com> a =C3=A9crit:
> >
> > > Hello. I am a Linux Application Developer.
> > >
> > >
> > > Application uses Xenomai 3.1x.
> > > The machine environment is 64bit and kernel 5.4.255.
> > >
> > > Repeat machine reboot at 55 second intervals.
> > > Most of the time it works fine, but sometimes the system freezes.=

> > > The mouse doesn't move and the keyboard doesn't work.
> > > The screen also freezes.
> > > There are no special messages in the kernel log.
> > > The same goes for syslog.
> > >
> > >
> > >
> > > So I'm running some tests.
> > > If you test without running the application, there is no problem =
with the system.
> > > Problems occur when the application runs.
> > > However, I don't see any special messages in the application log.=

> > >
> > >
> > > I haven't found the cause of Freezing yet.
> > > I am currently viewing the =C2=A1=C2=B0https://secure-web.cisco.c=
om/1XLvVz-8MEZDdYZfDgbDD6YEaNOjJeaQ6a47KjHffv0KQbTypxooAIDbLz8urSXEI6vR=
lttlL27KSW=5FmfF0ENueummSZ38ucNEvjty5-ZVBy60tljLbXzBNlB5cgnIzhT8moSYlzk=
UphFAcsDj-ghcCQ1QnKn1xIcEJho6xMExZ2wArvZaBvOJ0fcuxDro1q4C6PwSin=5FiyNBt=
03iXUJuhHltWbGv9K-oth9mI-QTIiNDu3wG7Xej8rdBFNijChtrgaOlUBzUBAxaipEmzDHd=
BpRA1HEHvIm523iNHg7XsdjgKftK0Od1fpZmEZRtSn1N/https%3A%2F%2Fv3.xenomai.o=
rg%2Ftroubleshooting%2F=C2=A1=C2=B1 site.
> > > I would like to test some of the things mentioned on this site.
> > > If possible, I would like you to look at this site together.
> > >
> > >
> > > This site is talking about Kernel configuration that needs to be =
removed.
> > > "CONFIG=5FKGDB"
> > > This option is currently enabled, so I removed it and tested it.
> > > But Freezing occurred.
> > > A problem has occurred, but should this option be removed?
> > >
> > >
> > > This site talks about "Freeze or machine lockup".
> > > 1. =C2=A1=C2=B0Stack space overflow issue now biting sim real-tim=
e kernel 
> > > thread?=C2=A1=C2=B1 2. =C2=A1=C2=B0Spurious delay/timeout values =
computed by the 
> > > application (specifically: too short)=C2=A1=C2=B1 3. =C2=A1=C2=B0=
A case of freeze is a 
> > > system call called in a loop which fails without its return value=
 
> > > being properly checked.=C2=A1=C2=B1
> > >
> > >
> > > There are three explanations: I have a question about the first o=
ne.
> > > How many threads can the xenomai program create?
> > > What is the maximum stack size per thread in the xenomai program?=

> > > Our program has at least 22 xenomai threads.
> > > The stack size is different for each thread. It may have a maximu=
m of 8 MB and a minimum of 2 MB.
> > >
> > >
> > >
> > > The question is complicated and long, but I desperately need help=
.
> > > Please, reply.
> > > Thank you.
> >
> >
> >  Hi
> >
> > have you tried enabling CONFIG=5FXENO=5FOPT=5FWATCHDOG to enable de=
tection of runaway RT threads.
> > This might help you diagnosing the problem.
> >
> > Fran=C3=A7ois
> >
> >
> 
> So you mean xenomai watchdog is already active, but still the system =
hangs ?
> And the system hangs only when you run the RT application ?
> Do your application rely on custom kernel drivers ?
> Is JTAG debugging an option ?
> 
> Fran=C3=A7ois
> 

Well, I can't say for sure, but IMHO, if xenomai watchdog does not trig=
ger, I guess we can say it's not a userland runaway thread that causes =
the hang.

So this probably means problemsat kernel level. I don't know this kerne=
l module your mentionning, but if it is proprietary, could you try to e=
xercise it's functions with a simple test program (that would idealy re=
produce the real application behaviour regarding driver access) and see=
 if the hang can occur in that configuration.

Apart from that, and without JTAG debug possibility, I can not give any=
 more advice on this. Sorry.

Fran=C3=A7ois

