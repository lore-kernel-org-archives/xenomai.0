Message-ID: <5268E1A3.4070206@xenomai.org>
Date: Thu, 24 Oct 2013 11:00:19 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <patchbomb.1381827036@devws164.be.alcatel-lucent.com>	<5262C351.8010704@xenomai.org>	<CAMJ=MEdj=y2Uj_y2tr9+Dfvy1r57rhnNqTWxjo500JhVk4qbVg@mail.gmail.com>	<CAKc2HpY8CP+Kt63y_yvpuyjS8hb7Nep3veSgKBv0sT4C74LBMg@mail.gmail.com>	<5266B0B0.3030006@xenomai.org>	<CAKc2HpacwSTShmnGT6q9P7TBvGSrVhbQ8vDRRY3xJS4fuFwUgg@mail.gmail.com>
 <CAKc2HpY81vxvmtrkXr6RowMgqLz9n+rrtojiTQZ0VvOut6exYQ@mail.gmail.com>
In-Reply-To: <CAKc2HpY81vxvmtrkXr6RowMgqLz9n+rrtojiTQZ0VvOut6exYQ@mail.gmail.com>
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
To: Kim De Mey <kim.demey@gmail.com>
Cc: xenomai@xenomai.org

On 10/24/2013 10:28 AM, Kim De Mey wrote:
>
>
>
> 2013/10/22 Kim De Mey <kim.demey@gmail.com <mailto:kim.demey@gmail.com>>
>
>
>
>
>     2013/10/22 Philippe Gerum <rpm@xenomai.org <mailto:rpm@xenomai.org>>
>
>         On 10/22/2013 06:45 PM, Kim De Mey wrote:
>
>
>
>
>             2013/10/19 Ronny Meeus <ronny.meeus@gmail.com
>             <mailto:ronny.meeus@gmail.com>
>             <mailto:ronny.meeus@gmail.com <mailto:ronny.meeus@gmail.com>>__>
>
>
>
>                      IIUC, this would add the quite unexpected
>             requirement of having
>                      to reopen a file for getting fresh data. read()
>             should actually
>                      (re-)read the current object state each time it is
>             invoked, and
>                      not resend some frozen state collected by the
>             corresponding
>                      open() indefinitely.
>
>                      e.g. this has to work with code like:
>
>                               fd =
>             open("/mnt/xenomai/1235/foo/____tasks", O_RDONLY);
>
>                               for (;;) {
>                                       ret = read(fd, buf, sizeof(buf));
>                                       ... process NEW data ...
>                               }
>
>                  Philippe,
>                  how to handle the case where the data is bigger than de
>             buffer
>                  passed by the user?
>                  Suppose the task data is 20k while the user read only
>             wants 4k. I
>                  would expect that the second read returns the second 4k
>             block and so on.
>                  By generating the complete output in 1 shot (for
>             example at open),
>                  the data would be more consistent in my opinion too.
>                  Suppose the data of a queue is dumped and the queue
>             contains a lot
>                  of messages. I would like to see a consistent view on
>             the queue and
>                  not the first 4k followed by some random messages after
>             it because
>                  the application is processing the queue in parallel.
>
>             Philippe,
>
>             As Ronny explains, the reason of "storing the state" at open
>             is so that
>             the data we read would be consistent. So yes, I think we
>             need this.
>
>
>         I don't think so. Implementing a snapshot mechanism so that
>         reading from a channel does return a consistent set of data does
>         not mean that we should do this in open(). This only means that
>         we should implement a snapshot mechanism for reading.
>
>
>     I meant that we need to be able to "store the state", not that we
>     necessary need to do it in the open(). My sentence was confusing,
>     sorry. As I explained further in my previous post we could do it in
>     the initial read() like it is done in sysfs for example.
>
> Philippe,
>
> I noticed that you made some changes to the registry code. Does this
> mean you have a plan in mind on how to tackle the "issue" in the
> discussion above?
>

I'm adding flexibility to the registry code, since there won't be any 
one-fits-it-all solution, the client code should be able to define its 
own policy with respect to handling fuse read requests, without imposing 
a standard on the others. This is basically why the snapshot mechanism 
should not be implemented in the generic registry code handling file 
open requests, because other clients may want to act as unbuffered data 
sources, returning fresh values each time they are read, assuming those 
values always fit in a fuse read request.

By exposing the open and release requests to the client code, we may 
allow clients to deal with snapshot the way you wanted initially, 
without imposing it to all others, making the approach acceptable.

I'm considering adding a simple mechanism for accumulating snapshot 
data, that would be seekable from the client read() handler, maybe just 
based on GNU obstacks, with a revision tag to detect changes in the data 
set being snapshot, so that the client code does not have to hold locks 
throughout the entire iteration over the object contents. This would be 
reminiscent of what we already do with Cobalt's vfiles 
(kernel/cobalt/vfile).

-- 
Philippe.

