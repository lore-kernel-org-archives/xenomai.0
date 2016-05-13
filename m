References: <CAEMXjGyohbJkCzMDTGWfhbREdmbT7VWoHpinyvbLTdpyRkEw1Q@mail.gmail.com>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <5735DB97.5080804@xenomai.org>
Date: Fri, 13 May 2016 15:50:15 +0200
MIME-Version: 1.0
In-Reply-To: <CAEMXjGyohbJkCzMDTGWfhbREdmbT7VWoHpinyvbLTdpyRkEw1Q@mail.gmail.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
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
To: Steve B <sbattazzo@gmail.com>, xenomai <xenomai@xenomai.org>

On 05/13/2016 01:42 AM, Steve B wrote:
> Hi guys,
> Does sendto() going into an XDDP socket involve any memory allocation
> that's not automatically getting de-allocated each time it's called?
> 
> I have an application running where I am writing a few different types of
> data packets to an XDDP socket on a fixed periodic basis, and in a separate
> console using "free" I see the memory usage increasing steadily until I
> only have about 5MB left, at which point it doesn't grow/shrink anymore. I
> don't seem to be losing any data after this happens, though.
> 
> I tried temporarily disabling my largest packet type, and saw that the rate
> of memory consumption decreases very significantly, which is why I think it
> has something to do with this.
> 
> I may be able to live with this if it's not causing any real problems but
> it is a little unsettling...

The memory is freed upon read() on the other side. Do the datagrams
linger somehow on the (non-rt) read-side?

-- 
Philippe.

