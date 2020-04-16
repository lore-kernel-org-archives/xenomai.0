Date: Thu, 16 Apr 2020 12:00:23 -0500 (CDT)
From: Per Oberg <pero@wolfram.com>
Message-ID: <37888427.83114.1587056423222.JavaMail.zimbra@wolfram.com>
In-Reply-To: <VI1PR05MB59172B3C0D8909BD37F9E947F6D80@VI1PR05MB5917.eurprd05.prod.outlook.com>
References: <2018325684.72682.1587053305425.JavaMail.zimbra@wolfram.com>
 <VI1PR05MB59172B3C0D8909BD37F9E947F6D80@VI1PR05MB5917.eurprd05.prod.outlook.com>
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

----- Den 16 apr 2020, p=C3=A5 kl 18:32, Lange Norbert norbert.lange@andrit=
z.com skrev:

> Hello Per,

> setsockopt is supported by rtnet (and wrapped with the POSIX skin). That =
said,
> it supports very little options you are used from Linux. Do a grep -r on
> xenomais sources.
> Xenomai mostly uses ioctls for bringing up Interfaces, etc.

> There are subtile differences and limitations aswell. I am pretty sure no=
w that
> most operations
> are behaving like you have an nonblocking filedescriptor / socket. The RT=
 focus
> means that there
> typically is just a check if buffers are available, and no effort is made=
 for
> waiting.
> So select will be your best friend.
> (I am just using packet sockets, but I believe it=E2=80=99s the same for =
all of them).

Thanks, I readded the list again. The reason I started looking into this is=
 that I had issues with blocking sends. I wanted to see what happened if I =
pulled the plug on the ethernet and tried to recover afterwards.=20

Digging around a bit is seems like I might actually have a compiler flag is=
sue (again...). I tried compiling my network code as a shared library.

> Norbert Lange

> > -----Original Message-----
> > From: Xenomai <xenomai-bounces@xenomai.org> On Behalf Of Per Oberg via
> > Xenomai
> > Sent: Donnerstag, 16. April 2020 18:08
> > To: xenomai <xenomai@xenomai.org>
> > Subject: RTNet and setsockopt

> > NON-ANDRITZ SOURCE: BE CAUTIOUS WITH CONTENT, LINKS OR
> > ATTACHMENTS.


> > Dear list

> > I am "porting" a posix application using raw network packages to RTNet.=
 The
> > old code is trying to use setsockopt and ioctl. The calls I am trying t=
o use are

> > setsockopt:
> > SO_RCVTIMEO
> > SO_SNDTIMEO
> > SO_DONTROUTE

>> These return "No such device". I guess that this is because setsockopt i=
s not
> > rt-
> > compatible, correct ? ( There seem to be no corresponding rt_setsockopt=
... )


> > ioctl :
> > IFF_PROMISC | IFF_BROADCAST

> > These return "Operation not supported".

> > My code works fairly well as it is, and I probably do not need SO_DONTR=
OUTE,
> > IFF_PROMISC, and IFF_BROADCAST with rtnet. I would, however, like to ha=
ve
> > SO_RCVTIMEO, SO_SNDTIMEO or nonblock. Do I need to use O_NONBLOCK
> > together with send() instead or am I missing something ?

> > Best Regards
> > Per =C3=96berg

> ________________________________

> This message and any attachments are solely for the use of the intended
> recipients. They may contain privileged and/or confidential information o=
r
> other information protected from disclosure. If you are not an intended
> recipient, you are hereby notified that you received this email in error =
and
> that any review, dissemination, distribution or copying of this email and=
 any
> attachment is strictly prohibited. If you have received this email in err=
or,
> please contact the sender and delete the message and any attachment from =
your
> system.

> ANDRITZ HYDRO GmbH

> Rechtsform/ Legal form: Gesellschaft mit beschr=C3=A4nkter Haftung / Corp=
oration

> Firmensitz/ Registered seat: Wien

> Firmenbuchgericht/ Court of registry: Handelsgericht Wien

> Firmenbuchnummer/ Company registration: FN 61833 g

> DVR: 0605077

> UID-Nr.: ATU14756806

> Thank You
> _________

Thanks
Per =C3=96berg

