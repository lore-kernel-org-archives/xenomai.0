Message-ID: <1396785025.43347.YahooMailNeo@web171602.mail.ir2.yahoo.com>
Date: Sun, 6 Apr 2014 12:50:25 +0100 (BST)
From: Matthias Schneider <ma30002000@yahoo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Subject: [Xenomai] Deadlock in CANCEL_RESTORE with CONFIG_XENO_ASYNC_CANCEL
	during thread suspension
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

Hi all,=0A=0Ausing xenomai-forge with mercury, when=A0=0ACONFIG_XENO_ASYNC_=
CANCEL is defined, CANCEL_RESTORE=0Awill include a call to backtrace_check(=
), which in turn=0Awill call backtrace_dump, which will take the=0Amutex "_=
_printlock".=0A=0AIn case a thread gets suspended while holding that lock,=
=A0=0Athe next call to CANCEL_RESTORE from whatever thread will=0Acause a d=
eadlock.=A0=0A=0AIs there any way of getting around that?=A0=0A=0ARegards,=
=0AMatthias =0A

