From: "Christopher Stone" <chris@domain.hid>
Subject: RE: AW: [Xenomai-core] Fundamental Questions
Date: Wed, 8 Mar 2006 13:54:10 -0500
Message-ID: <003501c642e1$b1050990$a10a10ac@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
In-Reply-To: <440F1FBB.4000403@domain.hid>
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: 'Jan Kiszka' <jan.kiszka@domain.hid>
Cc: xenomai@xenomai.org

I do not have specific plans. 

I am working on something I am currently calling the Xen Loadable Module or
XLM. It is an Xenomai application that when loaded, turns the Linux kernel
into a Xen compatible hypervisor. For the rationale behind it see here:
http://www.openembedded.biz/content/view/36/27.

When it is ready, in 6 to 8 weeks, I am prepared to contribute it. It is a
significant work, but, is an Xenomai application, so I don't know if you
guys want it. It does fit with your goals with respect to industrial grade
Linux. 

I think that XLM actually illustrates a key point that people forget when
they compare rt-preempt to Xenomai. I believe that in the industrial grade
Linux world, the ability to support multiple OS's is key, especially in
light of the emerging dual core CPU's. Due to ADEOS, Xenomai has the
infrastructure to support doing things like running eCos on one core and
Linux on the other, or eCos and Linux, side by side, on the same CPU. XLM is
designed to make this easy. Rt-preempt has no such capability. 

I am not trying to discredit rt-preempt. It is a significant and useful
piece of work and contains some pretty smart coding. However, in my view,
rt-preempt is just part of the solution required for industrial grade linux.
Things like rt-preempt, Xenomai, and hopefully XLM will all be pieces of a
comprehensive industrial grade linux solution.

If XLM is not a suitable contribution to Xenomai, then, I can contribute
other ways such as other feature development or bug fixing. I would need
some direction from the leaders in order to contribute in that way.

Cheers,
   Chris.

----------------------------------------
Christopher Stone
Principal
Sombrio Systems Inc.
www.openembedded.biz
613-831-1892

-----Original Message-----
From: Jan Kiszka [mailto:jan.kiszka@domain.hid] 
Sent: March 8, 2006 1:18 PM
To: chris@domain.hid
Cc: xenomai@xenomai.org
Subject: Re: AW: [Xenomai-core] Fundamental Questions

Christopher Stone wrote:
> In light of the desire for support below, would the Xenomai team
> consider listing companies capable of commercial support on their
> website, or create another mailing list for us to announce commercial
> offerings around Xenomai. I am prepared to contribute to Xenomai in
> order to receive this privilege.

We had such a page on the old RTAI site, though not really populated I
think to remember. I personally have no concerns creating such a forum
for Xenomai as well. I think we could start with a link sub-page on
xenomai.org.

> 
> Sorry for discussing commercial issues on your mailing list. If it
> makes it any better, we are a very small company, just trying to make
> a living, not a big corporate conglomerate.

I'm convinced that this is not a question of big or small. There should
just be a good balance between taking and giving.

> 
> As a final point, I believe Xenomai is very well positioned to become
> very popular and "future proof". I believe the next frontier for
> Linux is industrial grade Linux, or Linux on the factory floor and
> Xenomai will end up the technology of choice to make that happen.
> Contrary to many opinions I have heard, I beleve the rt-preempt work
> done by Ingo Molnar will enhance Xenomai and not replace it. I also

Yep, that is one important point why Xenomai is future-proof in my eyes.
The day may come when significant parts of the PREEMPT_RT effort are
merged into mainline. But then Xenomai will still be able to offer
either staged degrees of hard-RT side by side with that approach, or
become a wrapping layer on top of the new deterministic and fast
infrastructure (PREEMPT_RT + RT-extended glibc). No one should expect
that this will happen soon, PREEMPT_RT has just started its tricky way
into the kernel.

> think the break from RTAI was very smart as it has given you the
> flexibility to move Xenomai in the direction it needs to go. The
> recent releases have made Xenomai ready for the commercial world. So,
> kudos to the Xenomai team. You guys are proving to be great leaders
> with the right technology at the right time.
> 

This nice compliment clearly has to be passed to our smart maintainer!

Jan


PS: Do you already have specific plans for potential contributions? I'm
just curious.




