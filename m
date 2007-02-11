Message-ID: <45CF604F.4030706@domain.hid>
Date: Sun, 11 Feb 2007 20:28:31 +0200
From: Maksym Veremeyenko <verem@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] Strange deadlock.
References: <45CCCD10.9000008@domain.hid> <45CD44EF.6080807@domain.hid>
	<45CD9FD1.9040509@domain.hid>
In-Reply-To: <45CD9FD1.9040509@domain.hid>
Content-Type: text/plain; charset=KOI8-U; format=flowed
Content-Transfer-Encoding: quoted-printable
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: Xenomai-help@domain.hid

Jan Kiszka =D0=C9=DB=C5=D4:

> You are holding the mutex across the serial transaction, i.e. a
> secondary mode switch, right? If you haven't set
> CONFIG_XENO_OPT_RPIDISABLE, you might be are affected by the bug in the
> priority coupling between Xenomai and the Linux kernel. Already tried
> latest v2.3.x SVN?
i tried with r2170 and rewrited code for RT serial - situation the same.

Solution for me is to change tasks priority - set lower priority to task=20
that perform read/write serial driver operations under lock.

Perhaps i should rewrite code to exclude I/O operations under locked=20
mutex at all.


--=20
________________________________________
Maksym Veremeyenko

