Message-ID: <46C0587D.20206@domain.hid>
Date: Mon, 13 Aug 2007 15:11:25 +0200
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

Hi Wolfgang,

> The RTCAN assertion. Well, in fact, it can happen when the device goes 
> bus-off or is stopped while a TX message is pending. The next message 
> after (re-)start will the trigger this message. This is a bug but it 
> should _not_ harm (either I remove the assertion or I reset properly the 
> value of dev->tx_socket).
Clear. Thanks.


> The first one should be pretty clear. The rtskb pool seems to be exhausted.
Sorry if this is not clear to me. What is the rtskb pool and what are 
the implications of it being full?

>>
>> root@domain.hid# cat /proc/rtcan/devices
>> Name___________ _Baudrate State___ TX_Counter RX_Counter ____Errors
>> rtcan0          undefined stopped           0          0          0
>> rtcan1          undefined stopped           0          0          0
>> rtcan2            1000000 active     16850473   28691571    2367116
> 
> Oops, that much errors?
eeuuh yes, I started up can after having had it disabled for a very long 
time while I was working on the ethercat. I seem to have forgotten that 
CAN is not wireless, forgot to plug in the bus. So I think that those 
errors were picked up then, they did not seem to increase later on.


>> rt_dev_recv: aborted because socket was closed
>> rt_dev_recv: aborted because socket was closed
>> rt_dev_recv: aborted because socket was closed
>> rt_dev_recv: aborted because socket was closed
> 
> You should handle this error properly.
You are right. I think I am not closing the threads in the correct 
sequence, not sure I know how to yet. But can this be the cause of my 
problem? Where is the conflict/ complication arising between rtcan and 
eml. I do understand that this is an almost impossible question to find 
an answer to over two separate lists. :(


> 
> Hm, seems that your shutdown is not implemented properly.
I'd say this assessment is rather accurate. Will look into it:)

Roland

> 
> Wolfgang.
> 

