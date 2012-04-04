Message-ID: <4F7C7DEA.5070201@domain.hid>
Date: Wed, 4 Apr 2012 12:59:22 -0400
From: Makarand Pradhan <makarandpradhan@domain.hid>
MIME-Version: 1.0
References: <4F7333E7.7030608@domain.hid> <4F7339A8.6060701@domain.hid>
	<4F735716.4020508@domain.hid>
In-Reply-To: <4F735716.4020508@domain.hid>
Content-Type: multipart/alternative;
	boundary="------------060900020304050207030503"
Subject: Re: [Xenomai-help] Interrupt latency greater than 250ms. Question.
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Philippe Gerum <rpm@xenomai.org>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

--------------060900020304050207030503
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit

Hi Philippe,

We have found that the problem is that the interrupt is unexpectedly 
held masked at the IPIC level for a long time. Please find the trace below:

  2552 :|  + func               -54413    0.590  
qe_ic_cascade_low_ipic+0x8 (__ipipe_ack_irq+0x2c)
  2553 :|  + func               -54412    0.696  qe_ic_get_low_irq+0x8 
(qe_ic_cascade_low_ipic+0x30)
  2554 :|  + func               -54411    0.666  irq_linear_revmap+0x8 
(qe_ic_get_low_irq+0x5c)

*MASK in IPIC (SIMSR_H register bit 1)*
  2555 :|  + func               -54411    0.606  ipic_mask_irq+0x8 
(qe_ic_cascade_low_ipic+0x48)
  2556 :|  + func               -54410    0.590  irqd_to_hwirq+0x8 
(ipic_mask_irq+0x30)
  2557 :|  + func               -54410    0.909  
__ipipe_spin_lock_irqsave+0x8 (ipic_mask_irq+0x40)
  2558 :|  # func               -54409    0.727  
__ipipe_spin_unlock_irqrestore+0x8 (ipic_mask_irq+0xa8      )
  2559 :|  + func               -54408    0.560  
__ipipe_qe_ic_cascade_irq+0x8 (qe_ic_cascade_low_ipic+      0x5c)
  2560 :|  + begin   0x0000002b -54407    0.530  
__ipipe_qe_ic_cascade_irq+0x2c (qe_ic_cascade_low_ipic      +0x5c)
  2561 :|  + func               -54407    0.651  __ipipe_handle_irq+0x8 
(__ipipe_qe_ic_cascade_irq+0x38      )
  2562 :|  + func               -54406    0.939  
__ipipe_ack_level_irq+0x8 (__ipipe_handle_irq+0xbc)

*MASK in QUICC (CIMR register bit 11)*
  2563 :|  + func               -54405    0.787  qe_ic_mask_irq+0x8 
(__ipipe_ack_level_irq+0x40)

*XENOMAI SCHEDULER IS INVOKED*
  2576 :|  # func               -54393    0.590  __xnpod_schedule+0x8 
(xnintr_irq_handler+0x1f8)
*
UNMASK in QUICC (done by our user space handler)*
  2595 :   + func               -54377    0.621  __rt_intr_enable+0x8 
[xeno_native] (hisyscall_event+0x      1e4)

*UNMASK in IPIC (after 50ms, i.e. only after the scheduler returns):*
31637 :|   #end     0x0000002b  -518+   2.272  
__ipipe_qe_ic_cascade_irq+0x40 (qe_ic_cascade_low_ipic+      0x5c)
31638 :|   #func                -516+   1.090  ipic_unmask_irq+0x8 
(qe_ic_cascade_low_ipic+0x70)


**

As you can see from the trace above, the interrupt is held masked at the 
IPIC level all the time until the Xenomai scheduler returns and is only 
unmasked after that.

Is it really the way it should be? Shouldn't the interrupt be unmasked 
at the IPIC level right after masking it at the QUICC engine level?

Rgds,
Mak.



On 28/03/12 02:23 PM, Makarand Pradhan wrote:
> Hi Philippe,
>
> On 28/03/12 12:17 PM, Philippe Gerum wrote:
>> The log says your code wants to control when the IRQ is enabled again,
>> by calling rt_intr_enable() from userland. I guess you are setting
>> I_NOAUTOENA too. Correct?
> That is correct. I_NOAUTOENA is used in rt_intr_create. Otherwise the
> level trigerred interrupt will not allow the userland processing of the
> int. The userland handler is very small and it unconditionally
> rt_intr_enables the intr.
>
> Testing indicates that the interrupt is always enabled from user space
> within 250 usec after kernel gets the interrupt.
>
> I have noted that unless I see "#end 0x0000002b" and a hit to the
> ipic_unmask_irq, the next interrupt is not processed.
>
> And this is getting delayed once in a while which causes a delay in
> processing the next interrupt.
>
> So the sequence of events leading to the problem is:
>
> 1. Get interrupt: #begin   0x0000002b noted in ipipe trace
> 2. Intr enabled from user space. Always happens roughly within 250usec.
> 3. #end 0x0000002b noted in ipipe trace where the int is unmasked by ipipe.
>
> When I see the problem, step 3 is delayed. I am trying to capture a
> trace where the begin, int enable and end are captured.
>
> Your thoughts on what might cause this delay would be appreciated.
>
> Rgds,
> Mak.
>
>
>
>
>


-- 
___________________________________________________________________________
NOTICE OF CONFIDENTIALITY:
This e-mail and any attachments may contain confidential and privileged information.  If you are
not the intended recipient, please notify the sender immediately by return e-mail and delete this
e-mail and any copies.  Any dissemination or use of this information by a person other than the
intended recipient is unauthorized and may be illegal.
_____________________________________________________________________

  


--------------060900020304050207030503
Content-Type: text/html; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <meta content="text/html; charset=ISO-8859-1"
      http-equiv="Content-Type">
  </head>
  <body bgcolor="#ffffff" text="#000000">
    <p class="MsoNormal"><font face="Times New Roman" color="black"
        size="3"><span style="font-size: 12pt;">Hi Philippe,<br>
          <br>
          We have found that the problem is that the interrupt is
          unexpectedly held masked
          at the IPIC level for a long time. Please find the trace
          below:<br>
          <br>
          &nbsp;2552 :|&nbsp; +
          func&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
          -54413&nbsp;&nbsp;&nbsp; 0.590&nbsp; qe_ic_cascade_low_ipic+0x8
          (__ipipe_ack_irq+0x2c)<br>
          &nbsp;2553 :|&nbsp; +
          func&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
          -54412&nbsp;&nbsp;&nbsp; 0.696&nbsp; qe_ic_get_low_irq+0x8
          (qe_ic_cascade_low_ipic+0x30)<br>
          &nbsp;2554 :|&nbsp; +
          func&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
          -54411&nbsp;&nbsp;&nbsp; 0.666&nbsp; irq_linear_revmap+0x8
          (qe_ic_get_low_irq+0x5c)<br>
          <br>
          <b><span style="font-weight: bold;">MASK in IPIC (SIMSR_H
              register bit 1)</span></b><br>
          &nbsp;2555 :|&nbsp; + func&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
          -54411&nbsp;&nbsp;&nbsp; 0.606&nbsp; ipic_mask_irq+0x8
          (qe_ic_cascade_low_ipic+0x48)<br>
          &nbsp;2556 :|&nbsp; +
          func&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
          -54410&nbsp;&nbsp;&nbsp; 0.590&nbsp; irqd_to_hwirq+0x8 (ipic_mask_irq+0x30)<br>
          &nbsp;2557 :|&nbsp; +
          func&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
          -54410&nbsp;&nbsp;&nbsp; 0.909&nbsp; __ipipe_spin_lock_irqsave+0x8
          (ipic_mask_irq+0x40)<br>
          &nbsp;2558 :|&nbsp; #
          func&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
          -54409&nbsp;&nbsp;&nbsp; 0.727&nbsp; __ipipe_spin_unlock_irqrestore+0x8
          (ipic_mask_irq+0xa8&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; )<br>
          &nbsp;2559 :|&nbsp; +
          func&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
          -54408&nbsp;&nbsp;&nbsp; 0.560&nbsp; __ipipe_qe_ic_cascade_irq+0x8
          (qe_ic_cascade_low_ipic+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x5c)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
          <br>
          &nbsp;2560 :|&nbsp; + begin&nbsp;&nbsp; 0x0000002b -54407&nbsp;&nbsp;&nbsp;
          0.530&nbsp; __ipipe_qe_ic_cascade_irq+0x2c
          (qe_ic_cascade_low_ipic&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
          +0x5c)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <br>
          &nbsp;2561 :|&nbsp; +
          func&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
          -54407&nbsp;&nbsp;&nbsp; 0.651&nbsp; __ipipe_handle_irq+0x8
          (__ipipe_qe_ic_cascade_irq+0x38&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; )<br>
          &nbsp;2562 :|&nbsp; +
          func&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
          -54406&nbsp;&nbsp;&nbsp; 0.939&nbsp; __ipipe_ack_level_irq+0x8
          (__ipipe_handle_irq+0xbc)<br>
          <br>
          <b><span style="font-weight: bold;">MASK in QUICC (CIMR
              register bit 11)</span></b><br>
          &nbsp;2563 :|&nbsp; +
          func&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
          -54405&nbsp;&nbsp;&nbsp; 0.787&nbsp; qe_ic_mask_irq+0x8
          (__ipipe_ack_level_irq+0x40)<br>
          <br>
          <b><span style="font-weight: bold;">XENOMAI </span>SCHEDULER
            IS INVOKED</b><br>
          &nbsp;2576 :|&nbsp; #
          func&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
          -54393&nbsp;&nbsp;&nbsp; 0.590&nbsp; __xnpod_schedule+0x8
          (xnintr_irq_handler+0x1f8)<br>
          <b><span style="font-weight: bold;"><br>
              UNMASK in QUICC (done by our user space handler)</span></b><br>
          &nbsp;2595 :&nbsp;&nbsp; +
          func&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
          -54377&nbsp;&nbsp;&nbsp; 0.621&nbsp; __rt_intr_enable+0x8 [xeno_native]
          (hisyscall_event+0x&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1e4)<br>
          <br>
          <b><span style="font-weight: bold;">UNMASK in IPIC (after
              50ms, i.e. only after
              the scheduler returns):</span></b><br>
          31637 :|&nbsp;&nbsp; #end&nbsp;&nbsp;&nbsp;&nbsp; 0x0000002b&nbsp;
          -518+&nbsp;&nbsp; 2.272&nbsp; __ipipe_qe_ic_cascade_irq+0x40
          (qe_ic_cascade_low_ipic+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x5c)<br>
          31638 :|&nbsp;&nbsp;
          #func&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
          -516+&nbsp;&nbsp; 1.090&nbsp; ipic_unmask_irq+0x8
          (qe_ic_cascade_low_ipic+0x70)<br>
          <br>
          <br>
          <b><span style="font-weight: bold;"></span></b></span></font></p>
    <p class="MsoNormal"><font face="Times New Roman" color="black"
        size="3"><span style="font-size: 12pt;">As you can see from the
          trace above, the interrupt is
          held masked at the IPIC level all the time until the Xenomai
          scheduler returns
          and is only unmasked after that.</span></font></p>
    <p class="MsoNormal"><font face="Times New Roman" color="black"
        size="3"><span style="font-size: 12pt;">Is it really the way it
          should be? Shouldn&#8217;t the
          interrupt be unmasked at the IPIC level right after masking it
          at the QUICC
          engine level?<br>
        </span></font></p>
    <p class="MsoNormal"><font face="Times New Roman" color="black"
        size="3"><span style="font-size: 12pt;">Rgds,<br>
          Mak.<br>
        </span></font></p>
    <br>
    <br>
    On 28/03/12 02:23 PM, Makarand Pradhan wrote:
    <blockquote cite="mid:4F735716.4020508@domain.hid" type="cite">
      <pre wrap="">Hi Philippe,

On 28/03/12 12:17 PM, Philippe Gerum wrote:
</pre>
      <blockquote type="cite">
        <pre wrap="">The log says your code wants to control when the IRQ is enabled again,
by calling rt_intr_enable() from userland. I guess you are setting
I_NOAUTOENA too. Correct?
</pre>
      </blockquote>
      <pre wrap="">
That is correct. I_NOAUTOENA is used in rt_intr_create. Otherwise the 
level trigerred interrupt will not allow the userland processing of the 
int. The userland handler is very small and it unconditionally 
rt_intr_enables the intr.

Testing indicates that the interrupt is always enabled from user space 
within 250 usec after kernel gets the interrupt.

I have noted that unless I see "#end 0x0000002b" and a hit to the 
ipic_unmask_irq, the next interrupt is not processed.

And this is getting delayed once in a while which causes a delay in 
processing the next interrupt.

So the sequence of events leading to the problem is:

1. Get interrupt: #begin   0x0000002b noted in ipipe trace
2. Intr enabled from user space. Always happens roughly within 250usec.
3. #end 0x0000002b noted in ipipe trace where the int is unmasked by ipipe.

When I see the problem, step 3 is delayed. I am trying to capture a 
trace where the begin, int enable and end are captured.

Your thoughts on what might cause this delay would be appreciated.

Rgds,
Mak.





</pre>
    </blockquote>
    <br>
    <br>
    <pre class="moz-signature" cols="72">-- 
___________________________________________________________________________
NOTICE OF CONFIDENTIALITY:
This e-mail and any attachments may contain confidential and privileged information.  If you are
not the intended recipient, please notify the sender immediately by return e-mail and delete this
e-mail and any copies.  Any dissemination or use of this information by a person other than the
intended recipient is unauthorized and may be illegal.
_____________________________________________________________________

 </pre>
  </body>
</html>

--------------060900020304050207030503--

