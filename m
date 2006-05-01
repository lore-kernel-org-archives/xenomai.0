Message-ID: <4455E3D4.8060007@domain.hid>
Date: Mon, 01 May 2006 12:32:52 +0200
From: Wolfgang Grandegger <wg@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-core] UVM build error in todays head of SVN
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai-core <xenomai@xenomai.org>

Hello,

I just checked out Xenomai and realized the UVM build error below (while 
building for PPC 405 with IPIPE tracer).  "xnlock_put/get" seems not to 
be dummy without SMP.

Wolfgang.


if ppc-linux-gcc -DHAVE_CONFIG_H -I. -I. -I../../../../src/include  -O2 
-D_GNU_SOURCE -D_REENTRANT -D__XENO__ -Wall -pipe -D__IN_XENO__ 
-Wstrict-prototypes -I../../../../include -D__XENO_UVM__    -MT pod.o 
-MD -MP -MF ".deps/pod.Tpo" -c -o pod.o pod.c; \
then mv -f ".deps/pod.Tpo" ".deps/pod.Po"; else rm -f ".deps/pod.Tpo"; 
exit 1; fi
pod.c: In function 'xnpod_announce_tick':
pod.c:3304: warning: implicit declaration of function 'xnlock_get'
pod.c:3304: error: 'nklock' undeclared (first use in this function)
pod.c:3304: error: (Each undeclared identifier is reported only once
pod.c:3304: error: for each function it appears in.)
pod.c:3365: warning: implicit declaration of function 'xnlock_put'
make[4]: *** [pod.o] Error 1
make[4]: Leaving directory 
`/.automount/castor-vlab/root/home/wolf/rt/xenomai/src/skins/uvm/nucleus'
make[3]: *** [all-recursive] Error 1
make[3]: Leaving directory 
`/.automount/castor-vlab/root/home/wolf/rt/xenomai/src/skins/uvm'
make[2]: *** [all-recursive] Error 1
make[2]: Leaving directory 
`/.automount/castor-vlab/root/home/wolf/rt/xenomai/src/skins'
make[1]: *** [all-recursive] Error 1
make[1]: Leaving directory 
`/.automount/castor-vlab/root/home/wolf/rt/xenomai/src'
make: *** [all-recursive] Error 1




