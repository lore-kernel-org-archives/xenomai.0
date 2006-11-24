Message-ID: <4566F619.9060403@domain.hid>
Date: Fri, 24 Nov 2006 14:39:37 +0100
From: Wolfgang Grandegger <wg@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------090502080903080108080503"
Subject: [Xenomai-help] RT-Socket-CAN update, please read
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai-help <xenomai@xenomai.org>

This is a multi-part message in MIME format.
--------------090502080903080108080503
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hello,

I have just commited various modifications and improvements for 
RT-Socket-CAN to the SVN trunk (v2.3-devel). The modification you might 
realize sooner than later is the renaming of the RT-Socket-CAN kernel 
modules from "xeno_rtcan_*" to "xeno_can_*" to comply with the usual 
RTDM driver naming scheme. I have attached the full ChangeLog entry.

Any feedback is welcome, also on the new TX-Loopback feature.

Wolfgang.

--------------090502080903080108080503
Content-Type: text/plain;
 name="ChangeLog"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ChangeLog"

2006-11-24  Wolfgang Grandegger  <wg@domain.hid>

	* ksrc/drivers/can/README: Update list of supported CAN controllers
	and boards.

	* ksrc/drivers/can/rtcan_dev.h,
	ksrc/drivers/can/rtcan_socket.h,
	ksrc/drivers/can/rtcan_socket.c,
	ksrc/drivers/can/rtcan_raw.c,
	ksrc/drivers/can/rtcan_modules.c,
	ksrc/drivers/can/rtcan_virt.c,
	ksrc/drivers/can/sja1000/rtcan_sja1000.c,
	ksrc/drivers/can/mscan/rtcan_mscan.c,
	ksrc/drivers/can/Kconfig,
	ksrc/drivers/can/Config.in,
	src/utils/can/rtcansend.c,
	include/rtdm/rtcan.h,: Add feature TX loopback to local sockets.

	* ksrc/drivers/can/rtcan_raw.c,
	ksrc/drivers/can/sja1000/rtcan_sja1000.c,
	ksrc/drivers/can/mscan/rtcan_mscan.c: timestamps are now read and
	copied in rtcan_recv() and rtcan_tx_loopbcak().

	* ksrc/drivers/can/rtcan_raw.c, include/rtdm/rtcan.h:
	Remove locks for the setting and reading of the RX and TX timeout
	values and add a warning to the documentation.

	* src/utils/rtcansend.c: use sendto() by default to avoid binding
	a default filter and add option "-s" for using bind() and send().

	* src/utils/rtcanrecv.c: add option "-R" for relative timestamps.

	* ksrc/drivers/can/rtcan_internal.h: use now RTCAN_ASSERT macros
	when CONFIG_XENO_DRIVERS_CAN_DEBUG is set.

	* ksrc/drivers/can/mscan/Kconfig, ksrc/drivers/can/sja1000/Kconfig,
	ksrc/drivers/can/Kconfig: add more help for kernel parameters.

	* ksrc/drivers/can/rtcan_virt.c (rtcan_virt_init): fix bug in
	cleanup code.

	* ksrc/drivers/can/sja1000/rtcan_sja1000.c,
	ksrc/drivers/can/sja1000/rtcan_isa.c,
	ksrc/drivers/can/sja1000/rtcan_mem.c,
	ksrc/drivers/can/sja1000/rtcan_peak_pci.c,
	ksrc/drivers/can/sja1000/rtcan_peak_dng.c: Remove rtcan_dev_free()
	from rtcan_sja1000_unregister() to allow proper cleanup after the
	device has been unregistered.

	* ksrc/drivers/can/sja1000/rtcan_ixxat_pci.c,
	ksrc/drivers/can/sja1000/Kconfig,
	ksrc/drivers/can/sja1000/Config.in,
	ksrc/drivers/can/sja1000/Makefile: SJA1000 driver for IXXAT PCI
	cards added.

	* src/drivers/Makefile, ksrc/drivers/can/*, scripts/Modules.frag,
	src/utils/can/README: Replace "rtcan" with "can" in macro definitions
	CONFIG_XENO_DRIVERS_RTCAN_* and module names xeno_rtcan_* to comply to
	the common naming scheme.


--------------090502080903080108080503--

