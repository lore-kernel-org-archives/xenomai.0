MIME-Version: 1.0
Sender: peter.soetens@domain.hid
In-Reply-To: <4AC36ACA.8080201@domain.hid>
References: <4AC2448B.1080500@domain.hid>
	<634c78ce0909300710i6d30b905kafdf7d76b2b31c7c@domain.hid> 
	<4AC36ACA.8080201@domain.hid>
From: Peter Soetens <peter@domain.hid>
Date: Wed, 30 Sep 2009 18:58:59 +0200
Message-ID: <634c78ce0909300958y531325d1se6b87bc3fed40824@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Subject: Re: [Xenomai-core] RFC: 2.5 todo list.
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: Xenomai core <Xenomai-core@domain.hid>

On Wed, Sep 30, 2009 at 16:27, Gilles Chanteperdrix
<gilles.chanteperdrix@xenomai.org> wrote:
> Peter Soetens wrote:
>> On Tue, Sep 29, 2009 at 19:31, Gilles Chanteperdrix
>> <gilles.chanteperdrix@xenomai.org> wrote:
>>> Hi guys,
>>>
>>> full of energy after this tremendous first XUM, I would like to start a
>>> discussion about what people would like to see in the 2.5 branch.
>>
>> So if we answer positively, we'll delay the release ? I'd rather get
>> 2.5 out, and develop any new stuff on 2.6. I would also expect that
>> this list (or part of ) goes to xenomai-help too.
>
> The facts are:
> - our release cycle is long;
> - we want to keep the ABI stable for each branch.
> So, anything that we want "soon" and that breaks the ABI should be done
> in the 2.5 branch, otherwise will have to wait 2.6.

Ok, but there is stuff in 2.5 I want "soon" too, which you would be delaying.

>
>>
>>> Here is a first list, please feel free to criticize it:
>>> - signals in primary domain (something that we almost forgot)
>>
>> I refrain from using signals in my apps. They only cause disaster when
>> using 3rd party libraries. Only Ctrl-C (quit) and debugger signals are
>> used, and a switch from primary to secondary is perfectly acceptable
>> in these two cases.
>
> Yes, signals is a bit of a misnomer, what we actually want is for the
> kernel to be able to cause the execution of an asynchronous callback in
> user-space. For the native skin, it would be for the implementation of
> some hooks. For the posix skin, it would be for the implementation of
> signasl. The implementation of posix timers is based on signals (except
> for SIGEV_THREAD, but who uses SIGEV_THREAD in an rt app...), having
> them cause a switch to secondary mode make them unusable for practical
> purposes. So, with the current version of Xenomai posix skin, you have
> to implement your own timer method, having for instance a thread which
> nanosleep()s until the next timer expiry and then executes the callback.

Ok, but I don't use posix timers for the reasons above. I use
clock_nanosleep instead, which offers the same functionality.

>
>>
>>> - xnsynch_acquire using atomic_cmpxchg unconditionally (no #ifdefs)
>>
>> This is too core for me.
>>
>>> - statistics of all mapped named heaps in /proc/xenomai/heap
>>
>> Don't use heaps since we do all in user space (and I had the
>> impression that heap was for kernel<->user.)
>>
>>> - unwapped access to user-space posix skin methods
>>
>> I wouldn't know why I need this. Do you we link with libpthread
>> instead of libpthread-rt ?
>
> Well the wrap thing is a bit cumbersome. And having the calls be named
> with exactly the posix name is useful only if you intend to compile
> exactly the same code for xenomai and other posix systems. Otherwise,
> you could decide to use a little prefix or suffix to each posix skin
> service, and avoid the wrapping clumsyness.

So like we did in the RTAI days. Maybe we can use rt_ by (safe!)
default and allow a #define in case the users wants to use the
wrapping and is aware that he needs to use the wrapping during
linking.

>
>>
>>> - fast semaphores in user-space
>>
>> I donn't know why I wouldn't need this.
>>
>>> - syscall-less select ?
>>
>> Since a syscall is not per-se bad (?) I also don't see what to win here.
>
> syscall are expensive (which is why we do syscall-less mutexes for
> instance). The idea would be to put the bitfield with the ready file
> descriptors in a shared heap, to avoid going for the syscall if fds are
> already ready when entering select(). The scenario where we would gain
> is on a loaded system, which is exactly when we want to avoid useless
> syscalls.

Then I'm tempted to be in favour, although I'd like to confirm first
that select() is not broken as it is now. Are syscalls expensive
because I'm running Xenomai, or is this the case in vanilla Linux too
? Do we try to be better than Linux (until they use a similar 'fix' in
libc) ?

>
>>
>>> Actually, there are already a lot of things.
>>> So, what do you think?
>>
>> I'm uttermost concerned with stability and to a lesser extent
>> performance. I regard every feature change as changing those two
>> criteria for the worse (unless its a feature that fixes a bug).
>
> Well... I disagree. Even when fixing bugs we can introduce other bugs.
> What matters if you aim for stability and performance is improving the
> tests, not avoiding modifications.

You got me. But until the tests are improved, I beg you to be careful ;-)

Peter

