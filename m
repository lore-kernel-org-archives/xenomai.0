Message-ID: <4DD6CFFA.50108@domain.hid>
Date: Fri, 20 May 2011 22:32:58 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <BANLkTimo07YLRZKw2faMv3r5MuBeG047zQ@mail.gmail.com>	<4DD55CEE.4030607@domain.hid>
	<BANLkTim2KPKjhgSSAcyF4g1-CVFXFsCjTw@domain.hid>
In-Reply-To: <BANLkTim2KPKjhgSSAcyF4g1-CVFXFsCjTw@domain.hid>
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

On 05/20/2011 11:26 AM, suresh reddy wrote:
> On 05/19/2011 04:41 PM, suresh reddy wrote:
>> Hi all,
>>
>> iam running ubuntu 10.04 on my pandaboard  with the kernel
> 2.6.35-903-omap4.
>>
>> the latest linux kernel available is 2.6.38 and  the xenomai latest
>> version is v2.5.6. My question is is it compatible if i compile with the
>> available adeos patch for pandaboard?
> 
> Yes. You may have to adjust include/asm-arm/hal.h, as explained in the
> arm porting guide though.
> 
> 
> Ok. So,the linux kernel 2.6.38 and xenomai latest version with two
> macros adding in 
> include/asm-arm/hal.h will make it compile  for pandaboard  .

No. You can not use linux kernel 2.6.38, you need to pick the ipipe tree
from the git I sent you a link in a previous mail.

> Does the board supports CONFIG_GENERIC_TIME and
> CONFIG_GENERIC_CLOCKSOURCES ?

I do not understand how this question is related to Xenomai.

-- 
                                                                Gilles.

