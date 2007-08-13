Message-ID: <46C063E0.1010809@domain.hid>
Date: Mon, 13 Aug 2007 16:00:00 +0200
MIME-Version: 1.0
References: <46C02829.9020009@domain.hid> <46C04384.4030805@domain.hid>
	<46C05180.5090302@domain.hid> <46C05690.2010108@domain.hid>
In-Reply-To: <46C05690.2010108@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
From: Roland Tollenaar <rwatollenaar@domain.hid>
Subject: Re: [Xenomai-help] EML conflict with RTCAN?
 low_level_input	framebuilding failed.
Reply-To: rolandtollenaar@domain.hid
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Wolfgang Grandegger <wg@domain.hid>
Cc: Xenomai-help@domain.hid, EML users <ethercatmaster-users@domain.hid>

Hi,

All closing & shutting down has been perfected. There are no more errors 
on closing my application.

Yet the problem persists very explicitly. Rtcan and EML can run 
separately and never throw up any errors. As soon as they are used in 
combination then in 50% of the cases the framebuilding in EML gets 
messed up (as per the error message)

There is definitely something between the two that is not right.


>>>> RTnet:rtskb allocation from real-time cache failed.

Could I get some tips as to what I can do about this? I seem to get it 
even when I do not have rtcan activity running in my application and 
(because I am clueless) I would like to prevent this message which may 
signify the root of the problem.



Regards,

Roland.






>>> Hm, this is not supposed to happen.
>> Which of the two?
> 
> The RTCAN assertion. Well, in fact, it can happen when the device goes 
> bus-off or is stopped while a TX message is pending. The next message 
> after (re-)start will the trigger this message. This is a bug but it 
> should _not_ harm (either I remove the assertion or I reset properly the 
> value of dev->tx_socket).
> 
> The first one should be pretty clear. The rtskb pool seems to be exhausted.
> 
>>
>>> Can you show the output of /proc/rtcan/devices and 
>>> /proc/rtcan/sockets before and after the problem showed up.
>>
>> Below is an accumulation of what I think you are asking for. I am not 
>> convinced that the rtskb allocation failed message is serious, as you 
>> will see from the syslog and my comment above it only takes place when 
>> i close my application. Although I try to close all connections neatly 
>> certain threads still seem to be busy. See the errors I get on closing 
>> the application.
>>
>> App running with no problem:
>>
>> root@domain.hid:~# cat /proc/rtcan/sockets
>> fd Name___________ Filter ErrMask RX_Timeout_ns TX_Timeout_ns 
>> RX_BufFull TX_Lo
>>  2 rtcan2               1 0x00000      infinite      infinite 0     1
>>  0 rtcan2              -1 0x00000      infinite      infinite 0     1
>>
>> root@domain.hid:~# cat /proc/rtcan/devices
>> Name___________ _Baudrate State___ TX_Counter RX_Counter ____Errors
>> rtcan0          undefined stopped           0          0          0
>> rtcan1          undefined stopped           0          0          0
>> rtcan2            1000000 active     16321347   27633347    2367116
>>
>>
>> App running with messages failing
>>
>> root@domain.hid# cat /proc/rtcan/sockets
>> fd Name___________ Filter ErrMask RX_Timeout_ns TX_Timeout_ns 
>> RX_BufFull TX_Lo
>>  2 rtcan2               1 0x00000      infinite      infinite 0     1
>>  0 rtcan2              -1 0x00000      infinite      infinite 0     1
>>
>>
>> root@domain.hid# cat /proc/rtcan/devices
>> Name___________ _Baudrate State___ TX_Counter RX_Counter ____Errors
>> rtcan0          undefined stopped           0          0          0
>> rtcan1          undefined stopped           0          0          0
>> rtcan2            1000000 active     16850473   28691571    2367116
> 
> Oops, that much errors?
> 
>> cat /var/syslog shows that the error only seems to come up when the 
>> application closes.
>>
>> Only occurs on closing the application
>> Aug 13 13:01:28 (none) kernel: RTnet: rtskb allocation from real-time 
>> cache failed
>> Aug 13 13:02:14 (none) kernel: RTnet: rtskb allocation from real-time 
>> cache failed
>> Aug 13 14:02:34 (none) kernel: RTnet: rtskb allocation from real-time 
>> cache failed
>> Aug 13 14:03:36 (none) kernel: RTnet: rtskb allocation from real-time 
>> cache failed
>> Aug 13 14:18:39 (none) kernel: RTnet: rtskb allocation from real-time 
>> cache failed
>> Aug 13 14:19:33 (none) kernel: RTnet: rtskb allocation from real-time 
>> cache failed
>> Aug 13 14:19:58 (none) kernel: RTnet: rtskb allocation from real-time 
>> cache failed
>> Aug 13 14:21:27 (none) kernel: RTnet: rtskb allocation from real-time 
>> cache failed
>> Aug 13 14:22:10 (none) kernel: RTnet: rtskb allocation from real-time 
>> cache failed
>>
>>
>> When I close the application I get these errors
>>
>> rt_dev_recv: aborted because socket was closed
>> rt_dev_recv: aborted because socket was closed
>> rt_dev_recv: aborted because socket was closed
>> rt_dev_recv: aborted because socket was closed
>> rt_dev_recv: aborted because socket was closed
>> rt_dev_recv: aborted because socket was closed
>> rt_dev_recv: aborted because socket was closed
>> rt_dev_recv: aborted because socket was closed
>> rt_dev_recv: aborted because socket was closed
>> rt_dev_recv: aborted because socket was closed
>> rt_dev_recv: aborted because socket was closed
>> rt_dev_recv: aborted because socket was closed
>> rt_dev_recv: aborted because socket was closed
>> rt_dev_recv: aborted because socket was closed
>> rt_dev_recv: aborted because socket was closed
>> rt_dev_recv: aborted because socket was closed
> 
> You should handle this error properly.
> 
>> rt_dev_ioctl: Bad file descriptor
>> Waiting for tasks to stop....low_level_output(): Cannot Send
>> low_level_output(): Cannot Send
>> low_level_output(): Cannot Send
>> low_level_output(): Cannot Send
>> low_level_output(): Cannot Send
>> low_level_output(): Cannot Send
>> low_level_output(): Cannot Send
>> low_level_output(): Cannot Send
>> low_level_output(): Cannot Send
>> low_level_output(): Cannot Send
>> low_level_txandrx: failed: MAX_TRIES_TX: Giving up
>> DLL::txandrx() Error
>> PD_Buffer: Error sending PD
>> txandrx failed:
>>
>>
>> Does this shed any light on the matter?
> 
> Hm, seems that your shutdown is not implemented properly.
> 
> Wolfgang.
> 

