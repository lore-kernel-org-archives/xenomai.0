Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 11 Feb 2009 19:40:19 -0000
Message-ID: <4B3F8896E1733D4787DDB0EA1C7FF91F704A7F@ukmail.uk.wirelessworld.airvananet.com>
From: "Mike McTernan" <mmcternan@domain.hid>
Subject: [Xenomai-help] Massive improvement when Xenomai patched
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

Hi,

I've patched Blackfin uClinux 2008R1.5 with Adeos and Xenomai 2.4.6.1
and started benchmarking our system.  At this point the apps are
unmodified and I only change between a Xenomai enabled kernel and an
unmodified kernel.  This is verified by checking the boot messages and
the process list under /proc/xenomai/stats.

The critical app creates a thread to service a level sensitive interrupt
in user-space via a device driver.  The driver is a Linux char device,
the guts being:

    static irqreturn_t fpgairq_handler(int irq, void *p)
    {
        /* Disable this interrupt */
        disable_irq_nosync(irq);

        /* Enable any blocked task to run */
        fpgairq_waitcond =3D 1;
        wake_up_interruptible(&fpgairq_waitq);

        return IRQ_HANDLED;
    }

    static ssize_t fpgairq_read(struct file *filp, char *buf, size_t
size, loff_t *offp)
    {
        const int irq =3D gpio_to_irq(PIN_IRQ);

        ....

        /* Clear the wait condition */
        fpgairq_waitcond =3D 0;

        /* Enable the interrupt source */
        enable_irq(irq);

        /* Now wait for an interrupt */
        wait_event_interruptible(fpgairq_waitq, fpgairq_waitcond !=3D =
0);

        /* The interrupt handler will have disabled the interrupt again
*/

        return size;
    }
   =20
The user-space code sets it's pthread_setschedparam() to SCHED_FIFO with
a high priority.  It then loops, reading from the device to wait for the
next interrupt and then writes via a different device to acknowledge the
external interrupt source.  Measuring the duration for which the line is
asserted gives the time between the interrupt being asserted and it
being acknowledged.

I made measurements over ~2000 sweeps on a scope with the unpatched and
patched kernel, both when otherwise idle and then when under load.  To
create load I execute the following line on a telnet session:

  $ while true; do ls -l /mnt; done
 =20
The results:

  Configuration                    Duration (uS)
                           Min       Mean      Max
  Vanilla                  9.9       16.8     30.8
  Xenomai Kernel          19.0       27.5     50.4
  Vanilla + load          10.9    11017.4  19619.7
  Xenomai Kernel + load   59.4      215.5   1849.8

Clearly Xenomai appears to add some overhead to the interrupt handling
and acknowledgement.  That's to be expected as the apps are executing in
the secondary and the drivers are not RTDM, and the overhead is very
small in anycase.

But I don't understand why under load the scheduling of the non-Xenomai
task is so much improved.  The worst case is more than x10 better, the
average case x50.  It's incredible!

Is this to be expected?

Regards,

Mike



