Date: Mon, 6 Oct 2014 01:12:09 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20141005231208.GO14975@sisyphus.hd.free.fr>
References: <5431959D.8060504@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5431959D.8060504@xenomai.org>
Subject: Re: [Xenomai] [ANNOUNCE] Xenomai 3.0-rc1
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>
Cc: "Xenomai@xenomai.org" <Xenomai@xenomai.org>

On Sun, Oct 05, 2014 at 09:01:49PM +0200, Philippe Gerum wrote:
>
> We are pleased to announce the official release of Xenomai 3.0-rc1,
> which starts the candidate release cycle for Xenomai 3.
>
> Xenomai 3 is the new architecture of our real-time framework,
> which can run its APIs side-by-side with Linux as a co-kernel system
> delivering very low latencies, or natively over unmodified Linux
> kernels. In the latter case, the mainline kernel can be supplemented by
> the preempt-rt patch to meet stricter real-time requirements.
>
> The dual kernel configuration is currently supported over arm 32bit,
> powerpc32, powerpc64, x86_32, x86_64 and blackfin, with a port to
> aarch64 planned on Q1-2015. The single/native kernel configuration runs
> on any CPU architecture Linux supports.
>
> = What's new in Xenomai 3?
>
> http://xenomai.org/introducing-xenomai-3/
>
> = How to migrate from Xenomai 2.x?
>
> http://xenomai.org/migrating-from-xenomai-2-x-to-3-x/
>
> = Where is the code?
>
> http://git.xenomai.org/xenomai-3.git/
> http://download.gna.org/xenomai/testing/latest/xenomai-3.0-rc1.tar.bz2
>
> Thanks to all Xenomai contributors, and to the companies who made this
> possible, mainly by directly funding the development of some of the
> Xenomai 3 features, or giving access to the latest hardware.
>

Those who wish a quick test run of xeno-test on Xenomai 3 co-kernel
on x86_64 may try and use the pre-built bzImage and initrd available
here:

http://xenomai.org/live-initramfs/3.0-rc1/

You will find an example configuration file for booting with
syslinux. The way to make bootable usb keys with syslinux is
described here:

http://www.syslinux.org/wiki/index.php/HowTos

However, be warned: this initrd launches a telnet and ssh servers
with an empty root password, so do not use it on an hostile network,
and of course not on a machine with an interface with a public IP
address.

--
					    Gilles.

