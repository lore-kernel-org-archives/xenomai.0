From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17571.61403.535192.707585@domain.hid>
Date: Thu, 29 Jun 2006 17:20:59 +0200
Subject: Re: [Xenomai-help] static linking of posix demo
In-Reply-To: <5D63919D95F87E4D9D34FF7748CE2C2A3BC849@domain.hid>
References: <5D63919D95F87E4D9D34FF7748CE2C2A3BC849@domain.hid>
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Roderik_Wildenburg@domain.hid
Cc: xenomai@xenomai.org

Roderik_Wildenburg@domain.hid wrote:
 > when I try to link the posix demo satch.c statically by inserting a
 > "-static" option to the LDFLAGS ( %_rt: LDFLAGS= -static $(LDFLAGS_RT) )
 > I get a lot of Errors about undefined references :
 > e.g.:
 > undefined reference to `__wrap_timer_settime'
 > relocation truncated to fit: R_PPC_REL24 __wrap_timer_settime 
 > 
 > Does anybody know what I have done wrong, or is static linking not
 > supposed to be used.

I am afraid you are the first to ever try static linking. The issue is
that the --wrap directive is also applied to the symbols of the static
versions of the regular pthread and rt libraries. In order to avoid
that, I only see one solution (if you are really willing to statically
link the system pthread and rt libraries). First partially link the
satch_rt.o object with the libpthread_rt lib, with all the --wrap
options, and then link this partially linked object with the -lpthread
and -lrt libraries without the --wrap directives.

The following Makefile snippet attempts to do this.

-- 


					    Gilles Chanteperdrix.

LIBDIR=$(shell DESTDIR=$(DESTDIR) $(XENO_CONFIG) --libdir)

STAGE1_LDFLAGS:=$(patsubst %,--wrap %,$(shell cat $(LIBDIR)/posix.wrappers))
STAGE1_LDFLAGS+=-L$(LIBDIR) -lpthread_rt
STAGE2_LDFLAGS:=-static -lpthread -lrt

%_rt.stage1.o: %_rt.o
	$(LD) -o $@ -r $< $(STAGE1_LDFLAGS)

%_rt: %_rt.stage1.o
	$(CC) -o $@ $< $(STAGE2_LDFLAGS)

