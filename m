Message-ID: <4BCDA299.9030203@domain.hid>
Date: Tue, 20 Apr 2010 14:48:25 +0200
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
> 
>> - move all the initializations to assert.h
>>
>> This will make any reference to CONFIG_XENO_OPT_DEBUG_FOO outside of
>> assert.h suspicious, and easy to detect.
> 
> How many duplicates did you find?
> 
> Generally, I'm more a fan of decentralized management here (e.g. this
> avoids needless patch conflicts in central files).

My latest approach was not really working (it was working, but generated
warning when compiled with -Wundef, and the kernel is compiled with
-Wundef). So, let us stop the madness.

I have merged the following solution:
- fixed the direct references to CONFIG_XENO_OPT_DEBUG_FOO and replaced
them with XENO_DEBUG(FOO)
- moved the duplicate CONFIG_XENO_OPT_DEBUG_FOO initializations which
did not fit to a particular file to assert.h (actually only QUEUES and
NUCLEUS), let the other initializations live in peace where they were.

This is complemented by a check_script whose result on the previous
xenomai version you can see at:
http://sisyphus.hd.free.fr/~gilles/bx/distcheck/xenomai/log.html

-- 
					    Gilles.

