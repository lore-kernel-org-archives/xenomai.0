Message-ID: <5111750E.6090700@siemens.com>
Date: Tue, 05 Feb 2013 22:09:34 +0100
From: Jan Kiszka <jan.kiszka@siemens.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: [Xenomai] [FOR TESTING] I-pipe for 3.8-rc6-x86
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Xenomai <xenomai@xenomai.org>

Hi,

to move forward with our kernel support, I've started porting I-pipe to
upcoming 3.8. The result survived a very basic test in a VM, more
torturing is definitely required. In case someone already wants to have
a look or start porting other archs:

  git://git.xenomai.org/ipipe-jki next-x86
  (Note: "next" branches may be rebased without warning)

Xenomai generates minor troubles while building. PCI drivers seem to
require some massaging, and we get an ugly warning of Kconfig on every
build:

drivers/pcmcia/Kconfig:20:error: recursive dependency detected!
drivers/pcmcia/Kconfig:20:      symbol PCMCIA depends on PCCARD
drivers/pcmcia/Kconfig:5:       symbol PCCARD depends on HOTPLUG
init/Kconfig:1261:      symbol HOTPLUG is selected by PM_SLEEP_SMP
kernel/power/Kconfig:98:        symbol PM_SLEEP_SMP depends on PM_SLEEP
kernel/power/Kconfig:94:        symbol PM_SLEEP depends on HIBERNATE_CALLBACKS
kernel/power/Kconfig:21:        symbol HIBERNATE_CALLBACKS is selected by XEN_SAVE_RESTORE
arch/x86/xen/Kconfig:40:        symbol XEN_SAVE_RESTORE depends on PARAVIRT_GUEST
arch/x86/Kconfig:574:   symbol PARAVIRT_GUEST depends on IPIPE
kernel/ipipe/Kconfig:1: symbol IPIPE is selected by XENOMAI
init/Kconfig:1765:      symbol XENOMAI depends on INPUT_PCSPKR
drivers/input/misc/Kconfig:96:  symbol INPUT_PCSPKR depends on INPUT
drivers/input/Kconfig:8:        symbol INPUT is selected by VT
drivers/tty/Kconfig:1:  symbol VT is selected by FB_STI
drivers/video/Kconfig:680:      symbol FB_STI depends on FB
drivers/video/Kconfig:36:       symbol FB is selected by DRM_KMS_HELPER
drivers/gpu/drm/Kconfig:28:     symbol DRM_KMS_HELPER is selected by DRM_UDL
drivers/gpu/drm/udl/Kconfig:1:  symbol DRM_UDL depends on USB_ARCH_HAS_HCD
drivers/usb/Kconfig:82: symbol USB_ARCH_HAS_HCD depends on PCMCIA

This may be a false positive of Kbuild, need to dig deeper. It is
definitely harmless, just ugly.

So far,
Jan

-- 
Siemens AG, Corporate Technology, CT RTC ITP SDP-DE
Corporate Competence Center Embedded Linux

