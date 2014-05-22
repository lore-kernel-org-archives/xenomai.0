Message-ID: <1400785908.61926.YahooMailNeo@web171606.mail.ir2.yahoo.com>
Date: Thu, 22 May 2014 20:11:48 +0100 (BST)
From: Matthias Schneider <ma30002000@yahoo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Subject: [Xenomai] threadobj_set_schedparam and SCHED_OTHER on mercury
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

Hi,=0A=0ASince commit=0A=A02d102939333201169493688dd91258164bd9737c=0Acoppe=
rplate: more robustness for threadobj_set_schedparam()=0A=0Athreadobj_set_s=
chedparam() seems no longer to allow=A0=0ASCHED_OTHER on mercury,=A0due to =
prepare_rr_corespec() always=A0=0Areturning SCHED_FIFO.=0A=0Ai.e. threadobj=
_set_schedparam( prio 0, SCHED_OTHER) does not work anymore.=0A=0ARegards,=
=0AMatthias

