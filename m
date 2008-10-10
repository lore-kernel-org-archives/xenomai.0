Message-ID: <48EF76E1.4070706@domain.hid>
Date: Fri, 10 Oct 2008 17:38:09 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <819144.28662.qm@domain.hid>
In-Reply-To: <819144.28662.qm@domain.hid>
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
>> Where does custom_except leaves, in kernel-space or user-space ?
> 
> I have called rthal_trap_catch in the init function of the KD.
> I have tried also in a rt task inside KD.
> 
>>> - KD has an rtdm interface to map the 16 MB memory on user space with
>>> rtdm_iomap_to_user.
>>> - UD starts and It maps with the rtdm (rtdm_iomap_to_user)
>> This is completely useless. You can use an anonymous mapping in
>> user-space, you will not need the help from an rtdm driver. And your
>> mapping needs to be executable (you need to pass PROT_EXEC to mmap).
>>> - UD copy a binary asm x86 test fpu (some instructions to generate
>>> exceptions for tests) in the 16 MB memory mapped
>> If you do that, your binary needs to be relocatable, that is its code
>> must not depend on the address at which it is loaded. Are you sure your
>> binary blob has this property ?
> 
> It's a long story... I know anonymous mapping is better but I have need physical contiguos memory
> (not for the test of course). The binary blob has fixed addresses between 1 to 16 MB so I have mapped the first 15 MB of the UD (starting to 1 MB). I Know it is very strange...

To do this with RTDM, you should use rtdm_mmap_to_user, not
rtdm_iomap_to_user. And to do this with an anonymous mapping, you simply
need to pass the address where you want the mmap to occur to mmap, and
pass MAP_FIXED to mmap flags, this is all documented in mmap manual.

> I start UD from the terminal and the terminal always report the right error.

Ok. Probably the I-pipe patch only calls your callback for real-time
tasks. Is the thread which runs the binary blob created with xenomai
services ?

-- 
                                                 Gilles.

