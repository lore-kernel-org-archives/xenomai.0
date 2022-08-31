Received: from smtpfb1-g21.free.fr (smtpfb1-g21.free.fr [212.27.42.9])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 784C27E7
	for <xenomai@lists.linux.dev>; Wed, 31 Aug 2022 09:17:57 +0000 (UTC)
Received: from smtp5-g21.free.fr (smtp5-g21.free.fr [212.27.42.5])
	by smtpfb1-g21.free.fr (Postfix) with ESMTP id 2AC26DF95B3
	for <xenomai@lists.linux.dev>; Wed, 31 Aug 2022 11:12:05 +0200 (CEST)
Received: from mail.thom.fr.eu.org (unknown [IPv6:2a01:e0a:2aa:1dd0::2])
	by smtp5-g21.free.fr (Postfix) with ESMTPS id 2639060133;
	Wed, 31 Aug 2022 11:11:56 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mail.thom.fr.eu.org (8.15.2/8.15.2/Debian-22) with ESMTP id 27V9Bs42204735;
	Wed, 31 Aug 2022 11:11:55 +0200
From: =?utf-8?q?Fran=C3=A7ois_Legal?= <devel@thom.fr.eu.org>
In-Reply-To: <c0740fa3-b8ff-4e8d-08d3-10792dc0868f@siemens.com>
Content-Type: text/plain; charset="utf-8"
X-Forward: 217.109.173.233, 165.225.20.103
Date: Wed, 31 Aug 2022 11:11:54 +0200
Cc: xenomai@lists.linux.dev
To: "Jan Kiszka" <jan.kiszka@siemens.com>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Message-ID: <fd7-630f2600-77-31d48bc0@30520678>
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
> Jan
> 

I could take some time to see what happens. I probably had a problem in=
 my capability setting code.
For reference, this is my understanding of what has to be done :

Set the KEEPCAPS security bit
Relinquish root rights 
Set the CAP=5FSYS=5FNICE capability

After this sequence, the CAP=5FSYS=5FNICE is correctly set in the proce=
ss (you can tell by checking CapEff in /proc/[pid]/status)

However, I seem to have a chicken and egg problem here.

Reliquinshing of root rights is done after IPCs and thread creation, so=
 my thread are running. The problem is that as soon as setuid is called=
, then every thread using IPCs start running round as the call to IPC f=
unctions return error, and it seem the main thread never get to be sche=
duled to set the CAP=5FSYS=5FNICE bit.

If I try to relinquish root rights after my IPCs are created but before=
 the threads are created, I get an error while creating the threads.
If I try to raise the main thread priority before doing the sequence, i=
t does not work (pthread=5Fsetschedparam=5Fex returns 20)

Does all this means I have to do the root rights relinquish sequence in=
 the thread with the highest priority ?

Thanks

Fran=C3=A7ois

> -- 
> Siemens AG, Technology
> Competence Center Embedded Linux

