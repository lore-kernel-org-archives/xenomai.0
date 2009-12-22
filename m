From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <4B309A29.6030405@domain.hid>
References: <4B309A29.6030405@domain.hid>
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 22 Dec 2009 11:43:11 +0100
Message-ID: <1261478591.19080.133.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] Build tests: analogy, blackfin, rtcan and nios2.
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: Xenomai core <Xenomai-core@domain.hid>

On Tue, 2009-12-22 at 11:06 +0100, Gilles Chanteperdrix wrote:
> Hi,
> 
> Since I started talking about it, I have run build tests fixing a few
> things here and there. The current status is this (still at the same
> place: http://sisyphus.hd.free.fr/~gilles/bx):
> 
> * analogy: I have tried to disable some parts of analogy when compiling
> on machines without CONFIG_PCI, as compiling parts using PCI on a
> machine without PCI support, give various levels of warning and even
> errors depending on the architecture. Doing this, I stumbled across this
> compilation error:
> http://sisyphus.hd.free.fr/~gilles/bx/beagle/2.6.28-arm-none-linux-gnueabi-gcc-4.3.3/log.html#1
> this is with CONFIG_NI_MIO, but without CONFIG_NI_MITE.
> 
> So, Alex, could you:
> - fix that error, if this combination is supposed to make sense
> - fix the Kconfig/Makefile so that no PCI code is compiled if CONFIG_PCI
> is not set (I tried and do this myself, but better one who knows than
> 100 who have to search...). As I said, doing this result in various
> levels of success depending on the architecture.
> 
> * blackfin: I finally compiled blackfin!

Good. So now you can try fixing the climate.

>  had to build a toolchain for
> that as the binary-only toolchain from analog.com uses glibc 2.8 and
> mine is 2.7. However, blackfin does not compile very well, as can be
> seen by the log:
> http://sisyphus.hd.free.fr/~gilles/bx/bf537-stamp/2.6.30-bfin-uclinux-gcc-4.1.2/log.html#1
> It may happen that my toolchain is buggy or outdated though.

4.1.2 might still have the mcount prologue issue, so no tracer, but
aside of this, it seems ok here.

I've just pushed fixes for the NMI braindamage for blackfin.

> 
> * rtcan: on blackfin we seem to have a conflict with rtcan.
> The warning is about CAN_ERR_MASK, sure blackfin is a bit strange to
> define this in core headers which are included everywhere. This said,
> not prefixing a Xenomai symbol with something like XN seems to be asking
> for trouble. Wolfgang, do you think it would be possible to rename the
> symbols with such prefix? Or do you share some code with socket-can that
> you do not want to touch?
> 
> * nios2: I am lacking some important file needed to even start to compile.
> 

I'm on this.

> Thanks in advance for your efforts.
> Regards.
> 


-- 
Philippe.



