Message-ID: <48F08CD0.8000809@domain.hid>
Date: Sat, 11 Oct 2008 13:24:00 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <129381.87674.qm@domain.hid>
In-Reply-To: <129381.87674.qm@domain.hid>
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
> 
> 
>>> It's a long story... I know anonymous mapping is better but I have need physical contiguos memory
>>> (not for the test of course). The binary blob has fixed addresses between 1 to 16 MB so I have mapped the 
>> To do this with RTDM, you should use rtdm_mmap_to_user, not
>> rtdm_iomap_to_user. And to do this with an anonymous mapping, you simply
>> need to pass the address where you want the mmap to occur to mmap, and
>> pass MAP_FIXED to mmap flags, this is all documented in mmap manual.
> 
> I did't specify I have passed mem=xxx to kernel to take the upper 16MB so I have to use rtdm_iomap_to_user.
> I think the RTDM mapping works.

Yes, but I still think this is useless. If your user-space code expects
to be running from 1MB to 16MB, it expects this for virtual addresses,
not for physical addresses. So, I really think you should mmap the 1MB
to 16MB region by passing the start address to mmap with the MMAP_FIXED
flag.

> 
>>> I start UD from the terminal and the terminal always report the right error.
>> Ok. Probably the I-pipe patch only calls your callback for real-time
>> tasks. Is the thread which runs the binary blob created with xenomai
>> services ?
> 
> my_rt_task_func()
> {
>     int 3 // This is trapped by the custom exception routine (forwarded to xenomai handler). The terminal write
>             // trace/breakpoint trap
> }
> 
> my_rt_task_func()
> {
>     call *asm_part
> }
> 
> asm_part --- (it has been copied in the first 16 MB of user task mapped to the 16 MB kernel memory)
> 
> int 3 // This is not trapped by the custom exception routine however the a trace/breakpoint trap is raised and
>        //  it is written in terminal

You should trace the exception path in the I-pipe patch to find the
point where your exception handling callback is not called.

-- 
					    Gilles.

