Message-ID: <4BCCBE00.7090208@domain.hid>
Date: Mon, 19 Apr 2010 22:33:04 +0200
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
	<4BCCA30A.7050208@domain.hid> <4BCCA3C0.7040209@domain.hid>
	<4BCCAA38.4070000@domain.hid> <4BCCAD4D.9040600@domain.hid>
	<4BCCB107.7090800@domain.hid> <4BCCB34B.8020609@domain.hid>
	<4BCCB828.4070506@domain.hid>
In-Reply-To: <4BCCB828.4070506@domain.hid>
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
>>>>> diff --git a/scripts/prepare-kernel.sh b/scripts/prepare-kernel.sh
>>>>> index 24b1f17..d8038e0 100755
>>>>> Please let me know what precisely you dislike in this approach.
>>>> You have to re-run prepare-kernel when you modify the source.
>>> Normally, you have to anyway as you add some header or some other source
>>> file during this process.
>> Not necessarily.
> 
> At worst, you run into a build error and repeat the step. Otherwise, the
> next installation will fix it silently. It's much like the missing
> DECLARE_ASSERT_SYMBOL detection and resolution, IMO even more convenient.

I do not see in what way it is more convenient. I would now have to run
prepare-kernel.sh in a case when I did not have to run it. Adding
DECLARE_ASSERT_SYMBOL to one .c file just triggers the recompilation of
the file, and relinking of the kernel.

> 
>>>> I do not like dynamic sources generation. Especially when we have a
>>>> working solution based on C pre-processor macros.
>>>>
>>> My prepare-kernel approach also detects stall debug stuff: The uitron
>>> use of XENO_DEBUG is not backed by any config option.
>> The current candidate would also detect the missing
>> DECLARE_ASSERT_SYMBOL in that case.
>>
> 
> But not
> 
> #if XENO_DEBUG(DOES_NOT_EXIST)

This can be made during the build-test and thus avoided during a normal
compilation.

I am really, strongly opposed to dynamic code generation. Especially
which greps the whole source tree, this is a waste of cpu power. Most
shell scripts are wrong when first written and do not handle errors
correctly. I already see two or three pitfalls in the script you
proposed. Globally, this is really overkill and risky.

The alternative, a 3 lines C macro, has the inconvenient of requiring
that we declare the symbol, but after all the original solution had the
same, and nobody complained. We do not add debug symbols that often.
What is important however, is that we avoid the current mess which
happened in pod.h and pod.c because they used #ifdef
CONFIG_XENO_OPT_DEBUG_NUCLEUS, and this macro solution allows to detect
such issues..

We can add the missing features of this solution in the build-test
script. This way there is 0 impact on the compilation for end-users. And
since we do run the build-test script, we are sure not to miss any
error. And if the scripts erases xenomai sources directory because of
flaky error checking, it will only erase my xenomai sources.

-- 
					    Gilles.

