Date: Thu, 16 Apr 2020 13:04:38 -0500 (CDT)
From: Per Oberg <pero@wolfram.com>
Message-ID: <1173354937.92265.1587060278568.JavaMail.zimbra@wolfram.com>
In-Reply-To: <37888427.83114.1587056423222.JavaMail.zimbra@wolfram.com>
References: <2018325684.72682.1587053305425.JavaMail.zimbra@wolfram.com>
 <VI1PR05MB59172B3C0D8909BD37F9E947F6D80@VI1PR05MB5917.eurprd05.prod.outlook.com>
 <37888427.83114.1587056423222.JavaMail.zimbra@wolfram.com>
Subject: Re: RTNet and setsockopt
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai <xenomai@xenomai.org>

----- Den 16 apr 2020, p=C3=A5 kl 19:00, xenomai xenomai@xenomai.org skrev:
> ----- Den 16 apr 2020, p=C3=A5 kl 18:32, Lange Norbert norbert.lange@andr=
itz.com
> skrev:

> > Hello Per,

> > setsockopt is supported by rtnet (and wrapped with the POSIX skin). Tha=
t said,
> > it supports very little options you are used from Linux. Do a grep -r o=
n
> > xenomais sources.
> > Xenomai mostly uses ioctls for bringing up Interfaces, etc.

> > There are subtile differences and limitations aswell. I am pretty sure =
now that
> > most operations
> > are behaving like you have an nonblocking filedescriptor / socket. The =
RT focus
> > means that there
> > typically is just a check if buffers are available, and no effort is ma=
de for
> > waiting.
> > So select will be your best friend.
> > (I am just using packet sockets, but I believe it=E2=80=99s the same fo=
r all of them).

> Thanks, I readded the list again. The reason I started looking into this =
is that
> I had issues with blocking sends. I wanted to see what happened if I pull=
ed the
> plug on the ethernet and tried to recover afterwards.

> Digging around a bit is seems like I might actually have a compiler flag =
issue
> (again...). I tried compiling my network code as a shared library.

Progress, i guess. It was the read that was became non blocking.

Still: I believe that "setsockopt" is missing for PF_PACKET, SOCK_RAW. I ca=
n se that it is implemented for some of the packet types but there is no re=
ference to it in af_packet.c.

That said, I don't see how setsockopt is mapped to the different variants. =
I can se how recv and recfrom is mapped using the structure with the ".recv=
from =3D xxx" syntax but setsockopt seems to be different.

Also, when looking in the code i see that "MSG_DONTWAIT" is supported for r=
t_packet_recvmsg and that it sets sock->timeout to -1. So it seems a small =
fix to make this work, if I only knew where how setsockopt was mapped..

> > Norbert Lange

> > > -----Original Message-----
> > > From: Xenomai <xenomai-bounces@xenomai.org> On Behalf Of Per Oberg vi=
a
> > > Xenomai
> > > Sent: Donnerstag, 16. April 2020 18:08
> > > To: xenomai <xenomai@xenomai.org>
> > > Subject: RTNet and setsockopt

> > > NON-ANDRITZ SOURCE: BE CAUTIOUS WITH CONTENT, LINKS OR
> > > ATTACHMENTS.

> > > Dear list

> > > I am "porting" a posix application using raw network packages to RTNe=
t. The
> > > old code is trying to use setsockopt and ioctl. The calls I am trying=
 to use are

> > > setsockopt:
> > > SO_RCVTIMEO
> > > SO_SNDTIMEO
> > > SO_DONTROUTE

> >> These return "No such device". I guess that this is because setsockopt=
 is not
> > > rt-
> > > compatible, correct ? ( There seem to be no corresponding rt_setsocko=
pt... )

> > > ioctl :
> > > IFF_PROMISC | IFF_BROADCAST

> > > These return "Operation not supported".

> > > My code works fairly well as it is, and I probably do not need SO_DON=
TROUTE,
> > > IFF_PROMISC, and IFF_BROADCAST with rtnet. I would, however, like to =
have
> > > SO_RCVTIMEO, SO_SNDTIMEO or nonblock. Do I need to use O_NONBLOCK
> > > together with send() instead or am I missing something ?

> > > Best Regards
> > > Per =C3=96berg

> > ________________________________

> > This message and any attachments are solely for the use of the intended
> > recipients. They may contain privileged and/or confidential information=
 or
> > other information protected from disclosure. If you are not an intended
> > recipient, you are hereby notified that you received this email in erro=
r and
> > that any review, dissemination, distribution or copying of this email a=
nd any
> > attachment is strictly prohibited. If you have received this email in e=
rror,
> > please contact the sender and delete the message and any attachment fro=
m your
> > system.

> > ANDRITZ HYDRO GmbH

> > Rechtsform/ Legal form: Gesellschaft mit beschr=C3=A4nkter Haftung / Co=
rporation

> > Firmensitz/ Registered seat: Wien

> > Firmenbuchgericht/ Court of registry: Handelsgericht Wien

> > Firmenbuchnummer/ Company registration: FN 61833 g

> > DVR: 0605077

> > UID-Nr.: ATU14756806

> > Thank You
> > _________

> Thanks
> Per =C3=96berg

Thanks
Per =C3=96berg=20

