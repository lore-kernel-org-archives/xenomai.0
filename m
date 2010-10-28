Message-ID: <4CC9CEBA.8050407@domain.hid>
Date: Thu, 28 Oct 2010 21:27:54 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <mailman.71.1288260013.23099.xenomai@xenomai.org>
	<20101028163705.18211an5ytg9yv1c@domain.hid>
In-Reply-To: <20101028163705.18211an5ytg9yv1c@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] BeagleBoard-XM
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Michel He <michel.he@domain.hid>
Cc: xenomai@xenomai.org

Michel He wrote:
> hello all,
> 
>     I wonder whether anybody have ever tested Xenomai on the  
> BeagleBoard-XM (OMAP DM3730) or the no XM version (OMAP 3530). Are the  
> dsplink and examples fully working ?

A port to Xenomai on Beagle has been financed by Denx engineering a long
time ago:
http://www.denx.de/en/view/Software/SoftwareXenomaiProjects#Xenomai_Real_Time_Support_for_OM

The omap3530 is regularily tested, because, well, the platform where I
do most of my developments is an IGEPv2 board (the time for an x86 to
simply launch Linux, you have crashed, recompiled, and rebooted Linux on
ARM several times).

However, we do only test Linux services (we do it thoroughly, with LTP),
we do not test any TI-specific codecs and stuff. However(2), this should
work (not with real-time constraints, of course). If it does not, then
please report any issue.

-- 
                                                                Gilles.

