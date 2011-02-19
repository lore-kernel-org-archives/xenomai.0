Message-ID: <4D601B37.2010003@domain.hid>
Date: Sat, 19 Feb 2011 20:34:15 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <AANLkTikiCm5B-KwteOfzTwtCV8RXj1QFgfQCAmCCoC8V@mail.gmail.com>	<20101220154041.48C75CDE29A@gemini.denx.de>	<AANLkTi=C3FQ_Cms9qanmc1dgMgSvMC1Rrt-0X0tOPZMp@domain.hid>	<20110215200753.C4B6C146940@domain.hid>	<1297880887.1947.3.camel@domain.hid>	<AANLkTin-2JJz3V+7bE7q1SjT0TBniRaO+byS_R0mzJF_@domain.hid>	<1298111755.3304.1.camel@domain.hid>
	<4D5FE8D6.6030204@domain.hid>
In-Reply-To: <4D5FE8D6.6030204@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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

Gilles Chanteperdrix wrote:
> Marten Lootsma wrote:
>> Hi Flavio,
>>
>> But the second link
>> (http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=tree;f=arch/arm/mach-mx3;h=8021c7efda789b8fe5ae3e896b62ae125b231958;hb=795abaf1e4e188c4171e3cd3dbb11a9fcacaf505) isn't a Freescale link, is it?
> 
> Marten, please read carefully the latest of Wolfgang's mails again, and
> stop posting the same question over and over again: Wolfgang answered.
> If you did not understand something in this answer, please tell us what
> you did not understand, but stop skipping the answer.
> 

Besides, the link you post is to a kernel which has not even been
released yet.

When adapting the I-pipe patch to a new kernel, we only work with
released kernel, because we have to be sure that there is no other bugs
than I-pipe bugs when validating the I-pipe. And even this is not even
sufficient since, for instance, 2.6.35 and 2.6.37 were releases with
bugs which prevented the from running on ARM.

And for the ARM architecture, we only release patches to odd version
numbers. So, you will have to wait for 2.6.39.

-- 
                                                                Gilles.

