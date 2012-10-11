Message-ID: <50766A8F.9090901@wanadoo.fr>
Date: Thu, 11 Oct 2012 08:43:27 +0200
From: Thierry Bultel <thierry.bultel@wanadoo.fr>
MIME-Version: 1.0
References: <503227B5.9070002@basystemes.fr> <50322F06.4000009@wanadoo.fr>
	<503C63BE.8010201@xenomai.org>
	<503C709C.3020702@grandegger.com> <503C758B.9000906@wanadoo.fr>
	<503C7D77.2060209@grandegger.com> <50744BD3.1030703@wanadoo.fr>
	<50747C29.2060504@grandegger.com> <50748733.80709@wanadoo.fr>
In-Reply-To: <50748733.80709@wanadoo.fr>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] [PATCH] rtcan: driver for the Advantech PCI cards
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Wolfgang Grandegger <wg@grandegger.com>
Cc: "Xenomai@xenomai.org" <Xenomai@xenomai.org>

Why v3.2 from Freescale? For the SabreLite or Nitrohen6x I know about
>> 3.0.36 from Freescale (rel_imx_3.0.35_12.09.02 from
>> git.freecale.com/linux-2.6) or, much better, mainline Linux 3.4.
>> Concerning the iPipe patches I think you have currently no other choice.
>


In both cases, (latest one from Freescale, or 3.4 from mainline) there is currently
no available matching ipipe patch.
I do not know if the latest kernel from mainline will fit for the reference board that I will receive.

I do not realize the amount of work for porting either
- ipipe-core-3.2.21-arm.patch to 3.4 (mainline)
or
- adeos-ipipe-3.0.43-* to the latest (which one ?) kernel from Freescale

About that latest option I am a little bit puzzled.
Namely from what I know, Freescale kernels are on

http://git.freescale.com/git/cgit.cgi/imx/linux-2.6-imx.git/refs/heads
and the latest published 3.x kernel is ... a 3.0.15_12 that has not moved for months.
Thanks for clarifying

Thierry


