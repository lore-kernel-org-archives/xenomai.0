MIME-Version: 1.0
In-Reply-To: <5262C351.8010704@xenomai.org>
References: <patchbomb.1381827036@devws164.be.alcatel-lucent.com>
	<5262C351.8010704@xenomai.org>
From: Ronny Meeus <ronny.meeus@gmail.com>
Date: Sat, 19 Oct 2013 20:56:05 +0200
Message-ID: <CAMJ=MEdj=y2Uj_y2tr9+Dfvy1r57rhnNqTWxjo500JhVk4qbVg@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Subject: Re: [Xenomai] [PATCH 0 of 3] Xenomai-forge: Initial implementation
 of registry for pSOS
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai@xenomai.org

>
>
>
>
> IIUC, this would add the quite unexpected requirement of having to reopen
> a file for getting fresh data. read() should actually (re-)read the current
> object state each time it is invoked, and not resend some frozen state
> collected by the corresponding open() indefinitely.
>
> e.g. this has to work with code like:
>
>         fd = open("/mnt/xenomai/1235/foo/**tasks", O_RDONLY);
>         for (;;) {
>                 ret = read(fd, buf, sizeof(buf));
>                 ... process NEW data ...
>         }
>
>
Philippe,

how to handle the case where the data is bigger than de buffer passed by
the user?
Suppose the task data is 20k while the user read only wants 4k. I would
expect that the second read returns the second 4k block and so on.

By generating the complete output in 1 shot (for example at open), the data
would be more consistent in my opinion too.
Suppose the data of a queue is dumped and the queue contains a lot of
messages. I would like to see a consistent view on the queue and not the
first 4k followed by some random messages after it because the application
is processing the queue in parallel.

Ronny
