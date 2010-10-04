From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <4CA6DC45.1080502@domain.hid>
References: <4CA6DC45.1080502@domain.hid>
Content-Type: text/plain; charset="UTF-8"
Date: Mon, 04 Oct 2010 12:53:04 +0200
Message-ID: <1286189584.1702.98.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [Adeos-main] [git pull] Updates/fixes/enhancements for
	2.6.35-noarch
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: adeos-main <adeos-main@gna.org>, Wolfgang Mauerer <wolfgang.mauerer@domain.hid>

On Sat, 2010-10-02 at 09:16 +0200, Jan Kiszka wrote:
> The following changes since commit 6c5707dc49c6e4c5d996bd884f00f719a1f87bb5:
> 
>   ipipe: virtual IRQ may inherit the root acknowledge handler (2010-08-29 21:06:53 +0200)
> 
> are available in the git repository at:
>   git://git.kiszka.org/ipipe-2.6 queues/2.6.35-noarch
> 
> Note that this queue includes a merge of 2.6.35.7. While rebasing x86
> ipipe over 2.5.35 I realized that the missing stable bits in -noarch
> complicated that step. Therefore I'm proposing to keep also this branch
> in sync with its related stable tree.
>  That also makes sense in case some
> generic bits collide with a stable update. Resolving this in -noarch
> will avoid doing it over and over again for every arch that merges as
> well.

Fine with me, I'm already tracking -stable for all the architectures I'm
maintaining, and Gilles is ok with doing so starting from 2.6.35 for ARM
as well.

> 
> [edited author stats]
> Jan Kiszka (8):
>       Merge commit 'v2.6.35.7' into queues/2.6.35-noarch
>       ipipe: Fix ipipe_safe_current definition for !CONFIG_IPIPE
>       ipipe: Report enabled IRQs on ipipe_restore_pipeline_head entry
>       ipipe: Add ipi parameter check to ipipe_send_ipi
>       ipipe: Generic, deadlock-safe ipipe_critical_enter/exit
>       ipipe: Convert !__ipipe_root_domain_p to context checks
>       ipipe: Introduce ipipe_prepare_panic
>       ipipe: Add root preemption notifier
> 

[snip]

http://download.gna.org/adeos/patches/v2.6/x86/adeos-ipipe-2.6.35.7-x86-2.7-04.patch


> Philippe Gerum (1):
>       ipipe: export __ipipe_serial_debug() to modules
> 
> Wolfgang Mauerer (1):
>       ipipe: Pass NTP-corrected time information from Linux to higher domains
> 
>  Documentation/sound/alsa/HD-Audio-Models.txt   |    1 +
>  Makefile                                       |    4 +-
>  arch/alpha/kernel/err_marvel.c                 |    6 +-
>  arch/alpha/kernel/proto.h                      |    3 -
>  arch/alpha/kernel/sys_cabriolet.c              |   19 ++-
>  arch/alpha/kernel/sys_takara.c                 |   11 +-
>  arch/arm/Kconfig                               |   12 +
>  arch/arm/include/asm/ptrace.h                  |   17 +-
>  arch/arm/include/asm/tlbflush.h                |    8 +
>  arch/arm/kernel/entry-common.S                 |    2 +
>  arch/arm/mach-at91/at91sam9g45_devices.c       |    2 +-
>  arch/arm/mach-ixp4xx/ixdp425-setup.c           |    1 +
>  arch/arm/mach-mx3/mach-qong.c                  |    1 +
>  arch/arm/mach-orion5x/ts78xx-setup.c           |    1 +
>  arch/arm/mach-pxa/cm-x300.c                    |    3 +-
>  arch/arm/plat-mxc/gpio.c                       |    8 +
>  arch/arm/plat-mxc/include/mach/gpio.h          |    2 +
>  arch/blackfin/mach-bf537/boards/stamp.c        |    1 +
>  arch/blackfin/mach-bf561/boards/acvilon.c      |    1 +
>  arch/ia64/include/asm/compat.h                 |    2 +-
>  arch/ia64/kernel/fsys.S                        |   30 ++-
>  arch/ia64/kernel/msi_ia64.c                    |    2 +-
>  arch/ia64/sn/kernel/msi_sn.c                   |    2 +-
>  arch/mips/include/asm/compat.h                 |    2 +-
>  arch/parisc/include/asm/compat.h               |    2 +-
>  arch/parisc/kernel/firmware.c                  |   12 +-
>  arch/powerpc/Makefile                          |   16 +-
>  arch/powerpc/include/asm/compat.h              |    2 +-
>  arch/powerpc/kernel/perf_event_fsl_emb.c       |    1 +
>  arch/powerpc/kernel/time.c                     |   23 +-
>  arch/s390/include/asm/compat.h                 |    2 +-
>  arch/sparc/include/asm/atomic_64.h             |   10 +-
>  arch/sparc/include/asm/compat.h                |    2 +-
>  arch/sparc/include/asm/fb.h                    |    4 +
>  arch/sparc/include/asm/oplib_64.h              |   27 +--
>  arch/sparc/include/asm/parport.h               |    4 +
>  arch/sparc/include/asm/rwsem-const.h           |    2 +-
>  arch/sparc/prom/cif.S                          |   16 +-
>  arch/sparc/prom/console_64.c                   |   48 +++-
>  arch/sparc/prom/devops_64.c                    |   36 +++-
>  arch/sparc/prom/misc_64.c                      |  314 +++++++++++++++++-------
>  arch/sparc/prom/p1275.c                        |  102 +--------
>  arch/sparc/prom/tree_64.c                      |  210 ++++++++++++-----
>  arch/x86/Kconfig                               |    5 +
>  arch/x86/ia32/ia32entry.S                      |   22 +-
>  arch/x86/include/asm/cmpxchg_32.h              |  121 ++++------
>  arch/x86/include/asm/cmpxchg_64.h              |   44 ++--
>  arch/x86/include/asm/compat.h                  |    2 +-
>  arch/x86/include/asm/hpet.h                    |    1 -
>  arch/x86/include/asm/tsc.h                     |    2 +
>  arch/x86/kernel/apic/apic.c                    |    2 +-
>  arch/x86/kernel/apic/io_apic.c                 |    4 +-
>  arch/x86/kernel/cpu/mtrr/main.c                |   56 ++++-
>  arch/x86/kernel/cpu/perf_event_intel.c         |   81 +++++--
>  arch/x86/kernel/cpu/perf_event_p4.c            |   11 +-
>  arch/x86/kernel/cpu/vmware.c                   |   10 +-
>  arch/x86/kernel/early-quirks.c                 |   18 --
>  arch/x86/kernel/hpet.c                         |   31 ++-
>  arch/x86/kernel/mpparse.c                      |   16 ++
>  arch/x86/kernel/smpboot.c                      |   26 ++
>  arch/x86/kernel/tsc.c                          |   38 +++
>  arch/x86/kvm/emulate.c                         |    4 +-
>  arch/x86/kvm/mmu.c                             |    8 +-
>  arch/x86/kvm/paging_tmpl.h                     |   28 ++-
>  arch/x86/kvm/vmx.c                             |    4 +
>  arch/x86/kvm/x86.c                             |    7 +-
>  arch/x86/lib/atomic64_386_32.S                 |  238 ++++++++++--------
>  arch/x86/mm/fault.c                            |    4 +-
>  arch/x86/mm/kmmio.c                            |   16 +-
>  arch/x86/mm/testmmiotrace.c                    |   22 ++
>  arch/x86/oprofile/nmi_int.c                    |   43 +++-
>  arch/x86/pci/acpi.c                            |    9 +
>  arch/x86/power/cpu.c                           |    2 +
>  arch/x86/xen/enlighten.c                       |    2 +-
>  arch/x86/xen/time.c                            |   39 ---
>  crypto/Kconfig                                 |    8 +
>  crypto/algboss.c                               |    4 +
>  crypto/testmgr.c                               |   14 +
>  drivers/acpi/apei/erst.c                       |    1 +
>  drivers/ata/ata_piix.c                         |    8 +
>  drivers/ata/libahci.c                          |    2 +-
>  drivers/ata/libata-core.c                      |   14 +-
>  drivers/ata/libata-eh.c                        |    4 +
>  drivers/ata/libata-sff.c                       |    7 +-
>  drivers/ata/pata_cmd64x.c                      |    6 -
>  drivers/ata/pata_via.c                         |    2 +
>  drivers/ata/sata_mv.c                          |   44 +++-
>  drivers/atm/solos-pci.c                        |    7 +-
>  drivers/base/power/main.c                      |    1 +
>  drivers/block/drbd/drbd_main.c                 |   27 ++-
>  drivers/bluetooth/btusb.c                      |    3 +
>  drivers/char/agp/intel-agp.c                   |   44 +++-
>  drivers/char/agp/intel-agp.h                   |   19 +-
>  drivers/char/agp/intel-gtt.c                   |   66 +++++-
>  drivers/char/ipmi/ipmi_si_intf.c               |    8 +
>  drivers/char/mem.c                             |    5 +-
>  drivers/char/nozomi.c                          |    4 +-
>  drivers/char/tty_io.c                          |    4 +-
>  drivers/char/virtio_console.c                  |    6 +-
>  drivers/dma/ioat/dma.h                         |    1 +
>  drivers/dma/ioat/dma_v2.c                      |   24 ++-
>  drivers/dma/ioat/dma_v3.c                      |    5 +-
>  drivers/edac/amd64_edac.c                      |    6 +-
>  drivers/gpu/drm/drm_crtc_helper.c              |    4 +-
>  drivers/gpu/drm/drm_drv.c                      |    4 +-
>  drivers/gpu/drm/i915/i915_dma.c                |   44 +++-
>  drivers/gpu/drm/i915/i915_drv.c                |    6 +
>  drivers/gpu/drm/i915/i915_gem.c                |    1 +
>  drivers/gpu/drm/i915/i915_reg.h                |    9 +
>  drivers/gpu/drm/i915/intel_display.c           |  186 ++++++++++-----
>  drivers/gpu/drm/i915/intel_dp.c                |   58 ++---
>  drivers/gpu/drm/i915/intel_drv.h               |    8 +-
>  drivers/gpu/drm/i915/intel_lvds.c              |    2 -
>  drivers/gpu/drm/i915/intel_overlay.c           |    7 +-
>  drivers/gpu/drm/i915/intel_ringbuffer.c        |    8 +-
>  drivers/gpu/drm/nouveau/nv50_instmem.c         |    2 +
>  drivers/gpu/drm/radeon/atombios_crtc.c         |   23 ++-
>  drivers/gpu/drm/radeon/evergreen.c             |   66 +++++-
>  drivers/gpu/drm/radeon/r600.c                  |   29 ++-
>  drivers/gpu/drm/radeon/r600d.h                 |    1 +
>  drivers/gpu/drm/radeon/radeon.h                |    6 +
>  drivers/gpu/drm/radeon/radeon_atombios.c       |   16 +-
>  drivers/gpu/drm/radeon/radeon_device.c         |    2 +-
>  drivers/gpu/drm/radeon/radeon_i2c.c            |    7 +
>  drivers/gpu/drm/radeon/radeon_irq_kms.c        |    5 +-
>  drivers/gpu/drm/radeon/radeon_kms.c            |    4 +-
>  drivers/gpu/drm/radeon/radeon_legacy_crtc.c    |    2 +-
>  drivers/gpu/drm/radeon/radeon_object.c         |   27 ++-
>  drivers/gpu/drm/radeon/radeon_pm.c             |    5 +
>  drivers/gpu/drm/radeon/rs690.c                 |   27 +--
>  drivers/gpu/drm/radeon/rv515.c                 |   23 +-
>  drivers/gpu/drm/radeon/rv770.c                 |   57 +++++-
>  drivers/gpu/drm/radeon/rv770d.h                |    1 +
>  drivers/hid/usbhid/hid-core.c                  |    3 +-
>  drivers/hwmon/ads7871.c                        |   38 ++--
>  drivers/hwmon/emc1403.c                        |    1 -
>  drivers/hwmon/f75375s.c                        |    6 +-
>  drivers/hwmon/hp_accel.c                       |    2 +
>  drivers/hwmon/k8temp.c                         |   35 +++-
>  drivers/hwmon/pc87360.c                        |   31 ++-
>  drivers/ide/ide-cd.c                           |   14 +-
>  drivers/infiniband/hw/cxgb3/cxio_hal.h         |    2 +-
>  drivers/input/mouse/appletouch.c               |    6 +-
>  drivers/input/serio/i8042.c                    |   67 ++++--
>  drivers/isdn/gigaset/capi.c                    |   17 +-
>  drivers/isdn/sc/ioctl.c                        |   10 +-
>  drivers/md/dm-exception-store.c                |    4 +-
>  drivers/md/dm-exception-store.h                |    3 +-
>  drivers/md/dm-ioctl.c                          |   50 +++--
>  drivers/md/dm-snap.c                           |   44 ++--
>  drivers/md/dm.c                                |   63 ++++--
>  drivers/md/dm.h                                |    5 +
>  drivers/md/md.c                                |   37 ++--
>  drivers/md/md.h                                |    4 +
>  drivers/md/raid10.c                            |   18 ++
>  drivers/memstick/core/mspro_block.c            |    6 +-
>  drivers/message/fusion/mptscsih.c              |    2 +
>  drivers/misc/enclosure.c                       |    7 +-
>  drivers/mmc/core/core.c                        |   83 +++++--
>  drivers/mmc/core/host.c                        |    6 +
>  drivers/mmc/host/tmio_mmc.c                    |    7 +-
>  drivers/mmc/host/tmio_mmc.h                    |   13 +-
>  drivers/mtd/chips/cfi_cmdset_0001.c            |   20 +-
>  drivers/mtd/lpddr/lpddr_cmds.c                 |   20 +-
>  drivers/mtd/nand/mxc_nand.c                    |    2 +-
>  drivers/mtd/nand/nand_base.c                   |    1 +
>  drivers/mtd/nand/plat_nand.c                   |    7 +-
>  drivers/mtd/nand/pxa3xx_nand.c                 |    2 +-
>  drivers/net/bonding/bond_3ad.c                 |    3 +
>  drivers/net/bonding/bond_alb.c                 |    3 +
>  drivers/net/cxgb3/cxgb3_main.c                 |    2 +
>  drivers/net/e100.c                             |    2 +
>  drivers/net/e1000/e1000_main.c                 |    3 +
>  drivers/net/e1000e/82571.c                     |   31 ++-
>  drivers/net/e1000e/defines.h                   |    4 +
>  drivers/net/e1000e/hw.h                        |    2 +-
>  drivers/net/e1000e/lib.c                       |   10 +
>  drivers/net/e1000e/netdev.c                    |   17 +-
>  drivers/net/eql.c                              |    2 +
>  drivers/net/igb/igb_main.c                     |   10 +-
>  drivers/net/igbvf/netdev.c                     |    2 +
>  drivers/net/ixgb/ixgb_main.c                   |    2 +
>  drivers/net/ixgbe/ixgbe_main.c                 |    1 +
>  drivers/net/ixgbevf/ixgbevf_main.c             |    2 +
>  drivers/net/smsc911x.c                         |   92 ++++---
>  drivers/net/usb/hso.c                          |    2 +
>  drivers/net/wireless/ath/ath5k/base.c          |   25 ++
>  drivers/net/wireless/ath/ath9k/ar9002_calib.c  |    2 +-
>  drivers/net/wireless/ath/ath9k/ar9003_eeprom.c |    4 +-
>  drivers/net/wireless/ath/ath9k/eeprom.h        |    4 +-
>  drivers/net/wireless/ath/ath9k/eeprom_4k.c     |    4 +-
>  drivers/net/wireless/ath/ath9k/eeprom_9287.c   |    4 +-
>  drivers/net/wireless/ath/ath9k/eeprom_def.c    |    6 +-
>  drivers/net/wireless/ath/ath9k/htc_drv_main.c  |    3 +-
>  drivers/net/wireless/ath/ath9k/htc_drv_txrx.c  |   15 +-
>  drivers/net/wireless/ath/ath9k/hw.c            |   23 ++-
>  drivers/net/wireless/ath/ath9k/xmit.c          |   95 +++++---
>  drivers/net/wireless/ath/regd.h                |    1 -
>  drivers/net/wireless/iwlwifi/iwl-3945.c        |   16 --
>  drivers/net/wireless/iwlwifi/iwl-agn-hcmd.c    |   17 +-
>  drivers/net/wireless/iwlwifi/iwl-agn-rs.c      |   17 +-
>  drivers/net/wireless/iwlwifi/iwl-agn-tx.c      |   20 +--
>  drivers/net/wireless/iwlwifi/iwl-agn.c         |   83 ++++++-
>  drivers/net/wireless/iwlwifi/iwl-core.c        |   70 ++----
>  drivers/net/wireless/iwlwifi/iwl-core.h        |   13 +-
>  drivers/net/wireless/iwlwifi/iwl-devtrace.h    |    2 +-
>  drivers/net/wireless/iwlwifi/iwl-scan.c        |   18 +-
>  drivers/net/wireless/iwlwifi/iwl3945-base.c    |   56 ++++-
>  drivers/net/wireless/p54/txrx.c                |    2 +-
>  drivers/net/wireless/rtl818x/rtl8180_dev.c     |    2 +
>  drivers/net/wireless/wl12xx/wl1251_cmd.c       |    2 +-
>  drivers/net/xen-netfront.c                     |    1 +
>  drivers/oprofile/buffer_sync.c                 |   27 +-
>  drivers/oprofile/cpu_buffer.c                  |    2 -
>  drivers/parisc/led.c                           |    6 +-
>  drivers/pci/intel-iommu.c                      |  118 ++++++----
>  drivers/pci/msi.c                              |   27 ++-
>  drivers/pci/quirks.c                           |    4 +
>  drivers/pcmcia/pcmcia_resource.c               |    5 +-
>  drivers/platform/x86/compal-laptop.c           |    9 +
>  drivers/platform/x86/dell-laptop.c             |    7 +
>  drivers/platform/x86/dell-wmi.c                |    2 +-
>  drivers/platform/x86/hp-wmi.c                  |   51 +++--
>  drivers/power/apm_power.c                      |    1 +
>  drivers/regulator/wm8994-regulator.c           |    5 +-
>  drivers/rtc/rtc-s3c.c                          |   13 +-
>  drivers/serial/8250.c                          |    2 +
>  drivers/serial/8250_pci.c                      |   13 +
>  drivers/serial/bfin_sport_uart.c               |    2 +-
>  drivers/serial/suncore.c                       |   15 +-
>  drivers/ssb/driver_chipcommon.c                |    1 +
>  drivers/ssb/pci.c                              |   15 +-
>  drivers/staging/batman-adv/hard-interface.c    |   21 +-
>  drivers/staging/batman-adv/originator.c        |   14 +-
>  drivers/staging/hv/Kconfig                     |    2 +-
>  drivers/staging/hv/netvsc_drv.c                |    3 +
>  drivers/staging/hv/ring_buffer.c               |    3 +-
>  drivers/staging/hv/storvsc_api.h               |    4 +-
>  drivers/staging/hv/storvsc_drv.c               |   11 +-
>  drivers/staging/line6/Kconfig                  |    1 +
>  drivers/staging/panel/panel.c                  |    2 +
>  drivers/staging/rt2860/usb_main_dev.c          |   42 +++-
>  drivers/staging/vt6655/wpactl.c                |   11 +-
>  drivers/usb/atm/cxacru.c                       |   24 ++-
>  drivers/usb/class/cdc-acm.c                    |   23 ++-
>  drivers/usb/core/hub.c                         |    6 +-
>  drivers/usb/core/message.c                     |   22 +-
>  drivers/usb/core/quirks.c                      |    3 +
>  drivers/usb/core/urb.c                         |   50 ++---
>  drivers/usb/gadget/rndis.c                     |   10 +-
>  drivers/usb/host/ehci-pci.c                    |    1 +
>  drivers/usb/host/ehci-ppc-of.c                 |   12 +-
>  drivers/usb/host/ehci-sched.c                  |   10 +-
>  drivers/usb/host/ehci.h                        |    1 +
>  drivers/usb/host/xhci-ring.c                   |    2 +-
>  drivers/usb/misc/usbtest.c                     |    6 +-
>  drivers/usb/mon/mon_bin.c                      |    2 +-
>  drivers/usb/musb/musb_debugfs.c                |   37 ++--
>  drivers/usb/serial/cp210x.c                    |   10 +-
>  drivers/usb/serial/ftdi_sio.c                  |   17 ++-
>  drivers/usb/serial/ftdi_sio_ids.h              |   31 +++
>  drivers/usb/serial/generic.c                   |   15 +-
>  drivers/usb/serial/io_ti.c                     |    2 +-
>  drivers/usb/serial/mos7720.c                   |    3 +
>  drivers/usb/serial/mos7840.c                   |   35 ++-
>  drivers/usb/serial/navman.c                    |    1 +
>  drivers/usb/serial/option.c                    |   20 ++-
>  drivers/usb/serial/pl2303.c                    |    1 +
>  drivers/usb/serial/pl2303.h                    |    4 +
>  drivers/video/matrox/matroxfb_base.h           |    4 +-
>  drivers/video/sis/sis_main.c                   |    3 +
>  drivers/video/via/ioctl.c                      |    2 +
>  drivers/video/w100fb.c                         |    4 +-
>  drivers/xen/events.c                           |   22 ++-
>  firmware/Makefile                              |    2 +-
>  fs/aio.c                                       |   13 +-
>  fs/binfmt_misc.c                               |    2 +-
>  fs/block_dev.c                                 |   14 +-
>  fs/char_dev.c                                  |    5 +-
>  fs/cifs/connect.c                              |    6 +-
>  fs/compat.c                                    |    2 +-
>  fs/direct-io.c                                 |   30 ++-
>  fs/ecryptfs/file.c                             |   60 +++--
>  fs/ecryptfs/inode.c                            |    5 +-
>  fs/ext4/ext4.h                                 |    4 +-
>  fs/ext4/inode.c                                |   17 +-
>  fs/ext4/super.c                                |    4 +-
>  fs/fuse/dev.c                                  |   16 +-
>  fs/gfs2/log.c                                  |    2 +-
>  fs/jfs/xattr.c                                 |   87 +++----
>  fs/minix/namei.c                               |    2 +-
>  fs/namespace.c                                 |    2 +-
>  fs/nfs/client.c                                |    2 +-
>  fs/nfs/dir.c                                   |    2 +-
>  fs/nfs/nfs4proc.c                              |    8 +-
>  fs/nfs/super.c                                 |   15 ++
>  fs/nilfs2/super.c                              |    4 +-
>  fs/notify/inotify/inotify_user.c               |    7 +-
>  fs/ocfs2/acl.c                                 |   33 ++-
>  fs/ocfs2/aops.c                                |    7 +-
>  fs/ocfs2/dlm/dlmmaster.c                       |    9 +-
>  fs/ocfs2/dlm/dlmrecovery.c                     |   22 +-
>  fs/ocfs2/dlm/dlmthread.c                       |  114 ++++-----
>  fs/ocfs2/inode.c                               |    6 +-
>  fs/ocfs2/refcounttree.c                        |   20 ++-
>  fs/proc/task_mmu.c                             |    8 +-
>  fs/proc/vmcore.c                               |    2 +-
>  fs/signalfd.c                                  |    2 +
>  fs/super.c                                     |    6 +
>  fs/sysfs/file.c                                |    2 +-
>  fs/xfs/linux-2.6/xfs_aops.c                    |   24 ++-
>  fs/xfs/linux-2.6/xfs_aops.h                    |    2 +
>  fs/xfs/linux-2.6/xfs_ioctl.c                   |    2 +
>  fs/xfs/xfs_ialloc.c                            |   16 +-
>  fs/xfs/xfs_inode.c                             |   49 ++--
>  include/acpi/platform/aclinux.h                |   10 +-
>  include/drm/drm_pciids.h                       |    7 +
>  include/linux/Kbuild                           |    1 +
>  include/linux/compat.h                         |    3 +
>  include/linux/fs.h                             |   10 +-
>  include/linux/interrupt.h                      |    7 +-
>  include/linux/ipipe.h                          |   46 ++++-
>  include/linux/ipipe_base.h                     |   15 +-
>  include/linux/ipipe_tickdev.h                  |   25 ++
>  include/linux/ksm.h                            |   20 +-
>  include/linux/kvm_host.h                       |    1 +
>  include/linux/libata.h                         |    1 +
>  include/linux/mm.h                             |    8 +-
>  include/linux/mm_types.h                       |    2 +-
>  include/linux/mmc/host.h                       |    3 +
>  include/linux/mmzone.h                         |   13 +
>  include/linux/msi.h                            |    2 +
>  include/linux/mtd/flashchip.h                  |    2 +-
>  include/linux/netdevice.h                      |    2 +
>  include/linux/notifier.h                       |    1 +
>  include/linux/sched.h                          |    6 -
>  include/linux/skbuff.h                         |    4 +-
>  include/linux/swap.h                           |    3 +-
>  include/linux/tty.h                            |    3 +
>  include/linux/usb/quirks.h                     |    4 +
>  include/linux/vmstat.h                         |   22 ++
>  include/net/sock.h                             |    1 +
>  include/net/tcp.h                              |   36 +++-
>  include/net/udp.h                              |    1 +
>  include/sound/emu10k1.h                        |    1 +
>  include/trace/events/timer.h                   |    8 +-
>  kernel/compat.c                                |   21 ++
>  kernel/exit.c                                  |    5 +-
>  kernel/fork.c                                  |    7 +-
>  kernel/gcov/fs.c                               |  244 ++++++++++++++-----
>  kernel/groups.c                                |    5 +-
>  kernel/hw_breakpoint.c                         |    3 +-
>  kernel/ipipe/Kconfig                           |    3 +
>  kernel/ipipe/core.c                            |  204 +++++++++++++++-
>  kernel/irq/manage.c                            |    2 +-
>  kernel/power/snapshot.c                        |   85 +++++--
>  kernel/sched.c                                 |   28 +--
>  kernel/signal.c                                |    9 +-
>  kernel/sys.c                                   |    2 +
>  kernel/time/tick-sched.c                       |    2 +-
>  kernel/time/timekeeping.c                      |   14 +-
>  kernel/trace/ftrace.c                          |   19 +-
>  kernel/trace/ring_buffer.c                     |    3 +
>  kernel/trace/trace_functions_graph.c           |   10 +-
>  mm/backing-dev.c                               |    2 +
>  mm/bounce.c                                    |    2 +-
>  mm/compaction.c                                |    7 +-
>  mm/ksm.c                                       |    3 -
>  mm/memory.c                                    |   87 ++++++-
>  mm/memory_hotplug.c                            |   16 +-
>  mm/mlock.c                                     |   19 ++
>  mm/mmap.c                                      |   25 ++-
>  mm/mmzone.c                                    |   21 ++
>  mm/nommu.c                                     |    7 +-
>  mm/page-writeback.c                            |   26 +--
>  mm/page_alloc.c                                |   33 ++-
>  mm/percpu.c                                    |    2 +-
>  mm/slab.c                                      |    4 +-
>  mm/swapfile.c                                  |   29 ++-
>  mm/vmscan.c                                    |   43 +++-
>  mm/vmstat.c                                    |   15 +-
>  net/9p/trans_fd.c                              |    2 +-
>  net/Kconfig                                    |    2 +-
>  net/bridge/br_device.c                         |    8 +-
>  net/bridge/br_fdb.c                            |    2 +-
>  net/bridge/br_input.c                          |    6 +-
>  net/bridge/br_netfilter.c                      |    6 +-
>  net/bridge/br_stp_bpdu.c                       |    2 +-
>  net/can/bcm.c                                  |   41 ++-
>  net/can/raw.c                                  |    4 +
>  net/core/dev.c                                 |    9 +-
>  net/core/skbuff.c                              |    6 +-
>  net/ipv4/datagram.c                            |    5 +-
>  net/ipv4/devinet.c                             |    1 +
>  net/ipv4/netfilter/arp_tables.c                |    3 +
>  net/ipv4/netfilter/ip_tables.c                 |    3 +
>  net/ipv4/route.c                               |    7 +-
>  net/ipv4/tcp.c                                 |   39 ++--
>  net/ipv4/tcp_timer.c                           |    8 +-
>  net/ipv4/udp.c                                 |   44 ++++
>  net/ipv6/datagram.c                            |    7 +-
>  net/ipv6/netfilter/ip6_tables.c                |    3 +
>  net/ipv6/udp.c                                 |   10 +
>  net/irda/af_irda.c                             |    4 +-
>  net/irda/irlan/irlan_common.c                  |    2 +-
>  net/l2tp/l2tp_eth.c                            |    2 +-
>  net/llc/af_llc.c                               |    3 +-
>  net/mac80211/main.c                            |    6 +
>  net/mac80211/mesh_plink.c                      |   42 +++-
>  net/netlink/af_netlink.c                       |   46 ++---
>  net/rds/recv.c                                 |    2 +-
>  net/sched/act_nat.c                            |    3 +-
>  net/sched/sch_generic.c                        |   18 ++
>  net/sched/sch_sfq.c                            |   13 +
>  net/sctp/output.c                              |    1 -
>  net/sunrpc/auth_gss/auth_gss.c                 |    9 +-
>  net/sunrpc/rpc_pipe.c                          |    6 +-
>  net/unix/af_unix.c                             |   15 +-
>  net/wireless/mlme.c                            |   16 +-
>  net/wireless/scan.c                            |    5 +
>  net/wireless/wext-compat.c                     |    3 +
>  net/wireless/wext-core.c                       |   16 ++
>  scripts/mkmakefile                             |    4 +-
>  security/integrity/ima/ima.h                   |    1 +
>  security/integrity/ima/ima_iint.c              |    4 +-
>  security/integrity/ima/ima_main.c              |    8 +-
>  security/keys/keyctl.c                         |    6 +-
>  sound/core/pcm_native.c                        |    4 +
>  sound/core/seq/oss/seq_oss_init.c              |    9 +-
>  sound/pci/emu10k1/emu10k1.c                    |    4 +
>  sound/pci/emu10k1/emupcm.c                     |   30 ++-
>  sound/pci/emu10k1/memory.c                     |    4 +-
>  sound/pci/hda/hda_codec.c                      |    2 +-
>  sound/pci/hda/patch_cirrus.c                   |   50 ++++
>  sound/pci/hda/patch_conexant.c                 |   59 +++++
>  sound/pci/hda/patch_nvhdmi.c                   |   61 +++--
>  sound/pci/hda/patch_realtek.c                  |   22 ++-
>  sound/pci/hda/patch_sigmatel.c                 |   12 +-
>  sound/pci/intel8x0.c                           |    6 +
>  sound/pci/oxygen/oxygen.h                      |    1 +
>  sound/pci/oxygen/oxygen_lib.c                  |   21 ++-
>  sound/pci/oxygen/virtuoso.c                    |    1 +
>  sound/pci/oxygen/xonar_wm87x6.c                |   22 ++-
>  sound/pci/riptide/riptide.c                    |   11 +-
>  sound/soc/codecs/wm8580.c                      |    6 +-
>  sound/soc/codecs/wm8776.c                      |    7 -
>  sound/soc/soc-cache.c                          |    4 +-
>  sound/usb/card.c                               |   19 +-
>  sound/usb/clock.c                              |    3 +-
>  sound/usb/endpoint.c                           |   11 +-
>  sound/usb/format.c                             |   14 +-
>  sound/usb/mixer.c                              |   10 +-
>  sound/usb/pcm.c                                |    3 +-
>  tools/perf/util/callchain.h                    |    1 +
>  virt/kvm/kvm_main.c                            |    1 +
>  455 files changed, 5403 insertions(+), 2385 deletions(-)
> 

-- 
Philippe.



