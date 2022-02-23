From: "Chen, Hongzhan" <hongzhan.chen@intel.com>
Subject: RE: Realtime interrupt handling in driver
Date: Wed, 23 Feb 2022 06:12:56 +0000
Message-ID: <MN2PR11MB428557C85FD4DEE36A9E52FFF23C9@MN2PR11MB4285.namprd11.prod.outlook.com>
References: <PH1P110MB1050BF72127DFC0CE3440B64E23C9@PH1P110MB1050.NAMP110.PROD.OUTLOOK.COM>
In-Reply-To: <PH1P110MB1050BF72127DFC0CE3440B64E23C9@PH1P110MB1050.NAMP110.PROD.OUTLOOK.COM>
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
To: Russell Johnson <russell.johnson@kratosdefense.com>, "xenomai@xenomai.org" <xenomai@xenomai.org>

>-----Original Message-----
>From: Xenomai <xenomai-bounces@xenomai.org> On Behalf Of Russell Johnson v=
ia Xenomai
>Sent: Wednesday, February 23, 2022 8:10 AM
>To: xenomai@xenomai.org
>Subject: Realtime interrupt handling in driver
>
>Hello,
>
>In my driver that I have been converting to support OOB functionality with=
 the EVL core,=20
>I have an interrupt handler that handles all interrupts from a device sitt=
ing on the PCIe bus.
>I was reading through the information on your wiki about interrupt pipelin=
ing in Dovetail.=20
>I was confused a bit on if there is work that I need to do in order to get=
 interrupts & interrupt=20
>handlers to run out-of-band (and not be preempted by in-band linux process=
ing), or if the EVL core=20

It was supposed that you already went through introduction about dovetail i=
rq handling and request irq=20
for your driver as described in  [1]. Dovetail would handle oob interrupt a=
fter then per my understanding.

Regards

Hongzhan Chen

[1]: https://evlproject.org/dovetail/pipeline/irq_handling/

>takes care of that for me? If there is work I need to do with interrupt co=
nfig & interrupt handlers=20
>in order to make them able to run out-of-band, where do I need to start?
>
>Thanks!
>
>Russell
>

