From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <4B7C2F40.2010804@domain.hid>
References: <4B7BF0F6.8050007@domain.hid>  <4B7C2F40.2010804@domain.hid>
Content-Type: text/plain; charset="UTF-8"
Date: Wed, 17 Feb 2010 19:24:00 +0100
Message-ID: <1266431040.26785.52.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Xenomai kernel hanging at boot
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Daniele Nicolodi <daniele@domain.hid>
Cc: xenomai@xenomai.org

On Wed, 2010-02-17 at 19:02 +0100, Daniele Nicolodi wrote:
> Daniele Nicolodi wrote:
> > Hello. I'm new to Xenomai and I'm unable to make my first Xenomai kernel
> > to boot. I downloaded linux-2.6.32.7 sources from kernel.org and xenomai
> >  2.5.1. I patched the kernel, configured and compiled it. All went fine.
> > 
> > However when i try to boot this kernel it hangs at boot, immediately
> > after the boot loader dives up the control to the kernel, I think. I'm
> > left with a blinking _ and nothing more.
> 
> I tried to boot a 2.6.30.10 kernel with the Xenomai 2.5.1 patches and it
> boots fine, with the same configuration. I think there must be a severe
> regression in the last patches.
> 
> How can I help in investigating and solving the bug?
> 

By sending your .config file for example. You did not even mention which
architecture you are running on, albeit x86 seems likely.

> Thanks. Cheers,


-- 
Philippe. There is life beyond x86.



