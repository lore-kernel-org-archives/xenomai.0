MIME-Version: 1.0
In-Reply-To: <CAFjt0OkDDODSAjwBC6QJ4wMyae6RnzRhqKhgT7y0qqs1tPwc7g@mail.gmail.com>
References: <CAFjt0OkDDODSAjwBC6QJ4wMyae6RnzRhqKhgT7y0qqs1tPwc7g@mail.gmail.com>
From: Adam Vaughan <vaughana@umich.edu>
Date: Thu, 27 Apr 2017 09:09:09 -0700
Message-ID: <CAK4EZFS9BOuZWAno7ZAp=wmnue-3qh_sd601Z4THTdu72=cACQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai] RPi: Possible solution for freezes
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: =?UTF-8?Q?Geber_Villa_Fern=C3=A1ndez?= <gebervf@gmail.com>
Cc: john.gwynne@matrixresearch.com, "xenomai@xenomai.org" <xenomai@xenomai.org>

Hi Gerber,

I haven't tried Xenomai on the RPi in a few years (I've been working
on BeagleBone Xenomai lately), but I have experimented with Xenomai
2.6 patches on the RPi 1 in the configuration you describe.

There's more detail in section 7.5 in my dissertation [1], but I
strongly suggest checking that the USB driver isn't affecting your
overall system latency numbers under load.  Under heavy USB Ethernet
usage with the FIQ turned off I measured system stalls of up to 15
milliseconds under Xenomai with an oscilloscope.

The only fix I had for this was to use PREEMPT_RT to lower the USB
driver thread priority.  At the time, I couldn't get PREEMPT_RT
patches to cleanly apply to the available Xenomai kernel patches, so I
ended up just using PREEMPT_RT exclusively.  This patch situation is
likely different these days.

-Adam

[1] https://deepblue.lib.umich.edu/handle/2027.42/111333

On Thu, Apr 27, 2017 at 2:17 AM, Geber Villa Fern=C3=A1ndez
<gebervf@gmail.com> wrote:
> I was having the same problem of freezes in RPi (RPi3 in this case) for
> quite some time as explained in the following topic (kernel 4.1.21 with
> xenomai 3.0.3):
> http://www.xenomai.org/pipermail/xenomai/2017-February/037090.html
>
> I think that I achieved to solve the problem by disabling the FIQ
> capabilities of the USB driver. There are problems by using the FIQ USB
> driver with RT patches as shown in:
> https://community.emlid.com/t/rpi-2-fiq-usb-driver-problems/508/8
> https://www.raspberrypi.org/forums/viewtopic.php?f=3D29&t=3D39951&start=
=3D75
>
> The solution is as simple as adding the following parameters in the
> "cmdline.txt" file in the boot partition:
> dwc_otg.fiq_enable=3D0 dwc_otg.fiq_fsm_enable=3D0 dwc_otg.nak_holdoff=3D0
>
> If these parameters are loaded, introducing "dmesg | grep dwc_otg" in a
> terminal (e.g. by SSH) will give you the following information:
> [    0.511322] dwc_otg: FIQ disabled
> [    0.511327] dwc_otg: NAK holdoff disabled
> [    0.511331] dwc_otg: FIQ split-transaction FSM disabled
>
> I was doing several tests which consist of copying several folders with
> GBs of data from a PC to the RPi SD through WiFi (using rsync). With the
> USB FIQ driver, RPi freezes after some time (less than an hour). Without
> the USB FIQ driver, I have not had any freeze at the moment.
>
> More info about this driver (USB FIQ) can be obtained in:
> https://www.raspberrypi.org/forums/viewtopic.php?t=3D70437
>
> Regards,
> Geber
>
> _______________________________________________
> Xenomai mailing list
> Xenomai@xenomai.org
> https://xenomai.org/mailman/listinfo/xenomai

