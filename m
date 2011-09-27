Message-ID: <4E8188CB.4040102@domain.hid>
Date: Tue, 27 Sep 2011 10:26:51 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <cover.1316774468.git.richard.cochran@domain.hid>
	<4E7C8EB2.1020308@domain.hid>
	<20110926114118.GA2213@domain.hid>
In-Reply-To: <20110926114118.GA2213@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] [RFC 0/1] Class driver for raw Ethernet packets
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Richard Cochran <richardcochran@domain.hid>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

On 2011-09-26 13:41, Richard Cochran wrote:
> On Fri, Sep 23, 2011 at 03:50:42PM +0200, Jan Kiszka wrote:
>> On 2011-09-23 13:02, Richard Cochran wrote:
>>> This patch adds a class driver for raw Ethernet drivers under
>>> Xenomai. The goal is to support industrial protocols such as EtherCAT
>>> and IEC 61850, where the "stack" is a user space program needing
>>> direct access at the packet level. The class driver offers interfaces
>>> for registration, buffer management, and packet sending/receiving.
>>>
>>> Although this patch is a kind of first draft, still I have it working
>>> on the Freescale P2020 with a real world application, with very good
>>> results. I can post a patch series for the gianfar driver in the ipipe
>>> tree, if anyone is interested.
>>>
>>> The user space interface is a character device and not a socket, simply
>>> because my applications will probably never need fancy socket
>>> options. The class driver could surely be made to offer a socket
>>> instead, but I think the character is sufficient.
>>
>> Many interesting interfaces already exists for standard PF_PACKET (e.g.
>> time stamping), plus you gain portability this way. So let's not create
>> something special here even if it's sufficient for the first use case.
> 
> Okay, so if the raw packet driver idea finds acceptance (outside of
> rtnet), then I am willing to recast the thing as a socket.
>  
>>>
>>> The class driver is clearly in the wrong directory within the source
>>> tree, but I put it there just to get started. It really does not fit
>>> to any of the other drivers, so it probably would need its own place
>>> under ksrc/drivers.
>>
>> New class, new directory.
>>
>> However, the key question is how this approach relates to RTnet. Right
>> now its likely comparing apples to onions, but that may change as things
>> evolve in the right direction.
>>
>> Can you explain a bit about your NIC driver architecture and the
>> maintenance strategy? It looks like you are taking an approach of
>> patching existing drivers in-tree.
> 
> Yes, that is right.
> 
>> Anything that resolves the
>> maintenance pain we have with the RTnet model is already worth
>> considering. Did you take this approach intentionally? What pros and
>> cons do you see?
> 
> So, here is my story. Many months ago I needed a Xenomai program to
> send and receive raw packets. I looked at rtnet and decided that it
> was way too complicated. So, I added a rtdm character device to the
> Linux Ethernet MAC driver, a rather simple hack:
> 
>  drivers/net/arm/Makefile     |    4 +
>  drivers/net/arm/ixp4xx_eth.c |  316
>  +++++++++++++++++++++++++++++++++++++++++-
>  2 files changed, 319 insertions(+), 1 deletions(-)
> 
> That worked great. I did not bother to implement more than read/write,
> but I used a normal socket to set the multicast Rx list.
> 
> Now, I needed to port that application to a new platform. Again, I
> looked at rtnet (and the recently posted gianfar code), and again I
> came to the conclusion that I was better off with a direct driver
> hack.
> 
> Most of those 316 additional lines, above, were rtdm driver boiler
> plate, and I this time I wanted to abstract the code that will surely
> be the same, like device registration, user space send/receive, and
> buffer management. (Because the eTSEC (gianfar) is much more complex,
> and because I wanted hardware packet classification, the driver patch
> is much larger than before.)
> 
> I admire the rtnet project. Based on my limited understanding of it,
> if I really needed deterministic Ethernet, then I would write a brand
> new driver for the eTSEC (perhaps using gianfar.c as a reference), but
> I would *not* try and adapt the Linux driver.
> 
> Conversely, if I were writing a brand new driver, I would surely offer
> it as an rtnet driver, even thought I only need raw packets.
> 
> However, for the sole requirement of raw Ethernet, I think my simple
> driver API is much easier to work into existing drivers. I also think
> it is way easier to maintain by rebasing on later changes.
> 
> IMHO, the pros of my approach are:
> 
> - Simple to implement new drivers.
> 
>   Compare my rtpacket.h with the rtnet driver headers to see what I
>   mean. Or, read rtnet/Documentation/README.drvporting and ask
>   yourself, is it easy to port a driver to rtnet?

I would be careful with deriving generic properties from a potentially
lucky first example. Already tried to apply your pattern on a standard
PCI NIC, e.g. the common Intel 8257x series?

> 
> - Easier to maintain drivers.
> 
>   Making regular drivers into real time drivers will always be a
>   chore. But, with its simple interface, the packet class driver hack
>   is way less painful. (Look at my gianfar example. There really are
>   not many changes to the Linux driver.)

What is your "simple interface"? That's what I'm interested in. What is
the pattern to apply on an arbitrary driver to add RT support? How does
interface claiming work (so the RT is not conflicting with Linux)? How
does the configuration work? How do you deal with things like watchdogs,
error handling, IRQ coalescing avoidance, etc.? Hmm, looks like your
concept is completely lacking IRQ support. That's of course a major
limitation, specifically with RT Ethernet protocols where the network
provides a clock source.

> 
> - Better integration with Xenomai. 
> 
>   This class driver is simple enough to ship with Xenomai. It would be
>   nice to offer raw Ethernet to users directly, not make them jump
>   through addition hoops. For example, the last time I tried to
>   compile the latest rtnet from git (few months ago) I got:
> 
>      checking for Xenomai version... configure: error:
>      *** Unsupported Xenomai version 2.5.6 in home/cochran/stage/usr/xenomai
> 
> I really don't know how many people would need such an interface (and
> not need rtnet), but I would imagine that a need exists.

I'm surely not voting against Xenomai integration of some RT Ethernet
(micro-)stack. I'm even not voting against rewriting the RTnet mess from
scratch.

What I'm skeptic about are statements like "this is so much simpler
because it will never require X or Y". Reminds me of the people
reimplementing QEMU as kvm-tool. The architecture of an RT Ethernet
stack should at least be based on the experience of RTnet, not widely
ignore it.

Jan

-- 
Siemens AG, Corporate Technology, CT T DE IT 1
Corporate Competence Center Embedded Linux

