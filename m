Received: from smtpfb2-g21.free.fr (smtpfb2-g21.free.fr [212.27.42.10])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D370881D
	for <xenomai@lists.linux.dev>; Fri,  5 Aug 2022 12:58:43 +0000 (UTC)
Received: from smtp5-g21.free.fr (smtp5-g21.free.fr [212.27.42.5])
	by smtpfb2-g21.free.fr (Postfix) with ESMTP id 2F6104CB23
	for <xenomai@lists.linux.dev>; Fri,  5 Aug 2022 14:50:57 +0200 (CEST)
Received: from mail.thom.fr.eu.org (unknown [IPv6:2a01:e0a:2aa:1dd0::2])
	by smtp5-g21.free.fr (Postfix) with ESMTPS id F3A2B60148
	for <xenomai@lists.linux.dev>; Fri,  5 Aug 2022 14:50:48 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mail.thom.fr.eu.org (8.15.2/8.15.2/Debian-22) with ESMTP id 275ComZl912391
	for <xenomai@lists.linux.dev>; Fri, 5 Aug 2022 14:50:48 +0200
From: =?utf-8?q?Fran=C3=A7ois_Legal?= <devel@thom.fr.eu.org>
To: xenomai@lists.linux.dev
User-Agent: SOGoMail 5.0.1
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Date: Fri, 05 Aug 2022 14:50:48 +0200
Subject: Using setuid to relinquish root rights
Message-ID: <7eb52-62ed1200-d-65e32200@245807512>
X-Forward: 217.109.173.233, 165.225.20.103
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Virus-Scanned: clamav-milter 0.103.6 at tls-srv-03
X-Virus-Status: Clean

Hello,

I'm running a Xenomai (3.1) app, that comprises both realtime xenomai t=
hread and plain linux threads. The app starts as root so as to be able =
to bind <1024 tcp sockets.

After initialisation of the sockets and RT IPCs, I would like to reliqu=
insh root rights, by calling setuid.

After that call, I get lots of  syscall <56> denied to "One of my RT th=
read" and syscall <61> denied to "One of my RT thread".

I figured out I had to set the CAP=5FSYS=5FNICE capability to the app b=
efore, so I added 
caps =3D cap=5Fget=5Fproc();
cap=5Fset=5Fflag(caps, CAP=5FEFFECTIVE, 1, cap=5Flist, CAP=5FSET);
cap=5Fset=5Fproc(caps);
prctl(PR=5FSET=5FKEEPCAPS, 1, 0, 0, 0);

Without success. Morevover, the user that I set the uid to has group xe=
nomai as primary group plus I do echo 1000 >  /sys/module/xenomai/param=
eters/allowed=5Fgroup before running the app, but still.

Anybody can point me in the right direction.

Thanks in advance

Fran=C3=A7ois

