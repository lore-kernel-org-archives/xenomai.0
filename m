Message-Id: <47C2AC8D0200000100192941@domain.hid>
Date: Mon, 25 Feb 2008 11:54:53 -0500
From: "Hubert Talbot" <Hubert.Talbot@domain.hid>
References: <47BED8A502000001001928B7@domain.hid>
	<47C278F3.1060309@domain.hid>
In-Reply-To: <47C278F3.1060309@domain.hid>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Subject: [Xenomai-help] =?iso-8859-15?q?R=E9p=2E_=3A_Re=3A__Non_RT_PCI_dev?=
 =?iso-8859-15?q?ice_driver_vs_interrupts_=28go_with_rtdm=2E=2E=2E=29?=
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

Hi Jan,

I am looking for realtime solution.

As I said before, I want to make a proof-of-concept with Xenomai.

Here is my use case:

A "Fluke 741B Documenting Process Calibrator"
(http://ca.fluke.com/caen/products/Fluke+741B.htm?catalog_name=3DFlukeCanad=
a&Category=3DPCL(FlukeProducts))=20
sends pusle to I/O Sensoray 626 card. On pulse reception, card generates =
interrupt which is processed by an rt_task.

The program is simple. Mainly, it initialzes the board and creates two =
rt_task.
One for interrupt processing and the other for "sleeping" (2 secs).

The interrupt processing rt_task looks like:

while (!end)
{
   rt_intr_wait();
   S626_InterruptStatus();
   if (status)
   {
      ++count;
   }
   S626_DIOCapReset()
   S626_InterruptEnable()
}

The calls to S626_ functions ends up to ioctl calls.

I think that calling these functions leads to execution mode switches.

Running program for different frequencies gives after two seconds:

     pulse (KHz)           count          expected        lost (%)
     =20
          1                      2001            2000               ---
          2                      3996            4000               0.1
          3                      5989            6000               0.18
          4                      7975            8000               0.3125
          5                      9581            10000             4.19
          12                    10454          24000             56.44
          20                    12058          40000             69.86

Processing interrupts is the first step of the proof-of-concept.


Thanks

Hubert


>>> Jan Kiszka <jan.kiszka@domain.hid> 2008-02-25 03:14 >>>
Hubert Talbot wrote:
> Finally, I got the precision I expected. The problem was on the way the =
results were reported.
>=20
> However, more the frequency of the pulse generator is raised, less the =
results are good.
>=20
> I think it is time to go with rtdm...

RTDM is no magic bullet /wrt latency or jitter. You should try to=20
understand what you are measuring first before blindly replacing=20
something. I'm surely not saying porting to RTDM is a bad idea, but I=20
may not help you with what you are actually looking for.

What do you mean with "less good"? What frequencies are we talking=20
about? What is the critical code path (already considered to use some=20
tracing tool for analysis?)?

Jan




