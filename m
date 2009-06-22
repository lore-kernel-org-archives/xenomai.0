From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <4A3F7D57.2060704@domain.hid>
References: <200906221245.04890.smolorz@domain.hid>
	<4A3F73B6.1060202@domain.hid> <1245674235.4121.1.camel@domain.hid>
	<4A3F7D57.2060704@domain.hid>
Content-Type: text/plain
Date: Mon, 22 Jun 2009 15:01:38 +0200
Message-Id: <1245675698.4121.6.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] [BUG] [xenomai-head] xeno_posix.ko cannot be
 built
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

On Mon, 2009-06-22 at 14:47 +0200, Gilles Chanteperdrix wrote:
> Philippe Gerum wrote:
> > On Mon, 2009-06-22 at 14:06 +0200, Gilles Chanteperdrix wrote:
> >> Sebastian Smolorz wrote:
> >>> Hi Philippe,
> >>>
> >>> with latest head it is not possible to build the POSIX skin as module. It 
> >>> gives:
> >>>
> >>> ERROR: "xnarch_divrem_billion" [kernel/xenomai/skins/posix/xeno_posix.ko] 
> >>> undefined!
> >>>
> >>> Obviously an
> >>>
> >>> EXPORT_SYMBOL(xnarch_divrem_billion);
> >>>
> >>> is missing.
> >> Well, no. The definition of xnarh_divrem_billion is in the timeconv.h
> >> header, which should be included in places where this function is
> >> needed.
> > 
> > Actually, this is no inline stuff anymore, so we do need an export just
> > like tsc_to_ns and converse op.
> 
> Well, I still see its definition in timeconv.h, the only way I see to
> get an undefined symbol would be to use the function without including
> timeconv.h.
> 
> And indeed, ksrc/skins/posix/internal.h, which uses
> xnarch_divrem_billion does not include timeconv.h
> 

timeconv.h is not for direct inclusion, this is merely an instantiation
file that works both for kernel space and userland. Callers should
include asm/xenomai/system.h instead.

-- 
Philippe.



