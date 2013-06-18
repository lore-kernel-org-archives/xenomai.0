Message-ID: <ca9bc8023d17b2e095231bfb1a527cef.squirrel@www.xenomai.org>
In-Reply-To: <201306151740.30939.leo@alaxarxa.net>
References: <201306110043.26534.leo@alaxarxa.net>
	<201306151740.30939.leo@alaxarxa.net>
Date: Tue, 18 Jun 2013 18:09:09 +0200
From: "Gilles Chanteperdrix" <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Subject: Re: [Xenomai] Compiler and linker options for rtnet (and xenomai)
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Leopold Palomo Avellaneda <leo@alaxarxa.net>
Cc: Xenomai <xenomai@xenomai.org>, rtnet-users@lists.sourceforge.net


Leopold Palomo Avellaneda wrote:
> Hi,
>
> first of all sorry for the cross-posting but I think that there's
> something
> wrong in the xeno-config options in both projects. If I run:
>
> $ xeno-config --skin=native --ldflags
> -lnative -L/usr/lib -lxenomai -lpthread -lrt
>
> $ xeno-config --skin=posix --ldflags
> -Wl,@/usr/lib/posix.wrappers -L/usr/lib -lpthread_rt -lxenomai -lpthread
> -lrt
>
> $ xeno-config --skin=rtdm  --ldflags
> -lrtdm -L/usr/lib -lxenomai -lpthread -lrt
>
>
> So, in my application, that I _only_ use rtnet calls and also, the pthread
> calls (pthread_*,  rt_* calls)
>
> none of the options described fits my needs. Or rtdm skin adds the native
> lib,
> or we create another --ldflags with rtdm, native.
>
> What do you think?

Hi,

I am not sure I understand your question.

If you want to use the RTDM skin only, then use the flags given by
xeno-config --skin=rtdm

If you want to use the RTDM skin with the native skin, then use the flags
given by both xeno-config --skin=rtdm and xeno-config --skin=native

If you want to use the RTDM skin through the posix skin, then only use the
flags given by xeno-config --skin=posix

If you want to use the 3 skins (RTDM, native, posix), then use the flags
given by all three calls to xeno-config.

Regards.


-- 
                    Gilles.


