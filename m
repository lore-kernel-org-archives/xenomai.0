Message-ID: <4B924586.1060400@domain.hid>
Date: Sat, 06 Mar 2010 13:07:34 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <4B90ED0A.40101@domain.hid> <4B90F2D3.8020508@domain.hid>
	<4B91290C.7070005@domain.hid> <4B9131B4.6060105@domain.hid>
	<4B913C71.4060006@domain.hid> <4B914107.3000108@domain.hid>
	<4B9222D1.1000207@domain.hid>
In-Reply-To: <4B9222D1.1000207@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] [RFC][PATCH v2] Allow for deregistering current
 mode user space address
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
>>> Gilles Chanteperdrix wrote:
>>>> Jan Kiszka wrote:
>>>>> Gilles Chanteperdrix wrote:
>>>>>> Jan Kiszka wrote:
>>>>>>> This adds __xn_sys_drop_u_mode, a syscall to deregister the u_mode user
>>>>>>> space address passed on shadow creation for the current thread. We need
>>>>>>> this in order to safely shut down a thread that wants to release its
>>>>>>> u_mode memory (either malloc'ed or TLS-allocated). So far, the kernel
>>>>>>> might have touched this memory even after the release which caused
>>>>>>> subtle corruptions.
>>>>>>>
>>>>>>> After we released u_mode, we can no longer make reliable decisions based
>>>>>>> on it. For the fast mutex use case, we then assume the worst case, ie.
>>>>>>> we enforce syscall-based acquisitions unconditionally. For the
>>>>>>> assert_nrt case, we simply acquire the required information via
>>>>>>> __xn_sys_current_info.
>>>>>> As usual, you are firing patches too fast:
>>>>>> - you are lacking the exit syscall trap.
>>>>> Don't worry, my memory is not yet _that_ bad. :)
>>>>>
>>>>>> - the patch is not correct and will cause kernel-space addresses to be
>>>>>> passed to put_user, which probably yields bugs when the kernel is
>>>>>> compiled with proper debug flags;
>>>>> Right, e.g. ARM requires set_fs() fiddling in addition. But then a simple
>>>>> NULL-check is way better. Fixed.
>>>>>
>>>>>> - I do not see the point where the new syscall is called with __thread,
>>>>>> but I am not sure it is missing, and if it is missing, you will get the
>>>>>> rightfull warning when hitting the exit syscall.
>>>>> Destructor of (now unconditionally used) xeno_current_mode_key.
>>>>>
>>>>>> - the user-space users of the function to get current_mode are still
>>>>>> cluttered with special cases to handle the invalid state. And
>>>>>> illustrating nicely the deficiency of this approach, you have forgot one
>>>>>> user.
>>>>> My impression is that you are still a bit biased due to TLS limitations
>>>>> on ARM.
>>>> No, I think the __thread stuff thinks make C code look too much like C++
>>>> where the compiler makes things behind your back for such simple code as:
>>>>
>>>> void *foo = &bar;
>>>>
>>>> This is not what I expect from a C compiler, and I suspect a lot of C
>>>> developers, including the people who advocate that C, as a simple
>>>> language, and not C++ should be used for free software development.
>>>>
>>>> Yes, there is no gain on ARM, where this generates a function call as
>>>> pthread_getspecific and causes bugs with gcc >= 4.3, but not much gain
>>>> on x86 either where a function call is so cheap.
>>> As are individual memory accesses. The sum makes the difference.
>> Ok. If you find before 2.5.3 a platform where this makes a difference of
>> more than 5% of this platform's latency, I do not remove the __thread
>> stuff. Deal?
> 
> If you manage to remove 5% of the configuration variables of Xenomai
> that way. Or 5% of the conditional code.

The __thread stuff introduces two configuration variables, that is 4
combinations. Now, for the u_mode modifications for which you sent me a
pull-request (so, according to what you said, is tested), did you test
the 4 combinations? If no, then chances of bug are high. If yes, then do
not you think that it is a major PITA to compile Xenomai user-space 4
times for a so little gain?

So __thread has a maintenance cost, and if we do not pay attention to
it, we release buggy code. Now, let me quote something someone you know
very well wrote some time ago:
"While RTAI is focused on lowest technically feasible latencies, Xenomai
also considers clean extensibility (RTOS skins), portability, and
maintainability as very important goals."

This is in our wiki.
__thread and the wrong life-cycle u_mode are examples of things which
focus on ridiculous micro-optimizations rather on maintainability.


> I think my workflow was misleading regarding this. Not necessarily all
> stuff I push into my 'for-upstream' branch is done with all tests at the
> time when I push. Official pull request mails are supposed to mark this.
> I'm pushing to save my work and, of course, to expose it. So I
> appreciate comments, but I surely don't expect them within minutes.

No. You still refuse to acknowledge the truth: I receive pull requests
for untested stuff. Read John's mail again. He cherry picked changes,
for which I received a pull request, he ran the mutex-torture tests,
which the patchset had modified, and the test was not passing. So, the
conclusion is that you did not run mutex-torture, which the commit had
modified before sending the pull request. I did not have to dig long in
the git logs to find this example. It was just yesterday. Think about it.

That is precisely the situation I want to avoid from now on.

> 
>>  I'm trying to avoid the
>>> same assumption about other people as well, even when things look
>>> differently from time to time. To err is human, to always write correct
>>> code is divine.
>>>
>>> But as you already mentioned in another mail, there is room for
>>> improvement /wrt testability. On step forward would be an automated
>>> build and run of some git tree that we can check into. One board per
>>> arch would be enough to avoid issues we face from time to time when we
>>> only stress our favorite archs with new features or fixes.
>> We have the automated build.
> 
> Then we just need to run it against some 'build-test' branches of
> everyone's git repositories on checkin. That would be great.

Unfortunately, I am running the tests with ccache on a core i7 on a
raid0 array, and it still takes around one hour. So, I prefer running
this by hand. But do not worry, it is run before the releases.

> 
>> I plan seriously to work on the automated
>> run for 2.5.3. But it is too late for 2.5.2. Also note that I gave you
>> access to my server where several targets are configured and usable. If
>> you forgot the password, I can reset it.
> 
> I do remember this, but I thought this was for a specific test. If I'm
> supposed to access that box regularly, I'm fine, we can arrange this.

I was just mentioning this to mean that if you want to test, you can.
You are not supposed to do anything, you are free to use it, you can do
as you like.


> PS: Note that this u_mode fix exposed an issue of the sigtest:
> cancel_with_signals fails if there is some TSD destructor registered
> that issues a Xenomai syscall. Not sure yet if it is a fundamental issue
> or just related to the test itself.

The sigtest test probably assumes that no parasite syscall occurs. Yet
another reason for not using this u_mode implementation.

-- 
					    Gilles.

