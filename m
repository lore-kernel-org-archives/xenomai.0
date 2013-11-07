MIME-Version: 1.0
In-Reply-To: <a441383b612eacb044e6fa8abb015e84@grandegger.com>
References: <1383826877-8749-1-git-send-email-konradb3@gmail.com>
 <1383826877-8749-2-git-send-email-konradb3@gmail.com>
 <a441383b612eacb044e6fa8abb015e84@grandegger.com>
From: Konrad Banachowicz <konradb3@gmail.com>
Date: Thu, 7 Nov 2013 14:28:50 +0100
Message-ID: <CAJ2xAYGGdpVqJ_SH9XxzvWosG537G+o72e3y0Va5zTW7d9vLtQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Xenomai] [PATCH 2/2] rtcan/peek_pci: add support for 3 and 4
	port cards.
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Wolfgang Grandegger <wg@grandegger.com>
Cc: xenomai <xenomai@xenomai.org>

Hi Wolfgang,

I would say that it is done quite similar.
Maybe those defines (CHANNEL_SLAVE_2 ...) are misleading. The main
difference is that there is rtcan_peak_pci_add_chan(...) which is called in
loop in peak_pci_init_one(...) instead of putting all code here.
I left that this way to make may modification minimally invasive to
original code.

Pozdrawiam
Konrad Banachowicz


2013/11/7 Wolfgang Grandegger <wg@grandegger.com>

> Hi Konrad,
>
> could you please add 4 channel support as done for the corresponding Linux
> driver:
>
>   http://lxr.free-electrons.com/source/drivers/net/can/sja1000/peak_pci.c
>
> The master/slave approach is ugly and does not scale properly.
>
> On Thu,  7 Nov 2013 13:21:17 +0100, Konrad Banachowicz
> <konradb3@gmail.com> wrote:
> > ---
> >  ksrc/drivers/can/sja1000/rtcan_peak_pci.c |   61
> >  ++++++++++++++---------------
> >  1 file changed, 30 insertions(+), 31 deletions(-)
>
> Also please add a patch description next time.
>
> Thanks,
>
> Wolfgang.
>
>
