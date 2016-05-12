MIME-Version: 1.0
Date: Thu, 12 May 2016 16:42:00 -0700
Message-ID: <CAEMXjGyohbJkCzMDTGWfhbREdmbT7VWoHpinyvbLTdpyRkEw1Q@mail.gmail.com>
From: Steve B <sbattazzo@gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: [Xenomai] XDDP socket,
	any memory allocation when sendto() is called?
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai <xenomai@xenomai.org>

Hi guys,
Does sendto() going into an XDDP socket involve any memory allocation
that's not automatically getting de-allocated each time it's called?

I have an application running where I am writing a few different types of
data packets to an XDDP socket on a fixed periodic basis, and in a separate
console using "free" I see the memory usage increasing steadily until I
only have about 5MB left, at which point it doesn't grow/shrink anymore. I
don't seem to be losing any data after this happens, though.

I tried temporarily disabling my largest packet type, and saw that the rate
of memory consumption decreases very significantly, which is why I think it
has something to do with this.

I may be able to live with this if it's not causing any real problems but
it is a little unsettling...

Thanks!

Steve
