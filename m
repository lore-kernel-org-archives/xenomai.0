Subject: Re: [Xenomai-core] Buildbot cannot compile xenoma: rtcanconfig
	refences pthread_kill
From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <44E182B8.8000300@domain.hid>
References: <200608150949.30029.niklaus.giger@domain.hid>
	<44E182B8.8000300@domain.hid>
Content-Type: text/plain
Date: Tue, 15 Aug 2006 13:55:20 +0200
Message-Id: <1155642921.4327.7.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
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
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: xenomai-core <xenomai@xenomai.org>

On Tue, 2006-08-15 at 10:15 +0200, Jan Kiszka wrote:
> Niklaus Giger wrote:
> > Hi
> > 
> > All my PPC based compilation fail with something like
> > 
> > ccache gcc -rdynamic -o .libs/rtcanconfig 
> > rtcanconfig.o  -L/mnt/data.ng/buildslave/buildbot/quick-ppc/build/ppc/src/skins/native -L/mnt/data.ng/buildslave/buildbot/quick-ppc/build/ppc/src/skins/rtdm /mnt/data.ng/buildslave/buildbot/quick-ppc/build/ppc/src/skins/rtdm/.libs/librtdm.so -Wl,--rpath -Wl,/usr/xenomai/lib
> > /mnt/data.ng/buildslave/buildbot/quick-ppc/build/ppc/src/skins/rtdm/.libs/librtdm.so: 
> > undefined reference to `pthread_kill'
> > http://ngiger.dyndns.org/buildbot/ppc/builds/229/step-mk_xeno/0
> > Is this only a PPC problem? It appears first with build 226, which referred to 
> > revisions 1433 and 1434. Details see 
> > http://ngiger.dyndns.org/buildbot/ppc/builds/226
> > 
> > Jan, could you please have a look at the error, as it seems to me that you 
> > reduced the lib dependencies a little bit too much?
> 
> Well, neither rtcanconfig nor librtdm have explicit dependencies on
> libpthread. Unfortunately, the generic skin init code now drags in
> pthread_kill when the linker fails to remove xeno_handle_mlock_alert for
> librtdm. That doesn't happen with my gcc-4.1, likely older compilers are
> less smart.
> 
> Anyone any ideas how to solve it WITHOUT adding -lpthread to librtdm?

Could you develop a bit more, i.e. what's the issue with adding this
dependency?

>  I
> would say either move that functions to a separate module

The reason to have this code in nucleus/bind.h is that we don't have any
dependency on common libs aside of the ones providing the skin syscalls,
and we try to avoid code duplication by not implementing this stuff into
each and every init.c files.

>  or include it
> via a separate header that all skins include except rtdm.
> 

I'm still reluctant to make RTDM an exception to the common rule,
especially to fix a compiler issue.

> > 
> > Jan BTW, I also switched the RTNet svn to the new location. 
> 
> Looking forward to the build results once we get xenomai compiling
> again. A lot of stuff changed or got added recently.
> 
> > 
> > Best regards
> > 
> 
> Jan
> 
> _______________________________________________
> Xenomai-core mailing list
> Xenomai-core@domain.hid
> https://mail.gna.org/listinfo/xenomai-core
-- 
Philippe.



