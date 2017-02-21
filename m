MIME-Version: 1.0
From: Norbert Lange <nolange79@gmail.com>
Date: Tue, 21 Feb 2017 19:37:26 +0100
Message-ID: <CADYdroOG6RaLGmcpwFiHjJt-cU3f9vaCQw+vJ=tFdx3sg4nvhg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: [Xenomai] latency test and mercury
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Xenomai <xenomai@xenomai.org>

Hi,

I got some really big variations on the latency test (up to 4ms), but
I am not exactly sure if this supposed the realtime portion.
I am unable to run kernel or irq tests.

For a user thread, this is probably like expected since this is a full
debian desktop with RT kernel.

If I understood the mercury model right, I could create kernel modules
with realtime behaviour, Is there any test for latency amongst those?
(Documentation is rather light on mercury)

PS.
I can rule out SMI interaction, the count of those is not increasing.

Kind regards,
Norbert

