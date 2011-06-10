Message-ID: <4DF22735.9050608@domain.hid>
Date: Fri, 10 Jun 2011 16:16:21 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <BANLkTi=hBWZO5ngeXbPHELnYW9ofD7OuNg@domain.hid>
In-Reply-To: <BANLkTi=hBWZO5ngeXbPHELnYW9ofD7OuNg@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] --enable-arm-mach=omap4
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: suresh reddy <sureshreddy.balijepalli@domain.hid>
Cc: Xenomai help <xenomai@xenomai.org>

On 06/10/2011 03:48 PM, suresh reddy wrote:
> Dear Giles,
> 
> I done according to the documentation mentioned in readme.install (building
> for arm)
> 
> passing --enable-arm-mach=omap4 but i got below error
> 
> checking for ARM machine... configure: error: Invalid machine selected:
> "omap4"
> 
> as you mentioned , Once  kernel was prepared i cant configure pass omap3 .
> But how to pass --enable-arm-mach=omap4  then?
> 
> during xenomai/scripts/prepare-kernel.sh    we are just giving arch=arm
> 

No. What I told you is that you should pass --enable-arm-mach=omap3 for
omap4.

-- 
					    Gilles.

