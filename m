Content-Class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 30 Nov 2007 11:42:57 +0100
Message-ID: <5D63919D95F87E4D9D34FF7748CE2C2AE3C69D@ARVMAIL1.mra.roland-man.biz>
From: <Roderik.Wildenburg@domain.hid>
Subject: [Xenomai-help] rt_queue_write strange behaviour ++
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org

Sorry, but in my last mail (see below) I had forgotten to tell you my=20
Xenomai-Version and architecture.
I still use Xenomai 2.3.2 on PPC.

In the meantime I had a deeper look into the Xenomai source code=20
and I would say, the case we observed (msg->refcount =3D=3D 0 ; see =
below)
isn=B4t possible with rt_queue_write, as this function implicitly =
allocate=20
its messagebuffer and rt_queue_alloc initilaizes refcount to 1.
Immediatelly after this rt_queue_send is called, where the=20
plausibility test if( msg->refcount =3D=3D 0) is done and fails.=20
So, I can=B4t see a gap where refcount falls back to 0.

Does any guru have a good idea, I am quite clueless.

Original mail :
--------------------------------------------------------------------

Sometimes we get an EINVAL-Error with rt_queue_write.
If we immediatelly after the EINVAL-Error try an a second time to write
to the queue (with exactly the same parameters as at the first time) the
rt_queue_write succeeds (see appended code sniped) !!??

I traced down (xnprintf) the error to the function rt_queue_send where a
plausibility test is made :

if (xnheap_check_block(&q->bufpool, msg) || msg->refcount =3D=3D 0)=20
[approx at line 614]

this test fail as (msg->refcount =3D=3D 0).
If I understand the comment correctly :

/* In case of invalid block or if the sender does not own the
   message, just bail out. */

the sender does not own the message.
But if so, the second try should fail also (and I am quite sure the
message belongs to the sender) ?
Does anyone (probabliy Philipe) has an idea in what situation this
problem could occur or what is the reason for this strange behaviour ?

Unfortunately I could not reproduce this problem in a simple testcase,=20
but with our application the error occurs regularly (~10 times a hour).
So I rely on your intuition to spike this problem.

Many thanks in advance and best regards
Roderik=20

MAN Roland Druckmaschinen AG
Vorsitzender des Aufsichtsrates: Hanno C. Fiedler
Vorstand: Gerd Finkbeiner (Vorsitzender), Dr. Ingo Koch, Dr. Markus =
Rall, Paul Steidle   =20
Sitz der Gesellschaft: Offenbach am Main, Registergericht: Amtsgericht =
Offenbach HRB-Nr. 42592   =20
USt-Ident-Nr. DE 250200933

