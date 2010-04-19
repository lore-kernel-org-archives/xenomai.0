Message-ID: <4BCCA3C0.7040209@domain.hid>
Date: Mon, 19 Apr 2010 20:41:04 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <4BCC619E.2@domain.hid>
	<4BCC6CEE.70907@domain.hid>		<4BCC6E3C.3090301@domain.hid>
	<4BCC7092.1030809@domain.hid>		<4BCC71AF.4030903@domain.hid>
	<4BCC77BD.9040900@domain.hid>		<4BCC78D5.3010405@domain.hid>
	<4BCC7D88.4070403@domain.hid>	<1271693411.16659.128.camel@domain.hid>	<4BCC814C.6050003@domain.hid>
	<4BCC8484.1020108@domain.hid>	<4BCC9107.1080605@domain.hid>
	<4BCC9247.10709@domain.hid>	<4BCC9628.7030809@domain.hid>
	<4BCC9ADA.2020909@domain.hid> <4BCC9D8D.10906@domain.hid>
	<4BCC9E81.8000209@domain.hid> <4BCC9F49.1010302@domain.hid>
	<4BCCA30A.7050208@domain.hid>
In-Reply-To: <4BCCA30A.7050208@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] [RFC] fix XENO_OPT_DEBUG bugs.
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: xenomai-core <xenomai@xenomai.org>

Jan Kiszka wrote:
> Gilles Chanteperdrix wrote:
>> Jan Kiszka wrote:
>>> My compiler still complains about undefined 'y0' in the enabled case.
>>>
>>> I'll try to dig into a different direction now: Automatic generation
>>> during build. This is what the kernel does as well when the preprocessor
>>> gives up. Would even save the DECLARE and should make everyone happy.
>> No, please nothing like that.
> 
> Because ... ?
> 
> BTW, I'll extend the prepare stage. Defining the proper dependencies for
> build-time generation gets too hairy.
> 
>> This one works for me:
>> #include <stdlib.h>
>> #include <stdio.h>
>>
>> #define __name2(a, b) a ## b
>> #define name2(a, b) __name2(a, b)
>>
>> #define DECLARE_ASSERT_SYMBOL(sym)                                      \
>>         static const int XENO_OPT_DEBUG_##sym = 0; \
>>         static const int CONFIG_XENO_OPT_DEBUG_##sym##0 = 0
>>
>> #define XENO_DEBUG(sym) \
>>         (name2(CONFIG_XENO_OPT_DEBUG_##sym,0) > XENO_OPT_DEBUG_##sym)
>>
>> #define XENO_ASSERT(subsystem,cond,action)  do { \
>>     if (unlikely(XENO_DEBUG(subsystem) && !(cond))) { \
>>         xnarch_trace_panic_freeze(); \
>>         xnlogerr("assertion failed at %s:%d (%s)\n", __FILE__, __LINE__, (#cond)); \
>>         xnarch_trace_panic_dump(); \
>>         action; \
>>     } \
>> } while(0)
>>
>> DECLARE_ASSERT_SYMBOL(NUCLEUS);
>>
>> int main(void)
>> {
>>         if (XENO_DEBUG(NUCLEUS))
>>                 printf("Hello\n");
>> }
>>
>> Please try and send me the result of pre-processing if
>> it does not work for you.
>>
> 
> Find it attached.

It looks like you are defining CONFIG_XENO_OPT_DEBUG_NUCLEUS to be y
instead of 1.

-- 
					    Gilles.

