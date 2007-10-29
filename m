Message-ID: <472630A3.7020802@domain.hid>
Date: Mon, 29 Oct 2007 12:12:35 -0700
From: Dennis Nguyen <dennisnguy@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format="flowed"
Content-Transfer-Encoding: quoted-printable
Subject: [Xenomai-help] make xenomai/serial/16550A module error
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

I tried to build linux kernel 2.6.20.10 with xenomai 2.3.4 with serial=20
16550A Module (I selected serial 16550A as a M).=20
(adeos-ipipe-2.6.20-i386-1.10-10.patch)

I had an error:
   CC [M]  drivers/xenomai/serial/16550A.o
drivers/xenomai/serial/16550A.c: In function =91rt_16550_open=92:
drivers/xenomai/serial/16550A.c:448: error: incompatible types in assignment
make[3]: *** [drivers/xenomai/serial/16550A.o] Error 1
make[2]: *** [drivers/xenomai/serial] Error 2
make[1]: *** [drivers/xenomai] Error 2
make: *** [drivers] Error 2
[root@domain.hid linux-2.6.20.10]#

Any suggestion please?
Thanks,
Dennis

