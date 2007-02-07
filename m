Subject: Re: [Xenomai-core] Buildbot: uses 2.6.19 kernel. Sim has a problem
From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <200702060747.51412.niklaus.giger@domain.hid>
References: <200702060747.51412.niklaus.giger@domain.hid>
Content-Type: text/plain
Date: Wed, 07 Feb 2007 16:07:11 +0100
Message-Id: <1170860831.21675.28.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: Philippe Gerum <philippe.gerum@domain.hid>
Reply-To: rpm@xenomai.org
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: niklaus.giger@domain.hid
Cc: xenomai@xenomai.org

On Tue, 2007-02-06 at 07:47 +0100, Niklaus Giger wrote:
> Hi
> 
> After spending a week skiing I discovered that I had to update the buildbot to 
> use the 2.6.19 kernels everywhere. Seems to work.
> 
> I also found that since February 2 I get the following error message
>  
> g++ -DHAVE_CONFIG_H -I. -I. -I../include -fno-exceptions -D__XENO_SIM__ -I./.. -O2 -MT 
> libmvm_la-thread.lo -MD -MP -MF .deps/libmvm_la-thread.Tpo -c 
> thread.cc  -fPIC -DPIC -o .libs/libmvm_la-thread.o
> thread.cc:66: error: 'int MvmThread::globalTrace' is not a static member 
> of 'class MvmThread'
> make[1]: *** [libmvm_la-thread.lo] Fehler 1
> For details look at 
> http://ngiger.dyndns.org/buildbot-full/sim_f/builds/86/step-make_sim/1
> 

Fixed, thanks.

> Best regards
> 
-- 
Philippe.



