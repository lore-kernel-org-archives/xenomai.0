Message-ID: <51C61888.8080004@gmail.com>
Date: Sat, 22 Jun 2013 23:35:04 +0200
From: Manuel Huber <manuel.h87@gmail.com>
MIME-Version: 1.0
References: <51BE2859.8000307@gmail.com> <51BE9E2C.9090204@web.de>
	<51BEDC9B.6040603@gmail.com> <51C54A88.3050003@web.de>
	<51C5F102.8010803@gmail.com>
In-Reply-To: <51C5F102.8010803@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Problem accessing msg_name in rt_udp_recvmsg
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jan Kiszka <jan.kiszka@web.de>
Cc: xenomai@xenomai.org

> Isn't msg->msg_name a user space buffer? Why is it possible to access
> it from kernel space (Line 424 - 426)? I'm not really familiar with
> the Linux kernel that much, therefore I checked some other parts of
> RTnet (ipv4/tcp/tcp.c) and there is something strange as well:
>
>     2053     len = msg->msg_iov[0].iov_len;
>     2054     buf = msg->msg_iov[0].iov_base;
>
> So I'm really getting confused... I mean wouldn't such a bug cause
> serious problems? I'm running RTnet since months using the recvmsg
> system call (udp) all the time and never encountered a problem. Sorry
> ifthis question is somehow stupid, I really tried to figure it out
> myself...
Okay, sorry; There is a big difference between Linux and Xenomai most
probably.Is it possible to access any user-space buffer from Xenomai
in Primary Mode? What happens when a buffer is to small or invalid?
Is it a problem to use rtdm_(safe_)copy_to_user in Primary Mode or does
it only add overhead?

Sorry for not paying enough attention in first place, and for asking
so many questions...
