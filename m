From: Jeff Weber <jweber@domain.hid>
Date: Thu, 12 Apr 2007 08:18:00 -0500
References: <200704111656.18894.jweber@domain.hid>
	<b647ffbd0704111535l4e756c77he276a57f0f5f32cb@domain.hid>
In-Reply-To: <b647ffbd0704111535l4e756c77he276a57f0f5f32cb@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200704120818.00897.jweber@domain.hid>
Subject: Re: [Xenomai-help] Linux system calls from RT kernel task
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Dmitry Adamushko <dmitry.adamushko@domain.hid>
Cc: Xenomai help <xenomai@xenomai.org>

On Wednesday 11 April 2007 17:35, Dmitry Adamushko wrote:
> On 11/04/07, Jeff Weber <jweber@domain.hid> wrote:
> > Are there any restrictions against calling the Linux kernel, namely
> > do_gettimeofday(), from a Xenomai kernel task?
> >
> > Does the kernel space task switch from primary to secondary mode, just as
> > a user space task would?
>
> No.
Ok, so is a Xenomai kernel-based thread essentially locked into primary mode?  
And if so, would calls to rt_task_set_mode(T_PRIMARY,0,0) then be illegal?
>
> Regarding the use of Linux kernel functions, consider it from the
> point that your rt task (in general, any activity from the primary
> domain) could have interrupted the Linux kernel at any (well, almost)
> point.. i.e. some spin_locks can be held by the kernel and if you
> happen to call a function from the primary domain that does use these
> locks - well, nothing good is going to happen. In general, it's a no
> go.
What's the best general way to describe the list of functions that can use 
these locks, so I can avoid this scenario in the future?

	Jeff

