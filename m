Message-ID: <b647ffbd0704111535l4e756c77he276a57f0f5f32cb@domain.hid>
Date: Thu, 12 Apr 2007 00:35:50 +0200
From: "Dmitry Adamushko" <dmitry.adamushko@domain.hid>
In-Reply-To: <200704111656.18894.jweber@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <200704111656.18894.jweber@domain.hid>
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
To: Jeff Weber <jweber@domain.hid>
Cc: Xenomai help <xenomai@xenomai.org>

On 11/04/07, Jeff Weber <jweber@domain.hid> wrote:
> Are there any restrictions against calling the Linux kernel, namely
> do_gettimeofday(), from a Xenomai kernel task?
>
> Does the kernel space task switch from primary to secondary mode, just as a
> user space task would?

No.

Regarding the use of Linux kernel functions, consider it from the
point that your rt task (in general, any activity from the primary
domain) could have interrupted the Linux kernel at any (well, almost)
point.. i.e. some spin_locks can be held by the kernel and if you
happen to call a function from the primary domain that does use these
locks - well, nothing good is going to happen. In general, it's a no
go.

There were a number of discussions on this topic.

e.g. https://mail.gna.org/public/xenomai-core/2007-03/msg00099.html

>
>         thanks,
>         Jeff

-- 
Best regards,
Dmitry Adamushko

