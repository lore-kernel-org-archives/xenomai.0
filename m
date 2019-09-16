Date: Mon, 16 Sep 2019 02:32:08 -0500 (CDT)
From: Per Oberg <pero@wolfram.com>
Message-ID: <2078452807.5749189.1568619128144.JavaMail.zimbra@wolfram.com>
Subject: RTDM open, open_rt, and open_nrt
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

Hello list

I am trying to understand how rtdm works, and possibly why out of a histori=
cal context. Perhaps there is a good place to read up on this stuff, then p=
lease let me know.=20

It seems like in the rtdm-api there is only open, but no open_rt or open_nr=
t.=20
More specifically we have:=20
- read_rt  / read_nrt
- recvmsg_rt / recvmsg_nrt
- ioctl_rt / ioctl_nrt
- .. etc.

However, when studying an old xenomai2->3 ported driver it seems like there=
 used to be open_rt and open_nrt. The problem I was having before (see my b=
ackground comment below) was because the open had been mapped to the old op=
en_nrt code, which in turned used a rt-lock, thus a mix of the two. When sw=
itching to a regular mutex it "worked", as in it didn't complain.=20

In a short discussion Jan Kiszka gave me the impression that open could pos=
sibly end up being rt or nrt depending on situation.=20

P=C3=96: I'm guessing that open is always non-rt and therefore a rtdm_lock =
should be used? ...

JK: This depends. If the open code needs to synchronize only with other non=
-RT
JK: paths, normal Linux locks are fine. If there is the need to sync with t=
he
JK: interrupt handler or some of the _rt callbacks, rtdm_lock & Co. is need=
ed.


So, how does this work? And why was (if it was) open_nrt and open_rt replac=
ed with a common open?


Background
----------------
I recently wrote about a driver which warned about "drvlib.c:1349 rtdm_mute=
x_timedlock". I got good answers which led me to some more general question=
s, but instead of continuing in the old tread I thought it better to start =
a new one since it's not about the initial problem. The driver in case is t=
he Peak Linux Driver for their CAN hardware, see [1]


[1] https://www.peak-system.com/fileadmin/media/linux/index.htm


Best regards
Per =C3=96berg=20

