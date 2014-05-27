References: <CAJX3k=V+ns3H49G+5HuoMjv6+16yeRLXzr=D6dryyQiuVoQ_dA@mail.gmail.com>
 <oq8uprt339.fsf@merlin.sez.to>
 <CAJX3k=X=SOD3P503WM226Qf9VLzMLrRC_3R91DYsBtkwLY5wVA@mail.gmail.com>
 <oq38fytytt.fsf@merlin.sez.to>
 <BLU177-W291D54AEABEF93CCC47D2AA03A0@phx.gbl>
 <CAJX3k=VQ9+gOqSMq7oJEasxj0+LjnARJEh+w4E+ZGdNZP12_LQ@mail.gmail.com>
From: Paul Janzen <pcj@xenomai.sez.to>
Date: Tue, 27 May 2014 08:03:36 -0700
In-Reply-To: <CAJX3k=VQ9+gOqSMq7oJEasxj0+LjnARJEh+w4E+ZGdNZP12_LQ@mail.gmail.com> (Manu S.
 Madhav's message of "Tue, 27 May 2014 10:42:15 -0400")
Message-ID: <oqwqd7s1pz.fsf@merlin.sez.to>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
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

Manu S Madhav <manusmad@gmail.com> writes:

> counter is armed, when a +5V input is applied to PFI0. However, the value
> keeps decreasing as long as the input is connected, even though there is no
> edge. This does not happen when the counter is disarmed, and also the
> initial value is 0 when the counter is disarmed and then armed.

You are counting ticks of the internal clock (20 MHz in the original
6602), gated with PFI0. You need to CONFIG_SET_CLK_SRC to count an
external "clock" (edges).

> Curiously, regardless of whether the chan_desc in the instructions say 0 or
> 1, it is counter 0 which seems to be affected. I cannot do anything with
> counter 1, reading it always gives me a value of 0.

Counter 1 is one *subdev* up from counter 0, it is not the second
channel of subdev 2. 

-- Paul


