From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <4D6F89C8.9060005@domain.hid>
References: <20110302151603.GA14557@domain.hid>
	<4D6E61B6.906@domain.hid> <4D6E8A06.9060508@domain.hid>
	<20110303072147.GA4353@domain.hid>
	<1299137548.2072.3.camel@domain.hid> <4D6F88D6.4010105@domain.hid>
	<4D6F89C8.9060005@domain.hid>
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 03 Mar 2011 13:54:40 +0100
Message-ID: <1299156880.2072.6.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Stuck MSI in normal Linux driver
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

On Thu, 2011-03-03 at 13:30 +0100, Jan Kiszka wrote:
> On 2011-03-03 13:25, Wolfgang Grandegger wrote:
> > Hi Philippe,
> > 
> > On 03/03/2011 08:32 AM, Philippe Gerum wrote:
> >> On Thu, 2011-03-03 at 08:21 +0100, Richard Cochran wrote:
> >>> On Wed, Mar 02, 2011 at 07:18:46PM +0100, Jan Kiszka wrote:
> >>>> On 2011-03-02 16:26, Gilles Chanteperdrix wrote:
> >>>>> Richard Cochran wrote:
> >>>>>> The wiki pages 
> >>>>>>
> >>>>>>    http://www.xenomai.org/index.php/FAQs
> >>>>>>    http://www.xenomai.org/index.php/Configuring_x86_kernels
> >>>>>>
> >>>>>> say not to enable MSI on x86, with a link to a very old (2008)
> >>>>>> discussion.
> >>>
> >>> ...
> >>>
> >>>> The current situation looks like this:
> >>>>  - MSI[-X] usage for plain Linux drivers is fine, we are using it on
> >>>>    machines where you can hardly avoid MSI today
> >>>>  - MSI[-X] usage for RTDM (ie. RT) drivers is basically fine as long as
> >>>>    you avoid enabling/disabling from RT context (also used for quite
> >>>>    a while here, no known issues under this restriction)
> >>>
> >>> Okay, so I understand from this:
> >>>
> >>> 1. The wiki warning is out of date.
> >>>
> >>> 2. My own PCIe MSI driver/card *should* work.
> >>>    (It is not a current known limitation of adeos/xenomai.)
> >>
> >> The situation is not that clear. Enabling CONFIG_PCI_MSI on some 83xx
> >> board did cause a lock up at boot for me, so this may point the finger
> >> at the pipeline core for ppc, and not to Xenomai which was barely active
> >> at that stage.
> > 
> > Now I remember vaguely that we have seen a similar issue on the mpc8308
> > in autumn last year. Here is what you wrote that time:
> > 
> > On 09/29/2010 04:12 PM, Philippe Gerum wrote:
> >> Ok, I have a good news: the issue is spotted; and a bad one: this is no
> >> trivial stuff to fix. In short, CONFIG_PCI_MSI causes the PIC code to
> >> read PCI config memory on the fly during operations (which is intensely
> >> insane but that is how it goes). Of course, it does that via the regular
> >> PCI helpers, which are stuffed with normal locking constructs we may
> >> _not_ call from any real-time/non-regular context.
> >>
> >> To sum up, we need to call those helpers to ack/mask interrupts within
> >> the I-pipe, but we are not allowed to do this because this is inherently
> >> unsafe.
> >>
> >> Work-around: disable CONFIG_PCI_MSI in your configuration.
> >> The real fix would require much more thought, to make the PCI helpers
> >> Adeos-aware without inducing high latency.
> 
> As MSIs are edge-triggered, only requiring ack at the interrupt
> controller level, could it be that PPC is using the wrong flow handler here?

The pipeline forces mask/ack to prevent adverse effect of deferred
delivery to downstream handlers. Some chips require this.

> 
> Jan
> 

-- 
Philippe.



