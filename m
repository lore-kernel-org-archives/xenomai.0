From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17342.26740.324646.221814@domain.hid>
Date: Fri, 6 Jan 2006 13:54:12 +0100
Subject: Re: [Xenomai-core] Re: Oops, I broke something
In-Reply-To: <43BE626A.6000500@domain.hid>
References: <43BE5E3E.1060208@domain.hid>
	<43BE626A.6000500@domain.hid>
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Philippe Gerum <rpm@xenomai.org>
Cc: Jan Kiszka <jan.kiszka@domain.hid>, xenomai-core <xenomai@xenomai.org>

Philippe Gerum wrote:
 > Jan Kiszka wrote:
 > > But this raised the question to me again if we really need the "xenomai"
 > > prefix for all the skin headers /from within xenomai/. Why not doing the
 > > same linking dance for the other skins as well? Or do you also prefer
 > > that user include <xenomai/native/task.h> instead of just <native/task.h>?
 > 
 > We need this for building from within the kernel. Other options would 
 > require to either alter the Xenomai source tree adding symlinks there, 
 > pollute linux/include with symlinks to reach the individual Xeno 
 > components, or refer to some external tree that eventually redirects to 
 > the Xenomai tree, which is not acceptable in any case.

Maybe we could add EXTRA_CFLAGS=-I$(TOPDIR)/include/xenomai to every
xenomai kernel makefile and to the cflags returned by xeno-config for
kernel-space applications ?

-- 


					    Gilles Chanteperdrix.

