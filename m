Message-ID: <48EF7D19.7000608@domain.hid>
Date: Fri, 10 Oct 2008 18:04:41 +0200
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

This does not tell me how the thread running "my_rt_task_func" is created.

-- 
                                                 Gilles.

