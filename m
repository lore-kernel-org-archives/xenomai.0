Message-ID: <4BA0A489.7050006@domain.hid>
Date: Wed, 17 Mar 2010 10:44:41 +0100
From: Daniele Nicolodi <daniele@domain.hid>
MIME-Version: 1.0
References: <4B9236DD.2030900@domain.hid> <4B923AC8.3070109@domain.hid>
	<4B923F16.7010105@domain.hid> <4B9531A3.9040308@domain.hid>
	<4B9BC623.6020304@domain.hid>
In-Reply-To: <4B9BC623.6020304@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] xenomai/asm/xenomai/syscall.h is not c99 aware
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

Gilles Chanteperdrix wrote:
> Daniele Nicolodi wrote:
>> Daniele Nicolodi wrote:
>>
>>>> It probably can be made to work. But... do you realy need -std=c99 ?
>>> I didn't know about -std=gnu99. I can certainly use this extension.
>> It looks like using -std=gnu99 causes somehow the compilation to fail at
>> linking time. Gcc complains about multiple defined symbols in the object
>> files. However, my very limited knowledge of how compilers work do not
>> let me understand the problem.

> It should be fixed by this patch:
> http://git.xenomai.org/?p=xenomai-2.5.git;a=commitdiff;h=8cfc1103fe1cf9e700698e8230baf562ffb5cf06;hp=0386ae9a4e8befc67088e247b65be534d34efbe1
> 
> Could you try it?

It fixes the problem. Thanks.

Cheers,
-- 
Daniele


