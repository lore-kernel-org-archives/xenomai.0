Message-ID: <2ff1a98a0709200252t7bbab6a5s9af94c09c18c8546@domain.hid>
Date: Thu, 20 Sep 2007 11:52:02 +0200
From: "Gilles Chanteperdrix" <gilles.chanteperdrix@xenomai.org>
In-Reply-To: <46F231E8.7050804@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <46F231E8.7050804@domain.hid>
Subject: Re: [Xenomai-core] AT91SAM9260 support
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Claudio Scordino <cloud.of.andor@domain.hid>
Cc: michael trimarchi <trimarchimichael@domain.hid>, xenomai@xenomai.org, xenomai@xenomai.org

On 9/20/07, Claudio Scordino <cloud.of.andor@domain.hid> wrote:
> Hi list,
>
>     I'm starting working on the Atmel AT91SAM9260 platform,
> and I need Xenomai, of course.
>
> I have a couple of questions:
>
> - Does Xenomai/Adeos 2.3.3 support this platform, or I should use
>    Xenomai 2.4-rc1 ?

Current stable release is Xenomai 2.3.4, using Adeos for arm version
1.7-06, and yes, it supports the AT91SAM926x platforms.

>
> - I have seen tha Xenomai 2.4-rc1 is against Linux 2.6.20. Did
>    anybody already port Xenomai to Linux 2.6.22 (I just need
>    the at91 part) ?

The reason why I did not do the port is that I supposed that Adeos
noarch part for Linux 2.6.22 uses clockevent/clocksource, and
clockevent/clocksource is not implemented for all ARM boards (I mean
all arm boards supported by the Adeos patch), so unless somebody
really needs support for 2.6.22, I am waiting for 2.6.23.

-- 
                                               Gilles Chanteperdrix

