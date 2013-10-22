Message-ID: <5266B0B0.3030006@xenomai.org>
Date: Tue, 22 Oct 2013 19:06:56 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <patchbomb.1381827036@devws164.be.alcatel-lucent.com>	<5262C351.8010704@xenomai.org>	<CAMJ=MEdj=y2Uj_y2tr9+Dfvy1r57rhnNqTWxjo500JhVk4qbVg@mail.gmail.com>
 <CAKc2HpY8CP+Kt63y_yvpuyjS8hb7Nep3veSgKBv0sT4C74LBMg@mail.gmail.com>
In-Reply-To: <CAKc2HpY8CP+Kt63y_yvpuyjS8hb7Nep3veSgKBv0sT4C74LBMg@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] [PATCH 0 of 3] Xenomai-forge: Initial implementation
 of registry for pSOS
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Kim De Mey <kim.demey@gmail.com>, Ronny Meeus <ronny.meeus@gmail.com>
Cc: xenomai@xenomai.org

On 10/22/2013 06:45 PM, Kim De Mey wrote:
>
>
>
> 2013/10/19 Ronny Meeus <ronny.meeus@gmail.com
> <mailto:ronny.meeus@gmail.com>>
>
>
>         IIUC, this would add the quite unexpected requirement of having
>         to reopen a file for getting fresh data. read() should actually
>         (re-)read the current object state each time it is invoked, and
>         not resend some frozen state collected by the corresponding
>         open() indefinitely.
>
>         e.g. this has to work with code like:
>
>                  fd = open("/mnt/xenomai/1235/foo/__tasks", O_RDONLY);
>                  for (;;) {
>                          ret = read(fd, buf, sizeof(buf));
>                          ... process NEW data ...
>                  }
>
>     Philippe,
>     how to handle the case where the data is bigger than de buffer
>     passed by the user?
>     Suppose the task data is 20k while the user read only wants 4k. I
>     would expect that the second read returns the second 4k block and so on.
>     By generating the complete output in 1 shot (for example at open),
>     the data would be more consistent in my opinion too.
>     Suppose the data of a queue is dumped and the queue contains a lot
>     of messages. I would like to see a consistent view on the queue and
>     not the first 4k followed by some random messages after it because
>     the application is processing the queue in parallel.
>
> Philippe,
>
> As Ronny explains, the reason of "storing the state" at open is so that
> the data we read would be consistent. So yes, I think we need this.
>

I don't think so. Implementing a snapshot mechanism so that reading from 
a channel does return a consistent set of data does not mean that we 
should do this in open(). This only means that we should implement a 
snapshot mechanism for reading.

Any external code to Xenomai (e.g. "cat") shall be able to open a 
registry file once, then read from that channel any number of times, 
taking a fresh snapshot of the system state each time. This is why 
open() cannot be be used for this.

Whether fuse introduces some issues wrt the size of the read buffer is 
another matter which is orthogonal to that matter.

-- 
Philippe.

