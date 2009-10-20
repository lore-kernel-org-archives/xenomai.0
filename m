Sender: Alexis Berlemont <alexis.berlemont@domain.hid>
From: Alexis Berlemont <berlemont.hauw@domain.hid>
Date: Tue, 20 Oct 2009 23:29:30 +0200
References: <200910080126.13483.berlemont.hauw@domain.hid>
	<200910122352.00172.berlemont.hauw@domain.hid>
	<1255802141.2862.47.camel@domain.hid>
In-Reply-To: <1255802141.2862.47.camel@domain.hid>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <200910202329.30308.berlemont.hauw@domain.hid>
Subject: Re: [Xenomai-core] Some thoughts on Analogy "kernel side" framework
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai-core <xenomai@xenomai.org>

On Saturday 17 October 2009 19:55:41 Philippe Gerum wrote:
> On Mon, 2009-10-12 at 23:52 +0200, Alexis Berlemont wrote:
> > On Monday 12 October 2009 11:30:11 you wrote:
> > > On Mon, 2009-10-12 at 00:51 +0200, Alexis Berlemont wrote:
> > > > On Friday 09 October 2009 10:04:07 you wrote:
> > > > > On Fri, 2009-10-09 at 00:00 +0200, Alexis Berlemont wrote:
> > > > > > If I understand well, I have gone too far too soon; the idea
> > > > > > should be to keep the current framework as it is for 2.5.
> > > > > >
> > > > > > However, my former mail was not a definitive plan. The first goal
> > > > > > was to share ideas. So, do not worry too much. :)
> > > > >
> > > > > Maintaining two different frameworks for the same purpose won't
> > > > > fly. I'm worried because the future of Comedi/RTDM as merged in the
> > > > > 2.5 tree just became unclear - to say the least - as from you
> > > > > introduced the idea of changing its architecture.
> > > > >
> > > > > Your potential user-base has to know whether using the current
> > > > > Comedi/RTDM framework for new designs based on 2.5.x will still
> > > > > make sense in six months from now, when Analogy eventually emerges.
> > > > >
> > > > > In other words, is there any upgrade path planned? What would this
> > > > > entail?
> > > > >
> > > > > Would one have to rewrite custom DAQ drivers to port them from
> > > > > Comedi/RTDM to Analogy, or could rely on a some compat wrapper for
> > > > > supporting legacy Comedi/RTDM Driver-Kernel interface on top of the
> > > > > Analogy core?
> > > > >
> > > > > Would that new architecture bring changes in the applications, i.e.
> > > > > what about the impact of such changes on the way userland
> > > > > interfaces to the acquisition framework and/or its drivers?
> > > > >
> > > > > I would have thought that Comedi/RTDM in the 2.5 tree would become
> > > > > Analogy as is, and evolve over time in a careful manner so that
> > > > > people always have a reasonable upgrade path. But now, I'm unsure
> > > > > whether this is going to be the case, or we would end up with two
> > > > > different frameworks. So, what is the _exact_ plan?
> > > >
> > > > Ok. I will try to give my rough ideas.
> > > >
> > > > Comedi / RTDM is facing many questions:
> > > >
> > > > 1) Peter Soetens, a Comedi user, once told us that the APIs (kernel
> > > > and user) divergences with upstream were going to bring many
> > > > troubles. maintaining tasks, difficulties to lure orginal Comedi
> > > > users, etc. -> Should I ignore what was told that day or should I
> > > > find a way to satisfy the main request which was a smooth transition
> > > > between Comedi upstream and Comedi/RTDM.
> > >
> > > You don't seem to get the point yet: I'm in no way arguing about which
> > > technical direction you should head your project to, and I have no
> > > issue with your technical analysis.
> > >
> > > The issue I have is with your project management: Comedi/RTDM is
> > > currently part of the Xenomai tree, scheduled for 2.5 for more than a
> > > year, and you are now in the "back to the future" mode, asking people
> > > their feedback about major changes your would like to see in your
> > > infrastructure, at a moment when one may have expected it to be stable.
> > > This won't fly.
> > >
> > > > 2) People developing with Comedilib do not seem to be the same guys
> > > > working on the drivers. So, even if common users agreed with porting
> > > > their applications on the new library interface, they could not
> > > > integrate their needed drivers into the Xenomai drivers set. If you
> > > > want a clue, have a look at the Comedi mailing list, there are plenty
> > > > of mails starting with "Is there a Comedi driver for ..."
> > > > -> Should I still be confident that there will be contributions of
> > > > drivers ?
> > >
> > > If your point is about mentioning that OS implementers should provide a
> > > stable framework to build over, for others to implement drivers for
> > > their own devices, well, ok, I was vaguely aware of this; thanks for
> > > the heads up anyway. Problem is that you have just shot yourself in the
> > > foot, by tagging Comedi/RTDM has unstable and unusable in the context
> > > of developing drivers.
> > >
> > > If you tell people that you are about to rewrite the kernel side
> > > significantly before they had a chance to get their feet wet with it
> > > and consider basing their future work on it, you won't get any
> > > contribution, obviously. They will wait for your own dust to settle. Or
> > > they may not wait at all, and walk away.
> > >
> > > At any rate, deprecating the current Comedi/RTDM architecture now, only
> > > a few weeks before Xenomai 2.5 is rolled out, has pretty bad timing, to
> > > say the least.
> > >
> > > > 3) The Comedi framework is too different from other well-known
> > > > frameworks. However, I consider that audio and multimedia cards are
> > > > not different from acquistion devices. All of them can be divided
> > > > into subdevices or components but neither v4l2 nor alsa did implement
> > > > subdevices configurations like Comedi did. v4l2 and alsa drivers are
> > > > working both with devices fops-like structures but Comedi is working
> > > > with per subdevices callbacks far from the Linux driver model. Etc.
> > > > -> Should I leave our framework like it is ? Are we sure that the
> > > > fact the original Comedi framework is slowly losing contributions is
> > > > a coincidence ?
> > >
> > > Nobody tells you to freeze your work, and/or not to think of a better
> > > approach. But you need to do a better job of explaining how your
> > > potential users will get their upgrade path to your new architecture.
> > > And you did not. This is what having a plan means, not just telling
> > > people that you are not happy with the framework, and asking them how
> > > they would want it to be overhauled. Most of those who might want to
> > > base their work on Comedi/RTDM today would NOT want you to make the
> > > codebase a moving target.
> > >
> > > So, the plan I was talking about could be something along these lines:
> > >
> > > - we have such issues with Comedi/RTDM (fair enough)
> > > - it is suggested to fix them later this way in Analogy
> > > then,
> > >
> > > - we could provide an upgrade path from Comedi/RTDM (drivers and APIs)
> > > to Analogy that way...
> > > OR,
> > > - there is no reasonable upgrade path, so well, we would have to scrap
> > > Comedi/RTDM from the Xenomai 2.5 tree, because this makes no sense to
> > > issue a temporary framework for writing long-lived code such as
> > > drivers.
> > >
> > > Btw, AFAICT, it does not make much sense to keep Comedi/RTDM as your
> > > project name within Xenomai 2.5; it should have been moved to Analogy
> > > already. You may change your underlying architecture at some point
> > > without changing the name of your project, and keeping "Comedi" in the
> > > naming seems confusing, since there is no way it could be merged with
> > > the original project anyway.
> > >
> > > > 4) I tried to exchange with the original Comedi developers (even on
> > > > the LKML). Nothing emerged from my mails (except that the Comedi
> > > > maintainers told me to send my contributions to Greg KH and Greg KH
> > > > told me to send my contributions to the Comedi maintainers).
> > > > -> Do you have any sign that someone is working on the Comedi core ?
> > >
> > > That is not the point. There is a problem with Comedi, fair enough, but
> > > let's not import it to Xenomai. Unless I'm mistaken, that particular
> > > issue has been solved by switching gear to Analogy, so let's not rehash
> > > the reasons why it has been done, those are pretty obvious. Get away
> > > with this and move on.
> > >
> > > > 5) So far, Comedi/RTDM has only one driver which deserves interest:
> > > > the National Instruments NI PCIMIO. And it took quite a long time to
> > > > make it work by myself and I still have some work to do on it. A user
> > > > still has some troubles with his specific PPC host board. We are
> > > > striving to find the bug. -> Do we really have a significant user
> > > > base for Comedi/RTDM ?
> > >
> > > Nobody can force a user base to exist, but you could make it simpler
> > > for it to emerge, that is my point. By introducing uncertainty
> > > regarding your architecture a few weeks before the first release of
> > > your project in Xenomai, you are confusing people. This won't help
> > > having them write drivers for it.
> > >
> > > > These questions led me to the conclusions I shared in the ML:
> > > >
> > > > 1) I have a true worrisome problem: Comedi/RTDM is not living because
> > > > it lacks users on one side and contributors on the other side. The
> > > > machine is not running.
> > >
> > > Users are expected to be your contributors when it comes to drivers,
> > > most of the time if not always. Tell them why they should be confident
> > > that building over Comedi/RTDM now is (still) a safe bet. That is the
> > > "plan" I referred to.
> > >
> > > > 2) It is still time to make it overtake by assessing what went wrong.
> > > > There are Comedi users but they cannot use our framework because of
> > > > the lack of drivers.
> > >
> > > Typical catch #22. You assume the framework has to be perfect for
> > > having drivers contributed, but the framework can't be perfect without
> > > drivers available in the first place. -EDEADLOCK (since you can't
> > > provide those drivers yourself).
> > >
> > > Instead of rehashing "we ought to be able to reuse Comedi drivers",
> > > maybe it's time to walk the walk, and make this possible over
> > > Comedi/RTDM. Any adaptation layer to do this would have to be
> > > long-lived and well maintained, this could be a reasonable incentive
> > > for people to base their work on Comedi/RTDM now. This only makes sense
> > > if that layer can shield them from most changes in the next
> > > architecture though.
> > >
> > > > 3) The driver is the key. So, the kernel side is the key. We have to
> > > > improve it in two ways:
> > > > - (almost) seamlessly recover the original Comedi drivers;
> > > > - get some feedback on the best way to implement such a framework and
> > > > make it flexible, because, right now, I am pretty convinced I am in
> > > > the middle of what people call "the midlayer mistake".
> > > >
> > > >  So, I was not at the "plan" level yet when I sent the first mail of
> > > > this thread. I am still in the "design" phase just in case a redesign
> > > > needs to be done.
> > >
> > > You already answered the question whether such redesign is required or
> > > not, right?
> >
> > Clearly no. I would have been happy having technical talks about how
> > people would see the design. I did not send the mail to impose a solution
> > but to receive critics and to find out the best way. My opinion was just
> > a starting point.
> 
> Fair enough. However, the technical proposal you sent required the
> readership to be aware of both the current Comedi and potentially future
> Analogy implementation. This may be asking too much to get answers. I
> see two ways to get out from this:
> 
> - me, switching on bozo mode and making that thread running like a joke
> with silly questions,
> 
> - you, introducing the topic with higher level considerations and
> questions about what could make Analogy better than Comedi, in terms of
> user experience. E.g. what are the annoying issues with the API
> semantics on the application side, what makes writing a card driver the
> best incentive to start a therapy and so on.
> 
> So, should I enter bozo mode or will you spare people a therapy?

I will come back later and I will try to describe the situation from a higher 
point of view.

> > > Otherwise, what are we talking about?
> >
> > No need to say more.
> >
> > I think I clearly understood your issues. I kept on focusing on the
> > technical aspects leaving the plan unclear, which is not the right path.
> >
> > I also made a mistake by saying that I would create an analogy branch in
> > my git repository for a potential redesign. That did not leave place for
> > the current design.
> >
> > My former mails should have dealt with what Analogy _was_ instead of what
> > Analogy _would_ become.
> >
> > So here is what I propose:
> >
> > I like your idea "analogy 1 and analogy 2" but let's focus on 1.x series,
> > the stable one (the experimental flag will vanish in Kconfig).
> >
> >        -> Goal: ensure a smooth transition between Comedi and Analogy.
> 
> Yes. Yes. Yes.
> Indeed.
> 
> >        -> So far, the transition with Comedi is not good enough. So after
> > the 2.5 Xenomai release, I will work on improving this issue; along with
> > the Analogy driver API, a Comedi driver API will be available in some
> > intermediate layer.
> >
> >        -> The calibration feature is still missing. I will work on that
> > point.
> >
> > Then Analogy users would have a stable base on which acquisition
> > applications could evolve.
> >
> > So, to sum-up:
> >
> > In Xenomai 2.5: Analogy 1.0 :
> >        -> the current code
> >        ->  Support of a great part of National Instruments PCI cards
> > (thanks to the pcimio driver).
> >
> > In Xenomai x.x: Analogy 1.1:
> 
> Since that should not break the ABI, additions of that kind should go to
> the 2.5.x maintenance releases first. 
ok.

> Which also means that you may want
> to account for the ABI stability requirement up front.

I keep that in mind.

> >        -> Comedi compatibility layer
> >        -> Auto calibration
> >        -> Any Ideas / requests coming from users
> >        -> More Analogy drivers.
> >
> > Is that ok ?
> 
> Yes, provided this does mean that people working with Analogy 1.0 should
> be able to port to newer releases without redesigning their code.

Yes backward compatibility should be insured.

> > > The design phase must be part of a more general course of action. I
> > > won't argue about technicalities regarding how your acquisition system
> > > should look like, you know better. But I'm asking you whether
> > > Comedi/RTDM (or Analogy 1.0, whatever) - as it is now in the Xenomai
> > > 2.5 tree - still makes sense, with respect to what changing its
> > > architecture will entail?
> > >
> > > If so, will some layer be provided to migrate drivers from Analogy 1.0
> > > to 2.0, i.e. when the major architecture changes will have taken place?
> >

Alexis.

