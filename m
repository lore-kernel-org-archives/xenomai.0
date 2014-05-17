Message-ID: <1400327350.427.YahooMailNeo@web171605.mail.ir2.yahoo.com>
Date: Sat, 17 May 2014 12:49:10 +0100 (BST)
From: Matthias Schneider <ma30002000@yahoo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Subject: [Xenomai] Round-robin scheduling on cobalt
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

Hi all,=0A=0AWhen enabling rr schduling on cobalt via threadobj_set_rr(),  =
the call will be=A0=0Aforwarded to the cobalt-specific set_rr(). This funct=
ion will then call=A0=0Apthread_setschedparam_ex(), which in turn calls lib=
c_setschedparam() for=A0=0Aupdating the regular kernels view on the rr task=
. However, when using prios >=A0=0A99, libc_setschedparam() will clip them =
for SCHED_COBALT / SCHED_RT, SCHED_TP,=A0=0ASCHED_SPORADIC, SCHED_QUOTA, bu=
t not for SCHED_RR, leading to an EINVAL error.=A0=0AMercury maps rr schedu=
ling to SCHED_FIFO. Shouldnt cobalt also register rr tasks=A0=0Aas SCHED_FI=
FO and clip their prio? i.e. add SCHED_RR to the fall-through case=A0=0Alis=
t of in libc_setschedparam()?=0A=0AThanks in advance,=0A=0AMatthias

