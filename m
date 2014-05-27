MIME-Version: 1.0
In-Reply-To: <BLU177-W291D54AEABEF93CCC47D2AA03A0@phx.gbl>
References: <CAJX3k=V+ns3H49G+5HuoMjv6+16yeRLXzr=D6dryyQiuVoQ_dA@mail.gmail.com>
 <oq8uprt339.fsf@merlin.sez.to>
 <CAJX3k=X=SOD3P503WM226Qf9VLzMLrRC_3R91DYsBtkwLY5wVA@mail.gmail.com>
 <oq38fytytt.fsf@merlin.sez.to> <BLU177-W291D54AEABEF93CCC47D2AA03A0@phx.gbl>
From: Manu S Madhav <manusmad@gmail.com>
Date: Tue, 27 May 2014 10:42:15 -0400
Message-ID: <CAJX3k=VQ9+gOqSMq7oJEasxj0+LjnARJEh+w4E+ZGdNZP12_LQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Xenomai] Troubleshooting Analogy DIO
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Rosali Pyun <whimt@hotmail.com>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

Hey Rosali, Paul,

Thanks for the information. I have been trying to do this, using your
instructions as well as gpct_encoder.c from comedi, and also code from
people who have implemented it in Analogy (on 660x DAQs). The attempts have
been a complete bust so far.

I am able to disarm and arm the counter, and this I know because when I
read from counter 0 (using a4l_sync_read), the value is decremented if the
counter is armed, when a +5V input is applied to PFI0. However, the value
keeps decreasing as long as the input is connected, even though there is no
edge. This does not happen when the counter is disarmed, and also the
initial value is 0 when the counter is disarmed and then armed.

This is the only behavior I am able to produce from the counter. I have
tried using both QUADRATURE_X4_BITS and NORMAL_BITS, as well as a
combination of other things. I don't seem to be able to set the mode of the
counter properly.

Curiously, regardless of whether the chan_desc in the instructions say 0 or
1, it is counter 0 which seems to be affected. I cannot do anything with
counter 1, reading it always gives me a value of 0.

Rosali, do you have some sample code I can test? Even with NORMAL_BITS, I
would think the counter should decrement (or increment) only a single time
a +5V input is connected.

Manu S Madhav
Postdoctoral Associate
The Knierim Lab, Zanvyl Krieger Mind/Brain Institute,
LIMBS Lab, Mechanical Engineering Department
Johns Hopkins University
Baltimore, MD, USA 21218


On Tue, May 27, 2014 at 8:56 AM, Rosali Pyun <whimt@hotmail.com> wrote:

>
>
> > To: manusmad@gmail.com
> > From: pcj@xenomai.sez.to
> > Date: Sat, 24 May 2014 18:46:22 -0700
> > CC: xenomai@xenomai.org
> > Subject: Re: [Xenomai] Troubleshooting Analogy DIO
>
> >
> > Manu S Madhav <manusmad@gmail.com> writes:
> >
> > > One more question: Is anyone aware of an analogy implementation for
> > > using the DAQ counter for quadrature encoding? E.g. by using the
> > > A4L_INSN_CONFIG_GPCT_QUADRATURE_ENCODER instruction.
> >
> > I know it works in Comedi, but have not tried it in Analogy. You may
> > have to snarf some bit definitions from comedi.
> >
> > Try INSN_CONFIG, with two data
> > { A4L_INSN_CONFIG_SET_COUNTER_MODE,
> > NI_GPCT_COUNTING_MODE_QUADRATURE_X4_BITS |
> > NI_GPCT_COUNTING_DIRECTION_HW_UP_DOWN_BITS
> > }
> >
> > and then again to arm the counter:
> > { A4L_INSN_CONFIG_ARM, NI_GPCT_ARM_IMMEDIATE }
> >
> > Then you should be able to get the counter value back with
> > a4l_sync_read.
> >
> > A4L_INSN_CONFIG_GPCT_QUADRATURE_ENCODER appears to be a half-baked
> > sensoray only thing.
> >
> > -- Paul
> >
>
>
> I was not able to use the counter for quadrature encoder with NI m-series
> DAQ card.
> I ended up using "quadrature clock converter" chip along with the encoder
> and implemented simple counting functionality.
>
> INSN_CONFIG with
> {A4L_INSN_CONFIG_SET_COUNTER_MODE,
> NI_GPCT_COUNTING_MODE_NORMAL_BITS |
> NI_GPCT_COUNTING_DIRECTION_HW_UP_DOWN_BITS
> }
>
> Let me know if you have any luck with quadrature encoder mode.
>
> -Rosali
>
