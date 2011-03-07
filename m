Date: Mon, 7 Mar 2011 19:33:48 +0100
From: Richard Cochran <richardcochran@domain.hid>
Message-ID: <20110307183348.GA3272@domain.hid>
References: <4D6E8A06.9060508@domain.hid>
	<20110303072147.GA4353@domain.hid>
	<1299137548.2072.3.camel@domain.hid> <4D6F88D6.4010105@domain.hid>
	<4D6F89C8.9060005@domain.hid> <1299156880.2072.6.camel@domain.hid>
	<4D702802.5080001@domain.hid> <1299225060.2107.20.camel@domain.hid>
	<20110307092604.GA21619@domain.hid>
	<1299515837.2088.47.camel@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1299515837.2088.47.camel@domain.hid>
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
To: Philippe Gerum <rpm@xenomai.org>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>, Jan Kiszka <jan.kiszka@domain.hid>

On Mon, Mar 07, 2011 at 05:37:17PM +0100, Philippe Gerum wrote:
> No, your logic is right. The fsl_msi handler is utterly wrong there.
> Please try the following patch (not even compiled, but should be mostly
> ok -- famous last words). You should scrap all I-pipe changes on
> arch/powerpc/sysdev/fsl_msi.c before applying it, it is based on the
> vanilla 2.6.36 code.

Yes! It works!

The only strange thing is that many more interrupts appear in
/proc/interrupts than expected, but that is way better than freezing
the box. I'll be testing this box a lot more in the coming days.

Thanks so much for the patch and explanation!

Richard

