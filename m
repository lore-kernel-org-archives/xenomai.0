MIME-Version: 1.0
Sender: had2006@gmail.com
In-Reply-To: <554CBC2B.7090203@xenomai.org>
References: <CAKk99t1TPO3Tv5c+WLqPR0rcypa1bvA6tiKhoqu7cdTvAotDPQ@mail.gmail.com>
 <554CBC2B.7090203@xenomai.org>
Date: Fri, 8 May 2015 15:38:05 +0100
Message-ID: <CAKk99t0bY9P5o2fh84XS4teZ8GthySnMnfn614xn9L_zP4cSFA@mail.gmail.com>
From: Helder Daniel <hdaniel@ualg.pt>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Xenomai] Can rtdm_read, rtdm_write,
 be used in userspace in Xenomai 3.x
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>
Cc: "Xenomai@xenomai.org" <xenomai@xenomai.org>

Ok, the problem was indeed that the wrappers was not linked.
After telling xeno-config to generate switches for APIs --alchemy and
--posix its working fine.

Thanks

On 8 May 2015 at 14:37, Philippe Gerum <rpm@xenomai.org> wrote:

> On 05/08/2015 01:28 PM, Helder Daniel wrote:
> > Hi,
> >
> > I am writing a driver that implements read_rt and read_nrt handlers for
> > Xenomai 3-rc4 Cobalt.
> > But I am having problems when trying to read from user space in comand
> line:
> >
> > $> cat /dev/rtdm/device0
> > cat: /dev/rtdm/device0: Invalid argument
> >
> > and also from a user space real time thread:
> >
> > f = open("/dev/rtdm/device0");
> > for(;;){
> >    rt_task_wait_period(NULL);
> >    read (f, &count, 1);
> > //...
> >
> > This read gives me garbage.
> >
> >
>
> [snip]
>
> > Looking at kernel log, after accessing the driver from user spcae both:
> >
> > in cmd line with:
> >
> > $> cat /dev/rtdm/device0
> >
> > and from a real time task
> >
> > it seems that the open, close and read are never called, since there is
> no
> > entry in kernel log.
> >
> > I am doing something wrong?
>
> The Cobalt read() service must be called for invoking the related
> read_[n]rt handler in your RTDM driver. Since the cat command will use
> the regular glibc read() call instead, this won't work. Your test
> program is likely missing the wrapping step, which is performed by a
> linker trick, substituting calls to read() and other POSIX services to
> the corresponding Cobalt implementation. In your test, the glibc
> counterpart is still used, which won't work either.
>
> You need to make sure to pass --posix to xeno-config --ldflags for
> retrieving the proper LDFLAGS that do the magic for wrapping POSIX
> calls. You can combine APIs with xeno-config, such as --alchemy --posix.
>
> >
> > Should I use rtdm_read in user space to access the driver?
> >
>
> No, this is a kernel-space only service, for inter-driver communication.
> This is the reason why you can't pull the related declarations in a
> user-space program.
>
> --
> Philippe.
>



-- 
Helder Daniel
UALG - FCT
DEEI

http://w3.ualg.pt/~hdaniel
