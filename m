From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <4A3CC746.3040605@domain.hid>
References: <4A3CC746.3040605@domain.hid>
Content-Type: text/plain
Date: Sat, 20 Jun 2009 17:13:37 +0200
Message-Id: <1245510817.4090.186.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] debian specific kernel patching/unpatching
 problems with 2.6.29
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Stefan Kisdaroczi <kisda@domain.hid>
Cc: xenomai@xenomai.org

On Sat, 2009-06-20 at 13:25 +0200, Stefan Kisdaroczi wrote:
> Hi,
> 
> applying the xenomai kernelpatch created during debian package building
> results to a corrupt init/Kconfig file and 'make menuconfig' fails. The 
> problem
> starts with linux-2.6.29.  reason: growing init/Kconfig file, see  [1].
> This patch [2] fixed it (tested with 2.6.28 and 2.6.29).
> 
> The second problem is unpatching the kernel:
> Starting with 2.6.29 the Adoes-IPipe patches have a second hunk for 
> init/Kconfig
> to remove the last line [3]. This hunk fails while reverse patching the 
> kernel. Its
> conflicting with the generated Kconfig.frag-patch (see [2] too).
> Removing the second init/Kconfig-Hunk from the adeos-patch [3] fixed it.
> 
> tested with 2.5-rc2, but please merge to xenomai-2.4.x too. thank you.
> kisda
> 
> [1]
> wc -l (unpatched sources from kernel.org)
> 764  ./linux-2.6.24.7/init/Kconfig
> 875  ./linux-2.6.25.20/init/Kconfig
> 925  ./linux-2.6.26.8/init/Kconfig
> 912  ./linux-2.6.27.25/init/Kconfig
> 937  ./linux-2.6.28.9/init/Kconfig
> 1067 ./linux-2.6.29.5/init/Kconfig
> 1156 ./linux-2.6.30.0/init/Kconfig
> 
> [2]
> diff -uNrp xenomai-2.4.91.orig/debian/prepare-patch.sh 
> xenomai-2.4.91/debian/prepare-patch.sh

Thunderbird did massive whitespace damages to your patch it seems; could
you resend it attached? TIA,

-- 
Philippe.



