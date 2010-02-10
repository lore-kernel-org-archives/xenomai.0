Message-ID: <4B72FBF1.2020109@domain.hid>
Date: Wed, 10 Feb 2010 19:33:21 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <245373446233674495BCA5CA2FC1EB173713B4D0CD@RCexchangeSVR1.ruggedcom.local>,
	<4B72F95E.3080402@domain.hid>
	<245373446233674495BCA5CA2FC1EB173713B4D0CF@RCexchangeSVR1.ruggedcom.local>
In-Reply-To: <245373446233674495BCA5CA2FC1EB173713B4D0CF@RCexchangeSVR1.ruggedcom.local>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Kernel oops when reading /proc/xenomai/stats
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Andreas Glatz <AndreasGlatz@domain.hid>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

Andreas Glatz wrote:
> Hi,
> 
> 
>>> That's the kernel oops with additional debugging info (starts with 'HUHU' - see code below the oops):
>>>
>>> HUHU count=1 xnintr_count=-12
>> That's not good. What is your Xenomai version?
> 
> Hardware=MPC8360, Linux=2.6.32, Xenomai=2.4.10, ipipe=2.8-00
> 
>> Does everything work fine if you application terminates normally and
>> deletes the rt_intr objects explicitly?
> 
> Checking...
> 

And then you may want to track this down at the site that decrements
xnintr_count, ie. rt_intr_delete -> xnintr_detach.

Jan

-- 
Siemens AG, Corporate Technology, CT T DE IT 1
Corporate Competence Center Embedded Linux

