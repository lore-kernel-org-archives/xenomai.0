Message-ID: <1743f3b40809030205x5b1f2c7dt87056c9f851c2eb7@domain.hid>
Date: Wed, 3 Sep 2008 11:05:33 +0200
From: "Antonio Del Cinque" <adelcinque@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_10677_8719925.1220432733158"
Subject: [Xenomai-help] Problems with interrupts on MPC5121e
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

------=_Part_10677_8719925.1220432733158
Content-Type: multipart/alternative; 
	boundary="----=_Part_10678_22979711.1220432733158"

------=_Part_10678_22979711.1220432733158
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi all,
I'm trying to make Xenomai work on the MPC5121e SoC from Freescale (PowerPC
e300 embedded in). I adapted the Adeos patch for powerpc included in
Xenomai 2.4.2, but I'm not sure all stuff goes as it should.

The SoC includes a General Purpose Timer (GPT) chip with 8 programmable
timers, and a General Purpose IO (GPIO) chip with 32 IO pins. The timers are
capable of generating interrupts. I'd like to use the timers to drive real
time tasks in the Xenomai domain.

I have a vanilla kernel module working. The module registers an interrupt
handler on a timer. The handler toggles an IO pin to generate a square wave,
so I can measure the jitter with an oscilloscope.

To port the code to Xenomai, I changed the old driver, so that it doesn't
register and handle the interrupt handler, but still manages all the
hardware stuff. Then I used the rt_intr_create, rt_intr_wait API from user
space to register and handle the interrupt, as described in the Xenomai
docs, but the Xenomai task hangs (all the system hangs!) on the
rt_intr_wait, when all the preceding calls returned with no error. Can
anybody help me?

Following are the kernel driver snippet for hardware writes (with old
interrupt registration and handling commented out), and user application
with interrupt registration and handling. Original files are attached.

Thank you very much.
Antonio

VANILLA KERNEL DRIVER SNIPPET
======================

//static irqreturn_t mpc5121_gpt_handler(int irq, void *dev)
//{
//    static int count = 0;
//
//    // (Re)Arm the hardware interrupt
//    out_be32(&gpt_global->regs->status, GPT_STATUS_TEXP);
//
//    if (count++ % 2) {
//        set_pin_high(14);
//    } else  {
//        set_pin_low(14);
//    }
//
//    return IRQ_HANDLED;
//}

static int __devinit mpc5121_gpt_probe(struct of_device *op,
                       const struct of_device_id *match)
{
    struct mpc5121_gpt *gpt;
    int err;
    int size;
    int ret;
    u32 irq;

    void __iomem *ioctl;
    struct device_node *np;

    if (gpt_count++ == 5) {// TODO mamage all timers

        gpt = kzalloc(sizeof(*gpt), GFP_KERNEL);
        if (!gpt)
            return -ENOMEM;

        err = of_address_to_resource(op->node, 0, &gpt->mem);
        if (err)
            goto out_free;
        size = gpt->mem.end - gpt->mem.start + 1;
        if (!request_mem_region(gpt->mem.start, size, "mpc5121_gpt")) {
            err = -ENODEV;
            goto out_free;
        }
        gpt->regs = ioremap(gpt->mem.start, size);
        if (!gpt->regs) {
            err = -ENODEV;
            goto out_release;
        }

        dev_set_drvdata(&op->dev, gpt);
        spin_lock_init(&gpt->io_lock);
        gpt_global = gpt;

        irq = irq_of_parse_and_map(op->node, 0);
        printk("Timer IRQ: %d\n", irq);

//        ret = request_irq(irq, mpc5121_gpt_handler, IRQF_DISABLED,
//                        "mpx512x_test_timer", (void *)0);
//        if (ret) enable_irq(irq);

        spin_lock(&gpt->io_lock);

        /* Disable hardware interrupts */
        out_be32(&gpt->regs->mode, 0x0);

        /* Set the timer timeout */
        out_be32(&gpt->regs->count, 0x10000041);

        /* Enable hardware interrupts */
        out_be32(&gpt->regs->mode, GPT_MODE_STOP_CONT |
            GPT_MODE_INTEN | GPT_MODE_TIMER_MS | GPT_MODE_CE);
        out_be32(&gpt->regs->mode, in_be32(&gpt->regs->mode) | GPT_MODE_CE);

        spin_unlock(&gpt->io_lock);

        if (!err)
            return 0;

        iounmap(gpt->regs);

    out_release:
        release_mem_region(gpt->mem.start, size);

    out_free:
        kfree(gpt);
        return err;
    }

    else return 0;
}

USER APPLICATION
=============
#include <stdio.h>

#include <sys/mman.h>
#include <native/task.h>
#include <native/intr.h>

#define IRQ_NUMBER 75    /* Intercept interrupt #75 */
#define TASK_PRIO  99    /* Highest RT priority */
#define TASK_MODE  0    /* No flags */
#define TASK_STKSZ 0    /* Stack size (use default one) */

RT_INTR intr_desc;
RT_TASK server_desc;

void irq_server(void *cookie)
{
    int err;
    static int count = 0;
    static int wait = 0;

    for (;;) {
        // Wait for the next interrupt
        printf("%d\n", wait++);
        err = rt_intr_wait(&intr_desc, TM_INFINITE);
        if (err) {
            printf("rt_intr_wait ERROR: %d!!!\n", err);
            return;
        }

        // Handle the interrupt
        printf("%d\n", count++);
    }
}

int main(int argc, char *argv[])
{
    int err;

    mlockall(MCL_CURRENT | MCL_FUTURE);

    // Register interrupt with Xenomai
    err = rt_intr_create(&intr_desc, "MyIrq", IRQ_NUMBER, 0);
    if (err) {
        printf("rt_intr_create ERROR: %d!!!\n", err);
        return;
    }

    // Create the task that handles the interrupt
    err = rt_task_create(&server_desc, "MyIrqServer",
            TASK_STKSZ, TASK_PRIO, TASK_MODE);
    if (err) {
        printf("rt_task_create ERROR: %d!!!\n", err);
        return;
    }

    // Start the task that handles the interrupt
    err = rt_task_start(&server_desc, &irq_server, NULL);
    if (err) {
        printf("rt_task_start ERROR: %d!!!\n", err);
        return;
    }

    // Enable the interrupt with Xenomai
    err = rt_intr_enable(&intr_desc);
    if (err) {
        printf("rt_intr_enable ERROR: %d!!!\n", err);
        return;
    }

}

void cleanup(void)
{
    rt_intr_delete(&intr_desc);
    rt_task_delete(&server_desc);
}

------=_Part_10678_22979711.1220432733158
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<div dir="ltr">Hi all,<br>I&#39;m trying to make Xenomai work on the MPC5121e SoC from Freescale (PowerPC e300 embedded in). I adapted the Adeos patch for powerpc included in&nbsp; Xenomai 2.4.2, but I&#39;m not sure all stuff goes as it should.<br>
<br>The SoC includes a General Purpose Timer (GPT) chip with 8 programmable timers, and a General Purpose IO (GPIO) chip with 32 IO pins. The timers are capable of generating interrupts. I&#39;d like to use the timers to drive real time tasks in the Xenomai domain.<br>
<br>I have a vanilla kernel module working. The module registers an interrupt handler on a timer. The handler toggles an IO pin to generate a square wave, so I can measure the jitter with an oscilloscope.<br><br>To port the code to Xenomai, I changed the old driver, so that it doesn&#39;t register and handle the interrupt handler, but still manages all the hardware stuff. Then I used the rt_intr_create, rt_intr_wait API from user space to register and handle the interrupt, as described in the Xenomai docs, but the Xenomai task hangs (all the system hangs!) on the rt_intr_wait, when all the preceding calls returned with no error. Can anybody help me?<br>
<br>Following are the kernel driver snippet for hardware writes (with old interrupt registration and handling commented out), and user application with interrupt registration and handling. Original files are attached. <br>
<br>Thank you very much.<br>Antonio<br><br>VANILLA KERNEL DRIVER SNIPPET<br>======================<br><br>//static irqreturn_t mpc5121_gpt_handler(int irq, void *dev)<br>//{<br>//&nbsp;&nbsp;&nbsp; static int count = 0;<br>//<br>//&nbsp;&nbsp;&nbsp; // (Re)Arm the hardware interrupt<br>
//&nbsp;&nbsp;&nbsp; out_be32(&amp;gpt_global-&gt;regs-&gt;status, GPT_STATUS_TEXP);<br>//<br>//&nbsp;&nbsp;&nbsp; if (count++ % 2) {<br>//&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; set_pin_high(14);<br>//&nbsp;&nbsp;&nbsp; } else&nbsp; {<br>//&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; set_pin_low(14);<br>//&nbsp;&nbsp;&nbsp; }<br>//<br>//&nbsp;&nbsp;&nbsp; return IRQ_HANDLED;<br>
//}<br><br>static int __devinit mpc5121_gpt_probe(struct of_device *op,<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; const struct of_device_id *match)<br>{<br>&nbsp;&nbsp;&nbsp; struct mpc5121_gpt *gpt;<br>&nbsp;&nbsp;&nbsp; int err;<br>&nbsp;&nbsp;&nbsp; int size;<br>&nbsp;&nbsp;&nbsp; int ret;<br>
&nbsp;&nbsp;&nbsp; u32 irq;<br><br>&nbsp;&nbsp;&nbsp; void __iomem *ioctl;<br>&nbsp;&nbsp;&nbsp; struct device_node *np;<br><br>&nbsp;&nbsp;&nbsp; if (gpt_count++ == 5) {// TODO mamage all timers<br><br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; gpt = kzalloc(sizeof(*gpt), GFP_KERNEL);<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; if (!gpt)<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; return -ENOMEM;<br>
<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; err = of_address_to_resource(op-&gt;node, 0, &amp;gpt-&gt;mem);<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; if (err)<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; goto out_free;<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; size = gpt-&gt;mem.end - gpt-&gt;mem.start + 1;<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; if (!request_mem_region(gpt-&gt;mem.start, size, &quot;mpc5121_gpt&quot;)) {<br>
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; err = -ENODEV;<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; goto out_free;<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; }<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; gpt-&gt;regs = ioremap(gpt-&gt;mem.start, size);<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; if (!gpt-&gt;regs) {<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; err = -ENODEV;<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; goto out_release;<br>
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; }<br><br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; dev_set_drvdata(&amp;op-&gt;dev, gpt);<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; spin_lock_init(&amp;gpt-&gt;io_lock);<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; gpt_global = gpt;<br><br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; irq = irq_of_parse_and_map(op-&gt;node, 0);<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; printk(&quot;Timer IRQ: %d\n&quot;, irq);<br>
<br>//&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; ret = request_irq(irq, mpc5121_gpt_handler, IRQF_DISABLED,<br>//&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &quot;mpx512x_test_timer&quot;, (void *)0);<br>//&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; if (ret) enable_irq(irq);<br><br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; spin_lock(&amp;gpt-&gt;io_lock);<br>
<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; /* Disable hardware interrupts */<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; out_be32(&amp;gpt-&gt;regs-&gt;mode, 0x0);<br><br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; /* Set the timer timeout */<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; out_be32(&amp;gpt-&gt;regs-&gt;count, 0x10000041);<br><br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; /* Enable hardware interrupts */<br>
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; out_be32(&amp;gpt-&gt;regs-&gt;mode, GPT_MODE_STOP_CONT |<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; GPT_MODE_INTEN | GPT_MODE_TIMER_MS | GPT_MODE_CE);<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; out_be32(&amp;gpt-&gt;regs-&gt;mode, in_be32(&amp;gpt-&gt;regs-&gt;mode) | GPT_MODE_CE);<br>
<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; spin_unlock(&amp;gpt-&gt;io_lock);<br><br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; if (!err)<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; return 0;<br><br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; iounmap(gpt-&gt;regs);<br><br>&nbsp;&nbsp;&nbsp; out_release:<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; release_mem_region(gpt-&gt;mem.start, size);<br><br>
&nbsp;&nbsp;&nbsp; out_free:<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; kfree(gpt);<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; return err;<br>&nbsp;&nbsp;&nbsp; }<br><br>&nbsp;&nbsp;&nbsp; else return 0;<br>}<br><br>USER APPLICATION<br>=============<br>#include &lt;stdio.h&gt;<br><br>#include &lt;sys/mman.h&gt;<br>#include &lt;native/task.h&gt;<br>
#include &lt;native/intr.h&gt;<br><br>#define IRQ_NUMBER 75&nbsp;&nbsp;&nbsp; /* Intercept interrupt #75 */<br>#define TASK_PRIO&nbsp; 99&nbsp;&nbsp;&nbsp; /* Highest RT priority */<br>#define TASK_MODE&nbsp; 0&nbsp;&nbsp;&nbsp; /* No flags */<br>#define TASK_STKSZ 0&nbsp;&nbsp;&nbsp; /* Stack size (use default one) */<br>
<br>RT_INTR intr_desc;<br>RT_TASK server_desc;<br><br>void irq_server(void *cookie)<br>{<br>&nbsp;&nbsp;&nbsp; int err;<br>&nbsp;&nbsp;&nbsp; static int count = 0;<br>&nbsp;&nbsp;&nbsp; static int wait = 0;<br><br>&nbsp;&nbsp;&nbsp; for (;;) {<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; // Wait for the next interrupt<br>
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; printf(&quot;%d\n&quot;, wait++);<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; err = rt_intr_wait(&amp;intr_desc, TM_INFINITE);<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; if (err) {<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; printf(&quot;rt_intr_wait ERROR: %d!!!\n&quot;, err);<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; return;<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; }<br>
<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; // Handle the interrupt<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; printf(&quot;%d\n&quot;, count++);<br>&nbsp;&nbsp;&nbsp; }<br>}<br><br>int main(int argc, char *argv[])<br>{<br>&nbsp;&nbsp;&nbsp; int err;<br><br>&nbsp;&nbsp;&nbsp; mlockall(MCL_CURRENT | MCL_FUTURE);<br><br>&nbsp;&nbsp;&nbsp; // Register interrupt with Xenomai<br>
&nbsp;&nbsp;&nbsp; err = rt_intr_create(&amp;intr_desc, &quot;MyIrq&quot;, IRQ_NUMBER, 0);<br>&nbsp;&nbsp;&nbsp; if (err) {<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; printf(&quot;rt_intr_create ERROR: %d!!!\n&quot;, err);<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; return;<br>&nbsp;&nbsp;&nbsp; }<br><br>&nbsp;&nbsp;&nbsp; // Create the task that handles the interrupt<br>
&nbsp;&nbsp;&nbsp; err = rt_task_create(&amp;server_desc, &quot;MyIrqServer&quot;,<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; TASK_STKSZ, TASK_PRIO, TASK_MODE);<br>&nbsp;&nbsp;&nbsp; if (err) {<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; printf(&quot;rt_task_create ERROR: %d!!!\n&quot;, err);<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; return;<br>
&nbsp;&nbsp;&nbsp; }<br><br>&nbsp;&nbsp;&nbsp; // Start the task that handles the interrupt<br>&nbsp;&nbsp;&nbsp; err = rt_task_start(&amp;server_desc, &amp;irq_server, NULL);<br>&nbsp;&nbsp;&nbsp; if (err) {<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; printf(&quot;rt_task_start ERROR: %d!!!\n&quot;, err);<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; return;<br>
&nbsp;&nbsp;&nbsp; }<br><br>&nbsp;&nbsp;&nbsp; // Enable the interrupt with Xenomai<br>&nbsp;&nbsp;&nbsp; err = rt_intr_enable(&amp;intr_desc);<br>&nbsp;&nbsp;&nbsp; if (err) {<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; printf(&quot;rt_intr_enable ERROR: %d!!!\n&quot;, err);<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; return;<br>&nbsp;&nbsp;&nbsp; }<br><br>}<br>
<br>void cleanup(void)<br>{<br>&nbsp;&nbsp;&nbsp; rt_intr_delete(&amp;intr_desc);<br>&nbsp;&nbsp;&nbsp; rt_task_delete(&amp;server_desc);<br>}<br><br></div>

------=_Part_10678_22979711.1220432733158--

------=_Part_10677_8719925.1220432733158
Content-Type: text/x-csrc; name=gpt-test.c
Content-Transfer-Encoding: base64
X-Attachment-Id: f_fknq0m1y0
Content-Disposition: attachment; filename=gpt-test.c

I2luY2x1ZGUgPHN0ZGlvLmg+CgojaW5jbHVkZSA8c3lzL21tYW4uaD4KI2luY2x1ZGUgPG5hdGl2
ZS90YXNrLmg+CiNpbmNsdWRlIDxuYXRpdmUvaW50ci5oPgoKI2RlZmluZSBJUlFfTlVNQkVSIDc1
CS8qIEludGVyY2VwdCBpbnRlcnJ1cHQgIzc1ICovCiNkZWZpbmUgVEFTS19QUklPICA5OQkvKiBI
aWdoZXN0IFJUIHByaW9yaXR5ICovCiNkZWZpbmUgVEFTS19NT0RFICAwCS8qIE5vIGZsYWdzICov
CiNkZWZpbmUgVEFTS19TVEtTWiAwCS8qIFN0YWNrIHNpemUgKHVzZSBkZWZhdWx0IG9uZSkgKi8K
ClJUX0lOVFIgaW50cl9kZXNjOwpSVF9UQVNLIHNlcnZlcl9kZXNjOwoKdm9pZCBpcnFfc2VydmVy
KHZvaWQgKmNvb2tpZSkKewoJaW50IGVycjsKCXN0YXRpYyBpbnQgY291bnQgPSAwOwoJc3RhdGlj
IGludCB3YWl0ID0gMDsKCglmb3IgKDs7KSB7CgkJLy8gV2FpdCBmb3IgdGhlIG5leHQgaW50ZXJy
dXB0CgkJcHJpbnRmKCIlZFxuIiwgd2FpdCsrKTsKCQllcnIgPSBydF9pbnRyX3dhaXQoJmludHJf
ZGVzYywgVE1fSU5GSU5JVEUpOwoJCWlmIChlcnIpIHsKCQkJcHJpbnRmKCJydF9pbnRyX3dhaXQg
RVJST1I6ICVkISEhXG4iLCBlcnIpOwoJCQlyZXR1cm47CgkJfQoKCQkvLyBIYW5kbGUgdGhlIGlu
dGVycnVwdAoJCXByaW50ZigiJWRcbiIsIGNvdW50KyspOwoJfQp9CgppbnQgbWFpbihpbnQgYXJn
YywgY2hhciAqYXJndltdKQp7CglpbnQgZXJyOwoKCW1sb2NrYWxsKE1DTF9DVVJSRU5UIHwgTUNM
X0ZVVFVSRSk7CgoJLy8gUmVnaXN0ZXIgaW50ZXJydXB0IHdpdGggWGVub21haQoJZXJyID0gcnRf
aW50cl9jcmVhdGUoJmludHJfZGVzYywgIk15SXJxIiwgSVJRX05VTUJFUiwgMCk7CglpZiAoZXJy
KSB7CgkJcHJpbnRmKCJydF9pbnRyX2NyZWF0ZSBFUlJPUjogJWQhISFcbiIsIGVycik7CgkJcmV0
dXJuOwoJfQoKCS8vIENyZWF0ZSB0aGUgdGFzayB0aGF0IGhhbmRsZXMgdGhlIGludGVycnVwdAoJ
ZXJyID0gcnRfdGFza19jcmVhdGUoJnNlcnZlcl9kZXNjLCAiTXlJcnFTZXJ2ZXIiLAoJCQlUQVNL
X1NUS1NaLCBUQVNLX1BSSU8sIFRBU0tfTU9ERSk7CglpZiAoZXJyKSB7CgkJcHJpbnRmKCJydF90
YXNrX2NyZWF0ZSBFUlJPUjogJWQhISFcbiIsIGVycik7CgkJcmV0dXJuOwoJfQoKCS8vIFN0YXJ0
IHRoZSB0YXNrIHRoYXQgaGFuZGxlcyB0aGUgaW50ZXJydXB0CgllcnIgPSBydF90YXNrX3N0YXJ0
KCZzZXJ2ZXJfZGVzYywgJmlycV9zZXJ2ZXIsIE5VTEwpOwoJaWYgKGVycikgewoJCXByaW50Zigi
cnRfdGFza19zdGFydCBFUlJPUjogJWQhISFcbiIsIGVycik7CgkJcmV0dXJuOwoJfQoKCS8vIEVu
YWJsZSB0aGUgaW50ZXJydXB0IHdpdGggWGVub21haQoJZXJyID0gcnRfaW50cl9lbmFibGUoJmlu
dHJfZGVzYyk7CglpZiAoZXJyKSB7CgkJcHJpbnRmKCJydF9pbnRyX2VuYWJsZSBFUlJPUjogJWQh
ISFcbiIsIGVycik7CgkJcmV0dXJuOwoJfQoKfQoKdm9pZCBjbGVhbnVwKHZvaWQpCnsKCXJ0X2lu
dHJfZGVsZXRlKCZpbnRyX2Rlc2MpOwoJcnRfdGFza19kZWxldGUoJnNlcnZlcl9kZXNjKTsKfQo=

------=_Part_10677_8719925.1220432733158
Content-Type: text/x-csrc; name=mpc5121_gpt.c
Content-Transfer-Encoding: base64
X-Attachment-Id: f_fknq1ffd1
Content-Disposition: attachment; filename=mpc5121_gpt.c

LyoKICogR2VuZXJhbCBQdXJwb3NlIFRpbWVyIGRyaXZlciBmb3IgTVBDNTEyMS4KICoKICogQ29w
eXJpZ2h0IDIwMDgsIEFudG9uaW8gRGVsIENpbnF1ZSA8YWRlbGNpbnF1ZUBhcmNhZW1iZWRkZWQu
aXQ+CiAqIENvcHlyaWdodCAyMDA4LCBBcmNhIEVtYmVkZGVkLCBJbmMuIEFsbCByaWdodHMgcmVz
ZXJ2ZWQuCiAqCiAqIFRoaXMgcHJvZ3JhbSBpcyBmcmVlIHNvZnR3YXJlOyB5b3UgY2FuIHJlZGlz
dHJpYnV0ZSBpdCBhbmQvb3IgbW9kaWZ5CiAqIGl0IHVuZGVyIHRoZSB0ZXJtcyBvZiB0aGUgR05V
IEdlbmVyYWwgUHVibGljIExpY2Vuc2UgdmVyc2lvbiAyIGFzCiAqIHB1Ymxpc2hlZCBieSB0aGUg
RnJlZSBTb2Z0d2FyZSBGb3VuZGF0aW9uLgogKi8KI2luY2x1ZGUgPGxpbnV4L21vZHVsZS5oPgoj
aW5jbHVkZSA8YXNtL29mX2RldmljZS5oPgojaW5jbHVkZSA8YXNtL29mX3BsYXRmb3JtLmg+CiNp
bmNsdWRlIDxhc20vaW8uaD4KCi8vIFRPRE8gcmVtb3ZlIHRoaXMhISEKI2luY2x1ZGUgPGxpbnV4
L3J0Yy5oPgoKLy8jaW5jbHVkZSA8YXNtL21wYzUxMnguaD4hISEKCi8vIEdQSU8gcmVnaXN0ZXJz
IGJhc2UgYWRkcmVzcyBhbmQgb2Zmc2V0cwpzdGF0aWMgdm9pZCBfX2lvbWVtICpncGlvY3RsOwoj
ZGVmaW5lIEdQRElSCTB4MDAKI2RlZmluZSBHUE9EUgkweDA0CiNkZWZpbmUgR1BEQVQJMHgwOAoj
ZGVmaW5lIEdQSUVSCTB4MEMKI2RlZmluZSBHUElNUgkweDEwCiNkZWZpbmUgR1BJQ1IxCTB4MTQK
I2RlZmluZSBHUElDUjIJMHgxOAoKLyogUGluIG1hc2tzIGZvciBHUERJUiwgR1BPRFIsIEdQREFU
LCBHUElFUiBhbmQgR1BJTVIgKi8KI2RlZmluZSBwaW5fbWFzayhwaW5faW5kZXgpICgweDgwMDAw
MDAwID4+IHBpbl9pbmRleCkKCi8qIElPIGNvbnRyb2wgb2Zmc2V0cyBmb3IgR1BJTyBwaW5zIGF2
YWlsYWJsZSBvbiB0aGUgQURTNTEyMSBib2FyZCAqLwojZGVmaW5lIElPQ1RMX1BTQzZfMiAweDI4
QwojZGVmaW5lIElPQ1RMX1BTQzZfMyAweDI5MAoKI2RlZmluZSBHUFRfTU9ERV9USU1FUl9NUwko
MHg0KQojZGVmaW5lIEdQVF9NT0RFX0lOVEVOCQkoMTw8OCkKI2RlZmluZSBHUFRfTU9ERV9TVE9Q
X0NPTlQJKDE8PDEwKQojZGVmaW5lIEdQVF9NT0RFX0NFCQkoMTw8MTIpCiNkZWZpbmUgR1BUX1NU
QVRVU19URVhQCQkoMHhGRkZGKQoKc3RhdGljIGludCBncHRfY291bnQgPSAwOwpzdGF0aWMgaW50
IGNvdW50ID0gMDsKCnN0cnVjdCBtcGM1MTJ4X2dwdF9yZWdzIHsKCXUzMiBtb2RlOwkJLyogR1BU
eCArIDB4MDAgKi8KCXUzMiBjb3VudDsJCS8qIEdQVHggKyAweDA0ICovCgl1MzIgcHdtOwkJLyog
R1BUeCArIDB4MDggKi8KCXUzMiBzdGF0dXM7CQkvKiBHUFR4ICsgMFgwYyAqLwp9OwoKc3RydWN0
IG1wYzUxMjFfZ3B0IHsKCXN0cnVjdCByZXNvdXJjZSBtZW07CglzdHJ1Y3QgbXBjNTEyeF9ncHRf
cmVncyBfX2lvbWVtICpyZWdzOwoJc3BpbmxvY2tfdCBpb19sb2NrOwp9OwoKc3RhdGljIHN0cnVj
dCBtcGM1MTIxX2dwdCAqZ3B0X2dsb2JhbDsKCi8qIEdQSU8gbG93IGxldmVsIGFjY2VzcyBmdW5j
dGlvbnMgKi8Kc3RhdGljIGludCByZWFkX2Rpcih1bnNpZ25lZCBwaW4pCnsKCXJldHVybiAoaW5f
YmUzMihncGlvY3RsICsgR1BESVIpICYgKDB4ODAwMDAwMDAgPj4gcGluKSk/IDE6IDA7Cn0KCnN0
YXRpYyBpbnQgcmVhZF9waW4odW5zaWduZWQgcGluKQp7CglyZXR1cm4gKGluX2JlMzIoZ3Bpb2N0
bCArIEdQREFUKSAmICgweDgwMDAwMDAwID4+IHBpbikpPyAxOiAwOwp9CgpzdGF0aWMgdm9pZCBz
ZXRfcGluX2Rpcl9pbnB1dCh1bnNpZ25lZCBwaW4pCnsKCXVuc2lnbmVkIGdwX2RpciA9IGluX2Jl
MzIoZ3Bpb2N0bCArIEdQRElSKTsKCWdwX2RpciAmPSB+KDB4ODAwMDAwMDAgPj4gcGluKTsKCW91
dF9iZTMyKGdwaW9jdGwgKyBHUERJUiwgZ3BfZGlyKTsKfQoKc3RhdGljIHZvaWQgc2V0X3Bpbl9k
aXJfb3V0cHV0KHVuc2lnbmVkIHBpbikKewoJdW5zaWduZWQgZ3BfZGlyID0gaW5fYmUzMihncGlv
Y3RsICsgR1BESVIpOwoJZ3BfZGlyIHw9ICgweDgwMDAwMDAwID4+IHBpbik7CglvdXRfYmUzMihn
cGlvY3RsICsgR1BESVIsIGdwX2Rpcik7Cn0KCnN0YXRpYyB2b2lkIHNldF9waW5fbG93KHVuc2ln
bmVkIHBpbikKewoJdW5zaWduZWQgZ3BfZGF0ID0gaW5fYmUzMihncGlvY3RsICsgR1BEQVQpOwoJ
Z3BfZGF0ICY9IH4oMHg4MDAwMDAwMCA+PiBwaW4pOwoJb3V0X2JlMzIoZ3Bpb2N0bCArIEdQREFU
LCBncF9kYXQpOwp9CgpzdGF0aWMgdm9pZCBzZXRfcGluX2hpZ2godW5zaWduZWQgcGluKQp7Cgl1
bnNpZ25lZCBncF9kYXQgPSBpbl9iZTMyKGdwaW9jdGwgKyBHUERBVCk7CglncF9kYXQgfD0gKDB4
ODAwMDAwMDAgPj4gcGluKTsKCW91dF9iZTMyKGdwaW9jdGwgKyBHUERBVCwgZ3BfZGF0KTsKfQoK
Ly9zdGF0aWMgaXJxcmV0dXJuX3QgbXBjNTEyMV9ncHRfaGFuZGxlcihpbnQgaXJxLCB2b2lkICpk
ZXYpCi8vewovLwlzdGF0aWMgaW50IGNvdW50ID0gMDsKLy8KLy8JLy8gKFJlKUFybSB0aGUgaGFy
ZHdhcmUgaW50ZXJydXB0Ci8vCW91dF9iZTMyKCZncHRfZ2xvYmFsLT5yZWdzLT5zdGF0dXMsIEdQ
VF9TVEFUVVNfVEVYUCk7Ci8vCi8vCWlmIChjb3VudCsrICUgMikgewovLwkJc2V0X3Bpbl9oaWdo
KDE0KTsKLy8JfSBlbHNlICB7Ci8vCQlzZXRfcGluX2xvdygxNCk7Ci8vCX0KLy8KLy8JcmV0dXJu
IElSUV9IQU5ETEVEOwovL30KCnN0YXRpYyBpbnQgX19kZXZpbml0IG1wYzUxMjFfZ3B0X3Byb2Jl
KHN0cnVjdCBvZl9kZXZpY2UgKm9wLAoJCQkJICAgICAgIGNvbnN0IHN0cnVjdCBvZl9kZXZpY2Vf
aWQgKm1hdGNoKQp7CglzdHJ1Y3QgbXBjNTEyMV9ncHQgKmdwdDsKCWludCBlcnI7CglpbnQgc2l6
ZTsKCWludCByZXQ7Cgl1MzIgaXJxOwoKCXZvaWQgX19pb21lbSAqaW9jdGw7CglzdHJ1Y3QgZGV2
aWNlX25vZGUgKm5wOwoKCWlmIChncHRfY291bnQrKyA9PSA1KSB7Ly8gVE9ETyBtYW1hZ2UgYWxs
IHRpbWVycwoKCQlncHQgPSBremFsbG9jKHNpemVvZigqZ3B0KSwgR0ZQX0tFUk5FTCk7CgkJaWYg
KCFncHQpCgkJCXJldHVybiAtRU5PTUVNOwoKCQllcnIgPSBvZl9hZGRyZXNzX3RvX3Jlc291cmNl
KG9wLT5ub2RlLCAwLCAmZ3B0LT5tZW0pOwoJCWlmIChlcnIpCgkJCWdvdG8gb3V0X2ZyZWU7CgkJ
c2l6ZSA9IGdwdC0+bWVtLmVuZCAtIGdwdC0+bWVtLnN0YXJ0ICsgMTsKCQlpZiAoIXJlcXVlc3Rf
bWVtX3JlZ2lvbihncHQtPm1lbS5zdGFydCwgc2l6ZSwgIm1wYzUxMjFfZ3B0IikpIHsKCQkJZXJy
ID0gLUVOT0RFVjsKCQkJZ290byBvdXRfZnJlZTsKCQl9CgkJZ3B0LT5yZWdzID0gaW9yZW1hcChn
cHQtPm1lbS5zdGFydCwgc2l6ZSk7CgkJaWYgKCFncHQtPnJlZ3MpIHsKCQkJZXJyID0gLUVOT0RF
VjsKCQkJZ290byBvdXRfcmVsZWFzZTsKCQl9CgoJCWRldl9zZXRfZHJ2ZGF0YSgmb3AtPmRldiwg
Z3B0KTsKCQlzcGluX2xvY2tfaW5pdCgmZ3B0LT5pb19sb2NrKTsKCQlncHRfZ2xvYmFsID0gZ3B0
OwoKCQlpcnEgPSBpcnFfb2ZfcGFyc2VfYW5kX21hcChvcC0+bm9kZSwgMCk7CgkJcHJpbnRrKCJU
aW1lciBJUlE6ICVkXG4iLCBpcnEpOwoKLy8JCXJldCA9IHJlcXVlc3RfaXJxKGlycSwgbXBjNTEy
MV9ncHRfaGFuZGxlciwgSVJRRl9ESVNBQkxFRCwKLy8JCQkJCQkibXB4NTEyeF90ZXN0X3RpbWVy
IiwgKHZvaWQgKikwKTsKLy8JCWlmIChyZXQpIGVuYWJsZV9pcnEoaXJxKTsKCgkJc3Bpbl9sb2Nr
KCZncHQtPmlvX2xvY2spOwoKCQkvKiBEaXNhYmxlIGhhcmR3YXJlIGludGVycnVwdHMgKi8KCQlv
dXRfYmUzMigmZ3B0LT5yZWdzLT5tb2RlLCAweDApOwoKCQkvKiBTZXQgdGhlIHRpbWVyIHRpbWVv
dXQgKi8KCQlvdXRfYmUzMigmZ3B0LT5yZWdzLT5jb3VudCwgMHgxMDAwMDA0MSk7CgoJCS8qIEVu
YWJsZSBoYXJkd2FyZSBpbnRlcnJ1cHRzICovCgkJb3V0X2JlMzIoJmdwdC0+cmVncy0+bW9kZSwg
R1BUX01PREVfU1RPUF9DT05UIHwKCQkJR1BUX01PREVfSU5URU4gfCBHUFRfTU9ERV9USU1FUl9N
UyB8IEdQVF9NT0RFX0NFKTsKCQlvdXRfYmUzMigmZ3B0LT5yZWdzLT5tb2RlLCBpbl9iZTMyKCZn
cHQtPnJlZ3MtPm1vZGUpIHwgR1BUX01PREVfQ0UpOwoKCQlzcGluX3VubG9jaygmZ3B0LT5pb19s
b2NrKTsKCi8vCQkvLyBpL28gY29udHJvbAovLwkJbnAgPSBvZl9maW5kX2NvbXBhdGlibGVfbm9k
ZShOVUxMLCBOVUxMLCAiZnNsLG1wYzUxMjEtaW9jdGwiKTsKLy8JCWlmIChucCkgewovLwkJCWlv
Y3RsID0gb2ZfaW9tYXAobnAsIDApOwovLwkJCW9mX25vZGVfcHV0KG5wKTsgLy8gPz8/Ci8vCi8v
CQkJLy8gR1BJTzE0IGFuZCBHUElPMTUgb24gUFNDNiBwaW5zIDIgYW5kIDMKLy8JCQlvdXRfYmUz
Mihpb2N0bCArIElPQ1RMX1BTQzZfMiwgMHgwMDAwMDE4Myk7Ci8vCQkJb3V0X2JlMzIoaW9jdGwg
KyBJT0NUTF9QU0M2XzMsIDB4MDAwMDAxODMpOwovLwovLwkJCS8vIHdlIGRvIG5vdCBuZWVkIGlv
IGNvbnRyb2wgYW55bW9yZQovLwkJCWlvdW5tYXAoaW9jdGwpOwovLwkJfQovLwovLwkJLy8gZ3Bp
byBjb250cm9sCi8vCQlucCA9IG9mX2ZpbmRfY29tcGF0aWJsZV9ub2RlKE5VTEwsIE5VTEwsICJm
c2wsbXBjNTEyMS1ncGlvIik7Ci8vCQlpZiAobnApIHsKLy8JCQlncGlvY3RsID0gb2ZfaW9tYXAo
bnAsIDApOwovLwkJCW9mX25vZGVfcHV0KG5wKTsgLy8gPz8/Ci8vCQl9Ci8vCi8vCQlzZXRfcGlu
X2Rpcl9vdXRwdXQoMTQpOwoKCQlpZiAoIWVycikKCQkJcmV0dXJuIDA7CgoJCWlvdW5tYXAoZ3B0
LT5yZWdzKTsKCglvdXRfcmVsZWFzZToKCQlyZWxlYXNlX21lbV9yZWdpb24oZ3B0LT5tZW0uc3Rh
cnQsIHNpemUpOwoKCW91dF9mcmVlOgoJCWtmcmVlKGdwdCk7CgkJcmV0dXJuIGVycjsKCX0KCgll
bHNlIHJldHVybiAwOwp9CgpzdGF0aWMgaW50IF9fZGV2ZXhpdCBtcGM1MTIxX2dwdF9yZW1vdmUo
c3RydWN0IG9mX2RldmljZSAqb3ApCnsKCXByaW50aygibXBjNTEyMV9ncHRfcmVtb3ZlXG4iKTsK
CXJldHVybiAwOwp9CgpzdGF0aWMgc3RydWN0IG9mX2RldmljZV9pZCBtcGM1MTIxX2dwdF9tYXRj
aFtdID0gewoJeyAuY29tcGF0aWJsZSA9ICJmc2wsbXBjNTEyMS1ncHQiLCB9LAoJe30sCn07Cgpz
dGF0aWMgc3RydWN0IG9mX3BsYXRmb3JtX2RyaXZlciBtcGM1MTIxX2dwdF9kcml2ZXIgPSB7Cgku
b3duZXIgPSBUSElTX01PRFVMRSwKCS5uYW1lID0gIm1wYzUxMjEtZ3B0IiwKCS5tYXRjaF90YWJs
ZSA9IG1wYzUxMjFfZ3B0X21hdGNoLAoJLnByb2JlID0gbXBjNTEyMV9ncHRfcHJvYmUsCgkucmVt
b3ZlID0gbXBjNTEyMV9ncHRfcmVtb3ZlLAp9OwoKc3RhdGljIGludCBfX2luaXQgbXBjNTEyMV9n
cHRfaW5pdCh2b2lkKQp7CglwcmludGsoIm1wYzUxMjFfZ3B0X2luaXRcbiIpOwoJcmV0dXJuIG9m
X3JlZ2lzdGVyX3BsYXRmb3JtX2RyaXZlcigmbXBjNTEyMV9ncHRfZHJpdmVyKTsKfQoKc3RhdGlj
IHZvaWQgX19leGl0IG1wYzUxMjFfZ3B0X2V4aXQodm9pZCkKewoJcHJpbnRrKCJtcGM1MTIxX2dw
dF9leGl0XG4iKTsKLy8JcHJpbnRrKCJjb3VudDogJWRcbiIsIGNvdW50KTsKCW9mX3VucmVnaXN0
ZXJfcGxhdGZvcm1fZHJpdmVyKCZtcGM1MTIxX2dwdF9kcml2ZXIpOwp9CgpNT0RVTEVfTElDRU5T
RSgiR1BMIik7Ck1PRFVMRV9BVVRIT1IoIkFudG9uaW8gRGVsIENpbnF1ZSA8ZGVsY2lucXVlQGFy
Y2FlbWJlZGRlZC5pdD4iKTsKCm1vZHVsZV9pbml0KG1wYzUxMjFfZ3B0X2luaXQpOwptb2R1bGVf
ZXhpdChtcGM1MTIxX2dwdF9leGl0KTsK
------=_Part_10677_8719925.1220432733158--

