MIME-Version: 1.0
In-Reply-To: <518BA407.8020103@xenomai.org>
References: <CAPpP=rOMJi4u7sm9+a79aJ2GhhtJY7B5QD0+tVxsN7KoFMqxCw@mail.gmail.com>
	<518A5F0C.50403@xenomai.org>
	<CAPpP=rNt32NFsF5LhJybpcBRfm33za8kP2tQj+t4Vs9-hkH48w@mail.gmail.com>
	<518ABA3D.5070106@xenomai.org>
	<CAPpP=rOQm+GBuoB5KuAiAo5nG=HzggXb7CyLaP-SHAwebykPUw@mail.gmail.com>
	<518B8C50.2050107@xenomai.org>
	<CAPpP=rNkQTDCfRAxpN5wPNK-5R-4gngpxFGUCiqT2T8gwMKJRg@mail.gmail.com>
	<518BA407.8020103@xenomai.org>
Date: Thu, 9 May 2013 16:09:05 +0200
Message-ID: <CAPpP=rNCxHUfcBS7djmv8i+Er2PpXBdO101LfcxaZswzc9eBnw@mail.gmail.com>
From: alex alex <duch.alexandre@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Subject: Re: [Xenomai] [Posix] I/O multiplexing with select
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Xenomai <xenomai@xenomai.org>

I you call pthread_set_name_np for a thread that may not exist, this is

> an issue which has already been fixed:
>
>
I have tried to used pthread_set_name_np with a thread that may not exist
but it correctly returns ESRCH.

I've also tried to reproduce this bug by creating and canceling a thread in
a loop, but I can not have this bug anymore.
