Message-ID: <1404638402.36454.YahooMailNeo@web171603.mail.ir2.yahoo.com>
Date: Sun, 6 Jul 2014 10:20:02 +0100
From: Matthias Schneider <ma30002000@yahoo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Subject: [Xenomai] Question about threadobj_irq_prio
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

Hi all,=0A=0AI was under the expression that the max cobal scheduling prio =
in=A0=0Aforge was now 256 and that SCHED_COBALT had been replaced with=0ASC=
HED_FIFO. Is this correct?=A0=0A=0AAnyway,=0A=0Athreadobj_pkg_init(void) in=
itializes=0Athreadobj_irq_prio =3D __RT(sched_get_priority_max(SCHED_CORE))=
;=0Awhich is still mapping to 258 - however I would rather expect=A0=0A256.=
..=0A=0AThanks for clarification,=0A=0Aregards,=0AMatthias

