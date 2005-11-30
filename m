Message-ID: <438DB092.4050308@domain.hid>
Date: Wed, 30 Nov 2005 15:00:50 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] using mq_receive and mq_send
References: <02AA386EB831044F8537A696BA785C78076485@domain.hid>
In-Reply-To: <02AA386EB831044F8537A696BA785C78076485@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: "Landau, Bracha" <BLandau@domain.hid>
Cc: xenomai@xenomai.org.

Landau, Bracha wrote:
> I am using Xenomai on the MPC8272ADS board with kernel 2.6.14.3.
> 
> I've created an application that uses posix message queuing from xenomai.
> 
> When I call mq_open, mq_close, mq_setattr, mq_getattr, mq_unlink - the calls succeed.
> 
> When I call mq_receive or mq_send, the call fails (returns -1) and errno is set to 1 (Operation not permited).
> 
> I put some debugging printk's into the xenomai code and it seems it doesn't even get to the call to __mq_receive or __mq_send from syscall.c (it does get to printk's that I put in  the other __mq_* functions).
> 
> Can anyone help?
> 

You must link your app with the flags output by "xeno-config 
--posix-ldflags". Have a look at skins/posix/demos/Makefile for a 
working example.

-- 

Philippe.

