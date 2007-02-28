Message-ID: <45E5817E.5050001@domain.hid>
Date: Wed, 28 Feb 2007 14:19:58 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] prepare-kernel options
References: <200702281217.36362.paul_c@domain.hid>
In-Reply-To: <200702281217.36362.paul_c@domain.hid>
Content-Type: text/plain; charset=ISO-8859-15
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
To: Paul <paul_c@domain.hid>
Cc: xenomai-core <xenomai@xenomai.org>

Paul wrote:
> A little background - On Debian installations, a set of tools have been 
> provided to allow kernel packages to be quickly & simply generated. It is 
> something I do quite regularly with the following steps:
>  * Extract kernel sources in /tmp
>  * Apply patches
>  * Copy an existing .config over - Run `make oldconfig`
>  * make-kpkg binary-arch (produces kernel-image and kernel-header packages)
>  * Install/reboot
> 
> It may sound a long winded method, but it does allow me to use the generated 
> packages to install on any number of other machines.
> 
> The problem - prepare-kernel.sh creates symlinks to assorted files in the 
> Xenomai source tree. Not a problem if the same tree exists in the same 
> location on the target machine. As yet, there is no xenomai Debian package, 
> and the build location may not be the same as the install location - This 
> results in a large number of dangling symlinks which thwarts attempts to 
> compile out of tree modules using the kernel-headers package. I suspect the 
> same issues would exist for RPM packages and NFS mounted targets.
> 
> A solution - Instead of creating symlinks, the files need to be copied in to 
> the kernel source tree. Most people will use symlinks as it simplifies the 
> `svn up`/make process and avoids having to run prepare-kernel each time. I 
> propose a trivial patch that retains the original behaviour and provides an 
> option to turn off symlinks (patch attached).

In order to prepare for the Debianization, the options --outpatch,
--filterarch and --filterkvers were already added. That said, I see no
problem with your patch.

-- 
                                                 Gilles Chanteperdrix

