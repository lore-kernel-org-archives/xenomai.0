Message-ID: <46C05180.5090302@domain.hid>
Date: Mon, 13 Aug 2007 14:41:36 +0200
MIME-Version: 1.0
References: <46C02829.9020009@domain.hid> <46C04384.4030805@domain.hid>
In-Reply-To: <46C04384.4030805@domain.hid>
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
To: Wolfgang Grandegger <wg@domain.hid>, Xenomai-help@domain.hid, EML users <ethercatmaster-users@domain.hid>

Hi

>> RTnet:rtskb allocation from real-time cache failed.
>> Assertion failed! drivers/xenomai/can/rtcan_raw.c: rtcan_tx_push:168 
>> dev->tx_socket=0 (3) TX skb still in use.
> 
> Hm, this is not supposed to happen.
Which of the two?


> Can you show the output of /proc/rtcan/devices and /proc/rtcan/sockets 
> before and after the problem showed up.

Below is an accumulation of what I think you are asking for. I am not 
convinced that the rtskb allocation failed message is serious, as you 
will see from the syslog and my comment above it only takes place when i 
close my application. Although I try to close all connections neatly 
certain threads still seem to be busy. See the errors I get on closing 
the application.

App running with no problem:

root@domain.hid:~# cat /proc/rtcan/sockets
fd Name___________ Filter ErrMask RX_Timeout_ns TX_Timeout_ns RX_BufFull 
TX_Lo
  2 rtcan2               1 0x00000      infinite      infinite 
0     1
  0 rtcan2              -1 0x00000      infinite      infinite 
0     1

root@domain.hid:~# cat /proc/rtcan/devices
Name___________ _Baudrate State___ TX_Counter RX_Counter ____Errors
rtcan0          undefined stopped           0          0          0
rtcan1          undefined stopped           0          0          0
rtcan2            1000000 active     16321347   27633347    2367116


App running with messages failing

root@domain.hid# cat /proc/rtcan/sockets
fd Name___________ Filter ErrMask RX_Timeout_ns TX_Timeout_ns RX_BufFull 
TX_Lo
  2 rtcan2               1 0x00000      infinite      infinite 
0     1
  0 rtcan2              -1 0x00000      infinite      infinite 
0     1


root@domain.hid# cat /proc/rtcan/devices
Name___________ _Baudrate State___ TX_Counter RX_Counter ____Errors
rtcan0          undefined stopped           0          0          0
rtcan1          undefined stopped           0          0          0
rtcan2            1000000 active     16850473   28691571    2367116



cat /var/syslog shows that the error only seems to come up when the 
application closes.

Only occurs on closing the application
Aug 13 13:01:28 (none) kernel: RTnet: rtskb allocation from real-time 
cache failed
Aug 13 13:02:14 (none) kernel: RTnet: rtskb allocation from real-time 
cache failed
Aug 13 14:02:34 (none) kernel: RTnet: rtskb allocation from real-time 
cache failed
Aug 13 14:03:36 (none) kernel: RTnet: rtskb allocation from real-time 
cache failed
Aug 13 14:18:39 (none) kernel: RTnet: rtskb allocation from real-time 
cache failed
Aug 13 14:19:33 (none) kernel: RTnet: rtskb allocation from real-time 
cache failed
Aug 13 14:19:58 (none) kernel: RTnet: rtskb allocation from real-time 
cache failed
Aug 13 14:21:27 (none) kernel: RTnet: rtskb allocation from real-time 
cache failed
Aug 13 14:22:10 (none) kernel: RTnet: rtskb allocation from real-time 
cache failed


When I close the application I get these errors

rt_dev_recv: aborted because socket was closed
rt_dev_recv: aborted because socket was closed
rt_dev_recv: aborted because socket was closed
rt_dev_recv: aborted because socket was closed
rt_dev_recv: aborted because socket was closed
rt_dev_recv: aborted because socket was closed
rt_dev_recv: aborted because socket was closed
rt_dev_recv: aborted because socket was closed
rt_dev_recv: aborted because socket was closed
rt_dev_recv: aborted because socket was closed
rt_dev_recv: aborted because socket was closed
rt_dev_recv: aborted because socket was closed
rt_dev_recv: aborted because socket was closed
rt_dev_recv: aborted because socket was closed
rt_dev_recv: aborted because socket was closed
rt_dev_recv: aborted because socket was closed
rt_dev_ioctl: Bad file descriptor
Waiting for tasks to stop....low_level_output(): Cannot Send
low_level_output(): Cannot Send
low_level_output(): Cannot Send
low_level_output(): Cannot Send
low_level_output(): Cannot Send
low_level_output(): Cannot Send
low_level_output(): Cannot Send
low_level_output(): Cannot Send
low_level_output(): Cannot Send
low_level_output(): Cannot Send
low_level_txandrx: failed: MAX_TRIES_TX: Giving up
DLL::txandrx() Error
PD_Buffer: Error sending PD
txandrx failed:


Does this shed any light on the matter?


Roland


> 
> Wolfgang.
> 
> 

