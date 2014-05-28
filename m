MIME-Version: 1.0
In-Reply-To: <BLU177-W1EDB4301D455B5829C7B7A03A0@phx.gbl>
References: <CAJX3k=V+ns3H49G+5HuoMjv6+16yeRLXzr=D6dryyQiuVoQ_dA@mail.gmail.com>
 <oq8uprt339.fsf@merlin.sez.to>
 <CAJX3k=X=SOD3P503WM226Qf9VLzMLrRC_3R91DYsBtkwLY5wVA@mail.gmail.com>
 <oq38fytytt.fsf@merlin.sez.to> <BLU177-W291D54AEABEF93CCC47D2AA03A0@phx.gbl>
 <CAJX3k=VQ9+gOqSMq7oJEasxj0+LjnARJEh+w4E+ZGdNZP12_LQ@mail.gmail.com>
 <oqwqd7s1pz.fsf@merlin.sez.to> <BLU177-W1EDB4301D455B5829C7B7A03A0@phx.gbl>
From: Manu S Madhav <manusmad@gmail.com>
Date: Wed, 28 May 2014 09:31:46 -0400
Message-ID: <CAJX3k=WxM7yw+-jRXGT8n=j+Nf7y1dn44TTNhsD5aRXT0qDVbQ@mail.gmail.com>
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

Thanks again for your suggestions and code samples. I hadn't realized the
two counters were two separate subdevices.

Turns out I was using lsampl_t instead of unsigned int for the instruction
data structure, and that messed up the clock source instruction. Normal
counting works for now, and I can even get by using that, since my encoder
is high resolution (5000 counts / rev). However, quadrature (and
particularly the index bit) would be really useful.

So I set the counter mode to QUADRATURE_X4_BITS | HW_UP_DOWN_BITS, disabled
both gates, and used A4L_INSN_CONFIG_SET_OTHER_SRC to set a,b sources
using, for e.g.:

    int a = 8;
    unsigned int data[3];
    a4l_insn_t insn;

    insn.type = A4L_INSN_CONFIG;
    insn.idx_subd = idx_subd_CNT;
    insn.chan_desc = 0;
    insn.data_size = sizeof(data[0])*3;

    data[0] = A4L_INSN_CONFIG_SET_OTHER_SRC;
    data[1] = NI_GPCT_SOURCE_ENCODER_A;
    data[2] = NI_GPCT_PFI_OTHER_SELECT(a);
    insn.data = data;

    a4l_snd_insn(&dsc, &insn)

Now the counter gives one value for clockwise rotation (e.g. 0) and another
for counterclockwise (e.g. 1). So clearly it is using both a and b inputs
to determine direction of rotation. And this happens regardless of whether
clock source is set or not.

Getting closer - any thoughts?


Manu S Madhav
Postdoctoral Associate
The Knierim Lab, Zanvyl Krieger Mind/Brain Institute,
LIMBS Lab, Mechanical Engineering Department
Johns Hopkins University
Baltimore, MD, USA 21218


On Tue, May 27, 2014 at 11:54 AM, Rosali Pyun <whimt@hotmail.com> wrote:

>
>
> > To: manusmad@gmail.com
> > From: pcj@xenomai.sez.to
> > Date: Tue, 27 May 2014 08:03:36 -0700
>
> > CC: xenomai@xenomai.org
> > Subject: Re: [Xenomai] Troubleshooting Analogy DIO
> >
> > Manu S Madhav <manusmad@gmail.com> writes:
> >
> > > counter is armed, when a +5V input is applied to PFI0. However, the
> value
> > > keeps decreasing as long as the input is connected, even though there
> is no
> > > edge. This does not happen when the counter is disarmed, and also the
> > > initial value is 0 when the counter is disarmed and then armed.
> >
> > You are counting ticks of the internal clock (20 MHz in the original
> > 6602), gated with PFI0. You need to CONFIG_SET_CLK_SRC to count an
> > external "clock" (edges).
> >
> > > Curiously, regardless of whether the chan_desc in the instructions say
> 0 or
> > > 1, it is counter 0 which seems to be affected. I cannot do anything
> with
> > > counter 1, reading it always gives me a value of 0.
> >
> > Counter 1 is one *subdev* up from counter 0, it is not the second
> > channel of subdev 2.
> >
> > -- Paul
>
> I am attaching a sample code, which is based on comedi example.
>
> As Paul said, for NI card, counter 0 is subdevice 11 and counter 1 is
> subdevice 12.
>
> I am not using GATE functionality at the moment.
> I also found out that P0.6 and P0.7 are UP/DOWN channel for counter 0 and
> counter 1. (at least for NI PCI 6629 card)
>
> I hope this helps.
>
> -Rosali
>
