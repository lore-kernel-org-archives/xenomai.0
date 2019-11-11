MIME-Version: 1.0
References: <CABe-JLW82TeFyeL5Eft07XZWp1gY1o=aXXv60zCq6JA3vvKfeg@mail.gmail.com>
 <9347077a-804c-19cc-1a59-3506cd704584@siemens.com>
In-Reply-To: <9347077a-804c-19cc-1a59-3506cd704584@siemens.com>
From: Luca Barisani <lcbarisa@gmail.com>
Date: Mon, 11 Nov 2019 09:46:33 +0100
Message-ID: <CABe-JLWy2uHZ_a4UD+77AP1o14e5sDKu+GiogevR1nnu-H8aSg@mail.gmail.com>
Subject: Re: rtnet increase default mtu
Content-Type: text/plain; charset="UTF-8"
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Ok, thanks anyway. I thought it was possible since I found in
ipv4/ip_fragment.c some functions already implemented in that direction.

Luca

Il giorno lun 11 nov 2019 alle ore 08:00 Jan Kiszka <jan.kiszka@siemens.com>
ha scritto:

> On 09.11.19 10:23, Luca Barisani via Xenomai wrote:
> > Hi,
> >
> > I'm testing xenomai 3.1.0-rc2+linux kernel 4.19 with rtnet.
> > The application sends udp packets between a small number of units (intel
> > celeron/i5), some with an e1000 and others with igb (i210), connected
> > to the same switch and isolated from the rest of the network.
> > Rtnet is loaded without tdma support, I'm using nomac and so far all is
> > working fine. However, I was wondering if it could be possible to
> increase
> > mtu default value of 1500 to improve bandwidth.
> > I could not find any mtu option within rtifconfig, so I'm asking if this
> > value is fixed by design, maybe to avoid ip fragmentation, or there are
> > some ways to change its size.
>
> MTU modification is not available. That used to be by design as RTnet
> builds upon statically sized (and allocated) buffers. Modern NICs could
> likely spread jumbo frames over multiple buffers, so it should work -
> but the infrastructure is missing.
>
> Jan
>
> --
> Siemens AG, Corporate Technology, CT RDA IOT SES-DE
> Corporate Competence Center Embedded Linux
>
