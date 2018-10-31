From: "Pham, Phong" <phamp@ddc-web.com>
Subject: RE: [Xenomai] [PATCH 0/4] net/tcp: Fix several bugs and allow rttcp
 to be built
Date: Wed, 31 Oct 2018 16:55:04 +0000
Message-ID: <C2EC5BA46D13CD44B5915A8FEEB4C44EE545BC96@DDCEXCH.ddc-ny.com>
References: <1539775907-5124-1-git-send-email-sebastian.smolorz@gmx.de>
 <2247681.JhopzYo4NN@lenni>
 <C2EC5BA46D13CD44B5915A8FEEB4C44EE545BBF2@DDCEXCH.ddc-ny.com>
 <7041379.eS1cmEbPlD@lenni>
In-Reply-To: <7041379.eS1cmEbPlD@lenni>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Sebastian Smolorz <Sebastian.Smolorz@gmx.de>
Cc: Jan Kiszka <jan.kiszka@siemens.com>, "xenomai@xenomai.org" <xenomai@xenomai.org>, "Hillman, Robert" <hillman@ddc-web.com>


Hi Sebastian,

The issue has to do with endianness.  We are running PowerPC (big endian). =
 So in rt_tcp_set_flags(), flags is 32-bit wide and *tf is 16-bit wide.  I =
modified the line
from:

*tf =3D flags;

to

*tf =3D *(__be16 *)&flags;

and that does the job.

Now I encounter a different problem,

recv() returns 0 bytes but I know my FTP server sends a packet (seen by Wir=
eShark).  Can you point me where is the recv() implemented in tcp.c?  Is it=
 rt_tcp_rcv or rt_tcp_recvmsg?

Phong.


-----Original Message-----
From: Sebastian Smolorz [mailto:Sebastian.Smolorz@gmx.de]
Sent: Wednesday, October 31, 2018 7:08 AM
To: Pham, Phong
Cc: Jan Kiszka; xenomai@xenomai.org; Hillman, Robert
Subject: Re: [Xenomai] [PATCH 0/4] net/tcp: Fix several bugs and allow rttc=
p to be built

Pham, Phong wrote:
> This is what I see when my RTnet box, my laptop, and my FTP server
> (local on laptop) is on the same subnet 192.168.7.0:
>
> 192.168.7.79 is my RTnet box.

Which processor architecture is it?

> I used my laptop (192.168.7.106) to
> ping the RTnet box which is what you see with ICMP protocol.  The
> first TCP packet sent by my RTnet box (packet # 11) has the SYN bit
> not set.  (see attached image.  I pulled in your patch along with the
> patch named "rtdm: add integer file descriptor to struct rtdm_fd" to
> get TCP to compile.

So you don't use latest next? Do you use stable? Did you made changes to
the source code we are not aware of?

> Any advice you may have?  Do you know which
> relevant routine goes and set the TCP SYN bit that I can start
> looking?

It is set in rt_tcp_connect() line 1536:

ret =3D rt_tcp_send(ts, TCP_FLAG_SYN);

in kernel/drivers/net/stack/ipv4/tcp/tcp.c

--
Sebastian



Notice: This e-mail and any files transmitted with it may contain Data Devi=
ce Corporation's and its subsidiaries privileged and proprietary informatio=
n. It is intended solely for the use of the individual or entity to whom it=
 is addressed. If you are not the named recipient of this transmission, any=
 disclosure, copying, distribution or reliance on the contents of this mess=
age is prohibited. If you received this e-mail in error, please destroy it =
and any attached files and notify me immediately.

Click Here<http://www.ddc-web.com/Profile/EmailPrivacy.aspx> to view our pr=
ivacy statement.

