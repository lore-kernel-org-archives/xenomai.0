Message-ID: <43BE771C.2090005@domain.hid>
Date: Fri, 06 Jan 2006 14:56:44 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] Re: Oops, I broke something
References: <43BE5E3E.1060208@domain.hid>	<43BE626A.6000500@domain.hid>
	<17342.26740.324646.221814@domain.hid>
In-Reply-To: <17342.26740.324646.221814@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: Jan Kiszka <jan.kiszka@domain.hid>, xenomai-core <xenomai@xenomai.org>

Gilles Chanteperdrix wrote:
> Philippe Gerum wrote:
>  > Jan Kiszka wrote:
>  > > But this raised the question to me again if we really need the "xenomai"
>  > > prefix for all the skin headers /from within xenomai/. Why not doing the
>  > > same linking dance for the other skins as well? Or do you also prefer
>  > > that user include <xenomai/native/task.h> instead of just <native/task.h>?
>  > 
>  > We need this for building from within the kernel. Other options would 
>  > require to either alter the Xenomai source tree adding symlinks there, 
>  > pollute linux/include with symlinks to reach the individual Xeno 
>  > components, or refer to some external tree that eventually redirects to 
>  > the Xenomai tree, which is not acceptable in any case.
> 
> Maybe we could add EXTRA_CFLAGS=-I$(TOPDIR)/include/xenomai to every
> xenomai kernel makefile

Yes, I would preferably merge that instead of playing with symlinks.

  and to the cflags returned by xeno-config for
> kernel-space applications ?
> 

There no such support in xeno-config anymore. Kernel module flags and 
dependencies now exclusively belong to the kernel build system; 
xeno-config is only relevant for building user-space apps.

-- 

Philippe.

