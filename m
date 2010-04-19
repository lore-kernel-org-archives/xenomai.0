Message-ID: <4BCC6E3C.3090301@domain.hid>
Date: Mon, 19 Apr 2010 16:52:44 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <4BCC619E.2@domain.hid> <4BCC6CEE.70907@domain.hid>
In-Reply-To: <4BCC6CEE.70907@domain.hid>
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
>> Hi,
>>
>> I found some code which was referencing directly some
>> CONFIG_XENO_OPT_DEBUG_ variables with things like:
>>
>> #ifdef CONFIG_XENO_OPT_DEBUG_FOO
>>
>> This usage is incompatible with the pre-requisites of the assert.h
>> header that CONFIG_XENO_OPT_DEBUG_FOO should be defined at all times.
>> While grepping for CONFIG_XENO_OPT_DEBUG_, I found that we also have
>> many duplicates of construction like:
>> #ifndef CONFIG_XENO_OPT_DEBUG_FOO
>> #define CONFIG_XENO_OPT_DEBUG_FOO 0
>> #endif /* CONFIG_XENO_OPT_DEBUG_FOO */
>>
>> So, a patch follows which:
>> - replace the #ifdef with some #if XENO_DEBUG(FOO)
> 
> Should probably come as a separate patch.

Come on, the patch is simple, one patch for this is enough.

> 
>> - move all the initializations to assert.h
>>
>> This will make any reference to CONFIG_XENO_OPT_DEBUG_FOO outside of
>> assert.h suspicious, and easy to detect.
> 
> How many duplicates did you find?

A lot, especially for CONFIG_XENO_OPT_DEBUG_NUCLEUS

> 
> Generally, I'm more a fan of decentralized management here (e.g. this
> avoids needless patch conflicts in central files).

If we maintain the list in alphabetical order (which I have done), we 
reduce the likeliness for conflicts. The aim of doing this is also that 
I can check that the sources are clean with:

find xenomai-2.5 ! -name 'assert.h' -name '*.[ch]' | xargs grep CONFIG_XENO_OPT_DEBUG_

And that I can add this test to the automated build test.

Note that forgetting to add a #define to the list yields an immediate
compilation error. So, the patch makes things completely safe.

-- 
					    Gilles.

