Message-ID: <20021104100720.78382.qmail@domain.hid>
Date: Mon, 4 Nov 2002 02:07:20 -0800 (PST)
From: Girish Wadhwani <gwadh@domain.hid>
Subject: Re: [Adeos-main] Re: RTOS over Adeos document
In-Reply-To: <15806.22647.658709.7556@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
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
To: adeos-main@gna.org

Hello,

 But look,
> you have just
> doubled the weekly traffic! ;o)

Let me triple it then:-)

I was wondering about Adeos's roadmap. Right now I see
three uses of Adeos:
1, Real time capabilities for Linux
2, Clustering for Linux and
3, Running multiple instances of Linux on the same
machine.

Which of these is the project working towards? I there
an explicit roadmap towards any?  I particular I am
interested in 3 and ways to possibly achieve it. I
think this would be useful to a lot of people. 

One approach would be to have a VMM and virtualize all
resources. This would involve the overhead of "world
switches" to the host OS and virtualization (with the
VMM running as an application on the host OS). You
would land up with something like VMWare and plex86
which would have little value.

The other approach would be the one mentioned in the
clustering paper i.e. make Linux aware of Adeos. This
brings up the question of how to get two or more
instances share resources and co-operate. A major
problem would be devices. Without virtualization, it
would invlove a huge number of changes  to drivers,
making it difficult to develop and maintain, if one
were to support all the devices that Linux currently
does. In this case the purpose of Adeos would be to
multiplex access between multiple instances, which
would be aware of each other and avoid stepping on eac
others toes. The upside would be that you would have
significant performance advantages over the VMM
method. 

Any thoughts on this? Or am I completely off the mark?
The information I found on the Adeos papers did not go
into much detail as to how things would be implemented


Cheers,
Girish 

__________________________________________________
Do you Yahoo!?
New DSL Internet Access from SBC & Yahoo!
http://sbc.yahoo.com


