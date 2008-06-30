MIME-Version: 1.0
Date: Mon, 30 Jun 2008 09:52:31 +0200
From: Matthieu <matthieu.connaulte_xenomai@domain.hid>
Message-ID: <ba6c897fac979ba4210b412b6456b10c@domain.hid>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: [Xenomai-help] xntbase use
Reply-To: matthieu.connaulte_xenomai@domain.hid
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org

Hi,

I tried to use xntbase interface in userspace just to get the time in
nanoseconds of the master time base with xntbase_get_time(&nktbase),
including nucleus/timebase.h. But I've an error: 'nktbase' was not declar=
ed
in this scope
error: 'xntbase_get_time' was not declared in this scope

xntbase_get_time is said to be usable in user space, so I don't understan=
d
the problem ?

Matthieu



