Message-ID: <ac3922a00609280338n59d81a59x7eba1d1b09b5d1c@domain.hid>
Date: Thu, 28 Sep 2006 12:38:06 +0200
From: "Syed Amer Gilani" <amg@domain.hid>
Sender: groove.c@domain.hid
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Subject: [Xenomai-help] building cyclic testsuit
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

The "make install" part of installation breaks with following error:

../../skins/posix/.libs/libpthread_rt.a(libpthread_rt_la-init.o): In
function `__init_posix_interface':
init.c:(.text+0x280): undefined reference to `pthread_atfork'
collect2: ld returned 1 exit status
make[3]: *** [cyclictest] Fehler 1
make[3]: Leaving directory `/home/amg/xenobuild/src/testsuite/cyclic'
make[2]: *** [install-recursive] Fehler 1
make[2]: Leaving directory `/home/amg/xenobuild/src/testsuite'
make[1]: *** [install-recursive] Fehler 1
make[1]: Leaving directory `/home/amg/xenobuild/src'
make: *** [install-recursive] Fehler 1

how can i fix this?
simply skipping cyclic does not work with "--without--cyclic" or
"--disable-cyclic"

Regards,
Syed Amer Gilani

