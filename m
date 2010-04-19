Message-ID: <4BCC8484.1020108@domain.hid>
Date: Mon, 19 Apr 2010 18:27:48 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <4BCC619E.2@domain.hid> <4BCC6CEE.70907@domain.hid>	
	<4BCC6E3C.3090301@domain.hid> <4BCC7092.1030809@domain.hid>	
	<4BCC71AF.4030903@domain.hid> <4BCC77BD.9040900@domain.hid>	
	<4BCC78D5.3010405@domain.hid> <4BCC7D88.4070403@domain.hid>
	<1271693411.16659.128.camel@domain.hid>
	<4BCC814C.6050003@domain.hid>
In-Reply-To: <4BCC814C.6050003@domain.hid>
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
> Philippe Gerum wrote:
>>>>> config XENO_OPT_DEBUG_FOO
>>>>> 	bool "..."
>>>>>
>>>>> config XENO_OPT_DEBUG_FOO_P
>>>>> 	int
>>>>> 	default "1" if XENO_OPT_DEBUG_FOO
>>>>> 	default "0"
>>>>>
>>>>> and XENO_DEBUG() could be extended to test for
>>>>> CONFIG_XENO_OPT_DEBUG_FOO_P when given "FOO". I'm just not sure if this
>>>>> can be expressed for legacy 2.4 kernels, so it might have to wait for
>>>>> Xenomai 3.
>> Well, actually, I would not merge this in Xenomai 3. I find this rather
>> overkill; mainline first I mean, and mainline, i.e. the Xenomai code
>> base only requires a simple and straightforward way to get debug
>> switches right. Having to make Kconfig a kitchen sink for some unknown
>> out of tree modules to be happy is not really my preferred approach in
>> this particular case.
>>
>> Don't get me wrong, I'm not opposed to a more decentralized approach on
>> the paper, it's just that I only care about the mainline tree here.
> 
> The point is not out-of-tree but robustness. Neither the current
> decentralized #ifdef-#define nor its centralized brother meet this
> criteria. An approach like the above which forces you to provide all
> required bits before any of the cases (disabled/enabled) starts to work
> does so.

Ok. What about:

#define __name2(a, b) a ## b
#define name2(a, b) __name2(a, b)

#define DECLARE_ASSERT_SYMBOL(sym)					\
	static const int CONFIG_XENO_OPT_DEBUG_##sym##0 = 0,		\
		__CONFIG_XENO_OPT_DEBUG_##sym = name2(CONFIG_XENO_OPT_DEBUG_##sym, 0)

#define XENO_ASSERT(subsystem,cond,action)  do { \
    if (unlikely(__CONFIG_XENO_OPT_DEBUG_##subsystem > 0 && !(cond))) { \
        xnarch_trace_panic_freeze(); \
        xnlogerr("assertion failed at %s:%d (%s)\n", __FILE__, __LINE__, (#cond)); \
        xnarch_trace_panic_dump(); \
        action; \
    } \
} while(0)

DECLARE_ASSERT_SYMBOL(NUCLEUS);

It fails to compile when the debug symbol is set and
DECLARE_ASSERT_SYMBOL is missing, which plugs the failure of my previous
attempt.

-- 
					    Gilles.

