From: "Chen, Hongzhan" <hongzhan.chen@intel.com>
Subject: double enable_irq called in request_gpio_irq of
 kernel/drivers/gpio/gpio-core.c on dovetail-based xenomai
Date: Tue, 16 Mar 2021 06:09:10 +0000
Message-ID: <MWHPR11MB1710B256F2EA5537B38C8591F26B9@MWHPR11MB1710.namprd11.prod.outlook.com>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "xenomai@xenomai.org" <xenomai@xenomai.org>

Hi Philippe,

When I validate latmus on dovetailed-based xenomai, I found that enable_irq=
 would be called=20
twice in request_gpio_irq because xnintr_enable would be called by both rtd=
m_irq_request=20
and rtdm_irq_enable but  xnintr_enable  directly call enable_irq.  IPIPE  s=
eems to test=20
XN_IRQSTAT_DISABLED bit to avoid repeated calling ipipe_enable_irq.  May we=
 use same method
like ipipe is handling  XN_IRQSTAT_DISABLED  in xnintr_enable  and xnintr_d=
isable  to fix this such issue?


Regards

Hongzhan Chen


