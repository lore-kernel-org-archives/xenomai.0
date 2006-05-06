Message-ID: <445C7C80.9080105@domain.hid>
Date: Sat, 06 May 2006 12:37:52 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] [RFC] Micro-optimisations for the libs
References: <445C59C9.8020107@domain.hid>
In-Reply-To: <445C59C9.8020107@domain.hid>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: Daniel.Rossier@domain.hid, xenomai-core <xenomai@xenomai.org>

Jan Kiszka wrote:
> Hi,
> 
> [Daniel, I put you in the CC as you showed some interest in this topic.]
> 
> as I indicated a some weeks ago, I had a closer look at the code the
> user space libs currently produce (on x86). The following considerations
> are certainly not worth noticeable microseconds on GHz boxes, but they
> may buy us (yet another) few micros on low-end.
> 
> First of all, there is some redundant code in the syscall path of each
> skin service. This is due to the fact that the function code is
> calculated based on the the skin mux id each time a service is invoked.
> The mux id has to be shifted and masked in order to combine it with the
> constant function code part - this could also easily happen
> ahead-of-time, saving code and cycles for each service entry point.
> 
> Here is a commented disassembly of some simple native skin service which
> only takes one argument.
> 
> 
> Function prologue:
>  460:   55                      push   %ebp
>  461:   89 e5                   mov    %esp,%ebp
>  463:   57                      push   %edi
>  464:   83 ec 10                sub    $0x10,%esp
> 
> Loading the skin mux-id:
>  467:   a1 00 00 00 00          mov    0x0,%eax
> 
> Loading the argument (here: some pointer)
>  46c:   8b 7d 08                mov    0x8(%ebp),%edi
> 
> Calculating the function code:
>  46f:   c1 e0 10                shl    $0x10,%eax
>  472:   25 00 00 ff 00          and    $0xff0000,%eax
>  477:   0d 2b 02 00 08          or     $0x800022b,%eax
> 
> Saving the code:
>  47c:   89 45 f8                mov    %eax,0xfffffff8(%ebp)
> 
>  47f:   53                      push   %ebx
> 
> Loading the arguments (here only one):
>  480:   89 fb                   mov    %edi,%ebx
> 
> Restoring the code again, issuing the syscall:
>  482:   8b 45 f8                mov    0xfffffff8(%ebp),%eax
>  485:   cd 80                   int    $0x80
> 
>  487:   5b                      pop    %ebx
> 
> Function epilogue:
>  488:   83 c4 10                add    $0x10,%esp
>  48b:   5f                      pop    %edi
>  48c:   5d                      pop    %ebp
>  48d:   c3                      ret
> 
> 
> Looking at this code, I also started thinking about inlining short and
> probably heavily-used functions into the user code. This would save the
> function prologue/epilogue both in the lib and the user code itself. For
> sure, it only makes sense for time-critical functions (think of
> mutex_lock/unlock or rt_timer_read). But inlining could be made optional

The best optimization for rt_timer_read() would be to do the 
cycles-to-ns conversion in user-space from a direct TSC reading if the 
arch supports it (most do). Of course, this would only be possible for 
strictly aperiodic timing setups (i.e. CONFIG_XENO_OPT_PERIODIC_TIMING off).

For the rt_mutex_lock()/unlock(), we still need to refrain from calling 
the kernel for uncontended access by using some Xeno equivalent of the 
futex approach, which would suppress most of the incentive to 
micro-optimize the call itself.

> for the user by providing both the library variant and the inlined
> version. The users could then select the preferred one by #defining some
> control switch before including the skin headers.
> 
> Any thoughts on this? And, almost more important, anyone around willing
> to work on these optimisations and evaluate the results? I can't ATM.
> 

Quite frankly, I remember that I once had to clean up the LXRT inlining 
support in RTAI 3.0/3.1, and this was far from being fun stuff to do. 
Basically, AFAICT, having both inline and out-of-line support for 
library calls almost invariably ends up to a maintenance nightmare of 
some sort, e.g. depending whether to compile with gcc's optimization on 
or not, which might be dictated by the fact that one also wants 
(exploitable) debug information or not, and so on. Not to speak of the 
fact that you end up having two implementations to maintain separately.

This said, only the figures would tell us if such inlining brings 
something significant or not to the picture performance-wise on low-end 
hw, so I'd be interested to see those first.

-- 

Philippe.

