From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <4A3F73B6.1060202@domain.hid>
References: <200906221245.04890.smolorz@domain.hid>
	<4A3F73B6.1060202@domain.hid>
Content-Type: text/plain
Date: Mon, 22 Jun 2009 14:37:15 +0200
Message-Id: <1245674235.4121.1.camel@domain.hid>
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

On Mon, 2009-06-22 at 14:06 +0200, Gilles Chanteperdrix wrote:
> Sebastian Smolorz wrote:
> > Hi Philippe,
> > 
> > with latest head it is not possible to build the POSIX skin as module. It 
> > gives:
> > 
> > ERROR: "xnarch_divrem_billion" [kernel/xenomai/skins/posix/xeno_posix.ko] 
> > undefined!
> > 
> > Obviously an
> > 
> > EXPORT_SYMBOL(xnarch_divrem_billion);
> > 
> > is missing.
> 
> Well, no. The definition of xnarh_divrem_billion is in the timeconv.h
> header, which should be included in places where this function is
> needed.

Actually, this is no inline stuff anymore, so we do need an export just
like tsc_to_ns and converse op.

>  So, what is missing is probably a #include. But Ok, thanks for
> taking care of testing 2.5-rc2.
> 
-- 
Philippe.



