Message-ID: <4725FDB7.9050703@domain.hid>
Date: Mon, 29 Oct 2007 16:35:19 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <20071029152344.11243.qmail@domain.hid>
In-Reply-To: <20071029152344.11243.qmail@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: Philippe Gerum <philippe.gerum@domain.hid>
Subject: Re: [Xenomai-help] task suspending while starting the task
Reply-To: rpm@xenomai.org
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: poornima r <rpoornar@domain.hid>
Cc: xenomai@xenomai.org

poornima r wrote:
>  
> Hello,
> 
> I am working on powerPC board latest Xenomai stable version.
> I am communicating between two kernel(queue1.c and queue2.c)modules
> using Message queues.The queue descriptor is shared between the two
> kernel modules by using EXPORT_SYMBOL(queue_desc).
> The data is sent to the user space(read.c) through message pipes.
> This program runs fine somtimes but sometimes the task gets suspended
> while starting the task.

dmesg output?

-- 
Philippe.

