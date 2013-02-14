Message-ID: <511CD558.2000409@xenomai.org>
Date: Thu, 14 Feb 2013 13:15:20 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <511C911B.2080609@zultron.com>
In-Reply-To: <511C911B.2080609@zultron.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Announcing beta x86 Xenomai kernel packages: squeeze, precise,
 lucid
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: John Morris <john@zultron.com>
Cc: emc-developers@lists.sourceforge.net, Xenomai <xenomai@xenomai.org>

On 02/14/2013 08:24 AM, John Morris wrote:

> Hello emc-dev and xenomai lists,
> 
> I'm very pleased to announce the availability of one-size-fits-all
> Xenomai kernel packages for x86 arch.  These packages have been
> successfully tested on umpteen motherboards at this point, and are ready
> for wider testing.
> 
> * Beta status *
> Distros: Ubuntu Precise and Lucid; Debian Squeeze
> Architectures: i686 and amd64
> Xenomai version: v2.6.2.1, released 2013/01/25
> Kernel version: v3.5.7 vanilla
> Kernel config:  Ubuntu 3.5 stock kernel with Xenomai additions
> 
> The instruction wiki page on linuxcnc.org is somewhat oriented toward
> LinuxCNC users, but most will apply to the general audience:
> 
>   http://wiki.linuxcnc.org/cgi-bin/wiki.pl?XenomaiKernelPackages


Hi John,

thanks to you and the LinuxCNC community at large for working on this.
Is there any problem if we modify the page about Debian on Xenomai wiki
to point to this page?

We will also try and address the issues which were identified since you
started working on this, namely:
- allowing enabling the SMI workaround without kernel re-compilation
- allow building Xenomai user-space support with _FORTIY_SOURCE
- find the origin of the latency issue with i915 and opengl
- the harcoded 80 in the tsc test

Regards.

-- 
                                                                Gilles.

