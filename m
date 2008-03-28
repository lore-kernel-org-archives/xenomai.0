Date: Fri, 28 Mar 2008 21:46:31 +0100
From: Robert Schwebel <r.schwebel@domain.hid>
Message-ID: <20080328204631.GC9009@domain.hid>
References: <20080328190310.GB9009@domain.hid>
	<47ED4C7A.8070809@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <47ED4C7A.8070809@domain.hid>
Subject: Re: [Xenomai-core] [PATCH][SOLO] add more warnings
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai-core <xenomai@xenomai.org>

On Fri, Mar 28, 2008 at 08:52:26PM +0100, Philippe Gerum wrote:
> > I've looked into the first ones only yet and it looks to me like the
> > type definitions have to be reviewed carefully. For example, TASK_ID is
> > defined to be unsigned long, whereas the vxworks documentation [1] looks
> > more like if we need 'int' there. Which also makes me wonder if vxworks
> > has a special idea about what 'int' is;
>
> VxWorks assumes 32bit and sizeof(void *) == sizeof(int), unfortunately. See
> taskSpawn() for instance.

Yes, which probably means that using 'int' and friends is not a good
idea.

> Did you mean stdint.h?

Probably better, yes.

> What we need is an integer type which is able to carry a pointer on
> 32/64bit platforms, so we should rather use intptr_t I guess, as per
> C99, which expands as a long type. Object ids as unsigned long is a
> left over from the co-kernel version, where we use actual integer
> handles returned from kernel space, and not pointers in disguise. Will
> fix, thanks.

Hmm, if vxworks assumes "int" to be 32 bit, couldn't it lead to problems
if the pointer size itself isn't 32 bit as well?

> Merged, thanks.

Doesn't show up on http://www.denx.de/cgi-bin/gitweb.cgi?p=xenomai-solo.git;a=summary

?

Robert
-- 
 Dipl.-Ing. Robert Schwebel | http://www.pengutronix.de
 Pengutronix - Linux Solutions for Science and Industry
   Handelsregister:  Amtsgericht Hildesheim, HRA 2686
     Hannoversche Str. 2, 31134 Hildesheim, Germany
   Phone: +49-5121-206917-0 |  Fax: +49-5121-206917-9


