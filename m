Message-ID: <45D8BB73.1050007@domain.hid>
Date: Sun, 18 Feb 2007 21:47:47 +0100
From: Wolfgang Grandegger <wg@domain.hid>
MIME-Version: 1.0
References: <45D8B15C.5050707@domain.hid> <45D8B818.1090500@domain.hid>
In-Reply-To: <45D8B818.1090500@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-core] Re: More RTCAN patches
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

Jan Kiszka wrote:
> Wolfgang Grandegger wrote:
>> Hi Jan,
>>
>> I have two more patches in my quilt stack:
> 
> Sigh. ;)
> 
>>   2007-02-18  Wolfgang Grandegger  <wg@domain.hid>
>>
>>   * ksrc/drivers/can/rtcan_raw.c, ksrc/drivers/can/rtcan_socket.h:  add
>>     prefix RTCAN_ to TIMESTAMP_SIZE, HAS_TIMESTAMP and HAS_NO_TIMESTAMP
>>     to avoid name clashes, e.g. TIMESTAMP_SIZE is used by the kernel
>>     starting with 2.6.20.
> 
> These are only internal flags, right? Should go into stable as well
> then, I guess.

Two times yes.

> 
>>   * include/rtdm/rtcan.h: add "__attribute__ ((aligned(8)))" to the
>>     data[8] element of the struct can_frame.
> 
> Was already committed.

I realized in the meantime.

>>   2007-02-18  Wolfgang Grandegger  <wg@domain.hid>
>>
>>   * include/rtdm/rtcan.h
>>     ksrc/drivers/can/Config.in,
>>     ksrc/drivers/can/Kconfig,
>>     ksrc/drivers/can/rtcan_dev.h,
>>     ksrc/drivers/can/rtcan_module.c,
>>     ksrc/drivers/can/rtcan_raw.c,
>>     ksrc/drivers/can/rtcan_raw.h,
>>     ksrc/drivers/can/rtcan_socket.c,
>>     ksrc/drivers/can/rtcan_socket.h,
>>     ksrc/drivers/can/rtcan_socket.h,
>>     ksrc/drivers/can/rtcan_virt.c,
>>     ksrc/drivers/can/sja1000/rtcan_sja1000.c,
>>     ksrc/drivers/can/mscan/rtcan_mscan.c,
>>     src/utils/can/rtcansend.c: The socket option CAN_RAW_TX_LOOPBACK
>>     has been renamed to CAN_RAW_LOOPBACK to be compatible with the
>>     Socket-CAN implementation. Furthermore, all lower and upper case
>>     strings "tx_loopback" have been replaced with "loopback" (to
>>     shorten names).
> 
> Will commit to trunk.

Great, thank. Hope you didn't need a lot manual fiddling.

>> The first one also fixes the alignment issue discussed on the Socket-CAN
>>  mailing list.
>>
>> Any comments or objections?

Wolfgang.


