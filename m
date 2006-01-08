Message-ID: <43C11EEB.8040003@domain.hid>
Date: Sun, 08 Jan 2006 15:17:15 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] [rfc] Building Linux kernel in Xenomai tree.
References: <17343.42595.626357.181448@domain.hid>	<43C100A2.6040605@domain.hid>
	<17345.3786.644399.982109@domain.hid>
In-Reply-To: <17345.3786.644399.982109@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

Gilles Chanteperdrix wrote:
> Philippe Gerum wrote:
>  > Gilles Chanteperdrix wrote:
>  > > Hi,
>  > > 
>  > > attached is a patch of Xenomai trunk build system to allow building
>  > > Linux kernel as part of Xenomai build process. This way, typing make
>  > > install builds and installs the Linux kernel, kernel modules and
>  > > Xenomai.
>  > > 
>  > > The patch is a bit young and still has a few drawbacks, but before
>  > > spending to much time on it, I would like to know if anyone is opposed
>  > > to the idea of building Linux in Xenomai build tree.
>  > > 
>  > > To try this patch, apply and run the bootstrap script.
>  > > 3 options are then added to configure :
>  > > --enable-linux-build    Build Linux in Xenomai build tree
>  > > --with-linux-srcdir     specify the path to Linux sources. Default is to
>  > >                         use, if not cross-compiling, the source of the
>  > >                         running kernel or /usr/src/linux.
>  > 
>  > --enable-linux-build=<linux-tree> ?
> 
> The current approach is to use the sources of the running kernel if the
> only option specified is --enable-linux-build. Do you mean you find this
> feature superfluous ?
> 

If $enableval is "y", then no path has been specified, so you can 
default to the running kernel in such a case.

-- 

Philippe.

