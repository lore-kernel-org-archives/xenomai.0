Date: Thu, 16 Apr 2015 14:26:19 +0200
From: "Mariusz Janiak" <mariuszjaniak@wp.pl>
Message-ID: <552faa6bf2d134.92118662@wp.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai] Rtnet e1000e 82583: slow writel(tx_ring->tail),
 takes above 1us?
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Zhoupeng <zhoupeng1982@qq.com>
Cc: xenomai <xenomai@xenomai.org>

Dnia Czwartek, 16 Kwietnia 2015 13:30 Zhoupeng <zhoupeng1982@qq.com> napisa=
=B3(a) =

> I'm using Rtnet with 82583 ethernet card.
> It takes about 2us to send AF_PACKET using rt_dev_sendmsg(), about 200 by=
tes of data.
> =

> It is pretty fast, but I want to find what takes so long.
> At last I find that "writel(tx_ring-&gt;tail)" spend above 1us to complet=
e.
> =

> This is just MMIO write to 82583, of course MMIO is uncache.
> And PCIE ASPM is disabled, so L0s is not the problem.
> =

> I think PCIE Memory Write TLPs is fast enough, but why spend so much time?

Hi,

There is an interesting article that may be relevant to this issue

"PCI Express as a Killer of Software-based Real-Time Ethernet"

You can find copy in the attachment. =


Best
Mariusz


 =

> thanks,
> _______________________________________________
> Xenomai mailing list
> Xenomai@xenomai.org
> http://www.xenomai.org/mailman/listinfo/xenomai

-------------- next part --------------
A non-text attachment was scrubbed...
Name: rteth_hw_eval.pdf
Type: application/x-unknown
Size: 875870 bytes
Desc: not available
URL: <http://www.xenomai.org/pipermail/xenomai/attachments/20150416/f9dc8e9=
7/attachment.bin>
