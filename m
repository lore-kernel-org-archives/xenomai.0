Message-ID: <4F97A862.9050902@domain.hid>
Date: Wed, 25 Apr 2012 09:31:46 +0200
From: Wolfgang Grandegger <wg@domain.hid>
MIME-Version: 1.0
References: <4F96F53C.2070204@domain.hid>
	<4F96F786.8050700@domain.hid>
In-Reply-To: <4F96F786.8050700@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] rtcan I/O hang bug
	with	/proc/rtcan/rtcan0/registers
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: Andrew Tannenbaum <trb@domain.hid>, xenomai@xenomai.org

On 04/24/2012 08:57 PM, Gilles Chanteperdrix wrote:
> On 04/24/2012 08:47 PM, Andrew Tannenbaum wrote:
>> I'm running
>>
>> 	Linux 2.6.38.8
>> 	Xenomai 2.6.0
>> 	Atom N270 CPU
>>
>> I'm talking to CAN with a PEAK PCI SJA1000 CAN adapter.
>>
>> I have a control loop running at 200 Hz, and I use it to drive a motor
>> and read an encoder using rtcan.  My code is based on the
>> rtcansend/rtcanrecv examples.
>>
>> I found a bug where my control loop was hanging, and I've isolated the
>> problem so that it may be reproduced with Xenomai supplied tools,
>> without using my own code.
>>
>> The problem is:
>>
>> When I have a loop that is sending CAN packets, if I read
>> /proc/rtcan/rtcan0/registers at the same time, it causes the loop to
>> hang.  The hang is in rt_dev_sendto.
>>
>> To reproduce:
>>
>> Configure the CAN controller
>>
>> 	$ rtcanconfig rtcan0 --baudrate=1000000 start
>>
>> Send packets, in this case, SYNC messages at 1000 Hz
>> with tty output 1 Hz.
>>
>> 	$ rtcansend rtcan0 -i 0x80 -p 1000 -l 1000000
>>
>> It will print CAN SYNC (0x80) messages:
>>
>> 	<0x080> [0]
>> 	<0x080> [0]
>> 	...
>>
>> In another window, read rtcan0/registers in a loop (10 Hz):
>>
>> 	$ while :; do cat /proc/rtcan/rtcan0/registers; sleep .1; done
> 
> Hi Andrew,
> 
> I am probably not the one which will answer your question, because I
> know nothing about CAN hardware. What I know however is that some
> hardware registers, when read, have side effects. For instance reading
> an interrupt status may deassert the hardware interrupt.

Yes, reading the registers while running is not a good idea. The
"register" proc file is for debugging and should not be use under normal
operation.

Wolfgang.


