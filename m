Date: Thu, 3 Mar 2011 08:21:47 +0100
From: Richard Cochran <richardcochran@domain.hid>
Message-ID: <20110303072147.GA4353@domain.hid>
References: <20110302151603.GA14557@domain.hid>
	<4D6E61B6.906@domain.hid> <4D6E8A06.9060508@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4D6E8A06.9060508@domain.hid>
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
Cc: xenomai@xenomai.org

On Wed, Mar 02, 2011 at 07:18:46PM +0100, Jan Kiszka wrote:
> On 2011-03-02 16:26, Gilles Chanteperdrix wrote:
> > Richard Cochran wrote:
> >> The wiki pages 
> >>
> >>    http://www.xenomai.org/index.php/FAQs
> >>    http://www.xenomai.org/index.php/Configuring_x86_kernels
> >>
> >> say not to enable MSI on x86, with a link to a very old (2008)
> >> discussion.

...

> The current situation looks like this:
>  - MSI[-X] usage for plain Linux drivers is fine, we are using it on
>    machines where you can hardly avoid MSI today
>  - MSI[-X] usage for RTDM (ie. RT) drivers is basically fine as long as
>    you avoid enabling/disabling from RT context (also used for quite
>    a while here, no known issues under this restriction)

Okay, so I understand from this:

1. The wiki warning is out of date.

2. My own PCIe MSI driver/card *should* work.
   (It is not a current known limitation of adeos/xenomai.)

Thanks,

Richard

