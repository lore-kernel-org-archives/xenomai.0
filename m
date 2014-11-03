Date: Mon, 3 Nov 2014 17:44:33 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20141103164433.GG9327@sisyphus.hd.free.fr>
References: <314E5ECDAA86314791309FA670550F89C6762243@SINTEFEXMBX05.sintef.no>
 <20141103122602.GB7705@sisyphus.hd.free.fr>
 <314E5ECDAA86314791309FA670550F89C67627E4@SINTEFEXMBX05.sintef.no>
 <20141103153617.GD9327@sisyphus.hd.free.fr>
 <314E5ECDAA86314791309FA670550F89C6762872@SINTEFEXMBX05.sintef.no>
 <20141103160223.GE9327@sisyphus.hd.free.fr>
 <314E5ECDAA86314791309FA670550F89C6762910@SINTEFEXMBX05.sintef.no>
 <20141103162457.GF9327@sisyphus.hd.free.fr>
 <314E5ECDAA86314791309FA670550F89C676297E@SINTEFEXMBX05.sintef.no>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <314E5ECDAA86314791309FA670550F89C676297E@SINTEFEXMBX05.sintef.no>
Subject: Re: [Xenomai] Xenoma 2.6.4 missing posix/xeno_config.h ?
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Terje =?utf-8?Q?Fr=C3=B8ysa?= <Terje.Froysa@sintef.no>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

On Mon, Nov 03, 2014 at 04:40:15PM +0000, Terje Frøysa wrote:
> That's correct.
> 
> The /usr/include/time.h holds this code, hence the clockid_t should be defined.
> 
> Can the files in the /usr/inlcude directory be overshadowed by some other include files?

No. But some compilation flags may disable these types, which are
defined only for some versions of the posix standard.


> 
> The Makefile has grown quite complex:
> 
> KSRC := /lib/modules/$(shell uname -r)/source
> 
> XENO_DESTDIR:=/
> XENO_CONFIG:=$(XENO_DESTDIR)/usr/xenomai/bin/xeno-config
> XENO_POSIX_CFLAGS:=$(shell DESTDIR=$(XENO_DESTDIR) $(XENO_CONFIG) --skin=posix --cflags)
> XENO_POSIX_LIBS:=$(shell DESTDIR=$(XENO_DESTDIR) $(XENO_CONFIG) --skin=posix --ldflags)
> 
> # define any compile-time flags
> CFLAGS = -Wall -g $(XENO_POSIX_CFLAGS)
> 
> INCLUDES = -I$(KSRC)/include/xenomai -I$(KSRC)/include/xenomai/posix -I$(KSRC)/arch/arm/mach-omap2

You do not need to include $(KSRC)/include/xenomai and
-I$(KSRC)/include/xenomai/posix, these directories are for building
kernel modules only, not for building applications.

> 
> # define library paths in addition to /usr/lib
> #   if I wanted to include libraries not in /usr/lib I'd specify
> #   their path using -Lpath, something like:
> #LFLAGS = -L/home/newhall/lib  -L../lib
> 
> # define any libraries to link into executable:
> #   if I want to link in libraries (libx.so or libx.a) I use the -llibname
> #   option, something like (this will link in libmylib.so and libm.so:
> LIBS = -l$(XENO_POSIX_LIBS)

Just LIBS=$(XENO_POSIX_LIBS) without the -l

Coud you show us the complete Makefile so that we see all the flags
you pass to gcc?

-- 
					    Gilles.

