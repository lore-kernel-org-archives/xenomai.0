Message-ID: <1400327913.49772.YahooMailNeo@web171604.mail.ir2.yahoo.com>
Date: Sat, 17 May 2014 12:58:33 +0100 (BST)
From: Matthias Schneider <ma30002000@yahoo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Subject: [Xenomai] cobalt kernel compile issue
Reply-To: Matthias Schneider <ma30002000@yahoo.de>
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "xenomai@xenomai.org" <xenomai@xenomai.org>

This commit=0A=0A8ac3db811d2150434a35fefca5bd3b467139f6e8 cobalt/rtdm: extr=
act fd API=0A=0Aseems to be the cause for the following kernel/cobalt compi=
le issue:=0A=0Ainclude/trace/events/cobalt-rtdm.h: In function 'ftrace_raw_=
event_fd_event':=0Ainclude/trace/events/cobalt-rtdm.h:27:15: error: incompa=
tible types=A0=0Awhen assigning to type 'int' from type 'struct rtdm_fd'=0A=
=A0 =A0__entry->fd =3D context->fd;=0A=0A[...]=0A=0AIt appears that file rt=
dm file descriptors are struct rtdm_fd now=0Ainstead of=A0ints, leaving the=
 trace implementation in need of=0Aadaptation.=0A=0ARegards,=0AMatthias

