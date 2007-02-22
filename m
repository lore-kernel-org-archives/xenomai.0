Message-ID: <45DDB542.2050601@domain.hid>
Date: Thu, 22 Feb 2007 16:22:42 +0100
From: Wolfgang Grandegger <wg@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] CAN driver
References: <45DC1D05.1000206@domain.hid> <45DD8B42.1020709@domain.hid>	
	<bc4264770702220434v13302afcg3f790e823f08169c@domain.hid>	
	<45DD9294.1060109@domain.hid>	
	<bc4264770702220502p13556486l3d59ad7b4b3ff737@domain.hid>	
	<45DD9814.4060809@domain.hid>	
	<bc4264770702220536veb7de41saf40e41fccbbf377@domain.hid>	
	<45DD9DB0.1010103@domain.hid>	
	<bc4264770702220557x7d43d767m5383e8d8ce60204a@domain.hid>	
	<45DDA504.4070408@domain.hid>
	<bc4264770702220652m138956ceh32713b862ee1080a@domain.hid>
In-Reply-To: <bc4264770702220652m138956ceh32713b862ee1080a@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: roland Tollenaar <rolandtollenaar@domain.hid>
Cc: Xenomai-help@domain.hid, Jan Kiszka <jan.kiszka@domain.hid>

roland Tollenaar wrote:
> Hi Wolfgang,
> 
>> And /proc/rtcan/devices is also useful.
> 
> Device rtcan0 Baudrate undefined State active TXCounter 7 RXCounter 5 
> Errors 0
> Device rtcan1 Baudrate undefined State stopped TXCounter 0 RXCounter 0 
> Errors 0
> 
>> > virtual can with? I presume i can send it messages with rtcansend and
>> > read the messages with rtcanrecieve?
>> src/utils/can/README?
> Works. Can send and recieve messages on it. Interesting may be this:
> If i send with rtcansend then in another console recieve the messages
> will not display. I would have expected the messages to be in the
> stack and display (depending how many messages the stack can hold).
> Why is that expectation incorrect?

There is no per device stack. The messages will be delivered directly to 
  the sockets receive buffer if it is listening and the filter does match.

> 
>> > I still have the outstanding question of what the module will be
>> > called for the PEAK CAN dongle. I have to find it after make modules
>> > to squirrle it away so i can load it after booting due to the
>> > complications with my live distribution.  You said that I cannot build
>> > that into the kernel statically correct? Can it be loaded without the
>> > actual device being connected?
>>
>> I said, it can be statically linked into the kernel but it will not work
>> (without modification, we can discuss this issue when you have a PCAN
>> dongle). What should a driver without hardware be good for?
> Good question. On the other hand it would be useful to know which
> module I have to
> pick out and load. Then I can compile the kernel for that so long and
> make a structure that loads it after booting. But that can be done
> later too.

You can do it now, just try and then ask questions.

> 
>> > Maybe a small suggestion. Would it not be better to have the virtual
>> > can driver built into the kernel by default. As a new user I did not
>> > select it, saw no reason to.
>>
>> Might be useful, indeed. BTW: there is a help available for each
>> configuration option?
> There should be. I think I used the help. Will check again for you
> when I change the configuration to load the PEAK driver as a module.
> 
> Roland.

