Received: from smtp5-g21.free.fr (smtp5-g21.free.fr [212.27.42.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CAC523CD
	for <xenomai@lists.linux.dev>; Tue,  9 Aug 2022 16:31:03 +0000 (UTC)
Received: from mail.thom.fr.eu.org (unknown [IPv6:2a01:e0a:2aa:1dd0::2])
	by smtp5-g21.free.fr (Postfix) with ESMTPS id 2A8FF60138;
	Tue,  9 Aug 2022 18:30:55 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mail.thom.fr.eu.org (8.15.2/8.15.2/Debian-22) with ESMTP id 279GUsla1213070;
	Tue, 9 Aug 2022 18:30:54 +0200
From: =?utf-8?q?Fran=C3=A7ois_Legal?= <devel@thom.fr.eu.org>
In-Reply-To: <c0740fa3-b8ff-4e8d-08d3-10792dc0868f@siemens.com>
Content-Type: text/plain; charset="utf-8"
X-Forward: 217.109.173.233, 165.225.20.103
Date: Tue, 09 Aug 2022 18:30:54 +0200
Cc: xenomai@lists.linux.dev
To: "Jan Kiszka" <jan.kiszka@siemens.com>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Message-ID: <7eb50-62f28b80-13-4a5f7880@4962321>
Subject: =?utf-8?q?Re=3A?= Using setuid to relinquish root rights
User-Agent: SOGoMail 5.0.1
Content-Transfer-Encoding: quoted-printable
X-Virus-Scanned: clamav-milter 0.103.6 at tls-srv-03
X-Virus-Status: Clean

Le Mardi, Ao=C3=BBt 09, 2022 07:56 CEST, Jan Kiszka <jan.kiszka@siemens=
.com> a =C3=A9crit: 
 
> On 05.08.22 14:50, Fran=C3=A7ois Legal wrote:
> > Hello,
> > 
> > I'm running a Xenomai (3.1) app, that comprises both realtime xenom=
ai thread and plain linux threads. The app starts as root so as to be a=
ble to bind <1024 tcp sockets.
> > 
> > After initialisation of the sockets and RT IPCs, I would like to re=
liquinsh root rights, by calling setuid.
> > 
> > After that call, I get lots of  syscall <56> denied to "One of my R=
T thread" and syscall <61> denied to "One of my RT thread".
> > 
> > I figured out I had to set the CAP=5FSYS=5FNICE capability to the a=
pp before, so I added 
> > caps =3D cap=5Fget=5Fproc();
> > cap=5Fset=5Fflag(caps, CAP=5FEFFECTIVE, 1, cap=5Flist, CAP=5FSET);
> > cap=5Fset=5Fproc(caps);
> > prctl(PR=5FSET=5FKEEPCAPS, 1, 0, 0, 0);
> > 
> > Without success. Morevover, the user that I set the uid to has grou=
p xenomai as primary group plus I do echo 1000 >  /sys/module/xenomai/p=
arameters/allowed=5Fgroup before running the app, but still.
> > 
> > Anybody can point me in the right direction.
> > 
> 
> We may have regressions here as this configuration is not systematica=
lly
> tested. From your description and me read-up of our current logic, th=
is
> is supposed to work fine.
> 
> Can you debug the kernel logic in more details, check, if the cap is
> raised properly during the xenomai bind syscall and if we are later o=
n
> checking it correctly? Maybe some other condition that the cap if
> failing, though I don't see yet which one.
> 


Hello,

I won't be able to this before begining of next month, however, I would=
 need some pointers on what  to look for and where. I have to tell that=
 I've never used capabilities before.

Fran=C3=A7ois


> Jan
> 
> -- 
> Siemens AG, Technology
> Competence Center Embedded Linux

