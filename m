Message-ID: <4F79D5EA.3010501@domain.hid>
Date: Mon, 02 Apr 2012 18:38:02 +0200
From: Wolfgang Grandegger <wg@domain.hid>
MIME-Version: 1.0
References: <CAGq8jPhOy=v8Lccb+hddH9W_u8p-Ayi+XfEcFC+rHVzsSp-ghg@domain.hid>	<4F7555F7.6010102@domain.hid>	<CAGq8jPioLnu+ehj+LA5dL6OWUpxQnUH+Nh01kB088FtsLsSrGA@mail.gmail.com>	<CAGq8jPi4S4TTBy9dLYYnWuWQdX_awhXxu0C93okgFO5vWv_20A@mail.gmail.com>	<4F75B5BF.8030401@domain.hid>	<CAGq8jPgY6fTw0ufdj=pvc+Q1jrrQkYptSHTzFOQK=qSiJJU32Q@mail.gmail.com>	<4F75C7D1.4020808@domain.hid>
	<CAGq8jPhqv16jgPQh631x8S2MmDhm1F4HtnrQA0xsGPe4bTo6eA@mail.gmail.com>
In-Reply-To: <CAGq8jPhqv16jgPQh631x8S2MmDhm1F4HtnrQA0xsGPe4bTo6eA@mail.gmail.com>
Content-Type: multipart/mixed; boundary="------------060208080302000809040805"
Subject: Re: [Xenomai-help] Cross-link.c ---RTSER_RTIOC_WAIT_EVENT
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Minh GIANG <giang.hminh@domain.hid>
Cc: xenomai-help <xenomai@xenomai.org>

This is a multi-part message in MIME format.
--------------060208080302000809040805
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

On 04/02/2012 10:25 AM, Minh GIANG wrote:
> hello,
> 
> i don't know how call the function rt_dev_ioctl() after the timeout
> happened, this function is called in the begining of "while" loop
> (cross-link program).
> I get the value of struct  rtser_status,
> line status = 96
> modem status = 176
> to be honest, i don't know why cross-line program works without the
> function  rt_dev_ioctl() with  RTSER_RTIOC_WAIT_EVENT in  option.
> 
> main : write-file opened
> main : write-config written
> main : read-file opened
> main : read-config written
> main : write-task created
> main : read-task created
> main : starting write-task
> main : starting read-task
>  Nr |   write->irq    |    irq->read    |   write->read   |
> -----------------------------------------------------------
>   0 |17113389816533987823 |1333354257183912191 |         8348398
>   1 |17113389815533997483 |1333354258183885264 |         8331131
>   2 |17113389814533998100 |1333354259183882033 |         8328517
>   3 |17113389813534000420 |1333354260183884535 |         8333339
>   4 |17113389812533998430 |1333354261183888665 |         8335479
> ......
> 
> i tried to send a character table, and it also worked.

Hm, maybe you receive something, but the numbers are bogous. To
understand better what's going on, coud you please apply the attached
patch to your Xenomai tree, rebuild the kernel and send the dmesg output
while running cross-link.

BTW: what Xenomai version are you using?

Wolfgang.

> On Fri, Mar 30, 2012 at 4:48 PM, Wolfgang Grandegger <wg@domain.hid>wrote:
> 
>> On 03/30/2012 04:34 PM, Minh GIANG wrote:
>>> hi,
>>>
>>> with option RTSER_RTIOC_WAIT_EVENT in rt_dev_ioctl(), this function
>> returns
>>> un number -110 (Connection timed out)
>>> with option RTSER_RTIOC_GET_STATUS in rt_dev_ioctl(), this function
>> returns
>>> un number 0 (not message)
>>
>> You should call this function *after* the timeout happened. What does
>> the "struct rtser_status"  contain? Especially the "line_status" is of
>> interest.
>>
>>>
>>> Anyway, currently it works without  rt_dev_ioctl(), i can see
>> rt_dev_read()
>>> wait data event (with debug mode) while giving the period of write
>>> task,  for exemple  = two seconds.
>>>
>>> so can i remove the funtion rt_dev_ioctl?
>>
>> The rt_dev_ioctl should work. You can remove it, but the problem will
>> remain. To debug the problem you could also add some printk's here:
>>
>>
>> http://www.rts.uni-hannover.de/xenomai/lxr/source/ksrc/drivers/serial/16550A.c#223
>>
>> Especially the value of "iir" might be interesting.
>>
>> Wolfgang.
>>
> 


--------------060208080302000809040805
Content-Type: text/x-diff;
 name="16550A-irq-debug.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="16550A-irq-debug.patch"

diff --git a/ksrc/drivers/serial/16550A.c b/ksrc/drivers/serial/16550A.c
index 3672539..392c4f7 100644
--- a/ksrc/drivers/serial/16550A.c
+++ b/ksrc/drivers/serial/16550A.c
@@ -240,6 +240,7 @@ static int rt_16550_interrupt(rtdm_irq_t * irq_context)
 
 	while (1) {
 		iir = rt_16550_reg_in(mode, base, IIR) & IIR_MASK;
+		printk("base=%#lx iir=%#x\n", base, iir);
 		if (testbits(iir, IIR_PIRQ))
 			break;
 
@@ -258,6 +259,7 @@ static int rt_16550_interrupt(rtdm_irq_t * irq_context)
 				events |= RTSER_EVENT_MODEMLO;
 		}
 
+		printk("base=%#lx status=%#x\n", base, ctx->status);
 		ret = RTDM_IRQ_HANDLED;
 	}
 

--------------060208080302000809040805--

