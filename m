Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="----_=_NextPart_001_01CB0D82.8A5471D0"
Date: Wed, 16 Jun 2010 11:34:21 -0700
Message-ID: <2319761F7FA0D1479BA77EC2E0A8E7BCEDCE09@domain.hid>
In-Reply-To: <1275033915.27918.31.camel@domain.hid>
References: <181804936ABC2349BE503168465576460EBD5C0D@exchserver.basler.com>
	<1274047063.2972.1.camel@domain.hid>
	<2319761F7FA0D1479BA77EC2E0A8E7BCE8A603@domain.hid>
	<1275033915.27918.31.camel@domain.hid>
From: "Abhijit Majumdar" <abhijit.majumdar@domain.hid>
Subject: Re: [Xenomai-help] rt_task_sleep causing crashes on PowerPC
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai@xenomai.org, Steve Deiters <SteveDeiters@domain.hid>

This is a multi-part message in MIME format.

------_=_NextPart_001_01CB0D82.8A5471D0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi Philippe

I have attached a standalone test program which crashes my system. It
uses poxis skin to create a simple task which sleeps for 10 micro sec
and wakes up and continues to do so until the user kills the process.

Interesting things note --=20

	1. If I uncomment the printf statement at the beginning of the
while loop the program does not crash any more.
	2. OR if I use rt_task_sleep instead of clock_nanosleep it does
not crash.

I am using xenomai 2.5.2 and the arm platform has kernel 2.6.28. I've
cc-ed this email to a tech expert (Travis) of the vendor (EMAC) of the
arm system.=20

At the time of crashing I see the following error message on the screen
----

WARNING: at
/home/travis/projects/customers/pivotal_systems/workspace/linux-2.6.
28-xenomai-pivotal/kernel/sched.c:4382 add_preempt_count+0x84/0x98()
Modules linked in: at91_udc
[<c002e374>] (dump_stack+0x0/0x14) from [<c004510c>]
(warn_on_slowpath+0x4c/0x68
)
[<c00450c0>] (warn_on_slowpath+0x0/0x68) from [<c003dd44>]
(add_preempt_count+0x
84/0x98)
 r6:c38dc02c r5:00000000 r4:00000001
[<c003dcc0>] (add_preempt_count+0x0/0x98) from [<c0045d24>]
(vprintk+0x2c/0x3d4)
[<c0045cf8>] (vprintk+0x0/0x3d4) from [<c00466c8>] (printk+0xe0/0x194)
[<c00465e8>] (printk+0x0/0x194) from [<c00768f0>]
(__xnpod_schedule+0x38c/0x550)
 r3:00000003 r2:c039e3a0 r1:c3854000 r0:c032f630
 r8:c480d408 r7:c3b98ca0 r6:c3b98ca0 r5:00000000 r4:c03a0d10
[<c0076564>] (__xnpod_schedule+0x0/0x550) from [<c007698c>]
(__xnpod_schedule+0x
428/0x550)
[<c0076564>] (__xnpod_schedule+0x0/0x550) from [<c007698c>]
(__xnpod_schedule+0x
428/0x550)
[<c0076564>] (__xnpod_schedule+0x0/0x550) from [<c007698c>]
(__xnpod_schedule+0x
428/0x550)
[<c0076564>] (__xnpod_schedule+0x0/0x550) <1>Unable to handle kernel
paging requ
est at virtual address 00001008



Thanks for your help

Abhijit






-----Original Message-----
From: Philippe Gerum [mailto:rpm@xenomai.org
Sent: Friday, May 28, 2010 1:05 AM
To: Abhijit Majumdar
Cc: Steve Deiters; xenomai@xenomai.org
Subject: RE: [Xenomai-help] rt_task_sleep causing crashes on PowerPC

On Wed, 2010-05-26 at 14:03 -0700, Abhijit Majumdar wrote:
> Hi
>=20
> I get similar problem the xenomai posix skin. I have the latest
version
> of Xenomai (2.5.3) and kernel 2.6.28.=20
>=20
> I am using clock_nanosleep(CLOCK_REALTIME, ......) to wait for 1
> millisecond. It freezes the system. However if I sleep for a second it
> is fine.
>=20
> Philippe, should your fix work in my case too?=20

I have no idea which platform you are running your code on, so my answer
won't be specific, but in short: it is unlikely. This could rather be an
application error. You may want to try the failing code in a small
standalone unit test, and post that code to the list if it still fails
in that context, so we could have a look.

> If so, can you please
> send the fix.
>=20
> thanks
> Abhijit
>=20
> -----Original Message-----
> From: xenomai-help-bounces@domain.hid
[mailto:xenomai-help-bounces@domain.hid]
> On Behalf Of Philippe Gerum
> Sent: Sunday, May 16, 2010 2:58 PM
> To: Steve Deiters
> Cc: xenomai@xenomai.org
> Subject: Re: [Xenomai-help] rt_task_sleep causing crashes on PowerPC
>=20
> On Fri, 2010-05-14 at 19:18 -0500, Steve Deiters wrote:
> > I am running Xenomai 2.5.3, I-pipe version 2.9-00, with Linux
2.6.33.4
> > on a PowerPC MPC5121.  With small values of sleep ticks passed to
> > rt_task_sleep, I get various sorts of crashes.  Here is a simple
> program
> > using a delay loop that exhibits the behavior.
>=20
> <snip>
>=20
> >=20
> > I'm not sure if I have something misconfigured or what.  I am
> upgrading
> > from Xenomai 2.4.10 on an older kernel and I did not have this same
> > problem.
> >=20
>=20
> Bug confirmed here. Your setup is not involved, I'll send a fix asap.
>=20
> > Thanks.
> >=20
> >=20
> > _______________________________________________
> > Xenomai-help mailing list
> > Xenomai-help@domain.hid
> > https://mail.gna.org/listinfo/xenomai-help
>=20
>=20


--=20
Philippe.



------_=_NextPart_001_01CB0D82.8A5471D0
Content-Type: application/octet-stream;
	name="sleeptest.c"
Content-Transfer-Encoding: base64
Content-Description: sleeptest.c
Content-Disposition: attachment;
	filename="sleeptest.c"

CiNpbmNsdWRlIDxzdGRpby5oPgojaW5jbHVkZSA8c3RkbGliLmg+CiNpbmNsdWRlIDx1bmlzdGQu
aD4KI2luY2x1ZGUgPHNpZ25hbC5oPgojaW5jbHVkZSA8cG9zaXguaD4KI2luY2x1ZGUgPHB0aHJl
YWQuaD4KCmJvb2wgdGVybWluYXRlID0gZmFsc2U7CgoKcHRocmVhZF90IHRhc2sxOwpwdGhyZWFk
X2F0dHJfdCBhdHRyMTsKc3RydWN0IHNjaGVkX3BhcmFtIHNjaDE7CgoKdm9pZCogZnVuY190YXNr
MSh2b2lkICphcmcpewoKICB0aW1lc3BlYyBpbnRlcnZhbDsKICBpbnQgZXJyID0gMDsKCiAgd2hp
bGUgKCF0ZXJtaW5hdGUpewogICAgLy9wcmludGYoImluc2lkZSB3aGlsZSBsb29wIFxuIik7Cgog
ICAgaW50ZXJ2YWwudHZfc2VjID0gMDsKICAgIGludGVydmFsLnR2X25zZWMgPSAxMDAwMDsKCiAg
ICBpZiAoKGVyciA9IGNsb2NrX25hbm9zbGVlcChDTE9DS19SRUFMVElNRSwgMCwgJmludGVydmFs
LCBOVUxMKSkgIT0gMCl7CiAgICAgIHByaW50ZigiY2xvY2sgbmFub3NsZWVwIGZhaWxlZCBcbiIp
OwogICAgICBpZiAoZXJyID09IEVJTlRSKQogICAgICAgIHByaW50ZigiSW50ZXJydXB0ZWQgYnkg
c2lnbmFsIFxuIik7CiAgICAgIGVsc2UgaWYgKGVyciA9PSBFSU5WQUwpCiAgICAgICAgcHJpbnRm
KCJpbnRlcnZhbCBpcyBvdXQgb2YgcmFuZ2UgXG4iKTsKICAgICAgZWxzZSBpZiAoZXJyID09IEVO
T1RTVVApCiAgICAgICAgcHJpbnRmKCJjbG9jayBJRCBpcyBub3Qgc3VwcG9ydGVkIFxuIik7Cgog
ICAgICBicmVhazsKICAgIH0KICB9CgogIHByaW50ZigiZW5kIG9mIHRhc2sxIFxuIik7CiAgcmV0
dXJuIE5VTEw7Cn0KCgp2b2lkIGhhbmRsZVNodXRkb3duU2lnbmFsKGludCBzaWcpIHsKICB0ZXJt
aW5hdGUgPSB0cnVlOwoKICBzbGVlcCgxKTsKCiAgcHRocmVhZF9jYW5jZWwodGFzazEpOwoKICBw
dGhyZWFkX2F0dHJfZGVzdHJveSgmYXR0cjEpOwoKICBwcmludGYoIlxuUHJvZ3JhbSByZWFjaGVz
IGVuZFxuIik7Cn0KCgoKaW50IG1haW4oKXsKCiAgLyogbm8gbWVtb3J5LXN3YXBwaW5nIGZvciB0
aGlzIHByb2dyYW1tICovCiAgbWxvY2thbGwoTUNMX0NVUlJFTlQgfCBNQ0xfRlVUVVJFKTsKCiAg
c2lnbmFsKFNJR1RFUk0sIGhhbmRsZVNodXRkb3duU2lnbmFsKTsKICBzaWduYWwoU0lHSU5ULCBo
YW5kbGVTaHV0ZG93blNpZ25hbCk7CgogIGludCBlcnIgPSAwOwoKICBwdGhyZWFkX2F0dHJfaW5p
dCgmYXR0cjEpOwogIHB0aHJlYWRfYXR0cl9zZXRpbmhlcml0c2NoZWQoJmF0dHIxLFBUSFJFQURf
RVhQTElDSVRfU0NIRUQpOwogIHB0aHJlYWRfYXR0cl9zZXRzY2hlZHBvbGljeSgmYXR0cjEsIFND
SEVEX0ZJRk8pOwogIHNjaDEuc2NoZWRfcHJpb3JpdHkgPSA5MDsKICBwdGhyZWFkX2F0dHJfc2V0
c2NoZWRwYXJhbSgmYXR0cjEsICZzY2gxKTsKCiAgcHJpbnRmKCJwcm9ncmFtIHN0YXJ0ZWQgXG4i
KTsKCiAgZXJyID0gcHRocmVhZF9jcmVhdGUoJnRhc2sxLCAmYXR0cjEsIGZ1bmNfdGFzazEsIE5V
TEwpOwoKICBpZiAoZXJyKXsKICAgIHByaW50ZigidGFzazEgdGhyZWFkIGNvdWxkIG5vdCBiZSBj
cmVhdGVkICVkXG4iLCBlcnIpOwogICAgcmV0dXJuIGVycjsKICB9CgogIHBhdXNlKCk7CgogIHJl
dHVybiAwOwoKCn0KCg==

------_=_NextPart_001_01CB0D82.8A5471D0--

