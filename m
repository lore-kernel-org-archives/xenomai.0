Date: Thu, 18 Nov 2021 00:09:14 +0100
From: Henning Schild <henning.schild@siemens.com>
Subject: Re: l2reflect - network-based I/O latency benchmark
Message-ID: <20211118000914.677d12a2@md1za8fc.ad001.siemens.net>
In-Reply-To: <ab49288f-2a12-4549-a335-5329a22d1585@siemens.com>
References: <ab49288f-2a12-4549-a335-5329a22d1585@siemens.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jan Kiszka via Xenomai <xenomai@xenomai.org>
Cc: Jan Kiszka <jan.kiszka@siemens.com>, "Moessbauer, Felix (CT RDA IOT
 SES-DE)" <felix.moessbauer@siemens.com>

Am Wed, 24 Mar 2021 12:11:27 +0100
schrieb Jan Kiszka via Xenomai <xenomai@xenomai.org>:

> Hi all,
> 
> as we discussed today in the community call how to use a network link
> to benchmark Xenomai I/O, here is the link to our work for a different
> activity that we shared with the dpdk community:
> 
> http://mails.dpdk.org/archives/dev/2020-September/181035.html
> 
> Being DPDK, this comes without interrupts, but that might be
> extensible. There are minor updates available internally, so let us
> know if interest is concrete, then we can refresh this.

In fact the version posted there has interrupts if one wants. We
started off with polling only but decided to add interrupts for the
mainlining.
We hope to eventually succeed with mainline. More stakeholders asking
for a "cyclictest" for ethernet I/O could help.
There is not much internal stuff we did not yet publish, a bit of
advanced tracing which can be regarded optional for the first round.
And a bit of linux-bridge support which so far did not result in
promising results (low latency) and will need more investigation.

All the internal bits can be shared any time but simply did not yet
work well enough to propose them for mainline.

Henning

> Jan
> 


