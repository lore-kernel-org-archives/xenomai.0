Message-ID: <4D605B70.6010508@domain.hid>
Date: Sun, 20 Feb 2011 01:08:16 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <AANLkTikiCm5B-KwteOfzTwtCV8RXj1QFgfQCAmCCoC8V@mail.gmail.com>	
	<20101220154041.48C75CDE29A@gemini.denx.de>	
	<AANLkTi=C3FQ_Cms9qanmc1dgMgSvMC1Rrt-0X0tOPZMp@domain.hid>	
	<20110215200753.C4B6C146940@domain.hid>	
	<1297880887.1947.3.camel@domain.hid>	
	<AANLkTin-2JJz3V+7bE7q1SjT0TBniRaO+byS_R0mzJF_@domain.hid>	
	<1298111755.3304.1.camel@domain.hid>
	<4D5FE8D6.6030204@domain.hid>	 <4D601B37.2010003@domain.hid>
	<1298156382.3304.13.camel@domain.hid>
In-Reply-To: <1298156382.3304.13.camel@domain.hid>
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

Marten Lootsma wrote:
> Hi,
> 
> Thanks for clarifying. I am quite blue to git/kernel/versioning and in
> my optimism I underestimated the complexity of versioning and patching.
> I guess therefore I did not understand the answer of Wolfgang totally. 
> 
> Do I understand correct that: Xenomai support for iMX35 depends fully on
> the developers of Freescale to put their patches into the mainline
> kernel? 

The thing is, there are various degrees of support. The mainline kernel
probably only supports part of what the iMX35 proposes. This is probably
sufficient for porting Xenomai. The freescale kernel probably supports
much more than that, but needs more work to get Xenomai running. Now, it
all depends on what you need.

-- 
                                                                Gilles.

