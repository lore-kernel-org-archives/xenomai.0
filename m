Sender: Alexis Berlemont <alexis.berlemont@domain.hid>
From: Alexis Berlemont <berlemont.hauw@domain.hid>
Date: Mon, 12 Oct 2009 00:51:29 +0200
References: <200910080126.13483.berlemont.hauw@domain.hid>
	<72cf3fb0910081500y7f22500erb1415a16ea402919@domain.hid>
	<1255075447.2781.111.camel@domain.hid>
In-Reply-To: <1255075447.2781.111.camel@domain.hid>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <200910120051.30148.berlemont.hauw@domain.hid>
Subject: Re: [Xenomai-core] Some thoughts on Analogy "kernel side" framework
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai-core <xenomai@xenomai.org>

On Friday 09 October 2009 10:04:07 you wrote:
> On Fri, 2009-10-09 at 00:00 +0200, Alexis Berlemont wrote:
> > If I understand well, I have gone too far too soon; the idea should be
> > to keep the current framework as it is for 2.5.
> >
> > However, my former mail was not a definitive plan. The first goal was
> > to share ideas. So, do not worry too much. :)
> 
> Maintaining two different frameworks for the same purpose won't fly. I'm
> worried because the future of Comedi/RTDM as merged in the 2.5 tree just
> became unclear - to say the least - as from you introduced the idea of
> changing its architecture.
> 
> Your potential user-base has to know whether using the current
> Comedi/RTDM framework for new designs based on 2.5.x will still make
> sense in six months from now, when Analogy eventually emerges.
> 
> In other words, is there any upgrade path planned? What would this
> entail?
> 
> Would one have to rewrite custom DAQ drivers to port them from
> Comedi/RTDM to Analogy, or could rely on a some compat wrapper for
> supporting legacy Comedi/RTDM Driver-Kernel interface on top of the
> Analogy core?
> 
> Would that new architecture bring changes in the applications, i.e. what
> about the impact of such changes on the way userland interfaces to the
> acquisition framework and/or its drivers?
> 
> I would have thought that Comedi/RTDM in the 2.5 tree would become
> Analogy as is, and evolve over time in a careful manner so that people
> always have a reasonable upgrade path. But now, I'm unsure whether this
> is going to be the case, or we would end up with two different
> frameworks. So, what is the _exact_ plan?

Ok. I will try to give my rough ideas.

Comedi / RTDM is facing many questions:

1) Peter Soetens, a Comedi user, once told us that the APIs (kernel and user) 
divergences with upstream were going to bring many troubles. maintaining 
tasks, difficulties to lure orginal Comedi users, etc. 
-> Should I ignore what was told that day or should I find a way to satisfy 
the main request which was a smooth transition between Comedi upstream and 
Comedi/RTDM.

2) People developing with Comedilib do not seem to be the same guys working on 
the drivers. So, even if common users agreed with porting their applications 
on the new library interface, they could not integrate their needed drivers 
into the Xenomai drivers set. If you want a clue, have a look at the Comedi 
mailing list, there are plenty of mails starting with "Is there a Comedi 
driver for ..."
-> Should I still be confident that there will be contributions of drivers ?

3) The Comedi framework is too different from other well-known frameworks. 
However, I consider that audio and multimedia cards are not different from 
acquistion devices. All of them can be divided into subdevices or components 
but neither v4l2 nor alsa did implement subdevices configurations like Comedi 
did. v4l2 and alsa drivers are working both with devices fops-like structures 
but Comedi is working with per subdevices callbacks far from the Linux driver 
model. Etc.
-> Should I leave our framework like it is ? Are we sure that the fact the 
original Comedi framework is slowly losing contributions is a coincidence ?

4) I tried to exchange with the original Comedi developers (even on the LKML). 
Nothing emerged from my mails (except that the Comedi maintainers told me to 
send my contributions to Greg KH and Greg KH told me to send my contributions 
to the Comedi maintainers).
-> Do you have any sign that someone is working on the Comedi core ?

5) So far, Comedi/RTDM has only one driver which deserves interest: the 
National Instruments NI PCIMIO. And it took quite a long time to make it work 
by myself and I still have some work to do on it. A user still has some 
troubles with his specific PPC host board. We are striving to find the bug.
-> Do we really have a significant user base for Comedi/RTDM ?


These questions led me to the conclusions I shared in the ML:

1) I have a true worrisome problem: Comedi/RTDM is not living because it lacks 
users on one side and contributors on the other side. The machine is not 
running.

2) It is still time to make it overtake by assessing what went wrong. There 
are Comedi users but they cannot use our framework because of the lack of 
drivers.

3) The driver is the key. So, the kernel side is the key. We have to improve 
it in two ways:
- (almost) seamlessly recover the original Comedi drivers;
- get some feedback on the best way to implement such a framework and make it 
flexible, because, right now, I am pretty convinced I am in the middle of what 
people call "the midlayer mistake".

 So, I was not at the "plan" level yet when I sent the first mail of this 
thread. I am still in the "design" phase just in case a redesign needs to be 
done. 

Alexis.

