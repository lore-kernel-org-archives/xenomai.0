From: Wolfgang Denk <wd@domain.hid>
MIME-Version: 1.0
Content-type: text/plain; charset=ISO-8859-1
Content-transfer-encoding: 8bit
In-reply-to: <AANLkTi=C3FQ_Cms9qanmc1dgMgSvMC1Rrt-0X0tOPZMp@domain.hid>
References: <AANLkTikiCm5B-KwteOfzTwtCV8RXj1QFgfQCAmCCoC8V@mail.gmail.com>
	<20101220154041.48C75CDE29A@gemini.denx.de>
	<AANLkTi=C3FQ_Cms9qanmc1dgMgSvMC1Rrt-0X0tOPZMp@domain.hid>
Date: Tue, 15 Feb 2011 21:07:53 +0100
Message-Id: <20110215200753.C4B6C146940@domain.hid>
Subject: Re: [Xenomai-help] Xenomai on Freescale iMX35
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Marten Lootsma <m.lootsma@domain.hid>
Cc: xenomai@xenomai.org

Dear Marten,

In message <AANLkTi=C3FQ_Cms9qanmc1dgMgSvMC1Rrt-0X0tOPZMp@domain.hid> you wrote:
>
> Thank you for your answer. If I understood correctly the Freescale kernel
> development has been added to the mailline kernel tree:
> http://opensource.freescale.com/git?p=imx/linux-2.6-imx.git;a=summary
> http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=tree;f=arch/arm/mach-mx3;h=8021c7efda789b8fe5ae3e896b62ae125b231958;hb=795abaf1e4e188c4171e3cd3dbb11a9fcacaf505
> 
> Is this what you meant?

Oops?  What makes you think so?  

There are ongoing efforts to get support for the i.MX family into the
mainline kernel tree, but I don't see any of the Freescale LTIB code
being added, nor can I see that Freescale updated their LTIB support
to a recent version.

The most recent LTIB version is tagged as rel_imx_2.6.35_11.01.00 (see
http://opensource.freescale.com/git?p=imx/linux-2.6-imx.git;a=commit;h=27fdf7bae11978d21e8aba09bb635f49b07edd4a)
which is based on a v2.6.35.3 kernel tree (i. e. 3 kernel versions behind),
on top of which 744 Freescale-specific patches are applied.

It is these 744 patches that make the difference between Freescale's
LTIB tree amd mainline.

It appears there is still a _long_ way to go, not to mention that
they have to catch up for three versions.

> Can you inform me on the particular things that need to be done (or point me
> to the information), and what is approximately the development time needed.

Time needed to develop what exactly?

Best regards,

Wolfgang Denk

-- 
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@domain.hid
The ultimate barrier is one's viewpoint.
                        - Terry Pratchett, _The Dark Side of the Sun_

