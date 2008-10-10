Message-ID: <48EF600C.3060306@domain.hid>
Date: Fri, 10 Oct 2008 16:00:44 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <39918.70429.qm@domain.hid>
In-Reply-To: <39918.70429.qm@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] trap exceptions in user
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Gabriele Moabiti <gabmoa@domain.hid>
Cc: Xenomai help <xenomai@xenomai.org>

Gabriele Moabiti wrote:
> 
>> Xenomai uses rthal_trap_catch, so, you can use Xenomai code as an
>> example.
> 
> Named KD: kernel driver (ring 0). UD: user space task (ring 3).
> 
> - KD reserve 16 MB  of memory (note: virtual and physical contiguous)
> 
> 
> - I use rthal_trap_catch to customize exceptions (redirected to
> "custom_except" function) The "custom_except" function print the
> number of exception and recall the xenomai standard one.

Where does custom_except leaves, in kernel-space or user-space ?

> 
> - KD has an rtdm interface to map the 16 MB memory on user space with
> rtdm_iomap_to_user.
> 
> - UD starts and It maps with the rtdm (rtdm_iomap_to_user)

This is completely useless. You can use an anonymous mapping in
user-space, you will not need the help from an rtdm driver. And your
mapping needs to be executable (you need to pass PROT_EXEC to mmap).

> 
> - UD copy a binary asm x86 test fpu (some instructions to generate
> exceptions for tests) in the 16 MB memory mapped

If you do that, your binary needs to be relocatable, that is its code
must not depend on the address at which it is loaded. Are you sure your
binary blob has this property ?

> 
> - UD start the real time task
> 
> Now here is a the problem. If I invoke an exception (int 3, floating
> point exception and so on) outside the 16 MB mapped memory
> "custom_except" is called ok. If the same code is invoked into the 16
> MB mapped memory the program crash (and this is ok) reporting the
> description of the exception in the terminal (also this is ok) but
> "custom_except" is not called!

Who reports the exception, then ? Are you sure the exception reported is
the one you expect ? IOW, are you sure the problem is not that your
memory mapping is not executable ?

> 
> Is there something wrong using the mapped memory in this mode?
> 
> NOTE: I am using xenomai 2.4.0rc1 with kernel 2.6.23

Is this a joke ? Why choosing a release candidate of a release which
happened since then ? Why not using the latest stable release ?


-- 
                                                 Gilles.

