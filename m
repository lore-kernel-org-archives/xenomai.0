Message-ID: <4B7168ED.5050102@domain.hid>
Date: Tue, 09 Feb 2010 14:53:49 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <4B71666A.6040508@domain.hid>
	<1265723261.2368.18.camel@domain.hid>
In-Reply-To: <1265723261.2368.18.camel@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Xenomai FAILED to register object
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai@xenomai.org

Philippe Gerum wrote:
> On Tue, 2010-02-09 at 14:43 +0100, Alexandre Coffignal wrote:
>> Hi all,
>>
>> I use xenomai to port PSOS application, so I am using xenomai PSOS skin,
>> but i want to use xenomai pthread.
>>
>> My question is do you know if i can use psos skin and posix skin in the
>> same time?
>>
>> I already test it without success : when I load my prog, I have this
>> message :
>>     Xenomai pSOS skin init: t_shadow() failed, status -17
>>
>> and this message in dmess
>>     Xenomai: FAILED to register object MAIN (unknown type), status -17
> 
> Don't call both of them "MAIN".

I think the problem is that both skins try to shadow the main thread.
This can be disabled for the posix skin by passing --enable-dlopen-skins
on configure command line.

-- 
Gilles Chanteperdrix, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com

