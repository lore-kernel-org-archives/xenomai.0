Message-ID: <1743f3b40809190806x241788e2s90fdd271d5f723e7@domain.hid>
Date: Fri, 19 Sep 2008 17:06:39 +0200
From: "Antonio Del Cinque" <adelcinque@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_33935_28874366.1221836799232"
Subject: [Xenomai-help] Interrupt latency questions
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org

------=_Part_33935_28874366.1221836799232
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi all,
I need confirmations on the ipipe model, to interpret test results. Excuse
me, I'm new to this
kind of work, I only read introductory articles on the adeos/xenomai
architecture.

I'm testing Xenomai on an e300 Core PowerPC, and, to get lowest latencies, I
realized an RTDM
driver which handles an external timer interrupt:

-sh-2.05b# cat /proc/ipipe/Xenomai
       +----- Handling ([A]ccepted, [G]rabbed, [W]ired, [D]iscarded)
       |+---- Sticky
       ||+--- Locked
       |||+-- Exclusive
       ||||+- Virtual
[IRQ]  |||||
  75:  W..X.
 512:  W..XV
 515:  W...V

IRQ 75 is the timer interrupt. It is not handled in the Linux domain:

-sh-2.05b# cat /proc/ipipe/Linux | grep " 75"
  75:  A....

The Xenomai interrupt handler simply toggles a pin
generating a squarewave measured by an oscilloscope, so this is a jitter
test:

static int demo_interrupt(rtdm_irq_t *irq_context)
{
    int ret = RTDM_IRQ_HANDLED;
    struct gpt_drv_context *ctx;

    ctx = rtdm_irq_get_arg(irq_context, struct gpt_drv_context);

    // re-enable timer interrupt
    out_be32((ctx->gpt) + GPT_STATUS, GPT_STATUS_TEXP);

    // toggle GPIO
    if (read_pin(PIN, ctx)) {
        set_pin_low(PIN, ctx);
    } else {
        set_pin_high(PIN, ctx);
    }

    return ret;
}

The test shows a 2/3 uS jitter with no load.

Then I open an ssh connection with the target, and run a "cat /dev/zero >
file". The target
is mounted on an NFS root filesystem, so this generates a high number of
fast ethernet interrupts. Now the oscilloscope shows 15 uS jitter in the
worst case,
and a visible variance. I would assume this effect as increased max latency.

The ethernet interrupt is handled only in Linux domain by the original
vanilla handler,
but Linux should be stalled/preempted when the timer interrupt occurs. So I
assume
that latency is to be justified by the time it takes to adeos to record an
ethernet interrupt event in the i-logs when the timer interrupt is executing
or ready to
execute. Is this correct?

Assuming it is correct, what i-logs are concerned in the case of the
ethernet interrupt?
Is only the Xenomai i-log, only the Linux i-log, or both i-logs concerned? I
removed the
Interrupt Shield, but did not notice jitter differences.

Is there any way to lower max latency for the timer interrupt?

May I assume the max jitter measured is the upper bound, when there is only
this Xenomai
interrupt handler, and no other real time tasks?

May I assume that increasing the number of non real time related interrupts
in the system
would determine an increased mean latency, but not an increased max latency?

Thank you very much,
Antonio

------=_Part_33935_28874366.1221836799232
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<div dir="ltr">Hi all,<br>I need confirmations on the ipipe model, to interpret test results. Excuse me, I&#39;m new to this <br>kind of work, I only read introductory articles on the adeos/xenomai architecture.<br><br>I&#39;m testing Xenomai on an e300 Core PowerPC, and, to get lowest latencies, I realized an RTDM <br>
driver which handles an external timer interrupt:<br><br>-sh-2.05b# cat /proc/ipipe/Xenomai <br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; +----- Handling ([A]ccepted, [G]rabbed, [W]ired, [D]iscarded)<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |+---- Sticky<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ||+--- Locked<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |||+-- Exclusive<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ||||+- Virtual<br>[IRQ]&nbsp; |||||<br>&nbsp; 75:&nbsp; W..X.<br>&nbsp;512:&nbsp; W..XV<br>&nbsp;515:&nbsp; W...V<br><br>IRQ 75 is the timer interrupt. It is not handled in the Linux domain:<br><br>-sh-2.05b# cat /proc/ipipe/Linux | grep &quot; 75&quot;<br>
&nbsp; 75:&nbsp; A....<br><br>The Xenomai interrupt handler simply toggles a pin <br>generating a squarewave measured by an oscilloscope, so this is a jitter test:<br><br>static int demo_interrupt(rtdm_irq_t *irq_context)<br>{<br>&nbsp;&nbsp;&nbsp; int ret = RTDM_IRQ_HANDLED;<br>
&nbsp;&nbsp;&nbsp; struct gpt_drv_context *ctx;<br><br>&nbsp;&nbsp;&nbsp; ctx = rtdm_irq_get_arg(irq_context, struct gpt_drv_context);<br><br>&nbsp;&nbsp;&nbsp; // re-enable timer interrupt<br>&nbsp;&nbsp;&nbsp; out_be32((ctx-&gt;gpt) + GPT_STATUS, GPT_STATUS_TEXP);<br><br>&nbsp;&nbsp;&nbsp; // toggle GPIO<br>
&nbsp;&nbsp;&nbsp; if (read_pin(PIN, ctx)) {<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; set_pin_low(PIN, ctx);<br>&nbsp;&nbsp;&nbsp; } else {<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; set_pin_high(PIN, ctx);<br>&nbsp;&nbsp;&nbsp; }<br><br>&nbsp;&nbsp;&nbsp; return ret;<br>}<br><br>The test shows a 2/3 uS jitter with no load. <br><br>Then I open an ssh connection with the target, and run a &quot;cat /dev/zero &gt; file&quot;. The target <br>
is mounted on an NFS root filesystem, so this generates a high number of <br>fast ethernet interrupts. Now the oscilloscope shows 15 uS jitter in the worst case, <br>and a visible variance. I would assume this effect as increased max latency.<br>
<br>The ethernet interrupt is handled only in Linux domain by the original vanilla handler, <br>but Linux should be stalled/preempted when the timer interrupt occurs. So I assume <br>that latency is to be justified by the time it takes to adeos to record an <br>
ethernet interrupt event in the i-logs when the timer interrupt is executing or ready to<br>execute. Is this correct? <br><br>Assuming it is correct, what i-logs are concerned in the case of the ethernet interrupt? <br>Is only the Xenomai i-log, only the Linux i-log, or both i-logs concerned? I removed the <br>
Interrupt Shield, but did not notice jitter differences.<br><br>Is there any way to lower max latency for the timer interrupt?<br><br>May I assume the max jitter measured is the upper bound, when there is only this Xenomai<br>
interrupt handler, and no other real time tasks?<br><br>May I assume that increasing the number of non real time related interrupts in the system<br>would determine an increased mean latency, but not an increased max latency?<br>
<br>Thank you very much,<br>Antonio<br><br></div>

------=_Part_33935_28874366.1221836799232--

