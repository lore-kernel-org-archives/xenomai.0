Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 22 Oct 2007 11:45:41 +0200
Message-ID: <0B45E93C5FF65740AEAE690BF3848B7A4AB256@domain.hid>
From: "Fillod Stephane" <stephane.fillod@domain.hid>
Subject: Re: [Xenomai-core] Xenomai v2.4-rc4: freeze with RTAI skin,
	fine with other skins
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

Hi Gilles,

Thanks for the quick reply.

Gilles Chanteperdrix wrote:
> A case of freeze is a system call called in a loop which fails without
its return value being checked.

I forget to say that the RTAI application is running in kernel land,
because
no port of the RTAI skin has been made yet to user land (in fact, only
shm access).
So, can it still be a system call in a loop issue? Besides, the xeno=20
watchdog is not kicking.
Once freezed, the box does not respond to ping, so this is not a
SCHED_FIFO task stuck either.
Still searching..
--=20
Stephane

