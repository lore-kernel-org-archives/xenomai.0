From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <55DF2EBE.9090105@siemens.com>
Date: Thu, 27 Aug 2015 17:37:34 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: [Xenomai] [PULL 2/2] ipipe-3.18: Stable merges
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>, Xenomai <xenomai@xenomai.org>

The following changes since commit b115c4094d734e19fa7a96be1bf3958b3d244b8b:

  Revert "ipipe: Register function tracer for direct and exclusive invocation" (2015-08-27 17:22:39 +0200)

are available in the git repository at:

  git://git.xenomai.org/ipipe-jki for-upstream/3.18

for you to fetch changes up to 87ecd772fff628dded2c2d1c482d4756f3bc40f4:

  Merge tag 'v3.18.20' into for-upstream/3.18 (2015-08-27 17:24:37 +0200)

The merge of 3.18.19 required two ipipe-specific fix-ups:

 x86/ipipe: Remove duplicate cpu_tlbstate export
 x86/ipipe: Account for mwait-based halt

3.18.20 applied smoothly.

----------------------------------------------------------------
AMAN DEEP (1):
      usb: xhci: Bugfix for NULL pointer deference in xhci_endpoint_init() function

Aaro Koskinen (3):
      MIPS: OCTEON: dma-octeon: fix OHCI USB config check
      MIPS: OCTEON: fix PCI interrupt mapping for D-Link DSR-1000N
      pata_octeon_cf: fix broken build

Aaron Lu (1):
      gpio: crystalcove: set IRQCHIP_SKIP_SET_WAKE for the irqchip

Adam Honse (1):
      ALSA: usb-audio: Don't attempt to get Microsoft Lifecam Cinema sample rate

Adam Jackson (1):
      drm/mgag200: Reject non-character-cell-aligned mode widths

Adrien Schildknecht (1):
      SSB: fix Kconfig dependencies

Akinobu Mita (3):
      target/file: Fix BUG() when CONFIG_DEBUG_SG=y and DIF protection enabled
      target/file: Fix UNMAP with DIF protection support
      target/file: Fix SG table for prot_buf initialization

Al Viro (8):
      ocfs2: _really_ sync the right range
      ioctx_alloc(): fix vma (and file) leak on failure
      RCU pathwalk breakage when running into a symlink overmounting something
      path_openat(): fix double fput()
      coredump: accept any write method
      d_walk() might skip too much
      9p: forgetting to cancel request on interrupted zero-copy RPC
      9p: don't leave a half-initialized inode sitting around

Alan Stern (1):
      USB: usbfs: allow URBs to be reaped after disconnection

Aleksei Mamlin (1):
      libata: add ATA_HORKAGE_BROKEN_FPDMA_AA quirk for HP 250GB SATA disk VB0250EAVER

Alex Deucher (12):
      drm/radeon/dpm: fix 120hz handling harder
      drm/radeon: fix doublescan modes (v2)
      drm/radeon: adjust pll when audio is not enabled
      drm/radeon: add SI DPM quirk for Sapphire R9 270 Dual-X 2G GDDR5
      drm/radeon: add new bonaire pci id
      drm/radeon: retry dcpd fetch
      drm/radeon: don't share plls if monitors differ in audio support
      Revert "drm/radeon: don't share plls if monitors differ in audio support"
      Revert "drm/radeon: adjust pll when audio is not enabled"
      drm/radeon: take the mode_config mutex when dealing with hpds (v2)
      ALSA: hda - set proper caps for newer AMD hda audio in KB/KV
      drm/radeon: add a dpm quirk for Sapphire Radeon R9 270X 2GB GDDR5

Alex Williamson (2):
      iommu/vt-d: Detach domain *only* from attached iommus
      PCI: pciehp: Wait for hotplug command completion where necessary

Alexander Duyck (1):
      jhash: Update jhash_[321]words functions to use correct initval

Alexander Ploumistos (1):
      Bluetooth: ath3k: Add support Atheros AR5B195 combo Mini PCIe card

Alexander Sverdlin (2):
      MIPS: Octeon: Remove udelay() causing huge IRQ latency
      sctp: Fix race between OOTB responce and route removal

Alexander Usyskin (1):
      mei: me: wait for power gating exit confirmation

Alexei Starovoitov (4):
      bpf: fix verifier memory corruption
      bpf: fix 64-bit divide
      x86: bpf_jit: fix FROM_BE16 and FROM_LE16/32 instructions
      x86: bpf_jit: fix compilation of large bpf programs

Alexey Brodkin (1):
      stmmac: troubleshoot unexpected bits in des0 & des1

Alexey Khoroshilov (1):
      sound/oss: fix deadlock in sequencer_ioctl(SNDCTL_SEQ_OUTOFBAND)

Alexey Kodanev (1):
      net: tcp6: fix double call of tcp_v6_fill_cb()

Alexey Sokolov (1):
      cdc-acm: Add support of ATOL FPrint fiscal printers

Alistair Strachan (1):
      staging: android: sync: Fix memory corruption in sync_timeline_signal().

Anantha Krishnan (1):
      Bluetooth: Add support for Acer [0489:e078]

Andi Kleen (1):
      tools/vm: fix page-flags build

Andre Przywara (7):
      arm64: add cpu_capabilities bitmap
      arm64: add alternative runtime patching
      arm64: detect silicon revisions and set cap bits accordingly
      arm64: add Cortex-A53 cache errata workaround
      arm64: add Cortex-A57 erratum 832075 workaround
      arm64: protect alternatives workarounds with Kconfig options
      KVM: arm/arm64: check IRQ number on userland injection

Andrea Arcangeli (1):
      kvm: fix crash in kvm_vcpu_reload_apic_access_page

Andreas Werner (1):
      can: flexcan: Deferred on Regulator return EPROBE_DEFER

Andrew Elble (1):
      NFS: fix BUG() crash in notify_change() with patch to chown_common()

Andrew Morton (2):
      arch/x86/kvm/mmu.c: work around gcc-4.4.4 bug
      fs/binfmt_elf.c:load_elf_binary(): return -EINVAL on zero-length mappings

Andrey Ryabinin (1):
      ARM: 8320/1: fix integer overflow in ELF_ET_DYN_BASE

Andrzej Pietrasiewicz (1):
      usb: gadget: printer: enqueue printer's response for setup request

Andy Grover (1):
      target/pscsi: Don't leak scsi_host if hba is VIRTUAL_HOST

Andy Lutomirski (3):
      x86: Clean up cr4 manipulation
      x86: Store a per-cpu shadow copy of CR4
      x86/asm/irq: Stop relying on magic JMP behavior for early_idt_handlers

Anna Schumaker (1):
      NFS: Add a stub for GETDEVICELIST

Ansgar Hegerfeld (1):
      ALSA: hda/realtek - ALC292 dock fix for Thinkpad L450

Anton Blanchard (3):
      powerpc/perf: Cap 64bit userspace backtraces to PERF_MAX_STACK_DEPTH
      powerpc: Align TOC to 256 bytes
      powerpc/perf: Fix book3s kernel to userspace backtraces

Anton Nayshtut (1):
      bonding: Bonding Overriding Configuration logic restored.

Aravind Gopalakrishnan (1):
      x86/iommu: Fix header comments regarding standard and _FINISH macros

Archit Taneja (1):
      clk: qcom: fix RCG M/N counter configuration

Ard Biesheuvel (3):
      kvm: add a memslot flag for incoherent memory regions
      arm, arm64: KVM: handle potential incoherency of readonly memslots
      ARM: 8221/1: PJ4: allow building in Thumb-2 mode

Arnd Bergmann (3):
      [media] Add and use IS_REACHABLE macro
      dmaengine: shdmac: avoid unused variable warnings
      ideapad: fix software rfkill setting

Arne Fitzenreiter (2):
      libata: add ATA_HORKAGE_NOTRIM
      libata: force disable trim for SuperSSpeed S238

Arun Chandran (1):
      regmap: Fix regmap_bulk_read in BE mode

Axel Lin (7):
      usb: phy: Find the right match in devm_usb_phy_match
      ASoC: mc13783: Fix wrong mask value used in mc13xxx_reg_rmw() calls
      irqchip: sunxi-nmi: Fix off-by-one error in irq iterator
      genirq: devres: Fix testing return value of request_any_context_irq()
      ASoC: wm8737: Fixup setting VMID Impedance control register
      ASoC: wm8903: Fix define for WM8903_VMID_RES_250K
      ASoC: wm8955: Fix setting wrong register for WM8955_K_8_0_MASK bits

Bandan Das (1):
      KVM: nSVM: Check for NRIPS support before updating control field

Bard Liao (1):
      ASoC: rt5677: fixed wrong DMIC ref clock

Bart Van Assche (2):
      Defer processing of REQ_PREEMPT requests for blocked devices
      scsi_transport_srp: Introduce srp_wait_for_queuecommand()

Bartlomiej Zolnierkiewicz (2):
      cpuidle: remove state_count field from struct cpuidle_device
      clk: samsung: exynos4: Disable ARMCLK down feature on Exynos4210 SoC

Baruch Siach (4):
      pinctrl: remove maxpin from documentation
      pinctrl: remove enable/disable callbacks from documentation
      pinctrl: remove doc mention of the enable/disable API
      pinctrl: fix example .get_group_pins implementation signature

Ben Collins (1):
      Revert "dm crypt: fix deadlock when async crypto algorithm returns -EBUSY"

Ben Hutchings (3):
      usbnet: Fix tx_packets stat for FLAG_MULTI_FRAME drivers
      usbnet: Fix tx_bytes statistic running backward in cdc_ncm
      xen-pciback: Add name prefix to global 'permissive' variable

Ben Serebrin (1):
      KVM: VMX: Preserve host CR4.MCE value while in guest mode.

Benjamin Herrenschmidt (1):
      drivers/of: Add empty ranges quirk for PA-Semi

Benjamin Poirier (1):
      mlx4: Fix tx ring affinity_mask creation

Benjamin Tissoires (2):
      HID: uclogic: Set quirks from inside the driver
      HID: Introduce hidpp, a module to handle Logitech hid++ devices

Bjorn Helgaas (3):
      PCI: Don't look for ACPI hotplug parameters if ACPI is disabled
      x86/PCI: Use host bridge _CRS info on Foxconn K8M890-8237A
      x86/PCI: Use host bridge _CRS info on systems with >32 bit addressing

Bjørn Mork (1):
      cdc_ncm: Fix tx_bytes statistics

Bo Yan (1):
      arm64: fix midr range for Cortex-A57 erratum 832075

Bob Copeland (1):
      omfs: fix sign confusion for bitmap loop counter

Boris Brezillon (3):
      clk: at91: usb: propagate rate modification to the parent clk
      clk: at91: usb: fix determine_rate prototype
      clk: at91: pll: fix input range validity check

Boris Ostrovsky (4):
      xen/events: Clear cpu_evtchn_mask before resuming
      xen/xenbus: Update xenbus event channel on resume
      xen/console: Update console event channel on resume
      xen/events: Set irq_info->evtchn before binding the channel to CPU in __startup_pirq()

Borislav Petkov (2):
      x86/mce: Fix MCE severity messages
      x86/boot: Fix overflow warning with 32-bit binutils

Brian King (1):
      ipr: Increase default adapter init stage change timeout

Brian Norris (5):
      UBI: account for bitflips in both the VID header and data
      UBI: fix out of bounds write
      UBI: initialize LEB number variable
      UBI: fix check for "too many bytes"
      mtd: fix: avoid race condition when accessing mtd->usecount

Brian Silverman (1):
      sched: Fix RLIMIT_RTTIME when PI-boosting to RT

Calvin Owens (1):
      ksoftirqd: Enable IRQs and call cond_resched() before poking RCU

Catalin Marinas (2):
      arm64: Do not attempt to use init_mm in reset_context()
      mm: kmemleak: allow safe memory scanning during kmemleak disabling

Charles Keepax (2):
      ARM: S3C64XX: Use fixed IRQ bases to avoid conflicts on Cragganmore
      ASoC: dapm: Enable autodisable on SOC_DAPM_SINGLE_TLV_AUTODISABLE

Chen Gang (1):
      netfilter: nfnetlink_cthelper: Remove 'const' and '&' to avoid warnings

Chen Yucong (1):
      x86, mce, severity: Extend the the mce_severity mechanism to handle UCNA/DEFERRED error

Chen-Yu Tsai (2):
      ARM: sunxi: Have ARCH_SUNXI select RESET_CONTROLLER for clock driver usage
      mmc: sunxi: Use devm_reset_control_get_optional() for reset control

Chris Bainbridge (2):
      ACPI / SBS: Enable battery manager when present
      ACPI / SBS: Add 5 us delay to fix SBS hangs on MacBook

Chris Lesiak (1):
      hwmon: (ntc_thermistor) Ensure iio channel is of type IIO_VOLTAGE

Chris Metcalf (1):
      __bitmap_parselist: fix bug in empty string handling

Chris Wilson (1):
      agp/intel: Fix typo in needs_ilk_vtd_wa()

Christian Borntraeger (3):
      kernel: Provide READ_ONCE and ASSIGN_ONCE
      kernel: Change ASSIGN_ONCE(val, x) to WRITE_ONCE(x, val)
      KVM: s390: no need to hold the kvm->mutex for floating interrupts

Christian König (13):
      drm/radeon: add extra check in radeon_ttm_tt_unpin_userptr
      drm/radeon: fix wait in radeon_mn_invalidate_range_start
      drm/radeon: check new address before removing old one
      drm/radeon: disable semaphores for UVD V1 (v2)
      drm/radeon: make VCE handle check more strict
      drm/radeon: make UVD handle checking more strict
      drm/radeon: more strictly validate the UVD codec
      drm/radeon: fix VM_CONTEXT*_PAGE_TABLE_END_ADDR handling
      drm/radeon: partially revert "fix VM_CONTEXT*_PAGE_TABLE_END_ADDR handling"
      drm/radeon: fix lockup when BOs aren't part of the VM on release
      drm/radeon: reset BOs address after clearing it.
      drm/radeon: fix VM_CONTEXT*_PAGE_TABLE_END_ADDR handling
      drm/radeon: partially revert "fix VM_CONTEXT*_PAGE_TABLE_END_ADDR handling"

Christoffer Dall (11):
      arm/arm64: KVM: Don't clear the VCPU_POWER_OFF flag
      arm/arm64: KVM: Correct KVM_ARM_VCPU_INIT power off option
      arm/arm64: KVM: Reset the HCR on each vcpu when resetting the vcpu
      arm/arm64: KVM: Turn off vcpus on PSCI shutdown/reboot
      arm/arm64: KVM: Introduce stage2_unmap_vm
      arm/arm64: KVM: Don't allow creating VCPUs after vgic_initialized
      arm/arm64: KVM: Initialize the vgic on-demand when injecting IRQs
      arm/arm64: KVM: Require in-kernel vgic for the arch timers
      arm/arm64: KVM: Keep elrsr/aisr in sync with software model
      stable: Update documentation to clarify preferred procedure
      arm64: Don't report clear pmds and puds as huge

Christoph Hellwig (4):
      3w-xxxx: fix command completion race
      3w-9xxx: fix command completion race
      3w-sas: fix command completion race
      nfsd: fix the check for confirmed openowner in nfs4_preprocess_stateid_op

Christoph Paasch (1):
      tcp: Do not call tcp_fastopen_reset_cipher from interrupt context

Christophe Ricard (3):
      NFC: st21nfcb: Retry i2c_master_send if it returns a negative value
      NFC: st21nfcb: Do not remove header once the payload is sent
      NFC: st21nfcb: remove st21nfcb_nci_i2c_disable

Chuanxiao Dong (1):
      mmc: card: Don't access RPMB partitions for normal read/write

Chuck Lever (3):
      xprtrdma: Take struct ib_device_attr off the stack
      xprtrdma: Prevent infinite loop in rpcrdma_ep_create()
      NFS: Fix size of NFSACL SETACL operations

Claudio Cappelli (1):
      USB: option: add 2020:4000 ID

Clemens Ladisch (1):
      ALSA: usb-audio: add MAYA44 USB+ mixer control names

Colin Ian King (1):
      KEYS: ensure we free the assoc array edit if edit is valid

Cornelia Huck (1):
      KVM: s390: virtio-ccw: don't overwrite config space values

Cyrille Pitchen (1):
      i2c: at91: fix a race condition when using the DMA controller

D.S. Ljungmark (1):
      ipv6: Don't reduce hop limit for an interface

Damian Eppel (1):
      clocksource: exynos_mct: Avoid blocking calls in the cpu hotplug notifier

Dan Carpenter (4):
      PCI: cpcihp: Add missing curly braces in cpci_configure_slot()
      memstick: mspro_block: add missing curly braces
      ASoC: imx-wm8962: Add a missing error check
      USB: devio: fix a condition in async_completed()

Dan Williams (2):
      ahci: avoton port-disable reset-quirk
      block: fix ext_dev_lock lockdep report

Daniel Borkmann (3):
      ebpf: verifier: check that call reg with ARG_ANYTHING is initialized
      net: sched: fix call_rcu() race on classifier module unloads
      netfilter: x_tables: fix cgroup matching on non-full sks

Daniel Vetter (4):
      drm: Fixup racy refcounting in plane_force_disable
      drm/i915: Align initial plane backing objects correctly
      drm/i915: Dont enable CS_PARSER_ERROR interrupts at all
      drm/dp/mst: make sure mst_primary mstb is valid in work function

Darren Salt (1):
      HID: saitek: add USB ID for older R.A.T. 7

Darrick J. Wong (2):
      jbd2: fix r_count overflows leading to buffer overflow in journal recovery
      ext4: don't retry file block mapping on bigalloc fs with non-extent file

Darshana Padmadas (1):
      iio: imu: Use iio_trigger_get for indio_dev->trig assignment

Dave Airlie (1):
      drm/dp/mst: take lock around looking up the branch device on hpd irq

Dave Chinner (3):
      xfs: ensure truncate forces zeroed blocks to disk
      xfs: xfs_attr_inactive leaves inconsistent attr fork state behind
      xfs: xfs_iozero can return positive errno

Dave Olson (1):
      powerpc: Fix missing L2 cache size in /sys/devices/system/cpu

Dave P Martin (1):
      arm64: mm: Fix freeing of the wrong memmap entries with !SPARSEMEM_VMEMMAP

David Daney (1):
      stable_kernel_rules: Add clause about specification of kernel versions to patch.

David Disseldorp (1):
      cifs: fix use-after-free bug in find_writable_file

David Fries (1):
      w1_therm reference count family data

David Henningsson (6):
      ALSA: hda - fix "num_steps = 0" error on ALC256
      ALSA: hda - Add headset mic quirk for Dell Inspiron 5548
      ALSA: hda - Fix headset mic and mic-in for a Dell desktop
      ALSA: hda - Disable Headphone Mic boost for ALC662
      ALSA: hda - Add Conexant codecs CX20721, CX20722, CX20723 and CX20724
      ALSA: hda - Fix Dock Headphone on Thinkpad X250 seen as a Line Out

David Hildenbrand (2):
      KVM: s390: fix handling of write errors in the tpi handler
      KVM: s390: reinjection of irqs can fail in the tpi handler

David Härdeman (1):
      [media] rc-core: fix dib0700 scancode generation for RC5

David Miller (1):
      radeon: Do not directly dereference pointers to BIOS area.

David S. Miller (1):
      ipv4: Missing sk_nulls_node_init() in ping_unhash().

David Sterba (2):
      btrfs: simplify insert_orphan_item
      btrfs: don't accept bare namespace as a valid xattr

David Vrabel (2):
      xen/events: don't bind non-percpu VIRQs with percpu chip
      x86/xen: allow privcmd hypercalls to be preempted

David Woodhouse (1):
      iommu/vt-d: Allow RMRR on graphics devices too

Davide Italiano (1):
      ext4: move check under lock scope to close a race.

Deepak S (1):
      drm/i915/vlv: remove wait for previous GFX clk disable request

Dennis Yang (1):
      dm btree remove: fix bug in redistribute3

Ding Wang (1):
      mmc: card: Fixup request missing in mmc_blk_issue_rw_rq

Dmitry M. Fedin (1):
      ALSA: usb - Creative USB X-Fi Pro SB1095 volume knob support

Dmitry Monakhov (1):
      jbd2: use GFP_NOFS in jbd2_cleanup_journal_tail()

Dmitry Osipenko (1):
      ARM: tegra20: Store CPU "resettable" status in IRAM

Dmitry Torokhov (2):
      i2c: rk3x: report number of messages transmitted
      drm/i915: cope with large i2c transfers

Dmitry Tunin (5):
      ath3k: Add support of 0489:e076 AR3012 device
      ath3k: add support of 13d3:3474 AR3012 device
      ideapad_laptop: Lenovo G50-30 fix rfkill reports wireless blocked
      Bluetooth: ath3k: add support of 04ca:300f AR3012 device
      Bluetooth: ath3k: Add support of 04ca:300d AR3012 device

Doug Anderson (1):
      pinctrl: Don't just pretend to protect pinctrl_maps, do it for real

Doug Goldstein (2):
      USB: ftdi_sio: Added custom PID for Synapse Wireless product
      USB: ftdi_sio: Use jtag quirk for SNAP Connect E10

Ekaterina Tumanova (1):
      KVM: s390: Zero out current VMDB of STSI before including level3 data.

Emmanuel Grumbach (1):
      iwlwifi: dvm: run INIT firmware again upon .start()

Erez Shitrit (1):
      IB/mlx4: Fix WQE LSO segment calculation

Eric Auger (1):
      KVM: arm/arm64: vgic: vgic_init returns -ENODEV when no online vcpu

Eric Dumazet (13):
      tcp: tcp_make_synack() should clear skb->tstamp
      bnx2x: Fix busy_poll vs netpoll
      tcp: fix possible deadlock in tcp_send_fin()
      tcp: avoid looping in tcp_send_fin()
      net: do not deplete pfmemalloc reserve
      net: fix crash in build_skb()
      bridge: fix br_multicast_query_expired() bug
      udp: fix behavior of wrong checksums
      inet: add TCP_NEW_SYN_RECV state
      net: add sk_fullsock() helper
      tcp: tcp_get_info() should fetch socket fields once
      packet: read num_members once in packet_rcv_fanout()
      bnx2x: fix lockdep splat

Eric Sandeen (1):
      xfs: fix remote symlinks on V5/CRC filesystems

Eric W. Biederman (12):
      mnt: Improve the umount_tree flags
      mnt: Don't propagate umounts in __detach_mounts
      mnt: Fix fs_fully_visible to verify the root directory is visible
      mnt: Fail collect_mounts when applied to unmounted mounts
      fs_pin: Allow for the possibility that m_list or s_list go unused.
      ipv4: Avoid crashing in ip_error
      mnt: Fix the error check in __detach_mounts
      netfilter: nf_qeueue: Drop queue entries on nf_unregister_hook
      mnt: Refactor the logic for mounting sysfs and proc in a user namespace
      mnt: Modify fs_fully_visible to deal with locked ro nodev and atime
      vfs: Remove incorrect debugging WARN in prepend_path
      vfs: Ignore unlocked mounts in fs_fully_visible

Eric Wong (1):
      ALSA: usb-audio: don't try to get Benchmark DAC1 sample rate

Eric Work (1):
      md/raid0: fix restore to sector variable in raid0_make_request

Eryu Guan (3):
      ext4: check for zero length extent explicitly
      ext4: be more strict when migrating to non-extent based file
      ext4: correctly migrate a file with a hole at the beginning

Eugene Shatokhin (1):
      kprobes/x86: Return correct length in __copy_instruction()

Ezequiel Garcia (2):
      [media] stk1160: Make sure current buffer is released
      spi: pl022: Specify 'num-cs' property as required in devicetree binding

Fabian Frederick (3):
      fs/ufs: revert "ufs: fix deadlocks introduced by sb mutex merge"
      fs/ufs: restore s_lock mutex
      fs/ufs: restore s_lock mutex_init()

Fabio Estevam (1):
      ARM: dts: imx23-olinuxino: Fix polarity of LED GPIO

Felipe Balbi (16):
      usb: musb: core: fix TX/RX endpoint order
      usb: define a generic USB_RESUME_TIMEOUT macro
      usb: musb: use new USB_RESUME_TIMEOUT
      usb: host: oxu210hp: use new USB_RESUME_TIMEOUT
      usb: host: fusbh200: use new USB_RESUME_TIMEOUT
      usb: host: uhci: use new USB_RESUME_TIMEOUT
      usb: host: fotg210: use new USB_RESUME_TIMEOUT
      usb: host: r8a66597: use new USB_RESUME_TIMEOUT
      usb: host: isp116x: use new USB_RESUME_TIMEOUT
      usb: host: xhci: use new USB_RESUME_TIMEOUT
      usb: host: ehci: use new USB_RESUME_TIMEOUT
      usb: host: sl811: use new USB_RESUME_TIMEOUT
      usb: core: hub: use new USB_RESUME_TIMEOUT
      usb: dwc2: hcd: use new USB_RESUME_TIMEOUT
      usb: dwc3: gadget: don't clear EP_BUSY too early
      usb: musb: host: rely on port_mode to call musb_start()

Felix Fietkau (2):
      ath9k: fix tracking of enabled AP beacons
      ath9k: fix DMA stop sequence for AR9003+

Feng Kan (1):
      serial: 8250: add support for ACPI-probed serial port for X-Gene platform

Filipe Manana (6):
      Btrfs: fix log tree corruption when fs mounted with -o discard
      Btrfs: fix inode eviction infinite loop after cloning into it
      Btrfs: fix inode eviction infinite loop after extent_same ioctl
      Btrfs: make xattr replace operations atomic
      Btrfs: use kmem_cache_free when freeing entry in inode cache
      Btrfs: fix memory leak in the extent_same ioctl

Firo Yang (2):
      NFC: st21nfcb: Remove inappropriate kfree on a devm_kzalloc pointer
      md: fix a build warning

Florent Fourcot (1):
      tcp/ipv6: fix flow label setting in TIME_WAIT state

Florian Fainelli (1):
      net: phy: Allow EEE for all RGMII variants

Florian Westphal (1):
      netfilter: bridge: really save frag_max_size between PRE and POST_ROUTING

Frank C Guenther (1):
      ALSA: usb: Fix support for Denon DA-300USB DAC (ID 154e:1003)

Frank Praznik (1):
      HID: sony: Add support for the third-party SMK PS3 Bluetooth Remote

Frediano Ziglio (2):
      drm/qxl: Do not cause spice-server to clean our objects
      drm/qxl: Do not leak memory if qxl_release_list_add fails

Frodo Lai (1):
      Input: pixcir_i2c_ts - fix receive error

Gabriele Mazzotta (2):
      libata: Add helper to determine when PHY events should be ignored
      libata: Ignore spurious PHY event on LPM policy change

Ganesan Ramalingam (1):
      MIPS: Netlogic: Fix for SATA PHY init

Gavin Shan (1):
      powerpc/powernv: Don't map M64 segments using M32DT

Geert Uytterhoeven (1):
      [media] soc-camera: Fix devm_kfree() in soc_of_bind()

Geoff Levand (1):
      arm64/kvm: Fix assembler compatibility of macros

Gregory CLEMENT (4):
      ARM: mvebu: Disable CPU Idle on Armada 38x
      gpio: mvebu: Fix mask/unmask managment per irq chip type
      ARM: mvebu: armada-xp-openblocks-ax3-4: Disable internal RTC
      spi: orion: Fix maximum baud rates for Armada 370/XP

Grygorii Strashko (2):
      mmc: core: add missing pm event in mmc_pm_notify to fix hib restore
      leds / PM: fix hibernation on arm when gpio-led used with CPU led trigger

Gu Zheng (2):
      mm/memory hotplug: postpone the reset of obsolete pgdat
      mm/memory_hotplug.c: set zone->wait_table to null after freeing it

Guenter Roeck (2):
      hwmon: (nct6775) Add missing sysfs attribute initialization
      hwmon: (nct6683) Add missing sysfs attribute initialization

Haggai Eran (1):
      staging: rtl8712: prevent buffer overrun in recvbuf2recvframe

Hans Verkuil (2):
      [media] sh_veu: v4l2_dev wasn't set
      [media] vb2: fix 'UNBALANCED' warnings when calling vb2_thread_stop()

Hans de Goede (5):
      uas: Allow uas_use_uas_driver to return usb-storage flags
      uas: Add US_FL_MAX_SECTORS_240 flag
      uas: Set max_sectors_240 quirk for ASM1053 devices
      usb-storage: Add NO_WP_DETECT quirk for Lacie 059f:0651 devices
      Input: elantech - fix detection of touchpads where the revision matches a known rate

Harald Freudenberger (1):
      crypto: s390/ghash - Fix incorrect ghash icv buffer handling.

Heiko Carstens (1):
      s390/hibernate: fix save and restore of kernel text section

Helge Deller (1):
      parisc,metag: Fix crashes due to stack randomization on stack-grows-upwards architectures

Henning Rogge (1):
      net/ipv6/udp: Fix ipv6 multicast socket filter regression

Herbert Xu (2):
      Revert "net: Reset secmark when scrubbing packet"
      skbuff: Do not scrub skb mark within the same name space

Hon Ching \(Vicky\) Lo (1):
      vTPM: set virtual device before passing to ibmvtpm_reset_crq

Honggang LI (1):
      mlx5: wrong page mask if CONFIG_ARCH_DMA_ADDR_T_64BIT enabled for 32Bit architectures

Horia Geant? (2):
      crypto: talitos - avoid memleak in talitos_alg_alloc()
      Revert "crypto: talitos - convert to use be16_add_cpu()"

Howard Mitchell (1):
      ASoC: pcm512x: Add 'Analogue' prefix to analogue volume controls

Huacai Chen (2):
      MIPS: Loongson-3: Add IRQF_NO_SUSPEND to Cascade irqaction
      MIPS: Hibernate: flush TLB entries earlier

Hui Wang (3):
      ALSA: hda - Add one more node in the EAPD supporting candidate list
      ALSA: hda - fix headset mic detection problem for one more machine
      ALSA: hda - adding a DAC/pin preference map for a HP Envy TS machine

Ian Abbott (2):
      spi: spidev: fix possible arithmetic overflow for multi-transfer message
      staging: comedi: adv_pci1710: fix AI INSN_READ for non-zero channel

Ian Campbell (1):
      xen: netback: read hotplug script once at start of day.

Ian Wilson (1):
      netfilter: Zero the tuple in nfnl_cthelper_parse_tuple()

Ido Shamay (3):
      net/mlx4_en: Call register_netdevice in the proper location
      net/mlx4_en: Schedule napi when RX buffers allocation fails
      net/mlx4_en: Wake TX queues only when there's enough room

Igor Mammedov (1):
      kvm: avoid page allocation failure in kvm_set_memory_region()

Ilya Dryomov (5):
      rbd: end I/O the entire obj_request on error
      Revert "libceph: clear r_req_lru_item in __unregister_linger_request()"
      Revert "libceph: clear r_req_lru_item in __unregister_linger_request()"
      crush: ensuring at most num-rep osds are selected
      rbd: use GFP_NOIO in rbd_obj_request_create()

Imre Deak (1):
      drm/i915: vlv: fix save/restore of GFX_MAX_REQ_COUNT reg

Ingo Molnar (1):
      x86/fpu: Disable XSAVES* support for now

J. Bruce Fields (4):
      nfsd: return correct lockowner when there is a race on hash insert
      nfsd4: fix READ permission checking
      nfsd4: disallow SEEK with special stateids
      selinux: fix setting of security labels on NFS

JM Friedt (1):
      iio: DAC: ad5624r_spi: fix bit shift of output data value

Jack Morgenstein (1):
      net/mlx4_core: Fix error message deprecation for ConnectX-2 cards

Jakub Sitnicki (1):
      HID: microsoft: Add ID for NE7K wireless keyboard

James Bottomley (1):
      mvsas: fix panic on expander attached SATA devices

James Hogan (4):
      MIPS: KVM: Handle MSA Disabled exceptions from guest
      MIPS: lose_fpu(): Disable FPU when MSA enabled
      MIPS: Fix enabling of DEBUG_STACKOVERFLOW
      MIPS: Fix KVM guest fixmap address

Jan Kara (4):
      lib: Fix strnlen_user() to not touch memory after specified maximum
      fs: Fix S_NOSEC handling
      ufs: Fix warning from unlock_new_inode()
      ufs: Fix possible deadlock when looking up directories

Jan Kiszka (5):
      ARM: KVM: Fix size check in __coherent_cache_guest_page
      Merge tag 'v3.18.19' into for-upstream/3.18
      x86/ipipe: Remove duplicate cpu_tlbstate export
      x86/ipipe: Account for mwait-based halt
      Merge tag 'v3.18.20' into for-upstream/3.18

Jan Leupold (1):
      iio: adc: at91_adc: allow to use full range of startup time

Jan Stancek (1):
      powerpc: fix memory corruption by pnv_alloc_idle_core_states

Jani Nikula (3):
      drm/edid: set ELD for firmware and debugfs override EDIDs
      drm/i915/dp: there is no audio on port A
      drm/i915: Fix DDC probe for passive adapters

Jann Horn (1):
      fs: take i_mutex during prepare_binprm for set[ug]id executables

Janne Heikkinen (1):
      Bluetooth: Add USB device 04ca:3010 as Atheros AR3012

Janusz Dziedzic (1):
      mac80211: move WEP tailroom size check

Jason A. Donenfeld (5):
      USB: visor: Match I330 phone more precisely
      USB: pl2303: Remove support for Samsung I330
      ozwpan: Use proper check to prevent heap overflow
      ozwpan: divide-by-zero leading to panic
      ozwpan: unchecked signed subtraction leads to DoS

Jason Gunthorpe (2):
      RDMA/CMA: Canonize IPv4 on IPV6 sockets properly
      sctp: Fix mangled IPv4 addresses on a IPv6 listening socket

Jean Delvare (1):
      firmware: dmi_scan: Fix ordering of product_uuid

Jeff Layton (4):
      nfsd: return correct openowner when there is a race to put one in the hash
      nfs: increase size of EXCHANGE_ID name string buffer
      nfs: take extra reference to fl->fl_file when running a setlk
      nfs: take extra reference to fl->fl_file when running a LOCKU operation

Jens Freimann (1):
      KVM: s390: fix get_all_floating_irqs

Jeremiah Mahler (1):
      usb: serial: silence all non-critical read errors

Jesse Barnes (2):
      drm/i915/vlv: save/restore the power context base reg
      drm/i915/vlv: remove wait for previous GFX clk disable request

Jesse Gross (1):
      udptunnels: Call handle_offloads after inserting vlan tag.

Jiada Wang (1):
      serial: imx: Enable UCR4_OREN in startup interface

Jim Bride (1):
      drm/i915/hsw: Fix workaround for server AUX channel clock divisor

Jim Snow (1):
      sb_edac: Fix erroneous bytes->gigabytes conversion

Jingoo Han (1):
      of/address: use atomic allocation in pci_register_io_range()

Jiri Pirko (3):
      vlan: kill vlan_put_tag helper
      vlan: rename __vlan_put_tag to vlan_insert_tag_set_proto
      vlan: introduce *vlan_hwaccel_push_inside helpers

Jo-Philipp Wich (1):
      ALSA: hda/realtek - Enable the ALC292 dock fixup on the Thinkpad T450

Joe Konno (1):
      intel_pstate: set BYT MSR with wrmsrl_on_cpu()

Joe Lawrence (1):
      xhci: gracefully handle xhci_irq dead device

Joe Perches (1):
      selinux: fix sel_write_enforce broken return value

Joe Thornber (2):
      dm space map metadata: fix occasional leak of a metadata block on resize
      dm btree: silence lockdep lock inversion in dm_btree_del()

Joe Turner (1):
      ALSA: usb-audio: Don't attempt to get Lifecam HD-5000 sample rate

Joerg Roedel (1):
      iommu/amd: Handle large pages correctly in free_pagetable

Johan Hovold (1):
      gpio: sysfs: fix memory leaks and device hotplug

Johannes Berg (3):
      mac80211: fix RX A-MPDU session reorder timer deletion
      mac80211: don't use napi_gro_receive() outside NAPI context
      cfg80211: wext: clear sinfo struct before calling driver

Johannes Thumshirn (1):
      USB: serial: Destroy serial_minors IDR on module exit

John Crispin (1):
      MIPS: ralink: add missing symbol for RALINK_ILL_ACC

John D. Blair (1):
      USB: cp210x: add ID for HubZ dual ZigBee and Z-Wave dongle

John Soni Jose (1):
      be2iscsi: Fix kernel panic when device initialization fails

John Stultz (1):
      ktime: Fix ktime_divns to do signed division

John Youn (1):
      usb: dwc3: Reset the transfer resource index on SET_INTERFACE

Jonathan Davies (1):
      xen-netfront: transmit fully GSO-sized packets

Joseph Qi (1):
      jbd2: fix ocfs2 corrupt when updating journal superblock fails

Juergen Gross (1):
      xen/balloon: before adding hotplugged memory, set frames to invalid

Julian Anastasov (1):
      neigh: do not modify unlinked entries

Jun'ichi Nomura \\\\(NEC\\\\) (1):
      tg3: Hold tp->lock before calling tg3_halt() from tg3_init_one()

Junjie Mao (1):
      driver core: bus: Goto appropriate labels on failure in bus_add_device

Junling Zheng (1):
      net: socket: Fix the wrong returns for recvmsg and sendmsg

Junxiao Bi (1):
      ocfs2: dlm: fix race between purge and get lock resource

Jurgen Kramer (4):
      ALSA: usb-audio: Add native DSD support for Denon/Marantz DACs
      ALSA: usb-audio: Add mode select quirk for Denon/Marantz DACs
      ALSA: usb-audio: add native DSD support for Matrix Audio DACs
      ALSA: usb-audio: add native DSD support for JLsounds I2SoverUSB

Jérôme Glisse (3):
      drm/radeon: fix freeze for laptop with Turks/Thames GPU.
      drm/radeon: compute ring fix hibernation (CI GPU family) v2.
      drm/radeon: SDMA fix hibernation (CI GPU family).

K. Y. Srinivasan (4):
      scsi: storvsc: Fix a bug in copy_from_bounce_buffer()
      Drivers: hv: vmbus: Fix a bug in the error path in vmbus_open()
      Drivers: hv: vmbus: Don't wait after requesting offers
      storvsc: Set the SRB flags correctly when no data transfer is needed

Kailang Yang (8):
      ALSA: hda/realtek - Make more stable to get pin sense for ALC283
      ALSA: hda/realtek - Fix Headphone Mic doesn't recording for ALC256
      ALSA: hda/realtek - Support Dell headset mode for ALC256
      ALSA: hda/realtek - Support headset mode for ALC286/288
      ALSA: hda/realtek - Fix typo for ALC286/ALC288
      ALSA: hda/realtek - Add ALC298 alias name for Dell
      ALSA: hda/realtek - Support headset mode for ALC298
      ALSA: hda/realtek - Add ALC256 alias name for Dell

Ken Xue (1):
      serial: 8250_dw: add support for AMD SOC Carrizo

Kenneth Graunke (1):
      drm/i915: Make sample_c messages go faster on Haswell.

Konrad Rzeszutek Wilk (1):
      config: Enable NEED_DMA_MAP_STATE by default when SWIOTLB is selected

Konstantin Khlebnikov (5):
      mm: prevent endless growth of anon_vma hierarchy
      mm: fix corner case in anon_vma endless growing prevention
      ext4: fix bh leak on error paths in ext4_rename() and ext4_cross_rename()
      lib/rhashtable: fix race between rhashtable_lookup_compare and hashtable resize
      of: return NUMA_NO_NODE from fallback of_node_to_nid()

Koro Chen (1):
      ASoC: dapm: Modify widget stream name according to prefix

Krzysztof Kozlowski (6):
      compal-laptop: Fix leaking hwmon device
      compal-laptop: Check return value of power_supply_register
      power_supply: twl4030_madc: Check return value of power_supply_register
      power_supply: lp8788-charger: Fix leaked power supply on probe fail
      power_supply: ipaq_micro_battery: Fix leaking workqueue
      power_supply: ipaq_micro_battery: Check return values in probe

Krzysztof Opasiak (1):
      usb: gadget: configfs: Fix interfaces array NULL-termination

Larry Finger (4):
      rtlwifi: Fix IOMMU mapping leak in AP mode
      rtlwifi: rtl8192cu: Add new USB ID
      rtlwifi: rtl8192cu: Fix kernel deadlock
      mm: kmemleak_alloc_percpu() should follow the gfp from per_alloc()

Lars-Peter Clausen (1):
      iio: adis16400: Report pressure channel scale

Laszlo Ersek (1):
      arm, arm64: KVM: allow forced dcache flush on page faults

Laura Abbott (3):
      mm/page_alloc.c: call kernel_map_pages in unset_migrateype_isolate
      HID: usbhid: Add HID_QUIRK_NOGET for Aten DVI KVM switch
      n_tty: Fix auditing support for cannonical mode

Len Brown (1):
      sched/idle/x86: Restore mwait_idle() to fix boot hangs, to improve power savings and to improve performance

Leon Yu (1):
      mm: fix anon_vma->degree underflow in anon_vma endless growing prevention

Li Jun (1):
      usb: chipidea: otg: remove mutex unlock and lock while stop and start role

Liad Kaufman (1):
      iwlwifi: pcie: prevent using unmapped memory in fw monitor

Liang Li (1):
      kvm/fpu: Enable eager restore kvm FPU for MPX

Linus Torvalds (2):
      kernel: make READ_ONCE() valid on const arguments
      Fix firmware loader uevent buffer NULL pointer dereference

Linus Walleij (1):
      drivers: platform: parse IRQ flags from resources

Lior Amsalem (1):
      dmaengine: mv_xor: bug fix for racing condition in descriptors cleanup

Lorenzo Pieralisi (1):
      ARM: kvm: psci: fix handling of unimplemented functions

Lu Baolu (2):
      usb: xhci: handle Config Error Change (CEC) in xhci driver
      usb: xhci: apply XHCI_AVOID_BEI quirk to all Intel xHCI controllers

Lucas Stach (1):
      spi: imx: read back the RX/TX watermark levels earlier

Ludovic Desroches (3):
      tty/serial: at91: maxburst was missing for dma transfers
      mmc: atmel-mci: fix bad variable type for clkdiv
      ARM: at91/dt: sama5d4ek: mci0 uses slot 0

Lukas Czerner (4):
      ext4: make fsync to sync parent dir in no-journal for real this time
      ext4: fix data corruption caused by unwritten and delayed extents
      ext4: fix NULL pointer dereference when journal restart fails
      ext4: fix reservation release on invalidatepage for delalloc fs

Lukas Wunner (1):
      drm/i915: Add missing MacBook Pro models with dual channel LVDS

Lv Zheng (6):
      ACPICA: Utilities: split IO address types from data type models.
      ACPICA: Tables: Change acpi_find_root_pointer() to use acpi_physical_address.
      ACPICA: Utilities: Cleanup to enforce ACPI_PHYSADDR_TO_PTR()/ACPI_PTR_TO_PHYSADDR().
      ACPICA: Utilities: Cleanup to convert physical address printing formats.
      ACPICA: Utilities: Cleanup to remove useless ACPI_PRINTF/FORMAT_xxx helpers.
      ACPICA: Tables: Fix an issue that FACS initialization is performed twice

Majd Dibbiny (1):
      IB/mlx4: Saturate RoCE port PMA counters in case of overflow

Malcolm Priestley (2):
      staging: vt6656: use ieee80211_tx_info to select packet type.
      staging: vt6655: device_rx_srv check sk_buff is NULL

Manish Badarkhe (1):
      ASoC: davinci-evm: drop un-necessary remove function

Marc Zyngier (8):
      arm64: KVM: Fix TLB invalidation by IPA/VMID
      arm64: KVM: Fix HCR setting for 32bit guests
      arm/arm64: KVM: Invalidate data cache on unmap
      arm/arm64: KVM: Use kernel mapping to perform invalidation on page fault
      arm64: KVM: Fix stage-2 PGD allocation to have per-page refcounting
      arm64: KVM: Do not use pgd_index to index stage-2 pgd
      KVM: arm/arm64: vgic: Avoid injecting reserved IRQ numbers
      arm: KVM: force execution of HCPTR access on VM exit

Marcel Holtmann (2):
      Bluetooth: Add support for Broadcom device of Asus Z97-DELUXE motherboard
      Bluetooth: btusb: Fix memory leak in Intel setup routine

Marcelo Ricardo Leitner (1):
      sctp: fix ASCONF list handling

Marek Szyprowski (2):
      [media] media: s5p-mfc: fix mmap support for 64bit arch
      arm64: dma-mapping: always clear allocated buffers

Marek Vasut (2):
      rtlwifi: rtl8192cu: Add new device ID
      ARM: dts: imx28: Fix AUART4 TX-DMA interrupt name

Mario Kleiner (1):
      drm: Zero out invalid vblank timestamp in drm_update_vblank_count.

Mark Brown (1):
      i2c: core: Export bus recovery functions

Mark Edwards (1):
      USB: cp210x: add ID for KCF Technologies PRN device

Mark Hounschell (1):
      sd: Disable support for 256 byte/sector disks

Mark Rutland (3):
      ARM: 8307/1: psci: move psci firmware calls out of line
      ARM: 8356/1: mm: handle non-pmd-aligned end of RAM
      arm64: entry: fix context tracking for el0_sp_pc

Mark Salyzyn (1):
      unix/caif: sk_socket can disappear when state is unlocked

Markos Chandras (4):
      MIPS: Malta: Detect and fix bad memsize values
      MIPS: asm: asm-eva: Introduce kernel load/store variants
      MIPS: kernel: entry.S: Set correct ISA level for mips_ihb
      MIPS: Kconfig: Disable SMP/CPS for 64-bit

Markus Pargmann (1):
      ARM: dts: imx25: Add #pwm-cells to pwm4

Martin Fuzzey (1):
      iio: core: Fix double free.

Martin K. Petersen (2):
      sd: Unregister integrity profile
      sd: Fix missing ATO tag check

Martin Schwidefsky (1):
      s390/mm: correct return value of pmd_pfn

Martin Sperl (1):
      spi: fix race freeing dummy_tx/rx before it is unmapped

Mathias Nyman (2):
      xhci: fix isoc endpoint dequeue from advancing too far on transaction error
      xhci: Solve full event ring by increasing TRBS_PER_SEGMENT to 256

Matwey V. Kornilov (1):
      PCI: spear: Drop __initdata from spear13xx_pcie_driver

Mauro Carvalho Chehab (4):
      [media] s5h1420: fix a buffer overflow when checking userspace params
      [media] cx24116: fix a buffer overflow when checking userspace params
      [media] af9013: Don't accept invalid bandwidth
      [media] cx24117: fix a buffer overflow when checking userspace params

Max Filippov (4):
      xtensa: xtfpga: fix hardware lockup caused by LCD driver
      xtensa: provide __NR_sync_file_range2 instead of __NR_sync_file_range
      xtensa: ISS: fix locking in TAP network adapter
      xtensa: xtfpga: fix hardware lockup caused by LCD driver

Maxime Coquelin (1):
      regmap: Fix possible shift overflow in regmap_field_init()

Mel Gorman (2):
      mm, numa: really disable NUMA balancing by default on single node machines
      sched, numa: Do not hint for NUMA balancing on VM_MIXEDMAP mappings

Michael Brunner (1):
      gpio: gpio-kempld: Fix get_direction return value

Michael Davidson (1):
      fs/binfmt_elf.c: fix bug in loading of PIE binaries

Michael Ellerman (2):
      powerpc/cell: Fix crash in iic_setup_cpu() after per_cpu changes
      powerpc/cell: Fix cell iommu after it_page_shift changes

Michael Gernoth (1):
      ALSA: emu10k1: don't deadlock in proc-functions

Michael Holzheu (1):
      s390/kdump: fix REGSET_VX_LOW vector register ELF notes

Michal Hocko (1):
      ext4: replace open coded nofail allocation in ext4_free_blocks()

Michal Kazior (1):
      mac80211: prevent possible crypto tx tailroom corruption

Michal Kubeček (1):
      tcp: prevent fetching dst twice in early demux code

Michal Simek (2):
      serial: of-serial: Remove device_type = "serial" registration
      serial: xilinx: Use platform_get_irq to get irq description structure

Michel Dänzer (1):
      drm/radeon: Add RADEON_INFO_VA_UNMAP_WORKING query

Mika Westerberg (1):
      ACPI: Add support for device specific properties

Mike Christie (2):
      iscsi target: fix oops when adding reject pdu
      SCSI: add 1024 max sectors black list flag

Mike Galbraith (1):
      sched/idle/x86: Optimize unnecessary mwait_idle() resched IPIs

Mike Snitzer (1):
      blk-mq: fix use of incorrect goto label in blk_mq_init_queue error path

Miklos Szeredi (1):
      fuse: initialize fc->release before calling it

Mikulas Patocka (2):
      dm stats: fix divide by zero if 'number_of_areas' arg is zero
      libata: increase the timeout when setting transfer mode

Milan Plzik (1):
      HID: kye: Fix report descriptor for Genius PenSketch M912

Mimi Zohar (3):
      KEYS: fix "ca_keys=" partial key matching
      ima: fix ima_show_template_data_ascii()
      evm: labeling pseudo filesystems exception

Ming Lei (1):
      blk-mq: fix CPU hotplug handling

Mugunthan V N (1):
      net: phy: fix phy link up when limiting speed via device tree

Nadav Amit (1):
      KVM: x86: Fix MSR_IA32_BNDCFGS in msrs_to_save

Nadav Haklai (2):
      thermal: armada: Update Armada 380 thermal sensor coefficients
      ata: ahci_mvebu: Fix wrongly set base address for the MBus window setting

Naoya Horiguchi (5):
      mm: hwpoison: drop lru_add_drain_all() in __soft_offline_page()
      mm/hugetlb: use pmd_page() in follow_huge_pmd()
      mm/hugetlb: take page table lock in follow_huge_pmd()
      mm/memory-failure: call shake_page() when error hits thp tail page
      mm: soft-offline: fix num_poisoned_pages counting on concurrent events

Nathaniel W Filardo (1):
      USB: keyspan_pda: add new device id

Neal Cardwell (2):
      tcp: fix FRTO undo on cumulative ACK of SACKed range
      tcp: fix child sockets to use system default congestion control if not set

NeilBrown (2):
      md/raid0: fix bug with chunksize not a power of 2.
      md/raid5: don't record new size if resize_stripes fails.

Nicholas Bellinger (2):
      target: Fix COMPARE_AND_WRITE with SG_TO_MEM_NOALLOC handling
      iscsi-target: Convert iscsi_thread_set usage to kthread.h

Nicolas Dichtel (8):
      rtnl/bond: don't send rtnl msg for unregistered iface
      selinux/nlmsg: add XFRM_MSG_NEWSPDINFO
      selinux/nlmsg: add XFRM_MSG_GETSPDINFO
      selinux/nlmsg: add XFRM_MSG_[NEW|GET]SADINFO
      selinux/nlmsg: add XFRM_MSG_REPORT
      selinux/nlmsg: add XFRM_MSG_MIGRATE
      selinux/nlmsg: add XFRM_MSG_MAPPING
      rtnl: restore notifications for deleted interfaces

Nicolas Ferre (2):
      clk: at91: fix h32mx prototype inclusion in pmc header
      tty/serial: at91: RS485 mode: 0 is valid for delay_rts_after_send

Nicolas Iooss (2):
      wl18xx: show rx_frames_per_rates as an array as it really is
      firmware/ihex2fw.c: restore missing default in switch statement

Nicolas Pitre (1):
      ktime: Optimize ktime_divns for constant divisors

Nicolas Schichan (2):
      MIPS: BCM63xx: Move bcm63xx_gpio_init() to bcm63xx_register_devices().
      ARM: net fix emit_udiv() for BPF_ALU | BPF_DIV | BPF_K intruction.

Niklas Cassel (1):
      MIPS: smp-cps: cpu_set FPU mask if FPU present

Nikolay Aleksandrov (3):
      bridge: disable softirqs around br_fdb_update to avoid lockup
      bridge: fix multicast router rlist endless loop
      bridge: fix br_stp_set_bridge_priority race conditions

Nishanth Menon (1):
      C6x: time: Ensure consistency in __init

Octavian Purdila (1):
      ACPICA: Tables: Don't release ACPI_MTX_TABLES in acpi_tb_install_standard_table().

Oleg Nesterov (2):
      ptrace: fix race between ptrace_resume() and wait_task_stopped()
      perf: Fix ring_buffer_attach() RCU sync, again

Olga Kornievskaia (1):
      fixing infinite OPEN loop in 4.0 stateid recovery

Oliver Hartkopp (1):
      can: fix loss of CAN frames in raw_rcv

Oliver Neukum (6):
      cdc-wdm: fix endianness bug in debug statements
      cdc-acm: add sanity checks
      HID: add HP OEM mouse to quirk ALWAYS_POLL
      HID: add quirk for PIXART OEM mouse used by HP
      HID: usbhid: more mice with ALWAYS_POLL
      HID: usbhid: yet another mouse with ALWAYS_POLL

Omar Sandoval (3):
      ext4: fix indirect punch hole corruption
      btrfs: unlock i_mutex after attempting to delete subvolume during send
      Btrfs: don't invalidate root dentry when subvolume deletion fails

Pablo Neira Ayuso (2):
      netfilter: nft_compat: set IP6T_F_PROTO flag if protocol is set
      netfilter: nf_tables: allow to change chain policy without hook if it exists

Pali Rohár (1):
      dell-laptop: Fix allocating & freeing SMI buffer page

Palik, Imre (1):
      perf/x86: Honor the architectural performance monitoring version

Pan Xinhui (1):
      tty/n_gsm.c: fix a memory leak when gsmtty is removed

Panu Matilainen (1):
      ALSA: usb-audio: Add support for Zoom R16/24 capture and midi interfaces

Paolo Bonzini (3):
      Revert "KVM: x86: drop fpu_activate hook"
      KVM: MMU: fix CR4.SMEP=1, CR0.WP=0 with shadow pages
      KVM: mips: use id_to_memslot correctly

Pascal Huerst (1):
      ASoC: cs4271: Increase delay time after reset

Patrick Riphagen (1):
      USB: serial: ftdi_sio: Add support for a Motion Tracker Development Board

Paul Cercueil (2):
      iio: adis16400: Use != channel indices for the two voltage channels
      iio: adis16400: Compute the scan mask from channel indices

Paul Clarke (1):
      powerpc: Re-enable dynticks

Paul E. McKenney (1):
      rcu: Correctly handle non-empty Tiny RCU callback list with none ready

Pavel Machek (1):
      ARM: dts: OMAP3-N900: Add microphone bias voltages

Pawel Moll (1):
      bus: arm-ccn: Fix node->XP config conversion

Pelle Nilsson (1):
      spi: bitbang: Make setup_transfer() callback optional

Peter Hurley (1):
      n_tty: Fix read buffer overwrite when no newline

Peter Hutterer (2):
      Input: synaptics - add min/max quirk for Lenovo S540
      Input: synaptics - add min/max quirk for Lenovo S540

Peter Maydell (1):
      arm/arm64: KVM: vgic: move reset initialization into vgic_init_maps()

Peter Meerwald (1):
      iio: tmp006: Check channel info on write

Peter Sanford (1):
      USB: cp210x: add ID for Aruba Networks controllers

Peter Ujfalusi (3):
      dmaengine: omap-dma: Fix memory leak when terminating running transfer
      ASoC: tas2552: Fix kernel crash when the codec is loaded but not part of a card
      ASoC: tas2552: Fix kernel crash caused by wrong kcontrol entry

Peter Zubaj (1):
      ALSA: emu10k1: Emu10k2 32 bit DMA mode

Petr Kulhavy (1):
      dmaengine: edma: fix memory leak when terminating running transfers

Philipp Zabel (2):
      ARM: dts: imx6: phyFLEX: USB VBUS control is active-high
      serial: imx: Fix DMA handling for IDLE condition aborts

Philippe Reynes (1):
      ARM: dts: imx27: only map 4 Kbyte for fec registers

Pravin B Shelar (1):
      vxlan: Fix double free of skb.

Preeti U Murthy (1):
      timers/tick/broadcast-hrtimer: Fix suspicious RCU usage in idle loop

Quentin Casasnovas (2):
      cdc-acm: prevent infinite loop when parsing CDC headers.
      x86/microcode/intel: Guard against stack overflow in the loader

Rabin Vincent (2):
      tracing: Handle ftrace_dump() atomic context in graph_trace_open()
      Revert "dm crypt: fix deadlock when async crypto algorithm returns -EBUSY"

Radim Krčmář (4):
      KVM: use slowpath for cross page cached accesses
      KVM: nVMX: mask unrestricted_guest if disabled on L0
      KVM: x86: make vapics_in_nmi_mode atomic
      KVM: x86: properly restore LVT0

Rafael J. Wysocki (6):
      Revert "PM / hibernate: avoid unsafe pages in e820 reserved regions"
      ACPI / scan: Annotate physical_node_lock in acpi_scan_is_offline()
      ACPI / init: Fix the ordering of acpi_reserve_resources()
      Driver core: Unified device properties interface for platform firmware
      PCI: Propagate the "ignore hotplug" setting to parent
      ACPI / PM: Add missing pm_generic_complete() invocation

Rafał Miłecki (2):
      MIPS: BCM47XX: Fix detecting Microsoft MN-700 & Asus WL500G
      b43: fix support for 14e4:4321 PCI dev with BCM4321 chipset

Ralf Baechle (2):
      MIPS: Octeon: Delete override of cpu_has_mips_r2_exec_hazard.
      NET: ROSE: Don't dereference NULL neighbour pointer.

Raphael Assenat (1):
      HID: usbhid: Add a quirk for raphnet multi-gamepad adapters

Rasmus Villemoes (1):
      PCI/AER: Avoid info leak in __print_tlp_header()

Richard Cochran (3):
      net: dp83640: fix broken calibration routine.
      net: dp83640: reinforce locking rules.
      net: dp83640: fix improper double spin locking.

Richard Fitzgerald (1):
      ASoC: arizona: Fix noise generator gain TLV

Robert Schlabbach (1):
      usb: core: Fix USB 3.0 devices lost in NOTATTACHED state after a hub port reset

Ross Lagerwall (2):
      xen/netback: Properly initialize credit_bytes
      efivarfs: Ensure VariableName is NUL-terminated

Roy Franz (1):
      x86/efi: Store upper bits of command line buffer address in ext_cmd_line_ptr

Rui Miguel Silva (1):
      usb: gadget: f_fs: add extra check before unregister_gadget_item

Russell King (2):
      ARM: fix broken hibernation
      ARM: fix missing syscall trace exit

Rusty Russell (1):
      lguest: fix out-by-one error in address checking.

Ryan Underwood (1):
      Disable write buffering on Toshiba ToPIC95

Ryusuke Konishi (1):
      nilfs2: fix sanity check of btree level in nilfs_btree_root_broken()

Sabrina Dubroca (1):
      e1000: add dummy allocator to fix race condition between mtu change and netpoll

Sachin Prabhu (1):
      cifs: smb2_clone_range() - exit on unhandled error

Sagi Grimberg (5):
      iser-target: Fix session hang in case of an rdma read DIF error
      IB/iser: Fix wrong calculation of protection buffer length
      iser-target: Fix variable-length response error completion
      iser-target: release stale iser connections
      iser-target: Fix possible deadlock in RDMA_CM connection error

Sasha Levin (14):
      Linux 3.18.13
      Linux 3.18.14
      fs, omfs: add NULL terminator in the end up the token list
      vfs: read file_handle only once in handle_to_path
      Linux 3.18.15
      Linux 3.18.16
      Revert "tools/vm: fix page-flags build"
      Linux 3.18.17
      Linux 3.18.18
      Revert "nfs: take extra reference to fl->fl_file when running a LOCKU operation"
      Revert "Input: synaptics - add min/max quirk for Lenovo S540"
      Linux 3.18.19
      Revert "can: fix loss of CAN frames in raw_rcv"
      Linux 3.18.20

Sathyanarayanan Kuppuswamy (1):
      iio: bmc150: change sampling frequency

Scott Branden (1):
      rt2x00: add new rt2800usb device DWA 130

Scott Mayhew (1):
      svcrpc: fix potential GSSX_ACCEPT_SEC_CONTEXT decoding failures

Sean Young (1):
      HID: sjoy: support Super Joy Box 4

Sebastian Hesselbarth (1):
      ARM: dts: dove: Fix uart[23] reg property

Sebastian Pöhn (1):
      ip_forward: Drop frames with attached skb->sk

Sebastian Wicki (1):
      ALSA: hda - Add dock support for Thinkpad T450s (17aa:5036)

Sebastien Szymanski (1):
      ARM: clk-imx6q: refine sata's parent

Sergej Sawazki (1):
      ASoC: wm8741: Fix rates constraints values

Shachar Raindel (1):
      IB/uverbs: Prevent integer overflow in ib_umem_get address arithmetic

Shannon Zhao (1):
      arm/arm64: KVM: vgic: kick the specific vcpu instead of iterating through all

Shaohua Li (1):
      net: don't wait for order-3 page allocation

Shawn Bohrer (1):
      ipv4/udp: Verify multicast group is ours in upd_v4_early_demux()

Sifan Naeem (1):
      [media] rc: img-ir: fix error in parameters passed to irq_free()

Simon Guinot (3):
      net: mvneta: introduce compatible string "marvell, armada-xp-neta"
      ARM: mvebu: update Ethernet compatible string for Armada XP
      net: mvneta: disable IP checksum with jumbo frames for Armada 370

Simon Horman (3):
      ARM: shmobile: r8a7791: Correct SDHI clock labels and output-names
      ARM: shmobile: r8a7790: Correct SYSCIER value
      ARM: shmobile: r8a7791: Correct SYSCIER value

Sowmini Varadhan (2):
      RDS: Documentation: Document AF_RDS, PF_RDS and SOL_RDS correctly.
      sparc: Use GFP_ATOMIC in ldc_alloc_exp_dring() as it can be called in softirq context

Sriharsha Basavapatna (1):
      be2net: Replace dma/pci_alloc_coherent() calls with dma_zalloc_coherent()

Srinivas Pandruvada (2):
      iio: light: hid-sensor-prox: Fix modifier
      iio: pressure: hid-sensor-press: Fix modifier

Stefan Agner (3):
      iio: adc: vf610: use ADC clock within specification
      tty: serial: fsl_lpuart: specify transmit FIFO size
      tty: serial: fsl_lpuart: clear receive flag on FIFO flush

Stefan Lippers-Hollmann (1):
      x86/reboot: Add ASRock Q1900DC-ITX mainboard reboot quirk

Stefan Wahren (2):
      ARM: dts: imx23-olinuxino: Fix dr_mode of usb0
      regulator: core: fix constraints output buffer

Stephane Eranian (1):
      perf/x86/rapl: Enable Broadwell-U RAPL support

Stephen Boyd (1):
      clk: qcom: Fix i2c frequency table

Steve Cornelius (2):
      crypto: caam - improve initalization for context state saves
      crypto: caam - fix RNG buffer cache alignment

Steven Rostedt (3):
      ring-buffer: Replace this_cpu_*() with __this_cpu_*()
      module: Call module notifier on failure after complete_formation()
      tracing: Have filter check for balanced ops

Steven Rostedt (Red Hat) (4):
      tools lib traceevent kbuffer: Remove extra update to data pointer in PADDING
      tracing/filter: Do not allow infix to exceed end of string
      tracing/filter: Do not WARN on operand count going below zero
      tracing: Have branch tracer use recursive field of task struct

Stevens, Nick (1):
      hwmon: (mcp3021) Fix broken output scaling

Subbaraya Sundeep Bhatta (2):
      usb: dwc3: gadget: return error if command sent to DGCMD register fails
      usb: dwc3: gadget: return error if command sent to DEPCMD register fails

Sudip Mukherjee (2):
      nbd: fix possible memory leak
      staging: panel: fix lcd type

Sławomir Demeszko (1):
      staging: gdm724x: Correction of variable usage after applying ALIGN()

Takashi Iwai (16):
      ALSA: hda - Fix headphone pin config for Lifebook T731
      ALSA: emux: Fix mutex deadlock at unloading
      ALSA: emux: Fix mutex deadlock in OSS emulation
      ALSA: emu10k1: Fix card shortname string buffer overflow
      ALSA: hda - Add mute-LED mode control to Thinkpad
      ALSA: usb-audio: Check Marantz/Denon USB DACs in a single place
      ALSA: usb-audio: Add quirk for MS LifeCam Studio
      ALSA: hda - Add headphone quirk for Lifebook E752
      Revert "ALSA: hda - Add mute-LED mode control to Thinkpad"
      ALSA: hda - Add AZX_DCAPS_SNOOP_OFF (and refactor snoop setup)
      ALSA: hda - Fix noise on AMD radeon 290x controller
      ALSA: hda - Fix mute-LED fixed mode
      ALSA: hda/realtek - Add a fixup for another Acer Aspire 9420
      PM / sleep: Increase default DPM watchdog timeout to 60
      ALSA: hda - Add headset support to Acer Aspire V5
      ALSA: hda - Fix the dock headphone output on Fujitsu Lifebook E780

Takashi Sakamoto (1):
      ALSA: bebob: fix to processing in big-endian machine for sending cue

Takeshi Kihara (1):
      mmc: sh_mmcif: Fix timeout value for command request

Tatyana Nikolova (1):
      RDMA/core: Fix for parsing netlink string attribute

Tejun Heo (3):
      writeback: add missing INITIAL_JIFFIES init in global_update_bandwidth()
      writeback: fix possible underflow in write bandwidth calculation
      writeback: use |1 instead of +1 to protect against div by zero

Thadeu Lima de Souza Cascardo (1):
      bridge: fix parsing of MLDv2 reports

Theodore Ts'o (2):
      ext4: fix race between truncate and __ext4_journalled_writepage()
      ext4: call sync_blockdev() before invalidate_bdev() in put_super()

Thierry Reding (1):
      clk: tegra: Register the proper number of resets

Thomas Betker (4):
      iio: adc: xilinx: Fix register addresses
      iio: adc: xilinx: Fix "vccaux" channel .address
      iio: adc: xilinx: Fix VREFP scale
      iio: adc: xilinx: Fix VREFN sign

Thomas D (1):
      tools/power turbostat: Use $(CURDIR) instead of $(PWD) and add support for O= option in Makefile

Thomas Gleixner (1):
      sched: Handle priority boosted tasks proper in setscheduler()

Thomas Hebb (1):
      hfsplus: don't store special "osx" xattr prefix on-disk

Thomas Petazzoni (10):
      ARM: mvebu: do not register custom DMA operations when coherency is disabled
      pinctrl: mvebu: armada-38x: fix PCIe functions
      pinctrl: mvebu: armada-370: fix spi0 pin description
      pinctrl: mvebu: armada-375: remove non-existing NAND re/we pins
      pinctrl: mvebu: armada-xp: remove non-existing NAND pins
      pinctrl: mvebu: armada-xp: remove non-existing VDD cpu_pd functions
      pinctrl: mvebu: armada-xp: fix functions of MPP48
      pinctrl: mvebu: armada-375: remove incorrect space in pin description
      pinctrl: mvebu: armada-38x: fix incorrect total number of GPIOs
      mmc: sdhci-pxav3: do the mbus window configuration after enabling clocks

Thomas Reitmayr (1):
      [media] media: Fix regression in some more dib0700 based devices

Thomas Schlichter (1):
      cpuidle: ACPI: do not overwrite name and description of C0

Tom Herbert (2):
      net: add skb_checksum_complete_unset
      ppp: call skb_checksum_complete_unset in ppp_receive_frame

Tomas Winkler (2):
      mei: txe: reduce suspend/resume time
      mmc: block: Add missing mmc_blk_put() in power_ro_lock_show()

Tony Lindgren (2):
      ARM: OMAP2+: Fix omap off idle power consumption creeping up
      ARM: OMAP3: Fix booting with thumb2 kernel

Trond Myklebust (3):
      SUNRPC: Fix a memory leak in the backchannel code
      pNFS: Fix a memory leak when attempted pnfs fails
      NFS: Ensure we set NFS_CONTEXT_RESEND_WRITES when requeuing writes

Troy Tan (1):
      rtlwifi: rtl8192ee: Fix handling of new style descriptors

Ulf Hansson (3):
      ARM: ux500: Move GPIO regulator for SD-card into board DTSs
      ARM: ux500: Enable GPIO regulator for SD-card for HREF boards
      ARM: ux500: Enable GPIO regulator for SD-card for snowball

Ulrik De Bie (1):
      Input: elantech - fix absolute mode setting on some ASUS laptops

Uwe Kleine-König (4):
      clk: divider: fix selection of divider when rounding to closest
      clk: divider: fix calculation of maximal parent rate for a given divider
      serial: imx: Fix clearing of receiver overrun flag
      watchdog: omap: assert the counter being stopped before reprogramming

Vasily Averin (1):
      security_syslog() should be called once only

Ville Syrjälä (1):
      drm/i915: Reject the colorkey ioctls for primary and cursor planes

Vincent Fann (1):
      rtlwifi: Remove the clear interrupt routine from all drivers

Vineet Gupta (5):
      ARC: SA_SIGINFO ucontext regs off-by-one
      ARC: signal handling robustify
      ARC: unbork !LLSC build
      ARC: add compiler barrier to LLSC based cmpxchg
      ARC: add smp barriers around atomics per Documentation/atomic_ops.txt

Vinson Lee (2):
      perf symbols: Define STT_GNU_IFUNC for glibc 2.9 and older.
      perf tools: Work around lack of sched_getcpu in glibc < 2.6.

Viorel Suman (1):
      iio: inv_mpu6050: Clear timestamps fifo while resetting hardware fifo

Viresh Kumar (1):
      cpufreq: Schedule work for the first-online CPU on resume

Vittorio G (VittGam) (1):
      ALSA: usb-audio: Add quirk for MS LifeCam HD-3000

Vlad Yasevich (1):
      net: core: Correct an over-stringent device loop detection.

Vutla, Lokesh (1):
      crypto: omap-aes - Fix support for unequal lengths

WANG Cong (1):
      net_sched: invoke ->attach() after setting dev->qdisc

Wang Long (1):
      ring-buffer-benchmark: Fix the wrong sched_priority of producer

Wei Yongjun (2):
      ASoC: samsung: s3c24xx-i2s: Fix return value check in s3c24xx_iis_dev_probe()
      power/reset: at91: fix return value check in at91_reset_platform_probe()

Wenbo Wang (1):
      Fix bug in blk_rq_merge_ok

Will Deacon (2):
      arm64: errata: add workaround for cortex-a53 erratum #845719
      arm64: vdso: work-around broken ELF toolchains in Makefile

Willem de Bruijn (1):
      packet: avoid out of bounds read in round robin fanout

Witold Szczeponik (1):
      ACPI / PNP: add two IDs to list for PNPACPI device enumeration

Wolfram Sang (1):
      ALSA: usb-audio: Add mic volume fix quirk for Logitech Quickcam Fusion

Xi Wang (1):
      arm64: bpf: fix signedness bug in loading 64-bit immediate

Xiao Guangrong (2):
      KVM: MMU: fix smap permission check
      KVM: MMU: fix SMAP virtualization

Yann Droneaud (2):
      IB/core: disallow registering 0-sized memory region
      IB/core: don't disallow registering region starting at 0x0

Yao Xiwei (1):
      vti6: fix uninit when using x-netns

Yoshihiro Shimoda (1):
      ARM: shmobile: r8a7791: add USBDMAC{0,1} clocks to device tree

Yves-Alexis Perez (1):
      ALSA: hda - Add dock support for ThinkPad X250 (17aa:2226)

Zhao Junwang (1):
      drm: add a check for x/y in drm_mode_setcrtc

Zhichang Yuan (1):
      of/pci: Fix pci_address_to_pio() conversion of CPU address to I/O port

Zidan Wang (3):
      ASoC: wm8960: fix "RINPUT3" audio route error
      ASoC: wm8994: correct BCLK DIV 348 to 384
      ASoC: wm8960: the enum of "DAC Polarity" should be wm8960_enum[1]

hannes@stressinduktion.org (1):
      ipv6: protect skb->sk accesses from recursive dereference inside the stack

huaibin Wang (1):
      xfrm: release dst_orig in case of error in xfrm_lookup()

mancha security (1):
      lib: memzero_explicit: use barrier instead of OPTIMIZER_HIDE_VAR

monk.liu (1):
      drm/radeon: fix userptr BO unpin bug v3

oliver@neukum.org (1):
      HID: add ALWAYS_POLL quirk for a Logitech 0xc007

 .../devicetree/bindings/dma/fsl-mxs-dma.txt        |   2 +-
 .../bindings/net/marvell-armada-370-neta.txt       |   2 +-
 .../pinctrl/marvell,armada-370-pinctrl.txt         |   4 +-
 .../pinctrl/marvell,armada-375-pinctrl.txt         |   4 +-
 .../pinctrl/marvell,armada-38x-pinctrl.txt         |  38 +-
 .../bindings/pinctrl/marvell,armada-xp-pinctrl.txt |  32 +-
 .../devicetree/bindings/spi/spi_pl022.txt          |   2 +-
 Documentation/kernel-parameters.txt                |   2 +
 Documentation/networking/rds.txt                   |   9 +-
 Documentation/pinctrl.txt                          |  17 +-
 Documentation/stable_kernel_rules.txt              |  29 +-
 Documentation/virtual/kvm/api.txt                  |  12 +-
 Documentation/virtual/kvm/devices/s390_flic.txt    |   3 +
 Documentation/virtual/kvm/mmu.txt                  |  18 +-
 Makefile                                           |   2 +-
 arch/arc/include/asm/atomic.h                      |  23 +-
 arch/arc/include/asm/bitops.h                      |  19 +
 arch/arc/include/asm/cmpxchg.h                     |  26 +-
 arch/arc/include/asm/spinlock.h                    |  32 +
 arch/arc/kernel/signal.c                           |  24 +-
 arch/arm/boot/dts/armada-370-xp.dtsi               |   2 -
 arch/arm/boot/dts/armada-370.dtsi                  |   8 +
 arch/arm/boot/dts/armada-xp-mv78260.dtsi           |   2 +-
 arch/arm/boot/dts/armada-xp-mv78460.dtsi           |   2 +-
 arch/arm/boot/dts/armada-xp-openblocks-ax3-4.dts   |   4 +
 arch/arm/boot/dts/armada-xp.dtsi                   |  10 +-
 arch/arm/boot/dts/at91-sama5d4ek.dts               |   4 +-
 arch/arm/boot/dts/dove.dtsi                        |   4 +-
 arch/arm/boot/dts/imx23-olinuxino.dts              |   4 +-
 arch/arm/boot/dts/imx25.dtsi                       |   1 +
 arch/arm/boot/dts/imx27.dtsi                       |   2 +-
 arch/arm/boot/dts/imx28.dtsi                       |   2 +-
 arch/arm/boot/dts/imx6qdl-phytec-pfla02.dtsi       |   2 +
 arch/arm/boot/dts/omap3-n900.dts                   |   4 +
 arch/arm/boot/dts/r8a7791.dtsi                     |  17 +-
 arch/arm/boot/dts/ste-dbx5x0.dtsi                  |  17 -
 arch/arm/boot/dts/ste-href.dtsi                    |  15 +
 arch/arm/boot/dts/ste-snowball.dts                 |  13 +
 arch/arm/include/asm/elf.h                         |   2 +-
 arch/arm/include/asm/kvm_emulate.h                 |   5 +
 arch/arm/include/asm/kvm_mmu.h                     |  87 ++-
 arch/arm/include/uapi/asm/kvm.h                    |   8 +-
 arch/arm/kernel/Makefile                           |   3 +-
 arch/arm/kernel/entry-common.S                     |   4 +-
 arch/arm/kernel/hibernate.c                        |   5 +-
 arch/arm/kernel/iwmmxt.S                           |  13 +
 arch/arm/kernel/process.c                          |  10 +-
 arch/arm/kernel/psci-call.S                        |  31 +
 arch/arm/kernel/psci.c                             |  39 +-
 arch/arm/kernel/reboot.h                           |   6 +
 arch/arm/kvm/arm.c                                 |  38 +-
 arch/arm/kvm/guest.c                               |   1 -
 arch/arm/kvm/interrupts.S                          |  10 +-
 arch/arm/kvm/interrupts_head.S                     |  20 +-
 arch/arm/kvm/mmu.c                                 | 251 +++++-
 arch/arm/kvm/psci.c                                |  34 +-
 arch/arm/mach-imx/clk-imx6q.c                      |   2 +-
 arch/arm/mach-mvebu/coherency.c                    |   5 +-
 arch/arm/mach-mvebu/pmsu.c                         |  16 +-
 arch/arm/mach-omap2/prm-regbits-34xx.h             |   1 +
 arch/arm/mach-omap2/prm-regbits-44xx.h             |   1 +
 arch/arm/mach-omap2/sleep34xx.S                    |  22 +-
 arch/arm/mach-omap2/vc.c                           |  12 +-
 arch/arm/mach-omap2/vc.h                           |   2 +
 arch/arm/mach-omap2/vc3xxx_data.c                  |   1 +
 arch/arm/mach-omap2/vc44xx_data.c                  |   1 +
 arch/arm/mach-s3c64xx/crag6410.h                   |   1 +
 arch/arm/mach-s3c64xx/mach-crag6410.c              |   1 +
 arch/arm/mach-shmobile/pm-r8a7790.c                |   2 +-
 arch/arm/mach-shmobile/pm-r8a7791.c                |   2 +-
 arch/arm/mach-sunxi/Kconfig                        |   6 +-
 arch/arm/mach-tegra/cpuidle-tegra20.c              |   5 +-
 arch/arm/mach-tegra/reset-handler.S                |  10 +-
 arch/arm/mach-tegra/reset.h                        |   4 +
 arch/arm/mach-tegra/sleep-tegra20.S                |  37 +-
 arch/arm/mach-tegra/sleep.h                        |   4 +
 arch/arm/mm/hugetlbpage.c                          |   6 -
 arch/arm/mm/mmu.c                                  |  20 +-
 arch/arm/net/bpf_jit_32.c                          |  15 +-
 arch/arm64/Kconfig                                 | 129 ++++
 arch/arm64/include/asm/alternative-asm.h           |  29 +
 arch/arm64/include/asm/alternative.h               |  43 ++
 arch/arm64/include/asm/cpufeature.h                |  30 +
 arch/arm64/include/asm/cputype.h                   |   5 +
 arch/arm64/include/asm/io.h                        |  23 +-
 arch/arm64/include/asm/kvm_arm.h                   |  21 +-
 arch/arm64/include/asm/kvm_emulate.h               |   7 +
 arch/arm64/include/asm/kvm_host.h                  |   1 +
 arch/arm64/include/asm/kvm_mmu.h                   |  81 +-
 arch/arm64/include/uapi/asm/kvm.h                  |   8 +-
 arch/arm64/kernel/Makefile                         |   2 +-
 arch/arm64/kernel/alternative.c                    |  64 ++
 arch/arm64/kernel/cpu_errata.c                     | 120 +++
 arch/arm64/kernel/cpuinfo.c                        |   3 +
 arch/arm64/kernel/entry.S                          |  21 +
 arch/arm64/kernel/setup.c                          |   3 +
 arch/arm64/kernel/smp.c                            |   2 +
 arch/arm64/kernel/vdso/Makefile                    |   4 +
 arch/arm64/kernel/vmlinux.lds.S                    |  11 +
 arch/arm64/kvm/guest.c                             |   1 -
 arch/arm64/kvm/hyp.S                               |   1 +
 arch/arm64/kvm/reset.c                             |   1 -
 arch/arm64/mm/cache.S                              |   4 +-
 arch/arm64/mm/context.c                            |   8 +
 arch/arm64/mm/dma-mapping.c                        |   6 +-
 arch/arm64/mm/hugetlbpage.c                        |  10 +-
 arch/arm64/mm/init.c                               |   4 +-
 arch/arm64/net/bpf_jit_comp.c                      |   2 +-
 arch/c6x/kernel/time.c                             |   2 +-
 arch/ia64/mm/hugetlbpage.c                         |   6 -
 arch/metag/mm/hugetlbpage.c                        |   6 -
 arch/mips/Kconfig                                  |   2 +-
 arch/mips/bcm47xx/board.c                          |   4 +-
 arch/mips/bcm63xx/prom.c                           |   4 -
 arch/mips/bcm63xx/setup.c                          |   4 +
 arch/mips/cavium-octeon/dma-octeon.c               |   2 +-
 arch/mips/include/asm/asm-eva.h                    | 137 ++--
 arch/mips/include/asm/fpu.h                        |   1 +
 arch/mips/include/asm/kvm_host.h                   |   2 +
 .../asm/mach-cavium-octeon/cpu-feature-overrides.h |   1 -
 arch/mips/include/asm/mach-generic/spaces.h        |   4 +
 arch/mips/include/asm/octeon/pci-octeon.h          |   3 -
 arch/mips/kernel/entry.S                           |   3 +-
 arch/mips/kernel/irq.c                             |   2 +-
 arch/mips/kernel/smp-cps.c                         |   6 +
 arch/mips/kvm/emulate.c                            |   1 +
 arch/mips/kvm/mips.c                               |   6 +-
 arch/mips/kvm/trap_emul.c                          |  28 +
 arch/mips/loongson/loongson-3/irq.c                |   1 +
 arch/mips/mm/hugetlbpage.c                         |  18 -
 arch/mips/mti-malta/malta-memory.c                 |   6 +
 arch/mips/netlogic/xlp/ahci-init-xlp2.c            |  13 +
 arch/mips/pci/pci-octeon.c                         |   8 +-
 arch/mips/pci/pcie-octeon.c                        |   8 -
 arch/mips/power/hibernate.S                        |   3 +-
 arch/mips/ralink/Kconfig                           |   5 +
 arch/parisc/include/asm/elf.h                      |   4 +
 arch/parisc/kernel/sys_parisc.c                    |   3 +
 arch/powerpc/include/asm/cputhreads.h              |   2 +-
 arch/powerpc/include/asm/irq_work.h                |   9 +
 arch/powerpc/kernel/cacheinfo.c                    |  44 +-
 arch/powerpc/kernel/vmlinux.lds.S                  |   1 +
 arch/powerpc/mm/hugetlbpage.c                      |   8 +
 arch/powerpc/perf/callchain.c                      |   2 +-
 arch/powerpc/perf/core-book3s.c                    |  11 +-
 arch/powerpc/platforms/cell/interrupt.c            |   2 +-
 arch/powerpc/platforms/cell/iommu.c                |   2 +-
 arch/powerpc/platforms/powernv/pci-ioda.c          |   3 +-
 arch/s390/crypto/ghash_s390.c                      |  25 +-
 arch/s390/include/asm/pgtable.h                    |   2 +-
 arch/s390/kernel/crash_dump.c                      |   2 +-
 arch/s390/kernel/suspend.c                         |   4 +
 arch/s390/kvm/interrupt.c                          |  70 +-
 arch/s390/kvm/kvm-s390.h                           |   4 +-
 arch/s390/kvm/priv.c                               |  42 +-
 arch/s390/mm/hugetlbpage.c                         |  20 -
 arch/sh/mm/hugetlbpage.c                           |  12 -
 arch/sparc/kernel/ldc.c                            |   2 +-
 arch/sparc/mm/hugetlbpage.c                        |  12 -
 arch/tile/mm/hugetlbpage.c                         |  28 -
 arch/x86/Kconfig                                   |   2 +-
 arch/x86/boot/compressed/eboot.c                   |   2 +
 arch/x86/include/asm/iommu_table.h                 |  11 +-
 arch/x86/include/asm/ipipe_base.h                  |   2 +-
 arch/x86/include/asm/irqflags.h                    |   2 +-
 arch/x86/include/asm/kvm_host.h                    |   5 +-
 arch/x86/include/asm/mce.h                         |   4 +
 arch/x86/include/asm/mwait.h                       |   8 +
 arch/x86/include/asm/paravirt.h                    |   6 +-
 arch/x86/include/asm/processor.h                   |  33 -
 arch/x86/include/asm/segment.h                     |  15 +-
 arch/x86/include/asm/special_insns.h               |   6 +-
 arch/x86/include/asm/tlbflush.h                    |  77 +-
 arch/x86/include/asm/virtext.h                     |   5 +-
 arch/x86/kernel/acpi/sleep.c                       |   2 +-
 arch/x86/kernel/cpu/common.c                       |  17 +-
 arch/x86/kernel/cpu/mcheck/mce-internal.h          |   4 +-
 arch/x86/kernel/cpu/mcheck/mce-severity.c          |  23 +-
 arch/x86/kernel/cpu/mcheck/mce.c                   |  20 +-
 arch/x86/kernel/cpu/mcheck/p5.c                    |   3 +-
 arch/x86/kernel/cpu/mcheck/winchip.c               |   3 +-
 arch/x86/kernel/cpu/microcode/intel_early.c        |   2 +-
 arch/x86/kernel/cpu/mtrr/cyrix.c                   |   6 +-
 arch/x86/kernel/cpu/mtrr/generic.c                 |   6 +-
 arch/x86/kernel/cpu/perf_event.c                   |   7 +-
 arch/x86/kernel/cpu/perf_event_intel.c             |  12 +-
 arch/x86/kernel/cpu/perf_event_intel_rapl.c        |   1 +
 arch/x86/kernel/entry_32.S                         |   3 +
 arch/x86/kernel/entry_64.S                         |   3 +
 arch/x86/kernel/head32.c                           |   1 +
 arch/x86/kernel/head64.c                           |   4 +-
 arch/x86/kernel/head_32.S                          |  46 +-
 arch/x86/kernel/head_64.S                          |  20 +-
 arch/x86/kernel/i387.c                             |  18 +-
 arch/x86/kernel/ipipe.c                            |  11 +-
 arch/x86/kernel/kprobes/core.c                     |   7 +-
 arch/x86/kernel/process.c                          |  60 +-
 arch/x86/kernel/process_32.c                       |   2 +-
 arch/x86/kernel/process_64.c                       |   2 +-
 arch/x86/kernel/reboot.c                           |  10 +
 arch/x86/kernel/setup.c                            |   2 +-
 arch/x86/kernel/xsave.c                            |   3 +-
 arch/x86/kvm/cpuid.c                               |   4 +
 arch/x86/kvm/cpuid.h                               |   8 +
 arch/x86/kvm/i8254.c                               |   2 +-
 arch/x86/kvm/lapic.c                               |   5 +-
 arch/x86/kvm/mmu.c                                 |  16 +-
 arch/x86/kvm/mmu.h                                 |   4 +-
 arch/x86/kvm/paging_tmpl.h                         |   7 +
 arch/x86/kvm/svm.c                                 |  11 +-
 arch/x86/kvm/vmx.c                                 |  30 +-
 arch/x86/kvm/x86.c                                 |  36 +-
 arch/x86/mm/fault.c                                |   2 +-
 arch/x86/mm/hugetlbpage.c                          |  12 -
 arch/x86/mm/init.c                                 |  12 +-
 arch/x86/mm/tlb.c                                  |   3 -
 arch/x86/net/bpf_jit_comp.c                        |  35 +-
 arch/x86/pci/acpi.c                                |  17 +-
 arch/x86/power/cpu.c                               |  11 +-
 arch/x86/realmode/init.c                           |   2 +-
 arch/x86/xen/enlighten.c                           |   4 +-
 arch/xtensa/Kconfig                                |  60 ++
 arch/xtensa/include/uapi/asm/unistd.h              |   2 +-
 arch/xtensa/platforms/iss/network.c                |  29 +-
 arch/xtensa/platforms/xtfpga/Makefile              |   3 +-
 .../platforms/xtfpga/include/platform/hardware.h   |   3 -
 .../xtensa/platforms/xtfpga/include/platform/lcd.h |  15 +
 arch/xtensa/platforms/xtfpga/lcd.c                 |  55 +-
 block/blk-merge.c                                  |   2 +-
 block/blk-mq.c                                     |  40 +-
 block/genhd.c                                      |  12 +-
 crypto/asymmetric_keys/asymmetric_keys.h           |   3 +
 crypto/asymmetric_keys/asymmetric_type.c           |  20 +-
 crypto/asymmetric_keys/x509_public_key.c           |  23 +-
 drivers/acpi/Makefile                              |   1 +
 drivers/acpi/acpi_pnp.c                            |   2 +
 drivers/acpi/acpica/acmacros.h                     |  13 +-
 drivers/acpi/acpica/dsopcode.c                     |   7 +-
 drivers/acpi/acpica/evregion.c                     |   2 +-
 drivers/acpi/acpica/exdump.c                       |   4 +-
 drivers/acpi/acpica/exfldio.c                      |  10 +-
 drivers/acpi/acpica/exregion.c                     |   8 +-
 drivers/acpi/acpica/hwvalid.c                      |  16 +-
 drivers/acpi/acpica/nsdump.c                       |  12 +-
 drivers/acpi/acpica/tbdata.c                       |  15 +-
 drivers/acpi/acpica/tbinstal.c                     |  28 +-
 drivers/acpi/acpica/tbprint.c                      |  19 +-
 drivers/acpi/acpica/tbxfroot.c                     |   7 +-
 drivers/acpi/acpica/utaddress.c                    |  34 +-
 drivers/acpi/acpica/utxfinit.c                     |  10 +-
 drivers/acpi/device_pm.c                           |   1 +
 drivers/acpi/internal.h                            |   6 +
 drivers/acpi/osl.c                                 |   6 +-
 drivers/acpi/processor_idle.c                      |   2 +-
 drivers/acpi/property.c                            | 542 +++++++++++++
 drivers/acpi/sbs.c                                 |   2 +-
 drivers/acpi/sbshc.c                               |  22 +
 drivers/acpi/scan.c                                |   8 +-
 drivers/ata/ahci.c                                 | 103 ++-
 drivers/ata/ahci_mvebu.c                           |   2 +-
 drivers/ata/libahci.c                              |   3 +-
 drivers/ata/libata-core.c                          |  41 +-
 drivers/ata/libata-eh.c                            |   3 +
 drivers/ata/libata-scsi.c                          |   3 +-
 drivers/ata/pata_octeon_cf.c                       |   2 +-
 drivers/base/Makefile                              |   2 +-
 drivers/base/bus.c                                 |   4 +-
 drivers/base/firmware_class.c                      |  16 +-
 drivers/base/platform.c                            |   9 +
 drivers/base/property.c                            | 185 +++++
 drivers/base/regmap/regmap.c                       |   5 +-
 drivers/block/nbd.c                                |   8 +-
 drivers/block/rbd.c                                |   9 +-
 drivers/bluetooth/ath3k.c                          |  13 +
 drivers/bluetooth/btusb.c                          |  12 +
 drivers/bus/arm-ccn.c                              |   2 +-
 drivers/char/agp/intel-gtt.c                       |   2 +-
 drivers/char/tpm/tpm_ibmvtpm.c                     |   5 +-
 drivers/clk/at91/clk-pll.c                         |  12 +-
 drivers/clk/at91/clk-usb.c                         |  62 +-
 drivers/clk/at91/pmc.h                             |   2 +-
 drivers/clk/clk-divider.c                          |  14 +-
 drivers/clk/qcom/clk-rcg2.c                        |   2 +-
 drivers/clk/qcom/gcc-ipq806x.c                     |   2 +-
 drivers/clk/samsung/clk-exynos4.c                  |  11 +-
 drivers/clk/tegra/clk.c                            |   2 +-
 drivers/clocksource/exynos_mct.c                   |  43 +-
 drivers/cpufreq/cpufreq.c                          |  19 +-
 drivers/cpufreq/intel_pstate.c                     |   2 +-
 drivers/cpuidle/cpuidle.c                          |   3 -
 drivers/cpuidle/sysfs.c                            |   5 +-
 drivers/crypto/caam/caamhash.c                     |   2 +
 drivers/crypto/caam/caamrng.c                      |   2 +-
 drivers/crypto/omap-aes.c                          |  14 +-
 drivers/crypto/talitos.c                           |   4 +-
 drivers/dma/edma.c                                 |   7 +
 drivers/dma/mv_xor.c                               |  72 +-
 drivers/dma/mv_xor.h                               |   1 +
 drivers/dma/omap-dma.c                             |   1 +
 drivers/dma/sh/shdmac.c                            |   4 +-
 drivers/edac/mce_amd.h                             |   3 -
 drivers/edac/sb_edac.c                             |  38 +-
 drivers/firmware/dmi_scan.c                        |   7 +-
 drivers/gpio/gpio-crystalcove.c                    |   1 +
 drivers/gpio/gpio-kempld.c                         |   2 +-
 drivers/gpio/gpio-mvebu.c                          |  24 +-
 drivers/gpio/gpiolib-sysfs.c                       |  19 +
 drivers/gpu/drm/drm_crtc.c                         |  20 +-
 drivers/gpu/drm/drm_dp_mst_topology.c              |  27 +-
 drivers/gpu/drm/drm_edid_load.c                    |   1 +
 drivers/gpu/drm/drm_irq.c                          |   9 +-
 drivers/gpu/drm/drm_probe_helper.c                 |   1 +
 drivers/gpu/drm/i915/i915_drv.c                    |  18 +-
 drivers/gpu/drm/i915/i915_drv.h                    |   1 +
 drivers/gpu/drm/i915/i915_gem_stolen.c             |   5 +-
 drivers/gpu/drm/i915/i915_irq.c                    |   8 +-
 drivers/gpu/drm/i915/i915_reg.h                    |   2 +
 drivers/gpu/drm/i915/intel_display.c               |  18 +-
 drivers/gpu/drm/i915/intel_dp.c                    |  11 +-
 drivers/gpu/drm/i915/intel_i2c.c                   |  86 ++-
 drivers/gpu/drm/i915/intel_lvds.c                  |  18 +-
 drivers/gpu/drm/i915/intel_pm.c                    |   4 +
 drivers/gpu/drm/i915/intel_sprite.c                |   4 +-
 drivers/gpu/drm/mgag200/mgag200_mode.c             |   5 +
 drivers/gpu/drm/qxl/qxl_cmd.c                      |   1 +
 drivers/gpu/drm/qxl/qxl_ioctl.c                    |   4 +-
 drivers/gpu/drm/radeon/atombios_crtc.c             |   8 +-
 drivers/gpu/drm/radeon/atombios_dp.c               |  20 +-
 drivers/gpu/drm/radeon/cik.c                       |  36 +-
 drivers/gpu/drm/radeon/cik_sdma.c                  |  11 +
 drivers/gpu/drm/radeon/ni.c                        |   3 +-
 drivers/gpu/drm/radeon/radeon.h                    |   1 +
 drivers/gpu/drm/radeon/radeon_asic.c               |   2 +-
 drivers/gpu/drm/radeon/radeon_asic.h               |   4 +
 drivers/gpu/drm/radeon/radeon_bios.c               |  10 +-
 drivers/gpu/drm/radeon/radeon_device.c             |  15 +
 drivers/gpu/drm/radeon/radeon_irq_kms.c            |   2 +
 drivers/gpu/drm/radeon/radeon_kms.c                |   3 +
 drivers/gpu/drm/radeon/radeon_mn.c                 |  11 +-
 drivers/gpu/drm/radeon/radeon_pm.c                 |  22 +-
 drivers/gpu/drm/radeon/radeon_ttm.c                |  12 +-
 drivers/gpu/drm/radeon/radeon_uvd.c                | 105 ++-
 drivers/gpu/drm/radeon/radeon_vce.c                |  65 +-
 drivers/gpu/drm/radeon/radeon_vm.c                 |  36 +-
 drivers/gpu/drm/radeon/rv770d.h                    |   3 +
 drivers/gpu/drm/radeon/si.c                        |   2 +-
 drivers/gpu/drm/radeon/si_dpm.c                    |   2 +
 drivers/gpu/drm/radeon/uvd_v1_0.c                  |  14 +-
 drivers/gpu/drm/radeon/uvd_v2_2.c                  |  29 +
 drivers/hid/Kconfig                                |  11 +
 drivers/hid/Makefile                               |   1 +
 drivers/hid/hid-core.c                             |   6 +
 drivers/hid/hid-ids.h                              |  25 +
 drivers/hid/hid-kye.c                              | 140 ++++
 drivers/hid/hid-logitech-hidpp.c                   | 842 +++++++++++++++++++++
 drivers/hid/hid-microsoft.c                        |   2 +
 drivers/hid/hid-saitek.c                           |   2 +
 drivers/hid/hid-sjoy.c                             |   3 +
 drivers/hid/hid-sony.c                             |   3 +
 drivers/hid/hid-uclogic.c                          |  27 +
 drivers/hid/usbhid/hid-quirks.c                    |  18 +-
 drivers/hv/channel.c                               |   7 +-
 drivers/hv/channel_mgmt.c                          |  12 +-
 drivers/hwmon/mcp3021.c                            |  14 +-
 drivers/hwmon/nct6683.c                            |   2 +
 drivers/hwmon/nct6775.c                            |   2 +
 drivers/hwmon/ntc_thermistor.c                     |   9 +
 drivers/i2c/busses/i2c-at91.c                      |  70 +-
 drivers/i2c/busses/i2c-rk3x.c                      |   2 +-
 drivers/i2c/i2c-core.c                             |   3 +
 drivers/iio/accel/bmc150-accel.c                   |  18 +-
 drivers/iio/adc/at91_adc.c                         |   8 +-
 drivers/iio/adc/vf610_adc.c                        |  91 ++-
 drivers/iio/adc/xilinx-xadc-core.c                 |   5 +-
 drivers/iio/adc/xilinx-xadc.h                      |   6 +-
 drivers/iio/dac/ad5624r_spi.c                      |   4 +-
 drivers/iio/imu/adis16400.h                        |   1 +
 drivers/iio/imu/adis16400_core.c                   |  38 +-
 drivers/iio/imu/adis_trigger.c                     |   2 +-
 drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c         |  25 +-
 drivers/iio/industrialio-core.c                    |   5 +-
 drivers/iio/industrialio-event.c                   |   1 +
 drivers/iio/light/hid-sensor-prox.c                |   2 -
 drivers/iio/pressure/hid-sensor-press.c            |   2 -
 drivers/iio/temperature/tmp006.c                   |   3 +
 drivers/infiniband/core/cma.c                      |  27 +-
 drivers/infiniband/core/iwpm_msg.c                 |   2 +-
 drivers/infiniband/core/umem.c                     |  11 +
 drivers/infiniband/hw/mlx4/mad.c                   |  20 +-
 drivers/infiniband/hw/mlx4/qp.c                    |   3 +-
 drivers/infiniband/ulp/iser/iser_initiator.c       |   4 +-
 drivers/infiniband/ulp/isert/ib_isert.c            |  44 +-
 drivers/input/mouse/elantech.c                     |  29 +-
 drivers/input/mouse/elantech.h                     |   1 +
 drivers/input/mouse/synaptics.c                    |   7 +-
 drivers/input/touchscreen/pixcir_i2c_ts.c          |   2 +-
 drivers/iommu/amd_iommu.c                          |   6 +
 drivers/iommu/intel-iommu.c                        |  13 +-
 drivers/irqchip/irq-sunxi-nmi.c                    |   2 +-
 drivers/leds/led-class.c                           |   7 +-
 drivers/lguest/core.c                              |   2 +-
 drivers/lguest/x86/core.c                          |   5 +-
 drivers/md/dm-stats.c                              |   2 +
 drivers/md/md.c                                    |   2 +-
 drivers/md/persistent-data/dm-btree-remove.c       |   6 +-
 drivers/md/persistent-data/dm-btree.c              |   2 +-
 drivers/md/persistent-data/dm-space-map-metadata.c |  50 +-
 drivers/md/raid0.c                                 |   5 +-
 drivers/md/raid5.c                                 |   3 +-
 drivers/media/dvb-frontends/a8293.h                |   2 +-
 drivers/media/dvb-frontends/af9013.c               |   4 +
 drivers/media/dvb-frontends/af9013.h               |   2 +-
 drivers/media/dvb-frontends/atbm8830.h             |   2 +-
 drivers/media/dvb-frontends/au8522.h               |   2 +-
 drivers/media/dvb-frontends/bcm3510.h              |   2 +-
 drivers/media/dvb-frontends/cx22700.h              |   2 +-
 drivers/media/dvb-frontends/cx22702.h              |   2 +-
 drivers/media/dvb-frontends/cx24110.h              |   2 +-
 drivers/media/dvb-frontends/cx24113.h              |   2 +-
 drivers/media/dvb-frontends/cx24116.c              |   8 +-
 drivers/media/dvb-frontends/cx24116.h              |   2 +-
 drivers/media/dvb-frontends/cx24117.c              |   2 +-
 drivers/media/dvb-frontends/cx24117.h              |   2 +-
 drivers/media/dvb-frontends/cx24123.h              |   2 +-
 drivers/media/dvb-frontends/cxd2820r.h             |   2 +-
 drivers/media/dvb-frontends/dib0070.h              |   2 +-
 drivers/media/dvb-frontends/dib0090.h              |   2 +-
 drivers/media/dvb-frontends/dib3000.h              |   2 +-
 drivers/media/dvb-frontends/dib3000mc.h            |   2 +-
 drivers/media/dvb-frontends/dib7000m.h             |   2 +-
 drivers/media/dvb-frontends/dib7000p.h             |   2 +-
 drivers/media/dvb-frontends/dib8000.h              |   2 +-
 drivers/media/dvb-frontends/dib9000.h              |   2 +-
 drivers/media/dvb-frontends/drxd.h                 |   2 +-
 drivers/media/dvb-frontends/drxk.h                 |   2 +-
 drivers/media/dvb-frontends/ds3000.h               |   2 +-
 drivers/media/dvb-frontends/dvb-pll.h              |   2 +-
 drivers/media/dvb-frontends/dvb_dummy_fe.h         |   2 +-
 drivers/media/dvb-frontends/ec100.h                |   2 +-
 drivers/media/dvb-frontends/hd29l2.h               |   2 +-
 drivers/media/dvb-frontends/isl6405.h              |   2 +-
 drivers/media/dvb-frontends/isl6421.h              |   2 +-
 drivers/media/dvb-frontends/isl6423.h              |   2 +-
 drivers/media/dvb-frontends/itd1000.h              |   2 +-
 drivers/media/dvb-frontends/ix2505v.h              |   2 +-
 drivers/media/dvb-frontends/l64781.h               |   2 +-
 drivers/media/dvb-frontends/lg2160.h               |   2 +-
 drivers/media/dvb-frontends/lgdt3305.h             |   2 +-
 drivers/media/dvb-frontends/lgdt330x.h             |   2 +-
 drivers/media/dvb-frontends/lgs8gl5.h              |   2 +-
 drivers/media/dvb-frontends/lgs8gxx.h              |   2 +-
 drivers/media/dvb-frontends/lnbh24.h               |   2 +-
 drivers/media/dvb-frontends/lnbp21.h               |   2 +-
 drivers/media/dvb-frontends/lnbp22.h               |   2 +-
 drivers/media/dvb-frontends/m88rs2000.h            |   2 +-
 drivers/media/dvb-frontends/mb86a16.h              |   2 +-
 drivers/media/dvb-frontends/mb86a20s.h             |   2 +-
 drivers/media/dvb-frontends/mt312.h                |   2 +-
 drivers/media/dvb-frontends/mt352.h                |   2 +-
 drivers/media/dvb-frontends/nxt200x.h              |   2 +-
 drivers/media/dvb-frontends/nxt6000.h              |   2 +-
 drivers/media/dvb-frontends/or51132.h              |   2 +-
 drivers/media/dvb-frontends/or51211.h              |   2 +-
 drivers/media/dvb-frontends/s5h1409.h              |   2 +-
 drivers/media/dvb-frontends/s5h1411.h              |   2 +-
 drivers/media/dvb-frontends/s5h1420.c              |   2 +-
 drivers/media/dvb-frontends/s5h1420.h              |   2 +-
 drivers/media/dvb-frontends/s5h1432.h              |   2 +-
 drivers/media/dvb-frontends/s921.h                 |   2 +-
 drivers/media/dvb-frontends/si21xx.h               |   2 +-
 drivers/media/dvb-frontends/sp8870.h               |   2 +-
 drivers/media/dvb-frontends/sp887x.h               |   2 +-
 drivers/media/dvb-frontends/stb0899_drv.h          |   2 +-
 drivers/media/dvb-frontends/stb6000.h              |   2 +-
 drivers/media/dvb-frontends/stb6100.h              |   2 +-
 drivers/media/dvb-frontends/stv0288.h              |   2 +-
 drivers/media/dvb-frontends/stv0297.h              |   2 +-
 drivers/media/dvb-frontends/stv0299.h              |   2 +-
 drivers/media/dvb-frontends/stv0367.h              |   2 +-
 drivers/media/dvb-frontends/stv0900.h              |   2 +-
 drivers/media/dvb-frontends/stv090x.h              |   2 +-
 drivers/media/dvb-frontends/stv6110.h              |   2 +-
 drivers/media/dvb-frontends/stv6110x.h             |   2 +-
 drivers/media/dvb-frontends/tda1002x.h             |   4 +-
 drivers/media/dvb-frontends/tda10048.h             |   2 +-
 drivers/media/dvb-frontends/tda1004x.h             |   2 +-
 drivers/media/dvb-frontends/tda10071.h             |   2 +-
 drivers/media/dvb-frontends/tda10086.h             |   2 +-
 drivers/media/dvb-frontends/tda18271c2dd.h         |   2 +-
 drivers/media/dvb-frontends/tda665x.h              |   2 +-
 drivers/media/dvb-frontends/tda8083.h              |   2 +-
 drivers/media/dvb-frontends/tda8261.h              |   2 +-
 drivers/media/dvb-frontends/tda826x.h              |   2 +-
 drivers/media/dvb-frontends/ts2020.h               |   2 +-
 drivers/media/dvb-frontends/tua6100.h              |   2 +-
 drivers/media/dvb-frontends/ves1820.h              |   2 +-
 drivers/media/dvb-frontends/ves1x93.h              |   2 +-
 drivers/media/dvb-frontends/zl10036.h              |   2 +-
 drivers/media/dvb-frontends/zl10039.h              |   2 +-
 drivers/media/dvb-frontends/zl10353.h              |   2 +-
 drivers/media/pci/cx23885/altera-ci.h              |   2 +-
 drivers/media/platform/s5p-mfc/s5p_mfc_common.h    |   2 +-
 drivers/media/platform/sh_veu.c                    |   1 +
 drivers/media/platform/soc_camera/soc_camera.c     |   2 +-
 drivers/media/rc/img-ir/img-ir-core.c              |   2 +-
 drivers/media/tuners/fc0011.h                      |   2 +-
 drivers/media/tuners/fc0012.h                      |   2 +-
 drivers/media/tuners/fc0013.h                      |   2 +-
 drivers/media/tuners/fc2580.h                      |   2 +-
 drivers/media/tuners/max2165.h                     |   2 +-
 drivers/media/tuners/mc44s803.h                    |   2 +-
 drivers/media/tuners/mt2060.h                      |   2 +-
 drivers/media/tuners/mt2063.h                      |   2 +-
 drivers/media/tuners/mt20xx.h                      |   2 +-
 drivers/media/tuners/mt2131.h                      |   2 +-
 drivers/media/tuners/mt2266.h                      |   2 +-
 drivers/media/tuners/mxl5005s.h                    |   2 +-
 drivers/media/tuners/mxl5007t.h                    |   2 +-
 drivers/media/tuners/qt1010.h                      |   2 +-
 drivers/media/tuners/r820t.h                       |   2 +-
 drivers/media/tuners/tda18218.h                    |   2 +-
 drivers/media/tuners/tda18271.h                    |   2 +-
 drivers/media/tuners/tda827x.h                     |   2 +-
 drivers/media/tuners/tda8290.h                     |   2 +-
 drivers/media/tuners/tda9887.h                     |   2 +-
 drivers/media/tuners/tea5761.h                     |   2 +-
 drivers/media/tuners/tea5767.h                     |   2 +-
 drivers/media/tuners/tua9001.h                     |   2 +-
 drivers/media/tuners/tuner-simple.h                |   2 +-
 drivers/media/tuners/tuner-xc2028.h                |   2 +-
 drivers/media/tuners/xc4000.h                      |   2 +-
 drivers/media/tuners/xc5000.h                      |   2 +-
 drivers/media/usb/dvb-usb/dib0700_core.c           |  70 +-
 drivers/media/usb/dvb-usb/dib0700_devices.c        |   6 +
 drivers/media/usb/stk1160/stk1160-v4l.c            |  17 +-
 drivers/media/v4l2-core/videobuf2-core.c           |  11 +-
 drivers/memstick/core/mspro_block.c                |   3 +-
 drivers/misc/mei/client.c                          |   2 +-
 drivers/misc/mei/hw-me.c                           |  59 +-
 drivers/misc/mei/hw-txe.c                          |  33 +-
 drivers/misc/mei/mei_dev.h                         |  11 +
 drivers/mmc/card/block.c                           |  22 +-
 drivers/mmc/card/queue.c                           |   2 +-
 drivers/mmc/card/queue.h                           |   2 +
 drivers/mmc/core/core.c                            |   1 +
 drivers/mmc/host/atmel-mci.c                       |   9 +-
 drivers/mmc/host/sdhci-pxav3.c                     |  21 +-
 drivers/mmc/host/sh_mmcif.c                        |   2 +-
 drivers/mmc/host/sunxi-mmc.c                       |   4 +-
 drivers/mtd/mtd_blkdevs.c                          |   5 +
 drivers/mtd/ubi/attach.c                           |   2 +-
 drivers/mtd/ubi/cdev.c                             |   2 +-
 drivers/mtd/ubi/eba.c                              |   3 +-
 drivers/mtd/ubi/wl.c                               |   2 +-
 drivers/net/bonding/bond_alb.c                     |  17 +-
 drivers/net/bonding/bond_main.c                    |  15 +-
 drivers/net/bonding/bond_options.c                 |   2 +-
 drivers/net/can/flexcan.c                          |  11 +-
 drivers/net/ethernet/broadcom/bnx2x/bnx2x.h        | 137 ++--
 drivers/net/ethernet/broadcom/bnx2x/bnx2x_cmn.c    |   9 +-
 drivers/net/ethernet/broadcom/bnx2x/bnx2x_main.c   |   3 +-
 drivers/net/ethernet/broadcom/tg3.c                |   2 +
 drivers/net/ethernet/emulex/benet/be_cmds.c        |  87 ++-
 drivers/net/ethernet/emulex/benet/be_ethtool.c     |  18 +-
 drivers/net/ethernet/emulex/benet/be_main.c        |  22 +-
 drivers/net/ethernet/intel/e1000/e1000_main.c      |  10 +-
 drivers/net/ethernet/marvell/mvneta.c              |  27 +-
 drivers/net/ethernet/mellanox/mlx4/cmd.c           |   3 +-
 drivers/net/ethernet/mellanox/mlx4/en_netdev.c     |  16 +-
 drivers/net/ethernet/mellanox/mlx4/en_rx.c         |  26 +-
 drivers/net/ethernet/mellanox/mlx4/en_tx.c         |  27 +-
 drivers/net/ethernet/mellanox/mlx4/mlx4_en.h       |   2 +
 .../net/ethernet/mellanox/mlx5/core/pagealloc.c    |  10 +-
 drivers/net/ethernet/stmicro/stmmac/descs.h        |   2 +
 drivers/net/ethernet/stmicro/stmmac/enh_desc.c     |   3 +-
 drivers/net/ethernet/stmicro/stmmac/norm_desc.c    |   3 +-
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c  |  44 +-
 drivers/net/phy/dp83640.c                          |  23 +-
 drivers/net/phy/phy.c                              |   7 +-
 drivers/net/phy/phy_device.c                       |   5 +-
 drivers/net/ppp/ppp_generic.c                      |   1 +
 drivers/net/usb/asix_common.c                      |   2 +
 drivers/net/usb/cdc_mbim.c                         |   2 +-
 drivers/net/usb/cdc_ncm.c                          |   6 +-
 drivers/net/usb/sr9800.c                           |   1 +
 drivers/net/usb/usbnet.c                           |  17 +-
 drivers/net/vxlan.c                                |  56 +-
 drivers/net/wireless/ath/ath9k/beacon.c            |  20 +-
 drivers/net/wireless/ath/ath9k/common.h            |   2 +-
 drivers/net/wireless/ath/ath9k/main.c              |  12 +-
 drivers/net/wireless/b43/main.c                    |   4 +
 drivers/net/wireless/iwlwifi/dvm/dev.h             |   1 -
 drivers/net/wireless/iwlwifi/dvm/ucode.c           |   5 -
 drivers/net/wireless/iwlwifi/pcie/trans.c          |  11 +-
 drivers/net/wireless/rt2x00/rt2800usb.c            |   1 +
 drivers/net/wireless/rtlwifi/pci.c                 |  43 +-
 drivers/net/wireless/rtlwifi/rtl8188ee/hw.c        |  16 -
 drivers/net/wireless/rtlwifi/rtl8192cu/sw.c        |   2 +
 drivers/net/wireless/rtlwifi/rtl8192ee/hw.c        |  17 -
 drivers/net/wireless/rtlwifi/rtl8192ee/sw.c        |   3 +-
 drivers/net/wireless/rtlwifi/rtl8192ee/trx.c       |   7 +-
 drivers/net/wireless/rtlwifi/rtl8192ee/trx.h       |   2 +-
 drivers/net/wireless/rtlwifi/rtl8723ae/hw.c        |  13 -
 drivers/net/wireless/rtlwifi/rtl8723be/hw.c        |  17 -
 drivers/net/wireless/rtlwifi/rtl8821ae/hw.c        |  20 -
 drivers/net/wireless/rtlwifi/usb.c                 |   2 +-
 drivers/net/wireless/rtlwifi/wifi.h                |   1 +
 drivers/net/wireless/ti/wl18xx/debugfs.c           |   2 +-
 drivers/net/wireless/ti/wlcore/debugfs.h           |   4 +-
 drivers/net/xen-netback/xenbus.c                   |  34 +-
 drivers/net/xen-netfront.c                         |   5 +-
 drivers/nfc/st21nfcb/i2c.c                         |  14 +-
 drivers/nfc/st21nfcb/st21nfcb.c                    |   3 -
 drivers/of/address.c                               |  15 +-
 drivers/of/base.c                                  |  35 +-
 drivers/pci/host/pcie-designware.c                 |   2 +-
 drivers/pci/host/pcie-spear13xx.c                  |   4 +-
 drivers/pci/hotplug/cpci_hotplug_pci.c             |   3 +-
 drivers/pci/hotplug/pciehp_hpc.c                   |  52 +-
 drivers/pci/pci-acpi.c                             |   3 +
 drivers/pci/pci.c                                  |  11 +
 drivers/pci/pcie/aer/aerdrv_errprint.c             |  12 +-
 drivers/pcmcia/topic.h                             |  16 +
 drivers/pinctrl/core.c                             |  10 +-
 drivers/pinctrl/core.h                             |   2 +-
 drivers/pinctrl/devicetree.c                       |   2 +-
 drivers/pinctrl/mvebu/pinctrl-armada-370.c         |   4 +-
 drivers/pinctrl/mvebu/pinctrl-armada-375.c         |   4 +-
 drivers/pinctrl/mvebu/pinctrl-armada-38x.c         |  51 +-
 drivers/pinctrl/mvebu/pinctrl-armada-xp.c          |  37 +-
 drivers/platform/x86/compal-laptop.c               |  10 +-
 drivers/platform/x86/dell-laptop.c                 |   8 +-
 drivers/platform/x86/ideapad-laptop.c              |  10 +-
 drivers/power/ipaq_micro_battery.c                 |  22 +-
 drivers/power/lp8788-charger.c                     |   4 +-
 drivers/power/reset/at91-reset.c                   |   4 +-
 drivers/power/twl4030_madc_battery.c               |   7 +-
 drivers/regulator/core.c                           |   2 +-
 drivers/s390/kvm/virtio_ccw.c                      |  11 +-
 drivers/scsi/3w-9xxx.c                             |  57 +-
 drivers/scsi/3w-9xxx.h                             |   5 -
 drivers/scsi/3w-sas.c                              |  50 +-
 drivers/scsi/3w-sas.h                              |   4 -
 drivers/scsi/3w-xxxx.c                             |  42 +-
 drivers/scsi/3w-xxxx.h                             |   5 -
 drivers/scsi/be2iscsi/be_main.c                    |   2 +-
 drivers/scsi/ipr.h                                 |   2 +-
 drivers/scsi/mvsas/mv_sas.c                        |   5 +-
 drivers/scsi/scsi_devinfo.c                        |   1 +
 drivers/scsi/scsi_lib.c                            |   4 +-
 drivers/scsi/scsi_scan.c                           |   6 +
 drivers/scsi/scsi_transport_srp.c                  |  54 +-
 drivers/scsi/sd.c                                  |  20 +-
 drivers/scsi/sd_dif.c                              |   2 +-
 drivers/scsi/storvsc_drv.c                         |  18 +-
 drivers/spi/spi-bitbang.c                          |  17 +-
 drivers/spi/spi-imx.c                              |   4 +-
 drivers/spi/spi-orion.c                            |  25 +-
 drivers/spi/spi.c                                  |  11 +-
 drivers/spi/spidev.c                               |   5 +-
 drivers/ssb/Kconfig                                |   1 +
 drivers/staging/android/sync.c                     |   2 +-
 drivers/staging/comedi/drivers/adv_pci1710.c       |   3 +-
 drivers/staging/gdm724x/gdm_mux.c                  |  16 +-
 drivers/staging/ozwpan/ozusbsvc1.c                 |  19 +-
 drivers/staging/panel/panel.c                      |  10 +-
 drivers/staging/rtl8712/rtl8712_recv.c             |   3 +-
 drivers/staging/vt6655/device_main.c               |   4 +
 drivers/staging/vt6656/rxtx.c                      |  14 +-
 drivers/target/iscsi/iscsi_target.c                | 106 ++-
 drivers/target/iscsi/iscsi_target_core.h           |   7 +
 drivers/target/iscsi/iscsi_target_erl0.c           |  13 +-
 drivers/target/iscsi/iscsi_target_login.c          |  59 +-
 drivers/target/target_core_file.c                  | 122 +--
 drivers/target/target_core_pscsi.c                 |   3 +
 drivers/target/target_core_pscsi.h                 |   1 +
 drivers/target/target_core_sbc.c                   |  15 +-
 drivers/target/target_core_transport.c             |  37 +-
 drivers/thermal/armada_thermal.c                   |   6 +-
 drivers/tty/hvc/hvc_xen.c                          |  20 +-
 drivers/tty/n_gsm.c                                |   5 +-
 drivers/tty/n_tty.c                                | 123 ++-
 drivers/tty/serial/8250/8250_dw.c                  |  12 +
 drivers/tty/serial/atmel_serial.c                  |   9 +-
 drivers/tty/serial/fsl_lpuart.c                    |   5 +
 drivers/tty/serial/imx.c                           |  23 +-
 drivers/tty/serial/of_serial.c                     |   1 -
 drivers/tty/serial/uartlite.c                      |  11 +-
 drivers/tty/serial/xilinx_uartps.c                 |  12 +-
 drivers/usb/chipidea/otg_fsm.c                     |   4 -
 drivers/usb/class/cdc-acm.c                        |  36 +-
 drivers/usb/class/cdc-acm.h                        |   1 +
 drivers/usb/class/cdc-wdm.c                        |  12 +-
 drivers/usb/core/devio.c                           |  65 +-
 drivers/usb/core/hub.c                             |  86 +--
 drivers/usb/dwc2/hcd.c                             |   2 +-
 drivers/usb/dwc3/ep0.c                             |   4 +
 drivers/usb/dwc3/gadget.c                          |  10 +-
 drivers/usb/gadget/configfs.c                      |   1 +
 drivers/usb/gadget/function/f_fs.c                 |  10 +-
 drivers/usb/gadget/legacy/printer.c                |   9 +
 drivers/usb/host/ehci-hcd.c                        |  10 +-
 drivers/usb/host/ehci-hub.c                        |   9 +-
 drivers/usb/host/fotg210-hcd.c                     |   2 +-
 drivers/usb/host/fusbh200-hcd.c                    |   3 +-
 drivers/usb/host/isp116x-hcd.c                     |   2 +-
 drivers/usb/host/oxu210hp-hcd.c                    |   7 +-
 drivers/usb/host/r8a66597-hcd.c                    |   2 +-
 drivers/usb/host/sl811-hcd.c                       |   2 +-
 drivers/usb/host/uhci-hub.c                        |   5 +-
 drivers/usb/host/xhci-hub.c                        |   9 +-
 drivers/usb/host/xhci-mem.c                        |   2 +-
 drivers/usb/host/xhci-pci.c                        |   2 +-
 drivers/usb/host/xhci-ring.c                       |   9 +-
 drivers/usb/host/xhci.h                            |   2 +-
 drivers/usb/musb/musb_core.c                       |  47 +-
 drivers/usb/musb/musb_virthub.c                    |   6 +-
 drivers/usb/phy/phy.c                              |   4 +-
 drivers/usb/serial/cp210x.c                        |   3 +
 drivers/usb/serial/ftdi_sio.c                      |  10 +-
 drivers/usb/serial/ftdi_sio_ids.h                  |   7 +
 drivers/usb/serial/generic.c                       |   2 +-
 drivers/usb/serial/keyspan_pda.c                   |   3 +
 drivers/usb/serial/option.c                        |   1 +
 drivers/usb/serial/pl2303.c                        |   1 -
 drivers/usb/serial/pl2303.h                        |   4 -
 drivers/usb/serial/usb-serial.c                    |   1 +
 drivers/usb/serial/visor.c                         |   2 +-
 drivers/usb/storage/uas-detect.h                   |   9 +-
 drivers/usb/storage/uas.c                          |  16 +-
 drivers/usb/storage/unusual_devs.h                 |   7 +
 drivers/usb/storage/usb.c                          |   8 +-
 drivers/w1/slaves/w1_therm.c                       |  62 +-
 drivers/watchdog/omap_wdt.c                        |   7 +
 drivers/xen/Makefile                               |   2 +-
 drivers/xen/balloon.c                              |  23 +
 drivers/xen/events/events_2l.c                     |  10 +
 drivers/xen/events/events_base.c                   |  19 +-
 drivers/xen/preempt.c                              |  44 ++
 drivers/xen/privcmd.c                              |   2 +
 drivers/xen/xen-pciback/conf_space.c               |   6 +-
 drivers/xen/xen-pciback/conf_space.h               |   2 +-
 drivers/xen/xen-pciback/conf_space_header.c        |   2 +-
 drivers/xen/xenbus/xenbus_probe.c                  |  29 +
 firmware/ihex2fw.c                                 |   1 +
 fs/9p/vfs_inode.c                                  |   3 +-
 fs/9p/vfs_inode_dotl.c                             |   3 +-
 fs/aio.c                                           |   3 +
 fs/binfmt_elf.c                                    |   9 +-
 fs/btrfs/ctree.c                                   |   2 +-
 fs/btrfs/ctree.h                                   |   5 +
 fs/btrfs/dir-item.c                                |  10 +-
 fs/btrfs/extent-tree.c                             |   5 +-
 fs/btrfs/inode-map.c                               |   2 +-
 fs/btrfs/ioctl.c                                   |  19 +-
 fs/btrfs/tree-log.c                                |  16 +-
 fs/btrfs/xattr.c                                   | 203 +++--
 fs/cifs/file.c                                     |   1 +
 fs/cifs/smb2ops.c                                  |   3 +-
 fs/coredump.c                                      |   2 +-
 fs/dcache.c                                        |  19 +-
 fs/efivarfs/super.c                                |   2 +-
 fs/exec.c                                          |  79 +-
 fs/ext4/ext4_jbd2.c                                |   6 +
 fs/ext4/extents.c                                  |  17 +-
 fs/ext4/extents_status.c                           |   8 +
 fs/ext4/indirect.c                                 | 107 ++-
 fs/ext4/inode.c                                    |  40 +-
 fs/ext4/mballoc.c                                  |  16 +-
 fs/ext4/migrate.c                                  |  17 +-
 fs/ext4/namei.c                                    |  41 +-
 fs/ext4/super.c                                    |   1 +
 fs/fhandle.c                                       |   5 +-
 fs/fs_pin.c                                        |   4 +-
 fs/fuse/inode.c                                    |   2 +-
 fs/hfsplus/xattr.c                                 |  38 +-
 fs/inode.c                                         |   4 +-
 fs/jbd2/checkpoint.c                               |   7 +-
 fs/jbd2/journal.c                                  |  38 +-
 fs/jbd2/recovery.c                                 |  10 +-
 fs/jbd2/revoke.c                                   |  18 +-
 fs/jbd2/transaction.c                              |  25 +-
 fs/namei.c                                         |   9 +-
 fs/namespace.c                                     |  80 +-
 fs/nfs/nfs3xdr.c                                   |   2 +-
 fs/nfs/nfs4proc.c                                  |   3 +
 fs/nfs/nfs4state.c                                 |   2 +
 fs/nfs/nfs4xdr.c                                   |   6 +
 fs/nfs/pnfs.c                                      |   3 +
 fs/nfs/write.c                                     |   1 +
 fs/nfsd/nfs4proc.c                                 |   2 +
 fs/nfsd/nfs4state.c                                |  25 +-
 fs/nfsd/nfs4xdr.c                                  |  12 +-
 fs/nilfs2/btree.c                                  |   2 +-
 fs/ocfs2/dlm/dlmmaster.c                           |  13 +
 fs/ocfs2/file.c                                    |  14 +-
 fs/omfs/inode.c                                    |   6 +-
 fs/open.c                                          |   2 +-
 fs/pnode.h                                         |   1 -
 fs/proc/root.c                                     |   5 +-
 fs/sysfs/mount.c                                   |   5 +-
 fs/ufs/balloc.c                                    |  34 +-
 fs/ufs/ialloc.c                                    |  16 +-
 fs/ufs/inode.c                                     |   5 +-
 fs/ufs/namei.c                                     |  22 +-
 fs/ufs/super.c                                     |  11 +
 fs/ufs/ufs.h                                       |   1 +
 fs/xfs/libxfs/xfs_attr_leaf.c                      |   8 +-
 fs/xfs/libxfs/xfs_attr_leaf.h                      |   2 +-
 fs/xfs/xfs_attr_inactive.c                         |  83 +-
 fs/xfs/xfs_file.c                                  |  16 +-
 fs/xfs/xfs_inode.c                                 |  12 +-
 fs/xfs/xfs_inode.h                                 |   5 +-
 fs/xfs/xfs_iops.c                                  |  36 +-
 fs/xfs/xfs_symlink.c                               |   2 +-
 include/acpi/acpi_bus.h                            |   7 +
 include/acpi/acpixf.h                              |  12 +-
 include/acpi/actypes.h                             |  21 +
 include/acpi/platform/acenv.h                      |   1 +
 include/drm/drm_pciids.h                           |   1 +
 include/kvm/arm_arch_timer.h                       |  10 +-
 include/kvm/arm_vgic.h                             |   5 +-
 include/linux/acpi.h                               |  72 ++
 include/linux/blk_types.h                          |   4 +-
 include/linux/bpf.h                                |   4 +-
 include/linux/compiler.h                           |  74 ++
 include/linux/cpuidle.h                            |   1 -
 include/linux/fs.h                                 |   2 +-
 include/linux/hugetlb.h                            |   8 +-
 include/linux/if_vlan.h                            |  60 +-
 include/linux/jbd2.h                               |   4 +-
 include/linux/jhash.h                              |  17 +-
 include/linux/kconfig.h                            |   9 +
 include/linux/kmemleak.h                           |   6 +-
 include/linux/ktime.h                              |  29 +-
 include/linux/kvm_host.h                           |   1 +
 include/linux/libata.h                             |  11 +
 include/linux/netdevice.h                          |   6 +
 include/linux/nfs_xdr.h                            |   2 +-
 include/linux/nilfs2_fs.h                          |   2 +-
 include/linux/of.h                                 |  17 +-
 include/linux/pci.h                                |   6 +-
 include/linux/property.h                           |  73 ++
 include/linux/rhashtable.h                         |   2 +-
 include/linux/rmap.h                               |  10 +
 include/linux/sched/rt.h                           |   7 +-
 include/linux/skbuff.h                             |  13 +
 include/linux/swapops.h                            |   4 +
 include/linux/usb.h                                |  26 +
 include/linux/usb/usbnet.h                         |  16 +-
 include/linux/usb_usual.h                          |   2 +
 include/net/dst.h                                  |   1 +
 include/net/inet_connection_sock.h                 |   3 +-
 include/net/ip.h                                   |  16 -
 include/net/ip6_route.h                            |   3 +-
 include/net/netfilter/nf_queue.h                   |   2 +
 include/net/netns/sctp.h                           |   1 +
 include/net/sctp/sctp.h                            |   7 +-
 include/net/sctp/structs.h                         |   4 +
 include/net/sock.h                                 |  11 +
 include/net/tcp_states.h                           |   4 +-
 include/scsi/scsi_devinfo.h                        |   1 +
 include/sound/emu10k1.h                            |  14 +-
 include/sound/soc-dapm.h                           |   2 +-
 include/target/target_core_base.h                  |   2 +-
 include/uapi/drm/radeon_drm.h                      |   1 +
 include/uapi/linux/usbdevice_fs.h                  |   3 +-
 include/xen/events.h                               |   2 +-
 include/xen/xen-ops.h                              |  26 +
 kernel/bpf/core.c                                  |  12 +-
 kernel/bpf/verifier.c                              |   8 +-
 kernel/events/core.c                               |  14 +-
 kernel/irq/devres.c                                |   4 +-
 kernel/locking/rtmutex.c                           |  12 +-
 kernel/module.c                                    |   3 +
 kernel/power/Kconfig                               |   2 +-
 kernel/power/snapshot.c                            |  21 +-
 kernel/printk/printk.c                             |  11 +-
 kernel/ptrace.c                                    |  20 +
 kernel/rcu/tiny.c                                  |   5 +
 kernel/sched/core.c                                |  30 +-
 kernel/sched/fair.c                                |   4 +-
 kernel/softirq.c                                   |   6 +-
 kernel/time/hrtimer.c                              |  16 +-
 kernel/time/tick-broadcast-hrtimer.c               |  11 +-
 kernel/trace/ring_buffer.c                         |   3 +-
 kernel/trace/ring_buffer_benchmark.c               |   2 +-
 kernel/trace/trace.h                               |   1 +
 kernel/trace/trace_branch.c                        |  17 +-
 kernel/trace/trace_events_filter.c                 |  17 +-
 kernel/trace/trace_functions_graph.c               |   8 +-
 lib/bitmap.c                                       |  17 +-
 lib/rhashtable.c                                   |  12 +-
 lib/string.c                                       |   2 +-
 lib/strnlen_user.c                                 |   3 +-
 mm/gup.c                                           |  25 +-
 mm/hugetlb.c                                       |  74 +-
 mm/kmemleak.c                                      |  28 +-
 mm/memory-failure.c                                |  18 +-
 mm/memory_hotplug.c                                |  17 +-
 mm/mempolicy.c                                     |   2 +-
 mm/migrate.c                                       |   5 +-
 mm/mmap.c                                          |   2 +-
 mm/page-writeback.c                                |  13 +-
 mm/page_isolation.c                                |   1 +
 mm/percpu.c                                        |   2 +-
 mm/rmap.c                                          |  49 +-
 net/9p/client.c                                    |   3 +-
 net/bridge/br_fdb.c                                |   2 +
 net/bridge/br_ioctl.c                              |   2 -
 net/bridge/br_multicast.c                          |  11 +-
 net/bridge/br_netfilter.c                          |  17 +-
 net/bridge/br_stp_if.c                             |   4 +-
 net/bridge/br_vlan.c                               |   4 +-
 net/caif/caif_socket.c                             |   8 +
 net/ceph/crush/mapper.c                            |  16 +-
 net/ceph/osd_client.c                              |  33 +-
 net/core/dev.c                                     |  14 +-
 net/core/neighbour.c                               |  13 +
 net/core/netpoll.c                                 |   4 +-
 net/core/skbuff.c                                  |  42 +-
 net/core/sock.c                                    |  21 +-
 net/ipv4/af_inet.c                                 |   2 +
 net/ipv4/geneve.c                                  |  18 +-
 net/ipv4/ip_forward.c                              |   3 +
 net/ipv4/ping.c                                    |   1 +
 net/ipv4/route.c                                   |   4 +
 net/ipv4/tcp.c                                     |  17 +-
 net/ipv4/tcp_cong.c                                |   6 +-
 net/ipv4/tcp_fastopen.c                            |   2 -
 net/ipv4/tcp_input.c                               |   7 +-
 net/ipv4/tcp_ipv4.c                                |   2 +-
 net/ipv4/tcp_minisocks.c                           |   5 +-
 net/ipv4/tcp_output.c                              |  66 +-
 net/ipv4/udp.c                                     |  24 +-
 net/ipv6/ip6_output.c                              |   3 +-
 net/ipv6/ip6_vti.c                                 |   3 +-
 net/ipv6/ndisc.c                                   |   9 +-
 net/ipv6/tcp_ipv6.c                                |  15 +-
 net/ipv6/udp.c                                     |  10 +-
 net/mac80211/agg-rx.c                              |   8 +-
 net/mac80211/ieee80211_i.h                         |   3 +
 net/mac80211/main.c                                |   3 +
 net/mac80211/rx.c                                  |  12 +-
 net/mac80211/sta_info.h                            |   2 +
 net/mac80211/wep.c                                 |   6 +-
 net/netfilter/core.c                               |   1 +
 net/netfilter/nf_internals.h                       |   1 +
 net/netfilter/nf_queue.c                           |  17 +
 net/netfilter/nf_tables_api.c                      |   5 +-
 net/netfilter/nfnetlink_cthelper.c                 |   7 +-
 net/netfilter/nfnetlink_queue_core.c               |  24 +-
 net/netfilter/nft_compat.c                         |   6 +
 net/netfilter/xt_cgroup.c                          |   2 +-
 net/netlink/af_netlink.c                           |  11 +-
 net/openvswitch/actions.c                          |   4 +-
 net/openvswitch/datapath.c                         |   3 +-
 net/openvswitch/vport-gre.c                        |  12 +-
 net/packet/af_packet.c                             |  20 +-
 net/rose/af_rose.c                                 |   3 +-
 net/sched/cls_api.c                                |   5 +
 net/sched/sch_api.c                                |  10 +-
 net/sctp/output.c                                  |   4 +-
 net/sctp/socket.c                                  |  43 +-
 net/socket.c                                       |  24 +-
 net/sunrpc/auth_gss/gss_rpc_xdr.c                  |  23 +-
 net/sunrpc/backchannel_rqst.c                      |   2 +-
 net/sunrpc/xprtrdma/verbs.c                        |  40 +-
 net/sunrpc/xprtrdma/xprt_rdma.h                    |   1 +
 net/unix/af_unix.c                                 |   8 +
 net/wireless/wext-compat.c                         |   2 +
 net/xfrm/xfrm_policy.c                             |  12 +-
 security/integrity/evm/evm_main.c                  |  12 +
 security/integrity/ima/ima.h                       |   2 +-
 security/integrity/ima/ima_fs.c                    |   4 +-
 security/integrity/ima/ima_template_lib.c          |   3 +-
 security/keys/keyring.c                            |   8 +-
 security/selinux/hooks.c                           |   3 +-
 security/selinux/nlmsgtab.c                        |   7 +
 security/selinux/selinuxfs.c                       |   2 +-
 sound/firewire/bebob/bebob_maudio.c                |   8 +-
 sound/oss/sequencer.c                              |  12 +-
 sound/pci/emu10k1/emu10k1.c                        |   6 +-
 sound/pci/emu10k1/emu10k1_callback.c               |   4 +-
 sound/pci/emu10k1/emu10k1_main.c                   |  21 +-
 sound/pci/emu10k1/emupcm.c                         |   2 +-
 sound/pci/emu10k1/emuproc.c                        |  12 -
 sound/pci/emu10k1/memory.c                         |  11 +-
 sound/pci/hda/hda_codec.c                          |  21 +-
 sound/pci/hda/hda_intel.c                          |  77 +-
 sound/pci/hda/hda_priv.h                           |  12 +-
 sound/pci/hda/patch_conexant.c                     |  12 +
 sound/pci/hda/patch_realtek.c                      | 220 +++++-
 sound/pci/hda/patch_sigmatel.c                     |  25 +
 sound/soc/codecs/cs4271.c                          |   4 +-
 sound/soc/codecs/mc13783.c                         |   4 +-
 sound/soc/codecs/pcm512x.c                         |   4 +-
 sound/soc/codecs/rt5677.c                          |   2 +-
 sound/soc/codecs/tas2552.c                         |   4 +-
 sound/soc/codecs/wm5102.c                          |   2 +-
 sound/soc/codecs/wm5110.c                          |   2 +-
 sound/soc/codecs/wm8737.c                          |   6 +-
 sound/soc/codecs/wm8741.c                          |   8 +-
 sound/soc/codecs/wm8903.h                          |   2 +-
 sound/soc/codecs/wm8955.c                          |   2 +-
 sound/soc/codecs/wm8960.c                          |   4 +-
 sound/soc/codecs/wm8994.c                          |   2 +-
 sound/soc/codecs/wm8997.c                          |   2 +-
 sound/soc/davinci/davinci-evm.c                    |  10 -
 sound/soc/fsl/imx-wm8962.c                         |   2 +-
 sound/soc/samsung/s3c24xx-i2s.c                    |   4 +-
 sound/soc/soc-dapm.c                               |  11 +-
 sound/synth/emux/emux_oss.c                        |  11 +-
 sound/synth/emux/emux_seq.c                        |  29 +-
 sound/usb/clock.c                                  |   5 +
 sound/usb/mixer.c                                  |   1 +
 sound/usb/mixer_maps.c                             |   5 +
 sound/usb/mixer_quirks.c                           |   1 +
 sound/usb/pcm.c                                    |   5 +
 sound/usb/quirks-table.h                           |  40 +
 sound/usb/quirks.c                                 |  95 ++-
 sound/usb/quirks.h                                 |   5 +
 tools/lib/traceevent/kbuffer-parse.c               |   1 -
 tools/perf/util/cloexec.c                          |   6 +
 tools/perf/util/cloexec.h                          |   6 +
 tools/perf/util/symbol-elf.c                       |   4 +
 tools/power/x86/turbostat/Makefile                 |   6 +-
 virt/kvm/arm/arch_timer.c                          |  30 +-
 virt/kvm/arm/vgic-v2.c                             |   8 +
 virt/kvm/arm/vgic-v3.c                             |   8 +
 virt/kvm/arm/vgic.c                                | 125 +--
 virt/kvm/kvm_main.c                                |  23 +-
 1032 files changed, 10573 insertions(+), 4181 deletions(-)
 create mode 100644 arch/arm/kernel/psci-call.S
 create mode 100644 arch/arm/kernel/reboot.h
 create mode 100644 arch/arm64/include/asm/alternative-asm.h
 create mode 100644 arch/arm64/include/asm/alternative.h
 create mode 100644 arch/arm64/kernel/alternative.c
 create mode 100644 arch/arm64/kernel/cpu_errata.c
 create mode 100644 arch/powerpc/include/asm/irq_work.h
 create mode 100644 drivers/acpi/property.c
 create mode 100644 drivers/base/property.c
 create mode 100644 drivers/hid/hid-logitech-hidpp.c
 create mode 100644 drivers/xen/preempt.c
 create mode 100644 include/linux/property.h

