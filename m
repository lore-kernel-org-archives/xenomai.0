Message-ID: <1390939945.5452.YahooMailNeo@web171602.mail.ir2.yahoo.com>
Date: Tue, 28 Jan 2014 20:12:25 +0000 (GMT)
From: Matthias Schneider <ma30002000@yahoo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Subject: [Xenomai] atomic_sub_fetch in atomic.h
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

Hi all,=0A=0Ashouldn't=A0=0A=0A#define atomic_sub_fetch(v, n) =A0_sync_sub_=
and_fetch(&(v), n)=A0=0A=A0=0Ain file include/nocore/atomic.h line 48 of xe=
nomai-forge be rather=0A=0A#define atomic_sub_fetch(v, n) =A0__sync_sub_and=
_fetch(&(v), n)=0A=0A?=A0=0AIt is not used by the current code anyway, but =
does not compile when trying to=A0=0Ado so..=0A=0AThanks,=0A=0AMatthias=0A

