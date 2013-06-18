From: Leopold Palomo Avellaneda <leo@alaxarxa.net>
Date: Tue, 18 Jun 2013 23:33:21 +0200
References: <201306110043.26534.leo@alaxarxa.net>
	<201306151740.30939.leo@alaxarxa.net>
	<ca9bc8023d17b2e095231bfb1a527cef.squirrel@www.xenomai.org>
In-Reply-To: <ca9bc8023d17b2e095231bfb1a527cef.squirrel@www.xenomai.org>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <201306182333.22218.leo@alaxarxa.net>
Subject: Re: [Xenomai] Compiler and linker options for rtnet (and xenomai)
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: Xenomai <xenomai@xenomai.org>, rtnet-users@lists.sourceforge.net

A Dimarts, 18 de juny de 2013, Gilles Chanteperdrix va escriure:
> Leopold Palomo Avellaneda wrote:
> > Hi,
> > 
> > first of all sorry for the cross-posting but I think that there's
> > something
> > wrong in the xeno-config options in both projects. If I run:
> > 
> > $ xeno-config --skin=native --ldflags
> > -lnative -L/usr/lib -lxenomai -lpthread -lrt
> > 
> > $ xeno-config --skin=posix --ldflags
> > -Wl,@/usr/lib/posix.wrappers -L/usr/lib -lpthread_rt -lxenomai -lpthread
> > -lrt
> > 
> > $ xeno-config --skin=rtdm  --ldflags
> > -lrtdm -L/usr/lib -lxenomai -lpthread -lrt
> > 
> > 
> > So, in my application, that I _only_ use rtnet calls and also, the
> > pthread calls (pthread_*,  rt_* calls)
> > 
> > none of the options described fits my needs. Or rtdm skin adds the native
> > lib,
> > or we create another --ldflags with rtdm, native.
> > 
> > What do you think?
> 
> Hi,
> 
> I am not sure I understand your question.
> 
> If you want to use the RTDM skin only, then use the flags given by
> xeno-config --skin=rtdm
> 
> If you want to use the RTDM skin with the native skin, then use the flags
> given by both xeno-config --skin=rtdm and xeno-config --skin=native
> 
> If you want to use the RTDM skin through the posix skin, then only use the
> flags given by xeno-config --skin=posix
> 
> If you want to use the 3 skins (RTDM, native, posix), then use the flags
> given by all three calls to xeno-config.
> 
My problem is that neither of the three options fits my needs and to make a 
combination of two of them puts repeated options in the compiler. For example 
rtdm+native:

-lnative -L/usr/lib -lxenomai -lpthread -lrt -lrtdm -L/usr/lib -lxenomai 
-lpthread -lrt

I miss a "skin" rtnet, because IMHO the common use of rtnet using that calls 
cannot be set by none of the options of xeno-config, and you need a combination 
of both (rtdm+native).

I hope have been more clear now.

Regards,

Leo


-- 
--
Linux User 152692     PGP: 0xF944807E
Catalonia
-------------------------------------
A: Because it messes up the order in which people normally read text.
Q: Why is top-posting such a bad thing?
A: Top-posting.
Q: What is the most annoying thing in e-mail?

