MIME-Version: 1.0
Date: Mon, 31 Jan 2011 09:55:33 +0100
Message-ID: <AANLkTi=7M-cqps4b--i6Kud3o6-awuntk2Zpwj7JHZ8a@domain.hid>
From: gryma biloy <gryma.biloy@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Subject: [Xenomai-help] Is xenomai OK for early boot purpose ?
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org

Hello,

On a project running Linux on a beagle board, I'd like to add the
following capabilities to my platform :
=A0 - real time processes with periodic tasks (10ms, 100ms & 200 ms) and
a low jitter (< 50 us)
=A0 - early boot operations (i.e. being able to perform some tasks asap
after a power on reset)

I've searched for solutions over the net and Xenomai seems to be a
possible candidate to fulfill
these constraints. Can you please share your knowledge to confirm that
Xenomai would make
the job (especially on the early boot side) ?

Also, I don't have a clear understanding of Xenomai availability
during the Linux kernel startup.
If a statically link Xenomai to the kernel, when would it be operational ?

Thanks a lot for your help,

--
Gryma

