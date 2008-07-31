Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 31 Jul 2008 15:27:36 +0200
Message-ID: <406CC9939904F143B9D42CEEA3E56E563EE0B7@domain.hid>
References: <406CC9939904F143B9D42CEEA3E56E563AC067@domain.hid>	<48918FF9.6030804@domain.hid>
	<406CC9939904F143B9D42CEEA3E56E563AC08E@oab1mx1.oneaccess.intra>
	<489194FD.8000004@domain.hid> <4891AC9B.9020704@domain.hid>
From: "Filip Van Rillaer" <Filip.VanRillaer@domain.hid>
Subject: Re: [Xenomai-help] xnpipe EPOLLIN starvation
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>, rpm@xenomai.org
Cc: xenomai@xenomai.org

Hello Gilles,
=20
The 2nd write at the Xenomai side is coming a lot later.  In fact the
complete flow is a lot more complicated, I'll try to explain it.=20

A) User program in 2nd domain is called xenopipe. This program is using
the epoll interface to synchronize with tty1 and the pipe
B  A driver called rtvcom (emulating a uart) in Xenomai connected to the
other side of the pipe and notified by rt_pipe_monitor of activity on
the pipe.
C) A modem program in Xenomai that is talking to rtvcom

Xenomai modem program <-> rtvcom driver <-> pipe <-> xenopipe user
program <-> tty1 <-> keyboard
                                  =20

1) I press 'A' on my keyboard that is connected to a terminal tty1
2) EPOLLIN and EPOLLOUT from tty1 are received by xenopipe (EPOLLOUT
ignore as there is nottying to write now)
3) xenopipe reads from tty1
4) xenopipe writes to /dev/rtp1
5) rtvcom receives P_EVENT_INPUT (rt_pipe_monitor)
6) rtvcom notifies the modemprogram that new data has arrived and the
modemprogram reads from rtvcom (rt_dev_read), which results in rtvcom
calling rt_pipe_read. So now the 'A' has arrived in the modem program.
7) the modemprogram echo's back the received 'A' so it writes to rtvcom
(rt_dev_write), which results in rtvcom calling rt_pipe_write
8) xenopipe receives EPOLLIN and EPOLLOUT from pipe (EPOLLOUT is ignored
as we have nothing to write now)
9) xenopipe reads the echo-back character from the pipe
10) rtvcom receives P_EVENT_OUTPUT (ignored as it has currently nothing
to do write)
11) xenopipe writes the echo-back character to tty1
12) xenopipe receives EPOLLOUT of tty1 when the HW has sent out the
echo-back character

When I then type a little bit later the character 'T' on my keyboard the
sequence starts again from 2) but stops at 7).

Best regards,
Filip

-----Original Message-----
From: Gilles Chanteperdrix [mailto:gilles.chanteperdrix@xenomai.org
Sent: 31 July 2008 14:14
To: rpm@xenomai.org
Cc: Filip Van Rillaer; xenomai@xenomai.org
Subject: Re: [Xenomai-help] xnpipe EPOLLIN starvation

Philippe Gerum wrote:
> Filip Van Rillaer wrote:
>> Hello Gilles,
>>
>> EPOLLET is indeed enabled.
>> The first time EPOLLIN is received in the 2nd domain, I do a read (it

>> receives 1 byte in a buffer of 256).  So the read is exhausted and I=20
>> expect that the next time data arrives I should get the EPOLLIN (as=20
>> it BECOMES readable).

My point is that, when edge-triggered, you will not get notified if you
receive data while the reading thread has not yet managed to handle the
first notification.

--=20
                                                 Gilles.

