Date: Tue, 12 Mar 2019 03:18:39 -0500 (CDT)
From: Per Oberg <pero@wolfram.com>
Message-ID: <1581388606.618666.1552378719905.JavaMail.zimbra@wolfram.com>
Subject: Re: Using RTnet to communicate with regular UDP socket
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
Cc: xenomai <xenomai@xenomai.org>

Hi=20


019, p=C3=A5 kl 17:20, xenomai xenomai@xenomai.org skrev:=20
> Hi everyone=EF=BC=9A=20
> I am using xenomai + RTnet in Ubuntu=EF=BC=8CXenomai version 3.0.5 Linux =
kernal version=20
> 4.9.38. And the ethernet card is Intel e1000.=20

> I'm going to use RTnet to communicate with regular UDP socket like a sock=
et in=20
> raw Linux . I need to implement two way communication between Xenomai and=
=20
> another device witch is using regular UDP socket. In other words, RTnet s=
ocket=20
> in Xenomai should sent datagram to the regular UDP socket . If the regula=
r UDP=20
> protocol can decode the rt-udp datagram and get right data? Besides, RTne=
t=20
> socket in Xenomai should also receive datagram from regular UDP protocol,=
 so if=20
> the rt-udp in Xenomai can decode the regular UDP datagram?=20
> Thanks for everyone who spend time to give me some help!=20

Afaik, when you use the posix skin you may use the same UDP code in Xenomai=
 as in regular Posix/Linux as long as you compile your program with the rig=
ht flags. If your network destination/source is a RTNet address it will cal=
l the rt functions and if its an address belonging to the regular network i=
t will call the regular linux code.=20

Per =C3=96berg=20
