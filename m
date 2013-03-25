Message-ID: <51504AAB.5000600@grandegger.com>
Date: Mon, 25 Mar 2013 14:01:31 +0100
From: Wolfgang Grandegger <wg@grandegger.com>
MIME-Version: 1.0
References: <CAPRNvtSqfrtXW1L=W6_OTtenk+YyR_RWbPjrwRXYqEwN00P1rQ@mail.gmail.com>
In-Reply-To: <CAPRNvtSqfrtXW1L=W6_OTtenk+YyR_RWbPjrwRXYqEwN00P1rQ@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] CAN bus on beaglebone
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Davide Faconti <faconti@icarustechnology.com>
Cc: xenomai@xenomai.org

On 03/24/2013 11:01 PM, Davide Faconti wrote:
> Dear Xenomai users and developers,
> 
> finally I managet to have a working xenomai (Kernel 3.2.21, xenomai
> 2.6.2.1) on my beloved Beaglebone.
> 
> Everything works fine BUT I can't get my CAN bus working.
> Partly this is not a surprise, since I don't think that RTCAN
> currently support the D_CAN on Beaglebone (am I right?)

You are right? There is no C_CAN/D_CAN driver in RTcan. It needs to be
ported from the Linux driver similar to what I have done recently for
the Flexcan driver.

>> rtcanconfig rtcan0 --verbose --baudrate=125000 start
>> mode: start (0x1)
>> Can't get interface index for rtcan0, code = -19

#define	ENODEV		19	/* No such device */

That is no suprise. It's useless to use rtcanconfig without supported
device.

> What is disappointing is that the other Socketcan, that in theory it
> is also installed, isn't working anymore.
> 
> I can get the device can0 "up" writing the command
> 
>> ip link set can0 up type can bitrate 125000
> 
> But when I try to actually open de device I get the error
> 
>> Socket: Protocol not supported

Does it definitely work with a vanilla kernel (without iPipe and Xenomai)?

Did you link your program against the Xenomai POSIX libraries?

> Is there anyone that as any idea of what is going on and how I could fix it?
> According to Google no one has tried already to use Xenomai +
> Beaglebone + CAN  ;)

As long as you do not have a RTcan driver for your hardware you could
play with the "Virtual CAN bus driver" (CONFIG_XENO_DRIVERS_CAN_VIRT).

Wolfgang.


