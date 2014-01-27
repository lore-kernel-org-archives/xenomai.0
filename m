Message-ID: <1390856074.81966.YahooMailNeo@web171601.mail.ir2.yahoo.com>
Date: Mon, 27 Jan 2014 20:54:34 +0000 (GMT)
From: Matthias Schneider <ma30002000@yahoo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Subject: [Xenomai] segmentation fault in taskSpawn (xenomai-forge)
Reply-To: Matthias Schneider <ma30002000@yahoo.de>
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "xenomai@xenomai.org" <xenomai@xenomai.org>

=0A=0AHi all,=0A=0Ain case taskSpawn() fails due to lack of permissions in =
the current=A0=0Axenomai-forge checkout (tried with mercury), the following=
 function=0A=0Aret =3D __bt(copperplate_create_thread(&cta, &task->thobj.ti=
d));=0A=0Areturns ret !=3D 0 and I get the following segmentation fault:=0A=
=0Ahttp://pastebin.ca/2591742=0A=0Aholder->prev and holder->next seem to be=
 nullptrs. I am not 100% sure how to fix=A0=0Athis issue... I have a clone =
from the latest =A0xenomai-forge.git/next.=0A=0A=0AAlso, I would like to as=
k about the xenomai-forge style of resources handles=A0=0A(e.g. tasks, queu=
es, semaphores, etc.), which are actually pointers converted=A0=0Awith the =
mainheap_ref and mainheap_deref =A0macros.=0A=0AIn the xenomai 2.6 implemen=
tation, handles were resolved via a registry,=A0=0Aallowing the detection o=
f handles on deleted objects. However, with the=A0=0Apointer-based approach=
 in xenomai-forge, the result of a handle to a deleted=A0=0Aobject may eith=
er be gracefully detected (in case the memory is still readable=A0=0Aand th=
e magic does not match) or we will get a segmentation fault if the address=
=A0=0Ahas been freed. Obviously, since this happens in user mode, it will n=
ot have=A0=0Aimpact on kernel stability, and it indicates an improper use o=
f a handle, but is=A0=0Astill a different behaviour than xenomai 2.6.x. Is =
this desired or are there=A0=0Aplans to solve this differently in the futur=
e (e.g. by using some sort of=A0=0Aregistry, etc.)?=0A=0AThanks in advance =
for your answers,=A0=0Aregards,=0AMatthias=0A

