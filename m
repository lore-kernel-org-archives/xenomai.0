MIME-Version: 1.0
In-Reply-To: <4B46590F.2060308@domain.hid>
References: <4bed572e0911221135s64fc4726x1cd7235f116e11a4@domain.hid>
	<4B28208B.7000305@domain.hid>
	<4bed572e0912160458i32834958q9512476f1603979d@domain.hid>
	<4B2BF4D9.6000503@domain.hid>
	<4bed572e1001051015l21e71e8eyaec207701c2e21ad@domain.hid>
	<4B43BE72.6040101@domain.hid>
	<4bed572e1001060557x12ffd808k193573c565830a1b@domain.hid>
	<4B450B7E.80106@domain.hid>
	<4bed572e1001071124x55a964f8u22558c05c2a4485c@domain.hid>
	<4B46590F.2060308@domain.hid>
Date: Fri, 8 Jan 2010 11:14:47 +0000
Message-ID: <4bed572e1001080314n4d723074ld77459d1dffc8c3e@domain.hid>
From: Ettore Pedretti <epedrett@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Subject: Re: [Xenomai-help] Help on analogy_ni_pcimio (Alexis Berlemont?)
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Alexis Berlemont <berlemont.hauw@domain.hid>
Cc: xenomai@xenomai.org

Hi,

I started from scratch by rebooting the system.

analogy_config analogy0 analogy_ni_pcimio

insn_write (no output)

Relevant error trace:
Analogy: a4l_rt_open: minor=0
Analogy: a4l_rt_ioctl: minor=0
Analogy: a4l_ioctl_devcfg: minor=0
Analogy: a4l_presetup_transfer: minor=0
Analogy: a4l_device_attach: minor=0
Analogy: a4l_fill_lnkdesc: minor=0
Analogy: a4l_lct_drv: name=analogy_ni_pcimio
Analogy: a4l_assign_driver: minor=0
Analogy: analogy_ni_pcimio: pcimio_attach: found pci-6711 board
mite 0000:04:01.0: PCI->APIC IRQ transform: INT A -> IRQ 48
mite 0000:04:01.0: setting latency timer to 64
Analogy: MITE: 0xd0801000 mapped to f8e26000
Analogy: DAQ: 0xd0800000 mapped to f8e2a000
Analogy: MITE: version = 1, type = 1, mite mode = 1, interface mode = 3
Analogy: MITE: num channels = 3, write post fifo depth = 1, wins = 0, iowins = 2
Analogy: analogy_ni_pcimio: pcimio_attach: found irq 48
Analogy: analogy_ni_pcimio: mio_common: starting attach procedure...
Analogy: analogy_ni_pcimio: mio_common: registering AI subdevice...
Analogy: analogy_ni_pcimio: mio_common: AI subdevice not present
Analogy: analogy_ni_pcimio: mio_common: AI subdevice registered
Analogy: analogy_ni_pcimio: mio_common: registering AO subdevice...
Analogy: analogy_ni_pcimio: mio_common: AO: 4 channels
Analogy: analogy_ni_pcimio: mio_common: AO subdevice registered
Analogy: analogy_ni_pcimio: mio_common: registering DIO subdevice...
Analogy: analogy_ni_pcimio: mio_common: DIO: 8 channels
Analogy: analogy_ni_pcimio: mio_common: DIO subdevice registered
Analogy: analogy_ni_pcimio: mio_common: registering 8255 subdevice...
Analogy: analogy_ni_pcimio: mio_common: 8255 subdevice not present
Analogy: analogy_ni_pcimio: mio_common: 8255 subdevice registered
Analogy: analogy_ni_pcimio: mio_common: registering calib subdevice...
Analogy: analogy_ni_pcimio: mio_common: calib: common calibration
Analogy: analogy_ni_pcimio: mio_common: calib subdevice registered
Analogy: analogy_ni_pcimio: mio_common: registering EEPROM subdevice...
Analogy: analogy_ni_pcimio: mio_common: EEPROM: size = 512
Analogy: analogy_ni_pcimio: mio_common: EEPROM subdevice registered
Analogy: analogy_ni_pcimio: mio_common: registering PFI(DIO) subdevice...
Analogy: analogy_ni_pcimio: mio_common: PFI: 10 bits...
Analogy: analogy_ni_pcimio: mio_common: PFI subdevice registered
Analogy: analogy_ni_pcimio: mio_common: registering serial subdevice...
Analogy: analogy_ni_pcimio: mio_common: serial subdevice registered
Analogy: analogy_ni_pcimio: mio_common: registering GPCT[0] subdevice...
Analogy: analogy_ni_pcimio: mio_common: GPCT[0]: 24 bits
Analogy: analogy_ni_pcimio: mio_common: GPCT[0]: command feature available
Analogy: analogy_ni_pcimio: mio_common: GCPT[0] subdevice registered
Analogy: analogy_ni_pcimio: mio_common: registering GPCT[1] subdevice...
Analogy: analogy_ni_pcimio: mio_common: GPCT[1]: 24 bits
Analogy: analogy_ni_pcimio: mio_common: GPCT[1]: command feature available
Analogy: analogy_ni_pcimio: mio_common: GCPT[1] subdevice registered
Analogy: analogy_ni_pcimio: mio_common: registering counter subdevice...
Analogy: analogy_ni_pcimio: mio_common: counter subdevice registered
Analogy: analogy_ni_pcimio: mio_common: initializing AI...
Analogy: analogy_ni_pcimio: mio_common: AI initialization OK
Analogy: analogy_ni_pcimio: mio_common: initializing A0...
Analogy: analogy_ni_pcimio: mio_common: A0 initialization OK
Analogy: analogy_ni_pcimio: mio_common: DMA setup
Analogy: analogy_ni_pcimio: mio_common: attach procedure complete
Analogy: a4l_free_lnkdesc: minor=0
Analogy: a4l_setup_transfer: minor=0
Analogy: a4l_rt_close: minor=0
Analogy: a4l_rt_open: minor=0
Analogy: a4l_rt_ioctl: minor=0
Analogy: a4l_ioctl_devinfo: minor=0
Analogy: a4l_rt_ioctl: minor=0
---------------> snip <-----------------
Analogy: a4l_rt_ioctl: minor=0
Analogy: a4l_rt_ioctl: minor=0
Analogy: a4l_reserve_transfer: minor=0 idx=1
Analogy: a4l_rt_close: minor=0

Then typed:
cmd_write
cmd_write: triggering failed (ret=-16)

error trace:

Analogy: a4l_rt_open: minor=0
Analogy: a4l_rt_ioctl: minor=0
---------------> snip <-----------------
Analogy: a4l_rt_ioctl: minor=0
Analogy: a4l_rt_ioctl: minor=0
Analogy: a4l_ioctl_cancel: subdevice currently idle
Analogy: a4l_rt_ioctl: minor=0
Analogy: a4l_ioctl_cmd: minor=0
Analogy: a4l_fill_cmddesc: desc dump
Analogy: 	->idx_subd=1
Analogy: 	->flags=0
Analogy: 	->nb_chan=2
Analogy: 	->chan_descs=0x0
Analogy: 	->data_len=0
Analogy: 	->pdata=0x(null)
Analogy: a4l_check_cmddesc: minor=0
Analogy: a4l_ioctl_cmd: 1st cmd checks passed
Analogy: a4l_ioctl_cmd: driver's cmd checks passed
Analogy: a4l_reserve_transfer: minor=0 idx=1
Analogy: a4l_init_transfer: minor=0 idx=1
Analogy: a4l_rt_write: minor=0
Analogy: a4l_rt_ioctl: minor=0
Analogy: analogy_ni_pcimio: ni_request_ao_mite_channel: failed to
reserve mite dma channel for analog outut.
Analogy: a4l_rt_close: minor=0

Hope this helps
Ettore

