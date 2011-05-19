Message-ID: <4DD55CEE.4030607@domain.hid>
Date: Thu, 19 May 2011 20:09:50 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <BANLkTimo07YLRZKw2faMv3r5MuBeG047zQ@mail.gmail.com>
In-Reply-To: <BANLkTimo07YLRZKw2faMv3r5MuBeG047zQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Regarding available stable versions for
	pandaboard
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
Cc: xenomai@xenomai.org

On 05/19/2011 04:41 PM, suresh reddy wrote:
> Hi all,
> 
> iam running ubuntu 10.04 on my pandaboard  with the kernel 2.6.35-903-omap4.
> 
> the latest linux kernel available is 2.6.38 and  the xenomai latest
> version is v2.5.6. My question is is it compatible if i compile with the
> available adeos patch for pandaboard?

Yes. You may have to adjust include/asm-arm/hal.h, as explained in the
arm porting guide though.

-- 
                                                                Gilles.

