Message-ID: <BLU177-W1EDB4301D455B5829C7B7A03A0@phx.gbl>
From: Rosali Pyun <whimt@hotmail.com>
Date: Tue, 27 May 2014 15:54:18 +0000
In-Reply-To: <oqwqd7s1pz.fsf@merlin.sez.to>
References: <CAJX3k=V+ns3H49G+5HuoMjv6+16yeRLXzr=D6dryyQiuVoQ_dA@mail.gmail.com>,
 <oq8uprt339.fsf@merlin.sez.to>,
 <CAJX3k=X=SOD3P503WM226Qf9VLzMLrRC_3R91DYsBtkwLY5wVA@mail.gmail.com>,
 <oq38fytytt.fsf@merlin.sez.to>, <BLU177-W291D54AEABEF93CCC47D2AA03A0@phx.gbl>,
 <CAJX3k=VQ9+gOqSMq7oJEasxj0+LjnARJEh+w4E+ZGdNZP12_LQ@mail.gmail.com>,
 <oqwqd7s1pz.fsf@merlin.sez.to>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai] Troubleshooting Analogy DIO
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Manu S Madhav <manusmad@gmail.com>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>



> To: manusmad@gmail.com
> From: pcj@xenomai.sez.to
> Date: Tue, 27 May 2014 08:03:36 -0700
> CC: xenomai@xenomai.org
> Subject: Re: [Xenomai] Troubleshooting Analogy DIO
> =

> Manu S Madhav <manusmad@gmail.com> writes:
> =

> > counter is armed, when a +5V input is applied to PFI0. However, the val=
ue
> > keeps decreasing as long as the input is connected, even though there i=
s no
> > edge. This does not happen when the counter is disarmed, and also the
> > initial value is 0 when the counter is disarmed and then armed.
> =

> You are counting ticks of the internal clock (20 MHz in the original
> 6602), gated with PFI0. You need to CONFIG_SET_CLK_SRC to count an
> external "clock" (edges).
> =

> > Curiously, regardless of whether the chan_desc in the instructions say =
0 or
> > 1, it is counter 0 which seems to be affected. I cannot do anything with
> > counter 1, reading it always gives me a value of 0.
> =

> Counter 1 is one *subdev* up from counter 0, it is not the second
> channel of subdev 2. =

> =

> -- Paul

I am attaching a sample code, which is based on comedi example.
As Paul said, for NI card, counter 0 is subdevice 11 and counter 1 is subde=
vice 12.
I am not using GATE functionality at the moment.I also found out that P0.6 =
and P0.7 are UP/DOWN channel for counter 0 and counter 1. (at least for NI =
PCI 6629 card)
I hope this helps.
-Rosali 		 	   		  =

-------------- next part --------------
A non-text attachment was scrubbed...
Name: counter.cpp
Type: text/x-c
Size: 5432 bytes
Desc: not available
URL: <http://www.xenomai.org/pipermail/xenomai/attachments/20140527/e73d559=
f/attachment.bin>
