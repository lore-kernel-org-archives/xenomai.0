From: Philippe Gerum <philippe.gerum@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15814.44563.512381.639263@domain.hid>
Date: Mon, 4 Nov 2002 18:27:47 +0100
Subject: Re: [Adeos-main] Re: RTOS over Adeos document
In-Reply-To: <20021104100720.78382.qmail@domain.hid>
References: <15806.22647.658709.7556@domain.hid>
	<20021104100720.78382.qmail@domain.hid>
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
 > 
 > I was wondering about Adeos's roadmap. Right now I see
 > three uses of Adeos:
 > 1, Real time capabilities for Linux
 > 2, Clustering for Linux and
 > 3, Running multiple instances of Linux on the same
 > machine.
 > 
 > Which of these is the project working towards? I there
 > an explicit roadmap towards any?  I particular I am
 > interested in 3 and ways to possibly achieve it. I
 > think this would be useful to a lot of people. 
 > 

I would say #1, #3 then #2 since being able to run multiple copies of
Linux first would hopefully pave the way to efficient SMP clustering
over Adeos.  Seeking #1 was IMHO the fastest path to get a functional
and stable base to build onto. Once it's rock-solid for stressed
real-time systems running along Linux, we should have a reasonable
confidence for other kinds of use.

#1 is no more experimental since we already had some positive feedback
from demanding projects such as RTAI, Xenomai, or some company-lead
efforts who succeeded in coupling Adeos to their in-house real-time
kernel. The real problem now is the portability issue: Adeos is
x86-only, and this is bad, it sounds as a lack of maturity at the very
least. I hope the recent modularization effort will be an incentive to
port it to other archs.  However, this problem does not preclude us
from initiating #3 now.

 > One approach would be to have a VMM and virtualize all
 > resources. This would involve the overhead of "world
 > switches" to the host OS and virtualization (with the
 > VMM running as an application on the host OS). You
 > would land up with something like VMWare and plex86
 > which would have little value.
 > 

Agreed. I would rather call for a sound compromise between
functionality and performance, keeping the wild horse of
virtualization in manageable bounds.

 > The other approach would be the one mentioned in the
 > clustering paper i.e. make Linux aware of Adeos. This
 > brings up the question of how to get two or more
 > instances share resources and co-operate. A major
 > problem would be devices. Without virtualization, it
 > would invlove a huge number of changes  to drivers,
 > making it difficult to develop and maintain, if one
 > were to support all the devices that Linux currently
 > does. In this case the purpose of Adeos would be to
 > multiplex access between multiple instances, which
 > would be aware of each other and avoid stepping on eac
 > others toes. The upside would be that you would have
 > significant performance advantages over the VMM
 > method. 
 > 

I like the idea of giving exclusive control over the devices on a
per-domain/os basis instead of trying to share them at all cost. It
sounds more natural and less invasive.

 > Any thoughts on this? Or am I completely off the mark?
 > The information I found on the Adeos papers did not go
 > into much detail as to how things would be implemented
 > 

Yes, but at least they were well-written enough so that even _I_ had
been able to understand them and implement something that resembles
Karim's idea... So there's definitely room for unbounded hope! :o>

Philippe.


