Message-ID: <538645E1.3000604@xenomai.org>
Date: Wed, 28 May 2014 22:24:01 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <CAO0fa7ZiofUS3wsbx89uYsnt6icuv+DVcDbiEfVyG5DUeprj2w@mail.gmail.com>	<5382E8B1.8070402@xenomai.org>	<CAO0fa7YQ0TxiAhbmFmt+41o+rugoLXKjXxtHygpthNOiu8gd9w@mail.gmail.com>	<5383406C.4070902@xenomai.org>	<CAO0fa7YavfJxxLW6h3Wm8CRmS2+yb9Uhv5RDfsv04+pcpvorFg@mail.gmail.com>	<CAO0fa7byLgJQ2_sLDtJLmjsf=oh2NF7k37qnWWxmwhZW6N1ksw@mail.gmail.com>	<CAO0fa7YGSCmPducStbh7sM=HJtPYq86iO1e2ZAaKyjUjzPMEUA@mail.gmail.com>	<5385F190.7050303@xenomai.org>	<C528C59E-AFE8-4810-AC6F-E58A2C1DA47D@mah.priv.at>	<538622C8.6000906@xenomai.org>
 <CAO0fa7as++VjLsRckoZ5XQ1nsfSwMvu3CUmQJVyr0PLyWjNntg@mail.gmail.com>
In-Reply-To: <CAO0fa7as++VjLsRckoZ5XQ1nsfSwMvu3CUmQJVyr0PLyWjNntg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] gdb / threads on beaglebone black
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Drew <pythondrew@gmail.com>
Cc: "Xenomai@xenomai.org" <xenomai@xenomai.org>

On 05/28/2014 09:19 PM, Drew wrote:
> On Wed, May 28, 2014 at 1:54 PM, Gilles Chanteperdrix <
> gilles.chanteperdrix@xenomai.org> wrote:
> 
>>
>> Is there no message printed on the kernel console which would explain
>> why this syscall gets rejected?
>>
> 
> A good idea! Unfortunately, after hooking up my debug serial cable I don't
> see any message when this happens. Running tail -f /var/log/messages
> doesn't show anything suspicious either. (well, it did find some things I
> didn't clean up in my main application... ;-)
> 
> Grepping around for sys_barrier I come up with ksrc/nucleus/shadow.c. Does
> that contain the kernel side of the do while loop? I notice that
> xnshadow_sys_trace (which seems debugger related to me..) defaults its
> error to -ENOSYS...
> 
The problem is syscall restarting by calling the syscall
sys_restart_syscall. When it appeared in entry.S, I made the assumption
that it would only be used for Linux syscall, that Xenomai syscall would
never have anything else than current_thread_info()->restart_block.fn
equal to "do_not_restart_syscall". This seems to be right most of the
time, except when running under gdb, where the kernel may want to
restart xenomai syscalls.

This implies reworking entry.S somehow. I do not see how yet, but I am
on it.

-- 
                                                                Gilles.

