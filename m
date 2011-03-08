Date: Tue, 8 Mar 2011 08:55:49 +0100
From: Richard Cochran <richardcochran@domain.hid>
Message-ID: <20110308075548.GA3186@domain.hid>
References: <20110303072147.GA4353@domain.hid>
	<1299137548.2072.3.camel@domain.hid> <4D6F88D6.4010105@domain.hid>
	<4D6F89C8.9060005@domain.hid> <1299156880.2072.6.camel@domain.hid>
	<4D702802.5080001@domain.hid> <1299225060.2107.20.camel@domain.hid>
	<20110307092604.GA21619@domain.hid>
	<1299515837.2088.47.camel@domain.hid>
	<20110307183348.GA3272@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20110307183348.GA3272@domain.hid>
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

On Mon, Mar 07, 2011 at 07:33:48PM +0100, Richard Cochran wrote:
> The only strange thing is that many more interrupts appear in
> /proc/interrupts than expected,

Actually, I lied.

I forgot how about a second interrupt source on this card. Every event
might raise two interrupts, but if they occur close together in time,
Linux sees only one in /proc/interrupts.

So, Philippe, it is working perfectly.

Thanks again,

Richard

