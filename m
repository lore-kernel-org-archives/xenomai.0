From: "Yan, Hongliang" <archer.hl.yan@intel.com>
Date: Thu, 7 Jun 2018 15:55:47 +0000
Message-ID: <9DA3CFDAD528B6408A6F2150A12D33CA51A776E1@SHSMSX103.ccr.corp.intel.com>
Content-Language: en-US
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Subject: [Xenomai] INTR-REMAP issue while enabling GPIO interrupt as RTDM
	interrupt
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "Xenomai@xenomai.org" <Xenomai@xenomai.org>

Hi All,
  I am trying to enable pinctrl-intel.c GPIO interrupt as RTDM interrupt. I=
 use rtdm_irq_request to replace devm_request_irq in probe function.
  code is as following:
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
#if 1
    if ((ret =3D rtdm_irq_request(&irq_rtdm,
                    irq, handler_interruption,
                    0,
                    "test", NULL)) !=3D 0) {
        printk("rtdm request error\n");
}

#else
    ret =3D devm_request_irq(pctrl->dev, irq, intel_gpio_irq, IRQF_SHARED,
                   dev_name(pctrl->dev), pctrl);
    if (ret) {
        dev_err(pctrl->dev, "failed to request interrupt\n");
        goto fail;
    }
#endif
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
  I check /proc/xenomai/irq, it shows GPIO interrupt has been registered as=
 XENOMAI interrupt.
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
[root@localhost devices]# cat /proc/xenomai/irq
  IRQ         CPU0        CPU1        CPU2        CPU3
   14:           0           0           0           0         test
4352:           0           0           0           0         [sync]
4353:           0           0           0           1         [reschedule]
4354:     1007738      987012     1007340     1082939         [timer/0]
4355:           1           1           0           1         [timer-ipi]
4419:           0           0           0           0         [virtual]
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
But once I trigger the GPIO interrupt, the interrupt handler can't be calle=
d. Instead, it shows:
<3>[  156.957511] DMAR: DRHD: handling fault status reg 2
<3>[  156.957541] DMAR: INTR-REMAP: Request device [[f0:1f.0] fault index 0
<3>[  156.957541] INTR-REMAP:[fault reason 37] Blocked a compatibility form=
at interrupt request

I also list lspci -v, there is no device named f0:1f.0.
Could someone help me with this? Did I miss something when request RTDM int=
errupt?

Best Regards,

Archer Yan
