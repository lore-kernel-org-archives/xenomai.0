Message-ID: <44FF2E2C.9050209@domain.hid>
Date: Wed, 06 Sep 2006 15:23:08 -0500
From: Jeff Webb <jeff.webb@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] Kernel panic with Xenomai SMP kernel
References: <44F6E774.2000701@domain.hid>	
	<44F72F35.4070109@domain.hid>	<44F75C54.90608@domain.hid>	
	<17655.28122.163232.842311@domain.hid>	
	<44F84C23.9070105@domain.hid>	
	<17656.30980.846435.69720@domain.hid>	
	<44F8B112.9070203@domain.hid> <1157182863.4967.2.camel@domain.hid>
In-Reply-To: <1157182863.4967.2.camel@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org

Philippe Gerum wrote:
> Could you try specifically enabling/disabling CONFIG_PCI_MSI? TIA,

The CONFIG_PCI_MSI does not seem to be causing this particular kernel panic, but it does cause another.  If I enable this option on the working (but buggy) kernel, it boots and gets almost all the way through the init scripts before the kernel panics in move_native_irq with:

 <3> BUG: sleeping function called from invalid context at include/liux/rwsem.h: 43

So I continued my search for the other nasty config option.  After many recompiles, I discovered the source of the original kernel panic was setting CONFIG_HOTPLUG_CPU.  (The non-patched vanilla kernel works fine with CONFIG_HOTPLUG_CPU set.)  I realize that it does not make sense to have this set for a real-time system, but this is the sort of thing that is in the default fedora kernel config.

I was happy to discover the source of the kernel panic, but the SMP kernel was still not quite right (... strange pauses and repeated keystrokes, as I mentioned in a previous email).  I proceed to go through the kernel options in great detail and disable options that I thought were unnecessary.  After doing this, I finally ended up with an SMP xenomai kernel that appears to function properly.  I am now trying to find the option that caused the strange behavior.  I will let you know which option it is, if I can track it down.

I think my problem is solved, since I now have a working SMP kernel.  Now the question is, is there something we can do to keep this problem from biting others?  It seems to me that I took a reasonable approach:

  Download a vanilla kernel from kernel.org.
  Use the xenomai prepare-kernel script to apply the adeos patch.
  Load the default (working) fedora config file.
  Turn off the troublesome config options listed in the TROUBLESHOOTING file.
  Build the kernel as an RPM.

This approach has worked well in the past with many version of RTLinux (and even Xenomai / Linux 2.4/2.6 uniprocessor).  I'm not sure why the SMP build caused so many problems, but it would be nice to fix things up a bit.
  
Is the adeos patch supposed to work with any set of config options?  Or do we need to list some more options to avoid in the TROUBLESHOOTING file?  Let me know if I can help in debugging any problems that I may have uncovered.

Thanks for all your help in this,

-Jeff

