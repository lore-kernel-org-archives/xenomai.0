Message-ID: <4559D38C.2080001@domain.hid>
Date: Tue, 14 Nov 2006 15:32:44 +0100
From: Wolfgang Grandegger <wg@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-core] [PATCH] RT-Socket-CAN,
	TX loopback and further  improvements
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: xenomai-core <xenomai@xenomai.org>

Hi Jan,

attached is a patch implementing the TX loopback, apart from some other 
fixes and improvements. The TX loopback to foreign local sockets allows 
to have a net-alike behavior of the CAN bus. Local sockets listening to 
a device can receive TX messages as well. As discussed, the TX lookback 
is performed when TX is done (TX done interrupt). As I still think that 
it will not be used very often, I made it a configurable kernel option. 
When it's selected, it's _on_ by default and it can be switched off or 
on again with setsockopt() (to make the Linux Socket-CAN people happy). 
As long as it's not enabled, it adds little overhead to the driver. If 
you have no objections I will check it in.

Here is the ChangeLog entry:

2006-11-14  Wolfgang Grandegger  <wg@domain.hid>

         * ksrc/drivers/can/rtcan_dev.h,
         ksrc/drivers/can/rtcan_socket.h,
         ksrc/drivers/can/rtcan_socket.c,
         ksrc/drivers/can/rtcan_raw.c,
         ksrc/drivers/can/rtcan_modules.c,
         ksrc/drivers/can/sja1000/rtcan_sja1000.c,
         ksrc/drivers/can/mscan/rtcan_mscan.c,
         ksrc/drivers/can/Kconfig,
         ksrc/drivers/can/Config.in,
         src/utils/can/rtcansend.c,
         include/rtdm/rtcan.h,: Add feature TX loopback to local sockets.

         * ksrc/drivers/can/rtcan_raw.c, include/rtdm/rtcan.h:
         Remove locks for the setting and reading of the RX and TX
         timeout values and add a warning to the documentation.

         * src/utils/rtcansend.c: use sendto() by default to avoid
         binding a default filter and add option "-s" for using bind()
         and send().

         * src/utils/rtcanrecv.c: add option "-R" for relative
         timestamps.

         * ksrc/drivers/can/rtcan_internal.h: use now RTCAN_ASSERT macros
         when CONFIG_XENO_DRIVERS_RTCAN_DEBUG is set.

         * ksrc/drivers/can/mscan/Kconfig,
         ksrc/drivers/can/sja1000/Kconfig,
         ksrc/drivers/can/Kconfig: add more help for kernel parameters.

Thanks.

Wolfgang.







