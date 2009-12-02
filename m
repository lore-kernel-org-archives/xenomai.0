Message-ID: <4B16304B.3060206@domain.hid>
Date: Wed, 02 Dec 2009 10:15:55 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <4B15AFC0.6020805@domain.hid> <4B1627DC.30300@domain.hid>
In-Reply-To: <4B1627DC.30300@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] [pull request] Signals support.
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: Xenomai core <Xenomai-core@domain.hid>

Jan Kiszka wrote:
> Gilles Chanteperdrix wrote:
>> Hi,
>>
>> here come the pull request for user-space signals support. The simple 
>> solution; handling signals upon system call return, has been implemented
>> since the other solution (handling signals upon any return to 
>> user-space) required to change the I-pipe patch, and so made the 
>> upcoming 2.5 only compatible with newer patches.
>>
>> We pass to kernel-space a sixth argument which is a pointer where 
>> information about received signals is stored by kernel.
>>
>> The only architecture for which the implementation is peculiar is 
>> x86_32, because the register used as sixth argument is ebp, also used 
>> for the libc backtrace function implementation, so I tried to find a 
>> solution which makes backtracing still possible (otherwise we would have
>> said bye-bye to involuntary mode changes chasing with SIGXCPU) without 
>> breaking too many things.
> 
> I'm still digging through the code. A few minor remarks regarding the
> user space side so far:
> 
> XENOMAI_DO_SYSCALL becomes quite "bloated" now, and it's inlined. Did
> you check that the fast path (ie. no signal) only contains one
> conditional branch when the compiler is done with optimizing? If not (I
> suspect so), the code should be refactored to look more like
> 
> restart:
> 	do_syscall
> 	if unlikely(sigs.nsigs)
> 		res = handle_signals
> 		if res == -ERESTART
> 			goto restart

The test for sigs.nsigs is done in the inline xnsig_dispatch function,
which jumps to the out-of-line dispatch function only if there are
really some signals to handle. Then comes the test while (sigs.nsigs &&
sigs.remaining), so my hope was that the compiler would optimize the
jump-after-conditional-to-a-conditional-with-same-condition, this is a
pretty standard optimization, but have not checked that it did so.

As for the goto, I have nothing against gotos when they are needed, but
in that case we can easily avoid it with a do while loop.

> 
> Moreover, the inner while loop over sigs.remaining should be moved into
> a shared function as well. I don't see why it should be instantiated at
> each and every syscall invocation site.

The point is that when there are more than a fixed amount of signals
queued (16, arbitrarily fixed to allow for some queueing, but avoid
taking too much room on stack), we emit a second "inner" syscall to get
them. And the way to emit this second syscall is platform-dependent. The
code at this point is pretty much the same on all platforms... except on
x86_32, though it is probably possible to factor this out with clever
macros.

> 
> Am I right, there is no skin (except the test skin) using this feature
> so far?

Yes, we break the ABI first, and we will implement the posix skin
signals after the initial 2.5 release. Because the signals data union is
part of the ABI, it has already been given the posix siginfo structure
size. Since this structure is pretty large, I expected no skin to need
more room.

-- 
					    Gilles.

