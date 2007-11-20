Message-ID: <4b7912400711201144y21e893c0w7e494e1eba20f3b1@domain.hid>
Date: Wed, 21 Nov 2007 03:44:03 +0800
From: "zhangwei zhang" <linda.zhangwei@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Subject: [Xenomai-help] rtai_free & rtai_malloc problem
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

I try to install emc2 on xenomai (x86), the error is like this:

gcc -I/usr/local -I../../../include -g -Wall -DDEBUG -g -O2
-o .libs/usrmot usrmot-usrmotintf.o usrmot-usrmot.o usrmot-emcmotglb.o
usrmot-pid.o usrmot-emcmotlog.o usrmot-emcmotutil.o
-L/home/kyla/eldk/xeno-tux-0.1/src/libnml
/home/kyla/eldk/xeno-tux-0.1/src/libnml/.libs/libnml.so
-L/home/kyla/eldk/xeno-tux-0.1/src/emc/nml_intf
/home/kyla/eldk/xeno-tux-0.1/src/emc/nml_intf/.libs/libemc.a
-L/usr/xenomai/lib /usr/xenomai/lib/libnative.so -Wl,--rpath
-Wl,/usr/xenomai/lib
usrmot-usrmotintf.o: In function `usrmotExit':
/home/kyla/eldk/xenomai-2.3.4/src/emc/iotask/usrmotintf.c:1052:
undefined reference to `rtai_free'
usrmot-usrmotintf.o: In function `usrmotInit':
/home/kyla/eldk/xenomai-2.3.4/src/emc/iotask/usrmotintf.c:1003:
undefined reference to `rtai_malloc'
collect2: ld returned 1 exit status
make[3]: *** [usrmot] Error 1

in rtai, the definition of rtai_free(rt_shm_free) is
in /usr/realtime/include/rtai_shm.h , but in xenomai, no definition
in /usr/xenomai/include/rtai/shm.h but in shm.c of xenomai source code.
How can I modify the code to solve this problem?


Best regards

kyla

