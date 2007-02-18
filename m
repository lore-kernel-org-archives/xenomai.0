Message-ID: <45D8B9FE.6050500@domain.hid>
Date: Sun, 18 Feb 2007 21:41:34 +0100
From: Wolfgang Grandegger <wg@domain.hid>
MIME-Version: 1.0
References: <45D425B8.7070401@domain.hid>	<45D60C78.5090106@domain.hid>	<45D61C5C.8090201@domain.hid>	<45D709E4.80409@domain.hid>	<45D73F0B.8090703@domain.hid>	<45D74592.1020804@domain.hid>
	<45D74FE2.7030001@domain.hid> <45D899C2.8080000@domain.hid>
In-Reply-To: <45D899C2.8080000@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-core] Re: Magics of [CAN] message filtering
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
Cc: socketcan-core@domain.hid, Oliver Hartkopp <socketcan@domain.hid>, xenomai-core <xenomai@xenomai.org>

Jan Kiszka wrote:
> Jan Kiszka wrote:
>> Wolfgang Grandegger wrote:
>>> Jan Kiszka wrote:
>>>> Oliver Hartkopp wrote:
>>>>> When you're touching anything inside your API, have you ever thought to add
>>>>>
>>>>> __attribute__ ((aligned(8)))
>>>>>
>>>>> to the data[8] element of the struct can_frame?
>>>>>
>>>>> This would enable you to make 64 bit compares directly in the data
>>>>> section of the can_frame ...
>>>>>
>>>>> typedef __u32 canid_t;
>>>>>
>>>>> struct can_frame {
>>>>>     canid_t can_id;  /* 32 bit CAN_ID + EFF/RTR/ERR flags */
>>>>>     __u8    can_dlc; /* data length code: 0 .. 8 */
>>>>>     __u8    data[8] __attribute__ ((aligned(8)));
>>>>> };
>>>> [Swallowing down my well-known opinion on typeof(can_dlc) :)]
>>>>
>>>> Yes, this should be done, already for the more urging sake of
>>>> unambiguous layout of the structure across the kernel/user space border.
>>> Is this not already the case? At least the size of struct can_frame is 
>>> 16 bytes.
>> On all target archs? With all supported compilers? Better make it explicit.
> 
> gcc -Os is such an example, toasting the assumed can_frame layout by
> moving that 3-byte hole *after* data.

Ah, oh, this is always the case, not only with "-0s", as my tests show. 
But the size of the structure is always 16.

> 
> So this was an urging ABI bug, and I applied the alignment to both
> stable and trunk Xenomai SVNs. Thanks to Oliver for insisting on this!

Thanks.

Wolfgang.
x

