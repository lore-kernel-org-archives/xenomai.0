MIME-Version: 1.0
In-Reply-To: <5735DB97.5080804@xenomai.org>
References: <CAEMXjGyohbJkCzMDTGWfhbREdmbT7VWoHpinyvbLTdpyRkEw1Q@mail.gmail.com>
 <5735DB97.5080804@xenomai.org>
Date: Fri, 13 May 2016 10:53:48 -0700
Message-ID: <CAEMXjGws9VOasRJh2aV+bTXDvqFHTP4yuWD_T7hPp7BJCnM+bA@mail.gmail.com>
From: Steve B <sbattazzo@gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Xenomai] XDDP socket,
	any memory allocation when sendto() is called?
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
Cc: xenomai <xenomai@xenomai.org>

On Fri, May 13, 2016 at 6:50 AM, Philippe Gerum <rpm@xenomai.org> wrote:

> On 05/13/2016 01:42 AM, Steve B wrote:
> > Hi guys,
> > Does sendto() going into an XDDP socket involve any memory allocation
> > that's not automatically getting de-allocated each time it's called?
> >
> > I have an application running where I am writing a few different types of
> > data packets to an XDDP socket on a fixed periodic basis, and in a
> separate
> > console using "free" I see the memory usage increasing steadily until I
> > only have about 5MB left, at which point it doesn't grow/shrink anymore.
> I
> > don't seem to be losing any data after this happens, though.
> >
> > I tried temporarily disabling my largest packet type, and saw that the
> rate
> > of memory consumption decreases very significantly, which is why I think
> it
> > has something to do with this.
> >
> > I may be able to live with this if it's not causing any real problems but
> > it is a little unsettling...
>
> The memory is freed upon read() on the other side. Do the datagrams
> linger somehow on the (non-rt) read-side?
>
> --
> Philippe.
>

The non-rt side just reads the messages and writes them to binary files. I
have a slightly over 1k byte message coming across 100x per second, and log
files are saved off and new files are created every 60 seconds. The files
are pretty consistently coming out at 6.5 MB give or take a few percent (I
think the slop is mostly in the time keeping in the non-RT side). So I
think all of my data is there, though I wonder if whatever buffering there
is between the RT and non-RT side may be overflowing. I would think that I
should be seeing failures in my writes if the buffer is full?

That actually does bring me to the question, do I even need to be buffering
my on board log files to the non-RT side via XDDP at all? Could I just
write the files straight from my RT side?

Thanks,

Steve
