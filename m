Message-ID: <4C60F042.3000405@domain.hid>
Date: Mon, 09 Aug 2010 23:22:58 -0700
From: Bob Feretich <bob.feretich@domain.hid>
MIME-Version: 1.0
References: <307507.12667.qm@domain.hid>	
	<1281350069.1706.139.camel@domain.hid>
	<4C5FEB8C.200@domain.hid>	
	<1281361025.1706.143.camel@domain.hid>	
	<4C603899.5050402@domain.hid>
	<1281418522.2986.21.camel@domain.hid>
In-Reply-To: <1281418522.2986.21.camel@domain.hid>
Content-Type: multipart/alternative;
	boundary="------------070400040509070709090407"
Subject: Re: [Xenomai-help] Having trouble with a BeagleBoard GPIO interrupt
 pin
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai@xenomai.org, xenomai@xenomai.org

This is a multi-part message in MIME format.
--------------070400040509070709090407
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

  The below sequence worked around the problem:
insmod linux_asuspidvr.ko <-- this driver set the xxxDETET registers via 
request_irq()
rmmod linux_asuspidvr.ko <-- the driver exits, but the xxxDETECT 
registers remain set
insmod rt_asuspidvr.ko <-- interrupts now seem to occur properly

So I modified the rt driver probe routine to do the below:
     ret = request_irq(irq, adis_data_rdy_dummy_irq_handler,
             IRQF_TRIGGER_FALLING | IRQF_DISABLED, "asuspidvr",
             adis_data_rdy_dummy_irq_handler);
...
     disable_irq(GPIO133);
...
     ret = rtdm_irq_request(&adis_data_rdy_irq_handle, irq,
                    adis_data_rdy_irq_handler,
                    RTDM_IRQTYPE_EDGE,
                    "asuspidvr", ctx);
     ret = rtdm_irq_enable(&adis_data_rdy_irq_handle);
...
This seems to be working! I can now run the rt driver without first 
running the Linux driver. :-)

Do you see any problem with me continuing with the above temp fix?

Philippe,
I don't understand your response (below). It is too deep in 
Adeos/Xenomai technical details.
After the issues are worked out on -core, please report back to -help to 
let us know what we are to do.

It would also help if you could better describe the meaning of the 
rtdm_irq_request() flags and whether the Linux request_irq() flags have 
any implications to Adeos.

For example, I was quite surprised that both the request_irq() and 
rtdm_irq_request() to the same IRQ succeeded even though neither 
included a SHARE flag. This seems to require a rt driver to call both 
routines to protect its xxxDetect registers.

Regards,
Bob Feretich

On 8/9/2010 10:35 PM, Philippe Gerum wrote:
> On Mon, 2010-08-09 at 19:19 +0200, Gilles Chanteperdrix wrote:
>> Philippe Gerum wrote:
>>> On Mon, 2010-08-09 at 13:50 +0200, Gilles Chanteperdrix wrote:
>>>> Philippe Gerum wrote:
>>>>> On Mon, 2010-08-09 at 02:54 -0700, Bob Feretich wrote:
>>>>>> I am converting my second driver to RTDM. This one receives a
>>>>>> negativing going edge triggered interrupt on GPIO133 of the OMAP3
>>>>>> chip.
>>>>>>
>>>>>> I have...
>>>>>> ret = rtdm_irq_request(&adis_data_rdy_irq_handle, irq,
>>>>>>                     adis_data_rdy_irq_handler,
>>>>>>                     RTDM_IRQTYPE_EDGE,
>>>>>>                     "asuspidvr", ctx);
>>>>>> then...
>>>>>> ret = rtdm_irq_enable(&adis_data_rdy_irq_handle);
>>>>>>
>>>>>> but the interrupt handler is never invoked.
>>>>>>
>>>>>> cat /proc/xenomai/irq shows:
>>>>>> IRQ         CPU0
>>>>>>   37:       15815         [timer]
>>>>>>   39:           0         asuspidvr
>>>>>>   48:           0         asuspidvr
>>>>>>   91:           0         asuspidvr
>>>>>> 293:           0         asuspidvr
>>>>>> 418:           0         [virtual]
>>>>>>
>>>>>> IRQ 293 in the interrupt that should be happening.
>>>>>>
>>>>>> I can see the pulses on the input pin and the non-rt version of the
>>>>>> driver sees the interrupts, so that excludes hardware issues and
>>>>>> u-boot pin configuration issues.
>>>>>>
>>>>>> Any suggestions?
>>>>>> Regards,
>>>>>> Bob Feretich
>>>>>>
>>>>>>
>>>>>> __
>>>>> For some reason, that IRQ line may not be properly enabled by the core
>>>>> code. Could you introduce this patch? If a valid routine is reported in
>>>>> the kernel log message, you could locate it by address, from a kernel
>>>>> image objdump.
>>>> There may also be more to do than enabling the irq line, such as
>>>> programming the hardware to enable irq for this gpio, set the type
>>>> (edge, level) and so on. You can try and call request_irq, then free_irq
>>>> before calling rtdm_request_irq to see if request_irq would trigger some
>>>> actions that rtdm_request_irq does not trigger.
>>>>
>>> If you mean that beagle_twl_gpio_setup() still has to be called at this
>>> point, then we probably have something broken at ipipe level.
>> I was rather thinking about gpio_irq_type, which is normally called
>> through "set_irq_type". I wonder however, if calling this function for
>> an irq registered through rtdm will not screw things up, especially
>> since it changes the flow handler, or do nothing because the irq has not
>> been registered with request_irq.
>>
> chip->set_type() should be called when setting the IRQ trigger; this one
> completely depends on the per-chip routine. In the gpio_irq_type(), that
> should be fine, since we relay the settings through
> __fixup_irq_handler(), which is Adeos-defined.
>
> Xenomai is not currently setting the IRQ trigger when requesting an
> interrupt, which is the problem. However, set_type() handlers are often
> required to run in secondary mode; this means than any call on behalf of
> rtdm_irq_request() would restrict the latter to secondary mode only,
> which is not currently the case.
>
> This means that we should probably force this requirement on
> rthal_irq_request() at some point, because connecting a Xenomai
> interrupt descriptor to the Linux core may impose secondary mode on us.
>
> PS: switching the discussion to -core where it belongs now.
>

--------------070400040509070709090407
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: 8bit

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <meta content="text/html; charset=UTF-8" http-equiv="Content-Type">
    <title></title>
  </head>
  <body bgcolor="#ffffff" text="#000000">
    The below sequence worked around the problem:<br>
    <small><tt><small>insmod linux_asuspidvr.ko   &lt;-- this driver set
          the xxxDETET registers via request_irq()<br>
          rmmod linux_asuspidvr.ko  &lt;-- the driver exits, but the
          xxxDETECT registers remain set<br>
          insmod rt_asuspidvr.ko      &lt;-- interrupts now seem to
          occur properly</small></tt></small><br>
    <br>
    So I modified the rt driver probe routine to do the below:<br>
    <small><tt><small>    ret = request_irq(irq,
          adis_data_rdy_dummy_irq_handler, <br>
                      IRQF_TRIGGER_FALLING | IRQF_DISABLED, "asuspidvr",
          <br>
                      adis_data_rdy_dummy_irq_handler);<br>
          ...<br>
              disable_irq(GPIO133);<br>
          ...<br>
              ret = rtdm_irq_request(&amp;adis_data_rdy_irq_handle, irq,<br>
                             adis_data_rdy_irq_handler,<br>
                             RTDM_IRQTYPE_EDGE,<br>
                             "asuspidvr", ctx);<br>
              ret = rtdm_irq_enable(&amp;adis_data_rdy_irq_handle);<br>
          ...</small></tt></small><br>
    This seems to be working! I can now run the rt driver without first
    running the Linux driver.<span class="moz-smiley-s1"><span> :-) </span></span><br>
    <br>
    Do you see any problem with me continuing with the above temp fix?<br>
    <br>
    Philippe,<br>
    I don't understand your response (below). It is too deep in
    Adeos/Xenomai technical details.<br>
    After the issues are worked out on -core, please report back to
    -help to let us know what we are to do.<br>
    <br>
    It would also help if you could better describe the meaning of the
    rtdm_irq_request() flags and whether the Linux request_irq() flags
    have any implications to Adeos.<br>
    <br>
    For example, I was quite surprised that both the request_irq() and
    rtdm_irq_request() to the same IRQ succeeded even though neither
    included a SHARE flag. This seems to require a rt driver to call
    both routines to protect its xxxDetect registers.<br>
    <br>
    Regards,<br>
    Bob Feretich<br>
    <br>
    On 8/9/2010 10:35 PM, Philippe Gerum wrote:
    <blockquote cite="mid:1281418522.2986.21.camel@domain.hid"
      type="cite">
      <pre wrap="">On Mon, 2010-08-09 at 19:19 +0200, Gilles Chanteperdrix wrote:
</pre>
      <blockquote type="cite">
        <pre wrap="">Philippe Gerum wrote:
</pre>
        <blockquote type="cite">
          <pre wrap="">On Mon, 2010-08-09 at 13:50 +0200, Gilles Chanteperdrix wrote:
</pre>
          <blockquote type="cite">
            <pre wrap="">Philippe Gerum wrote:
</pre>
            <blockquote type="cite">
              <pre wrap="">On Mon, 2010-08-09 at 02:54 -0700, Bob Feretich wrote:
</pre>
              <blockquote type="cite">
                <pre wrap="">I am converting my second driver to RTDM. This one receives a
negativing going edge triggered interrupt on GPIO133 of the OMAP3
chip.

I have...
ret = rtdm_irq_request(&amp;adis_data_rdy_irq_handle, irq, 
                   adis_data_rdy_irq_handler, 
                   RTDM_IRQTYPE_EDGE, 
                   "asuspidvr", ctx);
then...
ret = rtdm_irq_enable(&amp;adis_data_rdy_irq_handle);

but the interrupt handler is never invoked.

cat /proc/xenomai/irq shows:
IRQ         CPU0
 37:       15815         [timer]
 39:           0         asuspidvr
 48:           0         asuspidvr
 91:           0         asuspidvr
293:           0         asuspidvr
418:           0         [virtual]

IRQ 293 in the interrupt that should be happening.

I can see the pulses on the input pin and the non-rt version of the
driver sees the interrupts, so that excludes hardware issues and
u-boot pin configuration issues.

Any suggestions?
Regards,
Bob Feretich


__
</pre>
              </blockquote>
              <pre wrap="">For some reason, that IRQ line may not be properly enabled by the core
code. Could you introduce this patch? If a valid routine is reported in
the kernel log message, you could locate it by address, from a kernel
image objdump.
</pre>
            </blockquote>
            <pre wrap="">There may also be more to do than enabling the irq line, such as
programming the hardware to enable irq for this gpio, set the type
(edge, level) and so on. You can try and call request_irq, then free_irq
before calling rtdm_request_irq to see if request_irq would trigger some
actions that rtdm_request_irq does not trigger.

</pre>
          </blockquote>
          <pre wrap="">
If you mean that beagle_twl_gpio_setup() still has to be called at this
point, then we probably have something broken at ipipe level.
</pre>
        </blockquote>
        <pre wrap="">
I was rather thinking about gpio_irq_type, which is normally called
through "set_irq_type". I wonder however, if calling this function for
an irq registered through rtdm will not screw things up, especially
since it changes the flow handler, or do nothing because the irq has not
been registered with request_irq.

</pre>
      </blockquote>
      <pre wrap="">
chip-&gt;set_type() should be called when setting the IRQ trigger; this one
completely depends on the per-chip routine. In the gpio_irq_type(), that
should be fine, since we relay the settings through
__fixup_irq_handler(), which is Adeos-defined.

Xenomai is not currently setting the IRQ trigger when requesting an
interrupt, which is the problem. However, set_type() handlers are often
required to run in secondary mode; this means than any call on behalf of
rtdm_irq_request() would restrict the latter to secondary mode only,
which is not currently the case.

This means that we should probably force this requirement on
rthal_irq_request() at some point, because connecting a Xenomai
interrupt descriptor to the Linux core may impose secondary mode on us.

PS: switching the discussion to -core where it belongs now.

</pre>
    </blockquote>
  </body>
</html>

--------------070400040509070709090407--

