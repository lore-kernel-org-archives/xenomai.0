Date: Tue, 8 Aug 2017 21:27:58 +0200
From: Henning Schild <henning.schild@siemens.com>
Message-ID: <20170808212758.550caab0@md1em3qc>
In-Reply-To: <86562178-3b5a-55fc-8652-dc15f228e541@xenomai.org>
References: <20170808112357.0063d74d@md1em3qc>
 <a676257d-9e88-1b81-15e6-adfffc1c7716@xenomai.org>
 <20170808134801.59ae5de6@md1em3qc>
 <86562178-3b5a-55fc-8652-dc15f228e541@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] [RFC] Xenomai3 tuneables replaced by environment
	variables
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>
Cc: "KISZKA, JAN" <jan.kiszka@siemens.com>, xenomai@xenomai.org

Am Tue, 8 Aug 2017 20:05:07 +0200
schrieb Philippe Gerum <rpm@xenomai.org>:

> On 08/08/2017 01:48 PM, Henning Schild wrote:
> > Am Tue, 8 Aug 2017 12:24:54 +0200
> > schrieb Philippe Gerum <rpm@xenomai.org>:  
> >> No, the core takes care of this. I'm unsure what your application
> >> does to hit any conflict of that kind.  
> >
> > dlopen() so main will see arguments meant for xenomai_init() or you
> > need to no_auto_init and fiddle with /proc/cmdline and call
> > xenomai_init 
> 
> At any rate, you do not need to fiddle with /proc/cmdline manually,
> really.

True you construct the argv and call xenomai_init().

> Could you sketch the requirements of the app with respect to option 
> parsing (namespace left aside)? Is there some main non-Xenomai 
> executable dlopening a Xenomai-based solib defining a set of
> rt-specific options?

Yes the application runs its own main() and later dlopen() s multiple
libs, some of which may be linked to xenomai. The order of the dlopens
seems hard to control because of static c++ constructors or something
alike. But i suggest we discuss the internals of that particular app
after we have finished the discussion.

> 
> >>   And ultimately it has to keep a list of  
> >>> valid ones to do so pedanticly. If there are name clashes
> >>> behaviour is unclear. i.e. "--help" ld.so vs. dlopen
> >>>  
> >>
> >> --help can be extended. See how testsuite/latency does for an
> >> example.  
> >
> > Help was just one example, you could have the same problem with any
> > of the other parameters.  
> 
> I don't see any reason to override any other core parameter, beyond 
> --help which should remain as generic as possible but still allowing
> for all software layers existing in the application to contribute to
> it. --xeno-help would not make any sense.
>
> It seems that you are implicitly referring to ancillaries settings
> such as --silent, --verbose and --quiet as being problematic. Is it
> correct or are you referring to other parameters?

If your main comes before xenomai_init() it either has to be able to
ignore xenomai args or it will need to change argv/argc before
dlopening.

In the first case it has to know all valid args and the second one
does not sound very nice. And for the second one i am not sure there is
always a time window in the face of static ctors launching threads and
dlopening.
 
> >  
> >>> 2.
> >>> The setup_descriptors do work but they rely on getting the order
> >>> stricly right. They have to execute before the first
> >>> xenomai_init(). In complex applications with multithreaded init
> >>> using dlopen() and auto-init-solib that quickly turns out to be
> >>> unusable.  
> >>
> >> Well, I've been using setup descriptors on quite complex customer
> >> applications (including lots of C++ static constructor
> >> braindamage), and never went into any dead end like you seem to
> >> imply since the latest additions in 3.0.5. Descriptors have their
> >> own priorities, and you may now use auto-bootstrappable libs as
> >> well.  
> >
> > I did not. I gave my customer multiple examples on how to set
> > mem-pool-size in static, ld.so and dlopen(). They have braindamage
> > static c++ with dlopen() and could not make it work. At the moment
> > their main() ignores any unknown argument so they can use 1. but
> > that needs to be fixed.
> >  
> 
> The application may have to be fixed, I agree. Tunables provide a
> safer way to wire settings compared to environment variables. If
> settings need frequent updates, then environment variables are not
> practical at all.
> 
> If the issue is with calling Xenomai services from static ctors, then
> I can describe a way to do this. If other requirements exist along
> this one, please let me know.

Yes might be, but let discuss after we have concluded on the "there
should be one way that always works".

> >>> Suggestions:
> >>> 1.
> >>> 1.1 completely drop the support for parameters and the fiddling
> >>>     with /proc/cmdline
> >>> 1.2 or agree on a prefix "--xeno-" so the application can ignore
> >>> all xenomai parameters without knowing all  
> >
>  > You did not comment on that at all.
>  >  
> 
> Because this is asking for Xenomai not to use a few generic options 
> names for common ancillary services, leaving it to the application, 
> which I see no reason for. Leaving generic names to the core makes
> sense as much as the opposite.

1.1 suggests dropping but 1.2 suggests a name convention to ease parsing

> >>> 2.
> >>> 2.1 completely drop the setup_descriptors in favour of environment
> >>>     variables
> >>>  
> >>
> >> Hell no. Environment variables are crap. Unlike options which are
> >> explicit, those things tend to pollute some hidden namespace,
> >> staying there long after you stopped expecting them having any
> >> influence, set by dusty login scripts. That one is a strict nak
> >> for me, sorry.  
> >
> > Ok, that is a clear opinion and i get it. Let us not discuss env
> > variables anymore, but let us keep talking under that thread
> > title ;). 
> 
> No issue with that.
> 
> >>> That would be a drastic change but i think we should do something
> >>> about it. With environment variables it is clear what happens
> >>> without messing with the applications init or parameters, getting
> >>> rid of confusing complexity.
> >>>
> >>> Please let me know what you think, i would be happy to prepare
> >>> patches.  
> >>
> >> What is the exact problem you face regarding options? Please also
> >> remember that influencing the whole argument system only to
> >> support a quite infrequent use case such as dlopen() is not the
> >> way to go. It's ok to find a solution that might fit all usages,
> >> it is not to introduce stuff that eases 1% of the use cases which
> >> badly affects 99% of the rest.  
> >
> > My customer switched to xenomai3 and they did not manage to set the
> > tuneables without hacks. I looked into setting them and found that
> > there are different ways and different behaviours for these ways
> > depending on how you link. They could not make it work ... Ok i can
> > fix it for them without talking to the community.
> >
> > But i can do something about the fact that it is too complicated,
> > and that is what i am trying to do with this mail.
> >
> > I would like to see only one way that always works the same no
> > matter how you link, no questions about who wins when multiple want
> > to tune. Maybe we can drop the "--auto-init-solib" switch
> > eventually and just make it default.
> >  
> 
> Frankly, that seems a legitimate goal, but with C++ and static ctors
> in the picture, I don't see any one-fits-it-all solution. But there
> is no reason not to try finding one again.

I suggested one but promised to not bring it up again ;). Any other
ideas?
 
> > Imho 33% of the linking cases are broken, true that dlopen() is
> > probably not used a lot.
> >  
> 
> Not to speak of the fact that it introduces its own set of linking 
> issues (scope mess, late binding conflicts etc). I would usually use 
> that only for pure plugin architectures with fairly simple content 
> interfaces; I don't see any other situation that would legitimately 
> justify this.

My customers use it to have two versions of their app. A xenomai and a
non-xenomai version and the switch is in dlopening another lib. As far
as i know the non-xeno version is for basic testing on a regular Linux
and in simulation/virtualization. And the whole setup would
theoretically allow to switch the realtime provider without touching
the app.
I personally dont like it but just so you have some context.

Henning

