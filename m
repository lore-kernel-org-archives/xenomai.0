Message-ID: <44E182B8.8000300@domain.hid>
Date: Tue, 15 Aug 2006 10:15:52 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] Buildbot cannot compile xenoma: rtcanconfig
	refences pthread_kill
References: <200608150949.30029.niklaus.giger@domain.hid>
In-Reply-To: <200608150949.30029.niklaus.giger@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: jan.kiszka@domain.hid
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: niklaus.giger@domain.hid, xenomai-core <xenomai@xenomai.org>

Niklaus Giger wrote:
> Hi
> 
> All my PPC based compilation fail with something like
> 
> ccache gcc -rdynamic -o .libs/rtcanconfig 
> rtcanconfig.o  -L/mnt/data.ng/buildslave/buildbot/quick-ppc/build/ppc/src/skins/native -L/mnt/data.ng/buildslave/buildbot/quick-ppc/build/ppc/src/skins/rtdm /mnt/data.ng/buildslave/buildbot/quick-ppc/build/ppc/src/skins/rtdm/.libs/librtdm.so -Wl,--rpath -Wl,/usr/xenomai/lib
> /mnt/data.ng/buildslave/buildbot/quick-ppc/build/ppc/src/skins/rtdm/.libs/librtdm.so: 
> undefined reference to `pthread_kill'
> http://ngiger.dyndns.org/buildbot/ppc/builds/229/step-mk_xeno/0
> Is this only a PPC problem? It appears first with build 226, which referred to 
> revisions 1433 and 1434. Details see 
> http://ngiger.dyndns.org/buildbot/ppc/builds/226
> 
> Jan, could you please have a look at the error, as it seems to me that you 
> reduced the lib dependencies a little bit too much?

Well, neither rtcanconfig nor librtdm have explicit dependencies on
libpthread. Unfortunately, the generic skin init code now drags in
pthread_kill when the linker fails to remove xeno_handle_mlock_alert for
librtdm. That doesn't happen with my gcc-4.1, likely older compilers are
less smart.

Anyone any ideas how to solve it WITHOUT adding -lpthread to librtdm? I
would say either move that functions to a separate module or include it
via a separate header that all skins include except rtdm.

> 
> Jan BTW, I also switched the RTNet svn to the new location. 

Looking forward to the build results once we get xenomai compiling
again. A lot of stuff changed or got added recently.

> 
> Best regards
> 

Jan

