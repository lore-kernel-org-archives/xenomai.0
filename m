MIME-Version: 1.0
Date: Mon, 23 Feb 2009 12:16:34 -0800
Message-ID: <67b6b3430902231216k11c5addahaafef823075e7e54@domain.hid>
From: Mark Saiia <mark.saiia@domain.hid>
Content-Type: multipart/alternative; boundary=00221532cba0d4195704639badec
Subject: [Xenomai-help] Error building 2.6.27.19 w/
	adeos-ipipe-2.6.27.19-x86-2.2-06.patch
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

--00221532cba0d4195704639badec
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

When building 2.6.27.19 w/ adeos-ipipe-2.6.27.19-x86-2.2-06.patch. I get the
following error.

CC      kernel/xenomai/arch/generic/hal.o
kernel/xenomai/arch/generic/hal.c: In function 'rthal_irq_host_pend':
kernel/xenomai/arch/generic/hal.c:301: error: void value not ignored as it
ought to be


Has anyone else ran into this issue?

Deleting the return on that line appears to fix the issue.

Mark Saiia

--00221532cba0d4195704639badec
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

When building 2.6.27.19 w/ adeos-ipipe-2.6.27.19-x86-2.2-06.patch. I get th=
e following error.<br><br>CC&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kernel/xenomai/a=
rch/generic/hal.o<br>kernel/xenomai/arch/generic/hal.c: In function 'rthal_=
irq_host_pend':<br>kernel/xenomai/arch/generic/hal.c:301: error: void value=
 not ignored as it ought to be<br>
<br><br>Has anyone else ran into this issue?&nbsp; <br><br>Deleting the ret=
urn on that line appears to fix the issue.<br><br>Mark Saiia<br><br>

--00221532cba0d4195704639badec--

