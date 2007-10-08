Message-ID: <470A6B28.7020009@domain.hid>
Date: Mon, 08 Oct 2007 19:38:48 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <bc4264770710081022n71a97a91m6d839ab1e27cb54@domain.hid>
In-Reply-To: <bc4264770710081022n71a97a91m6d839ab1e27cb54@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] adeos patch for 2.6.21
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: roland Tollenaar <rolandtollenaar@domain.hid>
Cc: xenomai-help <xenomai@xenomai.org>

roland Tollenaar wrote:
> Hi,
> 
> just a repeat of a mail I sent to the adeos emergency center a couple
> of minutes ago.

"Thank you for calling the emergency centre. We are busy, please leave
your report after the signal."

> 
> I have a kernel 2.6.21 but there is no adeos patch for that kernel.
> 
> which adeos patch must I use?

There is none for this kernel on i386 (assuming this is your arch). The
easiest thing is to move forward to 2.6.22 - or you would have to
back-port that patch... ;)

> 
> I am planning to apply xenomai 2.4 just in case this has any effect on
> the choice of adeos.

Xenomai 2.4 is required for kernels beyond 2.6.20 anyway.

But note that we are still sweeping out remaining bugs around this
kernel, see "Fix __ipipe_pin_range_globally" and "IO-APIC stall due to
broken fasteoi handling" on Xenomai-core / Adeos-main. Moreover, today's
SVN breaks at least my test box. So you may want to wait a few days at
least, until the dust (hopefully) settled down again.

Jan

-- 
Siemens AG, Corporate Technology, CT SE 2
Corporate Competence Center Embedded Linux

