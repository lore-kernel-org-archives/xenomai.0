References: <1390856074.81966.YahooMailNeo@web171601.mail.ir2.yahoo.com>
 <52E77A43.3010706@xenomai.org> 
Message-ID: <1390939507.52519.YahooMailNeo@web171605.mail.ir2.yahoo.com>
Date: Tue, 28 Jan 2014 20:05:07 +0000 (GMT)
From: Matthias Schneider <ma30002000@yahoo.de>
In-Reply-To: <52E77A43.3010706@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai] segmentation fault in taskSpawn (xenomai-forge)
Reply-To: Matthias Schneider <ma30002000@yahoo.de>
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>, "xenomai@xenomai.org" <xenomai@xenomai.org>

> On Tuesday, January 28, 2014 10:36 AM, Philippe Gerum <rpm@xenomai.org> w=
rote:=0A=0A> > On 01/27/2014 09:54 PM, Matthias Schneider wrote:=0A>> =0A>>=
 =0A>>=A0 Hi all,=0A>> =0A>>=A0 in case taskSpawn() fails due to lack of pe=
rmissions in the current=0A>>=A0 xenomai-forge checkout (tried with mercury=
), the following function=0A>> =0A>>=A0 ret =3D __bt(copperplate_create_thr=
ead(&cta, &task->thobj.tid));=0A>> =0A>>=A0 returns ret !=3D 0 and I get th=
e following segmentation fault:=0A>> =0A>>=A0 http://pastebin.ca/2591742=0A=
> =0A> Confirmed using valgrind. It looks like portions of the task control=
 =0A> block are dismantled although they were not initialized yet:=0A> =0A>=
 task-1...=3D=3D11184=3D=3D Memcheck, a memory error detector=0A> =3D=3D111=
84=3D=3D Copyright (C) 2002-2012, and GNU GPL'd, by Julian Seward et al.=0A=
> =3D=3D11184=3D=3D Using Valgrind-3.8.1 and LibVEX; rerun with -h for copy=
right info=0A> =3D=3D11184=3D=3D Command: ./task-1 --cpu-affinity=3D0 --sil=
ent=0A> =3D=3D11184=3D=3D=0A> =3D=3D11184=3D=3D Invalid write of size 8=0A>=
 =3D=3D11184=3D=3D=A0 =A0 at 0x4E28D1A: notifier_destroy (private-list.h:58=
)=0A> =3D=3D11184=3D=3D=A0 =A0 by 0x4E25A3F: destroy_thread (threadobj.c:48=
3)=0A> =3D=3D11184=3D=3D=A0 =A0 by 0x4C1628B: __taskInit (taskLib.c:382)=0A=
> =3D=3D11184=3D=3D=A0 =A0 by 0x4C1661A: taskSpawn (taskLib.c:501)=0A> =3D=
=3D11184=3D=3D=A0 =A0 by 0x400C76: main (task-1.c:38)=0A> =3D=3D11184=3D=3D=
=A0 Address 0x7f1564f5dc90 is not stack'd, malloc'd or (recently) =0A> =0A>=
 free'd=0A>> =0A>>=A0 holder->prev and holder->next seem to be nullptrs. I =
am not 100% sure =0A> how to fix=0A>>=A0 this issue... I have a clone from =
the latest=A0 xenomai-forge.git/next.=0A> =0A> =0A> http://git.xenomai.org/=
xenomai-forge.git/commit/?h=3Dnext&id=3Dd4db547e281e3d1efba32311ad3d5efd8d4=
dc16e=0A> =0A> =0A>> =0A>> =0A>>=A0 Also, I would like to ask about the xen=
omai-forge style of resources handles=0A>>=A0 (e.g. tasks, queues, semaphor=
es, etc.), which are actually pointers converted=0A>>=A0 with the mainheap_=
ref and mainheap_deref=A0 macros.=0A>> =0A>>=A0 In the xenomai 2.6 implemen=
tation, handles were resolved via a registry,=0A>>=A0 allowing the detectio=
n of handles on deleted objects. However, with the=0A>>=A0 pointer-based ap=
proach in xenomai-forge, the result of a handle to a deleted=0A>>=A0 object=
 may either be gracefully detected (in case the memory is still readable=0A=
>>=A0 and the magic does not match) or we will get a segmentation fault if =
the address=0A>>=A0 has been freed. Obviously, since this happens in user m=
ode, it will not have=0A>>=A0 impact on kernel stability, and it indicates =
an improper use of a handle,=A0but is=0A>>=A0 still a different behaviour t=
han xenomai 2.6.x. Is this desired or are there=0A>>=A0 plans to solve this=
 differently in the future (e.g. by using some sort of=0A>>=A0 registry, et=
c.)?=0A> =0A> It is (mostly) desired, at least this is a deliberate trade-o=
ff between =0A> bug detection and performance in the fast path. It would be=
 possible to =0A> revalidate those pointers via some hash indexing when res=
olving handles =0A> when in debug mode though, but this is not high on the =
todo list at the =0A> moment.=0A> =0A> The good news is that over mercury, =
valgrind may help a lot in detecting =0A> such kind of issues.=0A> =0A> -- =
=0A> Philippe.=0A>=0A=0AThank you for the quick fix and the information.=A0=
=0A=0AMatthias=0A

