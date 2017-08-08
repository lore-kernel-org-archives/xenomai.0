Date: Tue, 8 Aug 2017 13:48:01 +0200
From: Henning Schild <henning.schild@siemens.com>
Message-ID: <20170808134801.59ae5de6@md1em3qc>
In-Reply-To: <a676257d-9e88-1b81-15e6-adfffc1c7716@xenomai.org>
References: <20170808112357.0063d74d@md1em3qc>
 <a676257d-9e88-1b81-15e6-adfffc1c7716@xenomai.org>
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

Am Tue, 8 Aug 2017 12:24:54 +0200
schrieb Philippe Gerum <rpm@xenomai.org>:

> On 08/08/2017 11:23 AM, Henning Schild wrote:
> > Hey,
> >
> > xenomai3 has its tuneables and they can be set with command-line
> > parameters and setup_descriptors.
> >
> > 1.
> > The command-line parameters impose on the application, it has to be
> > modified to skip/ignore them.  
> 
> No, the core takes care of this. I'm unsure what your application
> does to hit any conflict of that kind.

dlopen() so main will see arguments meant for xenomai_init() or you
need to no_auto_init and fiddle with /proc/cmdline and call xenomai_init

>   And ultimately it has to keep a list of
> > valid ones to do so pedanticly. If there are name clashes behaviour
> > is unclear. i.e. "--help" ld.so vs. dlopen
> >  
> 
> --help can be extended. See how testsuite/latency does for an example.

Help was just one example, you could have the same problem with any of
the other parameters.

> > 2.
> > The setup_descriptors do work but they rely on getting the order
> > stricly right. They have to execute before the first
> > xenomai_init(). In complex applications with multithreaded init
> > using dlopen() and auto-init-solib that quickly turns out to be
> > unusable. 
> 
> Well, I've been using setup descriptors on quite complex customer 
> applications (including lots of C++ static constructor braindamage),
> and never went into any dead end like you seem to imply since the
> latest additions in 3.0.5. Descriptors have their own priorities, and
> you may now use auto-bootstrappable libs as well.

I did not. I gave my customer multiple examples on how to set
mem-pool-size in static, ld.so and dlopen(). They have braindamage
static c++ with dlopen() and could not make it work. At the moment
their main() ignores any unknown argument so they can use 1. but that
needs to be fixed.

> > Suggestions:
> > 1.
> > 1.1 completely drop the support for parameters and the fiddling
> >     with /proc/cmdline
> > 1.2 or agree on a prefix "--xeno-" so the application can ignore all
> >     xenomai parameters without knowing all

You did not comment on that at all.

> > 2.
> > 2.1 completely drop the setup_descriptors in favour of environment
> >     variables
> >  
> 
> Hell no. Environment variables are crap. Unlike options which are 
> explicit, those things tend to pollute some hidden namespace, staying 
> there long after you stopped expecting them having any influence, set
> by dusty login scripts. That one is a strict nak for me, sorry.

Ok, that is a clear opinion and i get it. Let us not discuss env
variables anymore, but let us keep talking under that thread title ;).

> > That would be a drastic change but i think we should do something
> > about it. With environment variables it is clear what happens
> > without messing with the applications init or parameters, getting
> > rid of confusing complexity.
> >
> > Please let me know what you think, i would be happy to prepare
> > patches. 
> 
> What is the exact problem you face regarding options? Please also 
> remember that influencing the whole argument system only to support a 
> quite infrequent use case such as dlopen() is not the way to go. It's
> ok to find a solution that might fit all usages, it is not to
> introduce stuff that eases 1% of the use cases which badly affects
> 99% of the rest.

My customer switched to xenomai3 and they did not manage to set the
tuneables without hacks. I looked into setting them and found that
there are different ways and different behaviours for these ways
depending on how you link. They could not make it work ... Ok i can fix
it for them without talking to the community.

But i can do something about the fact that it is too complicated, and
that is what i am trying to do with this mail.

I would like to see only one way that always works the same no matter
how you link, no questions about who wins when multiple want to tune.
Maybe we can drop the "--auto-init-solib" switch eventually and just
make it default.

Imho 33% of the linking cases are broken, true that dlopen() is
probably not used a lot.

Henning

> PS: I'm supposedly off line at the moment, so follow ups may take
> some time to appear.
> 


