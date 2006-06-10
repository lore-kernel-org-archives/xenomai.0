From: Niklaus Giger <niklaus.giger@domain.hid>
Date: Sat, 10 Jun 2006 22:00:17 +0200
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200606102200.17991.niklaus.giger@domain.hid>
Subject: [Xenomai-core] Revision 1182 broke compiling PPC
Reply-To: niklaus.giger@domain.hid
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

Hi Philippe

Your change seems to be broken (at least on PPC). In 
http://ngiger.dyndns.org/buildbot/hcu3/builds/71/step-mk_xeno/0
you will notice near the end
 
gcc -DHAVE_CONFIG_H -I. -I../../../../../build/xenomai/src/skins/vrtx -I../../../src/include -O2 -D_GNU_SOURCE -D_REENTRANT -D__XENO__ -Wall -pipe -D__IN_XENO__ -Wstrict-prototypes -I../../../../../build/xenomai/include -MT 
libvrtx_la-task.lo -MD -MP -MF .deps/libvrtx_la-task.Tpo -c ../../../../../build/xenomai/src/skins/vrtx/task.c  -fPIC -DPIC -o .libs/libvrtx_la-task.o
../../../../../build/xenomai/src/skins/vrtx/task.c:250:21: error: 
macro "XENOMAI_SKINCALL1" requires 3 arguments, but only 2 given
../../../../../build/xenomai/src/skins/vrtx/task.c: In function 'sc_delay':
../../../../../build/xenomai/src/skins/vrtx/task.c:249: 
error: 'XENOMAI_SKINCALL1' undeclared (first use in this function)
../../../../../build/xenomai/src/skins/vrtx/task.c:249: error: (Each 
undeclared identifier is reported only once
../../../../../build/xenomai/src/skins/vrtx/task.c:249: error: for each 
function it appears in.)
make[4]: *** [libvrtx_la-task.lo] Error 1
make[4]: Leaving directory 
`/mnt/data.ng/buildslave/buildbot/quick-hcu3/build/hcu/src/skins/vrtx'

Could you please take a look at it?

Best regards

-- 
Niklaus Giger

