Message-ID: <4AC4819F.4060809@domain.hid>
Date: Thu, 01 Oct 2009 12:17:03 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <4AC248FD.7050707@domain.hid> <1254391461.2703.176.camel@domain.hid>
In-Reply-To: <1254391461.2703.176.camel@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] RFC: primary mode signals design.
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Philippe Gerum <rpm@xenomai.org>
Cc: Xenomai core <Xenomai-core@domain.hid>

Philippe Gerum wrote:
> On Tue, 2009-09-29 at 19:50 +0200, Gilles Chanteperdrix wrote:
>> Hi,
>>
>> During my flights and connections, I had a thought about this primary
>> mode signals issue.
>>
>> Since the needs in term of primary mode signals greatly depends on what
>> the skins want to do with it (native wants hooks, posix wants posix
>> conformant signals), I think as much work as possible should be done in
>> the nucleus and skins implementation, not in the I-pipe (as usual). So,
>> I propose to:
>> 1- add an I-pipe SIGNAL_PENDING event
>> 2- add a bit somewhere in the task_struct or thread_info stuctures
>> indicating that signals are pending
>> 3- add a service to mark the bit, like:
>> int ipipe_mark_signal_pending(struct task_struct *task);
>> 4- in entry.S, when going back to user-space, test and clear the bit is
>> set, and if it was set, trigger the event
>> 5- implement services allowing to run a callback with some cookie when
>> returning to user-space, we may also need to be able to push on stack
>> some arguments that should be passed to the callback, (we need this
>> service internally anyway to push the pt_regs structure on stack, so
>> that the calling context can be restored after execution of the
>> callback, and we need a little help from user-space for this
>> restoration, probably in bind.h).
> 
> What bothers me is that we would duplicate what the kernel does in
> do_signal() for most architectures, and go through many hops from the

Maybe we can re-use the linux kernel code? Maybe we can even make that
code platform independent and put it in the nucleus, using the xnregs*
macros, and maybe adding some more to alter the pt_regs structure to
cause the return to user-space to pass by the callback, and to be able
to push some data on the stack, imposing the need of a syscall to
restore context.

-- 
                                          Gilles


