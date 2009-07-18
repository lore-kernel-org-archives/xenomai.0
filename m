Content-Class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Date: Sat, 18 Jul 2009 11:50:55 +0200
Message-ID: <899865CA54E4444DAF2E3639C04C5F4806005D@trillian.at.omicron.at>
From: Richard Cochran <richard.cochran@domain.hid>
Subject: [Xenomai-core] Strange results with ARM EABI, gcc 4.3.2
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai@xenomai.org

A certain xenomai project on ARM Linux of mine has been working fine
using gcc 3.4.5. I wanted to use a more recent compiler and the EABI,
so I used a default setting from crosstool-NG-1.4.1, which produces
gcc version 4.3.2.

However, I get the following result running the trivial-periodic
example program:

# ./trivial-periodic &
# cat /proc/xenomai/sched=20
CPU  PID    PRI      PERIOD     TIMEOUT    TIMEBASE  STAT       NAME
  0  0       -1      0          0          master    R          ROOT
  0  850     99      1000000000 79513195085358725 master    D          =
trivial

Looks like I will be waiting a long, long time for the timeout ;^)
Any ideas?

Thanks,
Richard


