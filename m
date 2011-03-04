Date: Fri, 4 Mar 2011 09:30:30 +0100
From: Richard Cochran <richardcochran@domain.hid>
Message-ID: <20110304083030.GB12640@domain.hid>
References: <4D6E61B6.906@domain.hid> <4D6E8A06.9060508@domain.hid>
	<20110303072147.GA4353@domain.hid>
	<1299137548.2072.3.camel@domain.hid> <4D6F88D6.4010105@domain.hid>
	<4D6F89C8.9060005@domain.hid> <1299156880.2072.6.camel@domain.hid>
	<4D702802.5080001@domain.hid> <1299225060.2107.20.camel@domain.hid>
	<4D709E55.8010904@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4D709E55.8010904@domain.hid>
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

On Fri, Mar 04, 2011 at 09:09:57AM +0100, Jan Kiszka wrote:
> 
> I'm not disagreeing. I'm just betting that MSI will quickly gain
> relevance there as well - up to the point where first devices no longer
> include with INTx support (perfectly legal, but I haven't seen one yet).

IFAICT, PCIe cards are allowed, not required to offer INTx.

In my case, I already asked HW if they could enable INTx in the
design. The IP core would offer this, but there seems not to be
possible in combination with the particular SoC core attached.

So, for now, it looks like I will have to find a way to support MSI...

Richard

