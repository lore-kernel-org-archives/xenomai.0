MIME-Version: 1.0
In-Reply-To: <4AF813D2.2000001@domain.hid>
References: <ddc6e05e0911090400r37e0160aha2c3088dc673c0aa@domain.hid>
	<4AF813D2.2000001@domain.hid>
Date: Mon, 9 Nov 2009 15:22:27 +0100
Message-ID: <ddc6e05e0911090622m52d0297fo24061b6bea475a8e@domain.hid>
From: Remco den Breeje <remco@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Subject: Re: [Xenomai-core] Context-sharing semaphores
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: xenomai-core <xenomai@xenomai.org>

On Mon, Nov 9, 2009 at 2:06 PM, Jan Kiszka <jan.kiszka@domain.hid> wrote:
> The design. :)

I totally agree :) However, I'm using generated (user-space) code that
I want to modify as little as possible. So with a simple ioctl-call I
want to be able to switch between software (pthread) and hardware
triggering (rtdm-driver).

> The proper design is to use a rtdm semaphore or event *inside* the
> kernel and let the application block on it when it calls a related IOCTL
> or other device function that shall synchronize on that condition.
>
> Don't share resources like this between kernel and user space. It's
> unclean, specifically as you once may want to access driver managed data
> along the sleeping/waking as well.
>
> Jan

The sem_open documentation states  "a connection between the semaphore
named name and the calling context (kernel-space as a whole, or
user-space process)". I interpreted this as exactly what I want - a
synchronization between user- and kernel-space. Please correct me if
I'm wrong.

>
> --
> Siemens AG, Corporate Technology, CT SE 2
> Corporate Competence Center Embedded Linux
>

Attached you find an example.
You can run it by executing: `make && sudo insmod ./km.ko && sudo ./um
; sudo rmmod km`

My syslog-output is: "Error opening clock semaphore (2)"

Thanks,

Remco den Breeje

