Message-ID: <43C18675.40404@domain.hid>
Date: Sun, 08 Jan 2006 22:39:01 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] [rfc] Building Linux kernel in Xenomai tree.
References: <17343.42595.626357.181448@domain.hid>	<43C100A2.6040605@domain.hid>	<17345.3786.644399.982109@domain.hid>	<43C11EEB.8040003@domain.hid>	<17345.17403.927352.223271@domain.hid>	<43C166BB.4030606@domain.hid>
	<17345.29846.188687.345939@domain.hid>
In-Reply-To: <17345.29846.188687.345939@domain.hid>
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
>  > > Philippe Gerum wrote:
>  > >  > Gilles Chanteperdrix wrote:
>  > >  > > The current approach is to use the sources of the running kernel if the
>  > >  > > only option specified is --enable-linux-build. Do you mean you find this
>  > >  > > feature superfluous ?
>  > >  > > 
>  > >  > 
>  > >  > If $enableval is "y", then no path has been specified, so you can 
>  > >  > default to the running kernel in such a case.
>  > > 
>  > > Here is a third version of the patch, where :
>  > > * the --enable-sim option is removed
>  > > * the --with-linux-srcdir option is removed
>  > > * the CC variable is passed to kernel build system
>  > > * prepare-kernel.sh no longer removes target directories before
>  > >   creating symbolic links.
>  > > 
>  > > 
>  > 
>  > This is needed for creating links in a new kernel for the fist time:
> 
> Sorry... Here is the 4th patch.
> 

Ok, looks like fairly local and non-intrusive. I'm merged this patch into the main 
trunk eventually, so that it gets more exposure and testing.

-- 

Philippe.

