Message-ID: <44DCED2B.5000407@domain.hid>
Date: Fri, 11 Aug 2006 22:48:43 +0200
From: Wolfgang Grandegger <wg@domain.hid>
MIME-Version: 1.0
References: <44DCA9DC.1000509@domain.hid>
In-Reply-To: <44DCA9DC.1000509@domain.hid>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-core] Re: CAN stack merged
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: xenomai-help <xenomai@xenomai.org>, xenomai-core <xenomai@xenomai.org>

Hi Jan,

Jan Kiszka wrote:
> Hi all,
> 
> I just hit enter, and all the nice CAN code is now in SVN head. We only
> need a check-in of a bootstrap run with the fitting autotool versions.
> Philippe, could you do this? [Meanwhile, one can also run it locally
> after checking out from SVN.]

Great. I gave it a quick try and it builds and works fine.

> Both the drivers and the tools were merged. You find the latter under
> src/utils/can. rtcanconfig will be installed to <prefix>/sbin,
> rtcansend/resc go to <prefix>/bin.
> 
> Wolfgang suggested to collect driver documentation under doc/drivers/,
> maybe this is better than having it in the driver's source directory (or
> under doc/txt like for irqbench or 16550A).
> 
> The utils README should be converted to man pages. Unless Wolfgang
> already started this (but he didn't sound like that ;) ): anyone willing
> to volunteer?

I'm willing to volunteer.

> Many thanks again to the contributors of RT-Socket-CAN! I'm convinced
> this is a significant milestone for CAN support under real-time Linux in
> general and, of course, specifically under Xenomai.

Thanks for your work as well.

I have already a few patches ready but next week I will be on holiday :-).

Have a nice weekend.

Wolfgang.







