From: Niklaus Giger <niklaus.giger@domain.hid>
Date: Tue, 6 Feb 2007 07:47:51 +0100
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200702060747.51412.niklaus.giger@domain.hid>
Subject: [Xenomai-core] Buildbot: uses 2.6.19 kernel. Sim has a problem
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
To: xenomai@xenomai.org

Hi

After spending a week skiing I discovered that I had to update the buildbot to 
use the 2.6.19 kernels everywhere. Seems to work.

I also found that since February 2 I get the following error message
 
g++ -DHAVE_CONFIG_H -I. -I. -I../include -fno-exceptions -D__XENO_SIM__ -I./.. -O2 -MT 
libmvm_la-thread.lo -MD -MP -MF .deps/libmvm_la-thread.Tpo -c 
thread.cc  -fPIC -DPIC -o .libs/libmvm_la-thread.o
thread.cc:66: error: 'int MvmThread::globalTrace' is not a static member 
of 'class MvmThread'
make[1]: *** [libmvm_la-thread.lo] Fehler 1
For details look at 
http://ngiger.dyndns.org/buildbot-full/sim_f/builds/86/step-make_sim/1

Best regards

-- 
Niklaus Giger

