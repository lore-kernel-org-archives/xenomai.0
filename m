From: Sagi Maimon <SMaimon@advaoptical.com>
Date: Tue, 31 Mar 2015 06:23:54 +0000
Message-ID: <2b2ffe256e0547af996997c833660a44@MUC-S-EX13B.advaoptical.com>
References: <7615c5d3d380485499b229435e14ee65@MUC-S-EX13B.advaoptical.com>
 <55195485.9070302@xenomai.org>
In-Reply-To: <55195485.9070302@xenomai.org>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Xenomai] Using xenomai posix routines instead of Linux POSIX
 routines
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>, "xenomai@xenomai.org" <xenomai@xenomai.org>

Hi,=20
thanks for the help.
I have read the document, and the use of wrapper makes good sense.=20
According to the document, when calling "pthread_create" (by using the XENO=
_POSIX_LIBS flags),  it will call  "__wrap_pthread_create" routine.
But I am using Xenomai 2.6.4 , and there is no implementation of "__wrap_pt=
hread_create" routine,=20
instead there is implementation of "pthread_create" under  kernel/xenomai/s=
kins/posix/thread.c

Can you please explain it?

Thanks,

Sagi

-----Original Message-----
From: Philippe Gerum [mailto:rpm@xenomai.org]=20
Sent: Monday, March 30, 2015 16:50
To: Sagi Maimon; xenomai@xenomai.org
Subject: Re: [Xenomai] Using xenomai posix routines instead of Linux POSIX =
routines

On 03/30/2015 03:40 PM, Sagi Maimon wrote:
> Hi,
>=20
> Until now I have created RT xenomai threads, by using the skin native API=
:
> kernel/xenomai/skins/native/task.c  (rt_task_create routine)
>=20
> and for creating Linux threads, I have used the "pthread_create" routine =
(.../powerpc-e300c3-linux-gnu/usr/lib/libpthread.so)
>=20
> xenomai also implements POSIX API:
> kernel/xenomai/skins/posix/thread.c
> And by looking at the code (and according to documentation), by calling "=
pthread_create" routine , xenomai creates RT threads.
>=20
>=20
> My question:
> I want to use the xenomai POSIX API, so How can I use the xenomai  "pthre=
ad_create" routine, instead of the one from (.../powerpc-e300c3-linux-gnu/u=
sr/lib/libpthread.so)?
> should I add something to my Makefile?
> Should I remove "-lpthread" parameter from my application Makefile?
>=20

This document explains how to create real-time POSIX applications with
Xenomai:

http://xenomai.org/2014/08/porting-a-linux-application-to-xenomai-dual-kern=
el/#Compilation_for_the_Xenomai_POSIX_skin

--=20
Philippe.

