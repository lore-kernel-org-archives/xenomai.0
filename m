Message-ID: <45D74592.1020804@domain.hid>
Date: Sat, 17 Feb 2007 19:12:34 +0100
From: Wolfgang Grandegger <wg@domain.hid>
MIME-Version: 1.0
References: <45D425B8.7070401@domain.hid> <45D60C78.5090106@domain.hid>
	<45D61C5C.8090201@domain.hid> <45D709E4.80409@domain.hid>
	<45D73F0B.8090703@domain.hid>
In-Reply-To: <45D73F0B.8090703@domain.hid>
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
> Oliver Hartkopp wrote:
>> When you're touching anything inside your API, have you ever thought to add
>>
>> __attribute__ ((aligned(8)))
>>
>> to the data[8] element of the struct can_frame?
>>
>> This would enable you to make 64 bit compares directly in the data
>> section of the can_frame ...
>>
>> typedef __u32 canid_t;
>>
>> struct can_frame {
>>     canid_t can_id;  /* 32 bit CAN_ID + EFF/RTR/ERR flags */
>>     __u8    can_dlc; /* data length code: 0 .. 8 */
>>     __u8    data[8] __attribute__ ((aligned(8)));
>> };
> 
> [Swallowing down my well-known opinion on typeof(can_dlc) :)]
> 
> Yes, this should be done, already for the more urging sake of
> unambiguous layout of the structure across the kernel/user space border.

Is this not already the case? At least the size of struct can_frame is 
16 bytes.

Wolfgang.


