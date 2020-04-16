Date: Thu, 16 Apr 2020 11:08:25 -0500 (CDT)
From: Per Oberg <pero@wolfram.com>
Message-ID: <2018325684.72682.1587053305425.JavaMail.zimbra@wolfram.com>
Subject: RTNet and setsockopt
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

Dear list

I am "porting" a posix application using raw network packages to RTNet. The=
 old code is trying to use setsockopt and ioctl. The calls I am trying to u=
se are=20

setsockopt:=20
 SO_RCVTIMEO
 SO_SNDTIMEO
 SO_DONTROUTE

These return "No such device". I guess that this is because setsockopt is n=
ot rt-compatible, correct ? ( There seem to be no corresponding rt_setsocko=
pt... )

ioctl :
 IFF_PROMISC | IFF_BROADCAST

These return "Operation not supported".=20

My code works fairly well as it is, and I probably do not need SO_DONTROUTE=
, IFF_PROMISC, and IFF_BROADCAST with rtnet. I would, however, like to have=
 SO_RCVTIMEO, SO_SNDTIMEO or nonblock. Do I need to use O_NONBLOCK together=
 with send() instead or am I missing something ?

Best Regards
Per =C3=96berg=20

