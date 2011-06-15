Message-ID: <4DF83DF1.2080501@domain.hid>
Date: Wed, 15 Jun 2011 07:06:57 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <4DF837EF.6010207@domain.hid>
In-Reply-To: <4DF837EF.6010207@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Beagleboard xenomai
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: David Wiebe <dwiebe2@domain.hid>
Cc: xenomai@xenomai.org

On 06/15/2011 06:41 AM, David Wiebe wrote:
> Hello,
> 
> Thanks for reading this. I checked out the beagleboard version of 
> xenomai. I tried make menuconfig and got the following
> 
> david@domain.hid$ make 
> menuconfig
> scripts/kconfig/mconf arch/arm/Kconfig
> init/Kconfig:1319: can't open file "arch/arm/xenomai/Kconfig"
> make[1]: *** [menuconfig] Error 1
> make: *** [menuconfig] Error 2
> 
> I know that arch/arm/xenomai/Kconfig is a link to a file but its broken. 
> How now? Where should the link be pointing?

I did not know there was a beagleboard version, and I do not know about
it. What I do know, however, is that "make menuconfig", will work in
Linux kernel sources prepared with the "prepare-kernel.sh" script, as
explained in installation instructions here:

http://www.xenomai.org/documentation/xenomai-2.5/README.INSTALL

-- 
                                                                Gilles.

