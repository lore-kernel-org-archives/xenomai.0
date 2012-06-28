Message-ID: <4FEC4245.9090804@grandegger.com>
Date: Thu, 28 Jun 2012 13:38:45 +0200
From: Wolfgang Grandegger <wg@grandegger.com>
MIME-Version: 1.0
References: <D1DC5191D5CF3A45A867CD95644B923921629A6D@REXMF.intranet.epfl.ch>,
	<4FE60190.5000108@xenomai.org>
	<D1DC5191D5CF3A45A867CD95644B92392162B98F@REXMF.intranet.epfl.ch>
	<4FEC3FF0.1050307@grandegger.com>
In-Reply-To: <4FEC3FF0.1050307@grandegger.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Peak PCI CAN card RTCAN problem
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Kronander Klas <klas.kronander@epfl.ch>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

On 06/28/2012 01:28 PM, Wolfgang Grandegger wrote:
> On 06/28/2012 01:11 PM, Kronander Klas wrote:
>> Hi,
>>
>> Thanks for the response. I now tried with xenomai version 2.6, I have some progress but it is still not working. 
>>
>> CAN-problem:
>> Looking at the syslog, the can card is detected and the rtcan interfaces are set up properly:
>>
>> Jun 28 11:58:14 wam-desktop kernel: [   11.954476] RT-Socket-CAN 0.90.2 - (C) 2006 RT-Socket-CAN Development Team
>> Jun 28 11:58:14 wam-desktop kernel: [   11.960228] RTCAN SJA1000 driver initialized
>> Jun 28 11:58:14 wam-desktop kernel: [   11.967911] PEAK-PCI-CAN: initializing device 001c:0001
>> Jun 28 11:58:14 wam-desktop kernel: [   11.967920] PEAK-PCI-CAN 0000:05:05.0: PCI INT A -> GSI 17 (level, low) -> IRQ 17
>> Jun 28 11:58:14 wam-desktop kernel: [   11.972902] PEAK-PCI-CAN: base_addr=f8470000 conf_addr=f8466000 irq=17
>> Jun 28 11:58:14 wam-desktop kernel: [   11.972914] rtcan: registered rtcan0
>> Jun 28 11:58:14 wam-desktop kernel: [   11.972920] PEAK-PCI-CAN: base_addr=f849e400 conf_addr=f8466000 irq=17
>> Jun 28 11:58:14 wam-desktop kernel: [   11.972928] rtcan: registered rtcan1
>>
>> I now also see the loaded xeno_can_peak_pci driver with lsmod. The status of the can is STOPPED for both ports:
>> cat /proc/rtcan/devices
>> Name___________ _Baudrate State___ TX_Counter RX_Counter ____Errors
>> rtcan0          undefined stopped           0          0          0
>> rtcan1          undefined stopped           0          0          0
>>
>> When trying to start rtcan0 I get an error:
>> /usr/xenomai/sbin/rtcanconfig rtcan0 -b 1000000 -c none start -v 
>> Cannot open RTDM CAN socket. Maybe driver not loaded?
> 
> Does the following command work?
> 
> /usr/xenomai/sbin/rtcanconfig -b 1000000 -c none start -v rtcan0

Sorry, it should be

Usage: rtcanconfig <can-interface> [Options] [up|down|start|stop|sleep]

Therefore try:

#/usr/xenomai/sbin/rtcanconfig rtcan0 -b 1000000 -v start

Wolfgang

