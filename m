MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17237.19216.373031.430361@domain.hid>
Date: Tue, 18 Oct 2005 21:20:48 +0200
Subject: Re: [Xenomai-help] compiling xenomai on x86_64
In-Reply-To: <43553F22.80805@domain.hid>
References: <4353F109.7000707@domain.hid>
	<4353F411.4000500@domain.hid>
	<4353F896.1040508@domain.hid>
	<435402B4.5060004@domain.hid> <435403C8.80400@domain.hid>
	<43540531.8050304@domain.hid>
	<435406E0.8020405@domain.hid> <435408E5.8020007@domain.hid>
	<435419B0.8030004@domain.hid>
	<4354AD5A.7010305@domain.hid>
	<17237.13723.766826.515585@domain.hid>
	<43553F22.80805@domain.hid>
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Jan Kiszka <kiszka@domain.hid>
Cc: xenomai@xenomai.org

Jan Kiszka wrote:
 > Gilles Chanteperdrix wrote:
 > > Jan Kiszka wrote:
 > >  > I just analysed this further: the problem disappears when I manually
 > >  > remove any "-I<path-to-kernel-includes>" from the makefiles. Seems to be
 > >  > the well-known user space include issue again... ;)
 > > 
 > > I tried to compile every kernel arch/i386 has a patch for with gcc 2.95,
 > > 3.3 and 3.4, and I saw no issue with inclusions of kernel headers
 > > from user-space. At all.
 > 
 > I think you were lucky. As far as I remember, it is generally no good
 > idea to include kernel header for userspace compilation as long as you
 > do not _exactly_ know (or test) what they bring with them. Some
 > structures or defines locate in different headers under /usr/include
 > compared to some kernel tree. So, if you are not lucky, you drag those
 > definitions in twice - see below.
 > 
 > > 
 > > So, there is definitely something you are doing differently from me. 
 > > If this issue is different from the '-m32' flag issue, could you please
 > > fill a bug report, and this time, attach the exact procedure you are
 > > following to compile (whether in-tree, or out-of-tree, whether using
 > > configure or Kconfig, everything that would allow someone to ), the
 > > .config and .xeno_config files you used, in order for me to be able to
 > > reproduce the problem you observed ?
 > > 
 > 
 > As I'm not sure if you can reproduce it easily without my environment
 > (that damn x86_64 gcc4 on SuSE10), I digged a little bit deeper, and
 > here is a new theory:
 > 
 > The compilation fails in skins/native/libs/task.c (there exist similar
 > files in other skins as well). The error: structures in
 > <linux>/include/asm/sigcontext.h are being redefined. Unfortunately, gcc
 > does not tell me where the first definition was. But here is my finding:
 > commenting out #include <signal.h> in libs/task.c makes that error
 > disappear. Following the include chain of /usr/include/signal.h
 > (userspace headers...), you get to /usr/include/bits/sigcontext.h.

I still do not get it: you are compiling on x86_64, so headers in
/usr/include are for x86_64, not ia32. Are you sure you do not need some
glibc-ia32-cross-devel package, or something like that ? The kernel does
not have these problems, since it is compiled with -ffreestanding.

Are you able to compile an ia32 user-space  hello world for example ?

-- 


					    Gilles Chanteperdrix.

