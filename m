Message-ID: <3DC69037.5A9A1577@domain.hid>
Date: Mon, 04 Nov 2002 10:20:23 -0500
From: Karim Yaghmour <karim@domain.hid>
Reply-To: karim@domain.hid
MIME-Version: 1.0
Subject: Re: [Adeos-main] Re: RTOS over Adeos document
References: <20021104100720.78382.qmail@domain.hid>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
Sender: adeos-main-admin@domain.hid
Errors-To: adeos-main-admin@domain.hid
List-Help: <mailto:adeos-main-request@domain.hid>
List-Post: <mailto:adeos-main@gna.org>
List-Subscribe: <http://mail.nongnu.org/mailman/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Id: <adeos-main.nongnu.org>
List-Unsubscribe: <http://mail.nongnu.org/mailman/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: <http://mail.nongnu.org/pipermail/adeos-main/>
To: Girish Wadhwani <gwadh@domain.hid>
Cc: adeos-main@gna.org

Girish Wadhwani wrote:
>  But look,
> > you have just
> > doubled the weekly traffic! ;o)
> 
> Let me triple it then:-)

Fantastic, let's have fun then ;)

> I was wondering about Adeos's roadmap. Right now I see
> three uses of Adeos:
> 1, Real time capabilities for Linux
> 2, Clustering for Linux and
> 3, Running multiple instances of Linux on the same
> machine.

Indeed.

> Which of these is the project working towards? I there
> an explicit roadmap towards any?  I particular I am
> interested in 3 and ways to possibly achieve it. I
> think this would be useful to a lot of people.

Agreed. If nothing else, you could try new drivers and not care about
a second Linux dying.

> One approach would be to have a VMM and virtualize all
> resources. This would involve the overhead of "world
> switches" to the host OS and virtualization (with the
> VMM running as an application on the host OS). You
> would land up with something like VMWare and plex86
> which would have little value.

No really interesting, we might as well just extend plex86 if we're
going down this road ...

> The other approach would be the one mentioned in the
> clustering paper i.e. make Linux aware of Adeos. This
> brings up the question of how to get two or more
> instances share resources and co-operate. A major
> problem would be devices. Without virtualization, it
> would invlove a huge number of changes  to drivers,
> making it difficult to develop and maintain, if one
> were to support all the devices that Linux currently
> does.

No, you don't need to do that. As I explain in the clustering paper,
all you need is to modify that PCI allocation code to first ask
Adeos about the components it should be seeing. There is no need to
change any of the drivers. We do need to make sure, nevertheless,
that any extra copies of Linux that boots don't reinitialize any
available ISA hardware, but I don't see this as much of a problem.

Of course, this involves that no two instances of Linux share the
same hardware. Which is just fine for what Adeos is supposed to
do. If you need to share hardware devices among OS instances, then
you certainly need somethine like VMWare or plex86. Sharing
hardware devices isn't part of Adeos' mandate.

> In this case the purpose of Adeos would be to
> multiplex access between multiple instances, which
> would be aware of each other and avoid stepping on eac
> others toes. The upside would be that you would have
> significant performance advantages over the VMM
> method.

We don't need to do this. Since any extra Linux doesn't even see the
PCI hardware it isn't supposed to use, there is no need to make sure
that the various Linux don't step on each other. The only possible
problem is if you have a Linux making random physical memory accesses,
but if that's the case then it's a bug and it has to be fixed.

As for how the various Linux instances are supposed to communicate
with a single Adeos instance, I first thought that soft ints could
be used, but these may turn out to be expensive. Instead, I think
we could reserve a MB or two in physical memory where we would place
the Adeos code and data. All Linux instances would map this instance
into their virtual address space and call upon it as they would
any other code.

> Any thoughts on this? Or am I completely off the mark?
> The information I found on the Adeos papers did not go
> into much detail as to how things would be implemented

The papers are really meant to be "food for thought". For sure they
can't explain every corner case. If that were true then I might have
just as well written the thing to start with ;)

Karim

===================================================
                 Karim Yaghmour
               karim@domain.hid
      Embedded and Real-Time Linux Expert
===================================================


