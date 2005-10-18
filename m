MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17237.12787.420638.405000@domain.hid>
Date: Tue, 18 Oct 2005 19:33:39 +0200
Subject: Re: [Xenomai-help] compiling xenomai on x86_64
In-Reply-To: <435488DB.2090406@domain.hid>
References: <4353F109.7000707@domain.hid>
	<4353F411.4000500@domain.hid>
	<4353F896.1040508@domain.hid>
	<435402B4.5060004@domain.hid> <435403C8.80400@domain.hid>
	<43540531.8050304@domain.hid>
	<435406E0.8020405@domain.hid>
	<435409AD.6060705@domain.hid>
	<43540BB5.9040401@domain.hid>
	<17236.13470.692381.730895@domain.hid>
	<435488DB.2090406@domain.hid>
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
To: Heikki Lindholm <holindho@domain.hid>
Cc: xenomai@xenomai.org

Heikki Lindholm wrote:
 > Gilles Chanteperdrix kirjoitti:
 > > Philippe Gerum wrote:
 > >  > Probably grabbing more stuff from the kernel cflags into XENO_ARCH_FLAGS (e.g. 
 > >  > -m[0-9]* to start with). Gilles, would this be ok?
 > > 
 > > Probably, but last time I checked that, the ppc-compiled version of the
 > > dummy program used at configuration time to extract the arch flags from
 > > Kbuild was not work here, because of ahem, quoting issues. There are
 > > some -m arguments we do not want (such as for example the -msoft-float
 > > used in ppc kernel space).
 > 
 > Hmm. Does this also mean that the compiler isn't taken from kernel 
 > config at all? I tried compiling Xeno on a ppc box the other day, where 
 > the kernel had already been compiled by gcc-3.4 on another host. The box 
 > also had gcc-3.4, but 3.3 as the default (old debian.) Xenomai config 
 > seemed to pick the wrong compiler, because modules complained at load 
 > time of 3.3 vs. 3.4 conflict. The kernel compile host's default was 
 > gcc-4.0, so it was also forced to use gcc-3.4.

No, it is only the hack to get the ARCH_FLAGS from kbuild system that
did not work, and now it seems to work. The Xenomai build system takes
the compiler from the CC variable, so as far as I know, the only way you
may get a different compiler when compiling the kernel and compiling
Xenomai is by having it set to a different value.

-- 


					    Gilles Chanteperdrix.

