From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <7ed3bc8b0909081602i245239dahf0823ad0bfd845f5@domain.hid>
References: <793108.19562.qm@domain.hid>
	<4AA691B8.4090204@domain.hid>
	<394564.56258.qm@domain.hid>
	<4AA6D85C.8040707@domain.hid>
	<982599.63991.qm@domain.hid>
	<4AA6DE47.8010804@domain.hid>
	<934774.26170.qm@domain.hid>
	<7ed3bc8b0909081602i245239dahf0823ad0bfd845f5@domain.hid>
Content-Type: text/plain
Date: Wed, 09 Sep 2009 10:36:25 +0200
Message-Id: <1252485385.2820.17.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] RT Task RPC over a POSIX/Native Queue
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Stuart O Anderson <soa@domain.hid>
Cc: xenomai@xenomai.org

On Tue, 2009-09-08 at 19:02 -0400, Stuart O Anderson wrote:
> I am working with a similar problem at the moment.  I have a realtime
> task that uses rt_net to do UDP communication with embedded systems on
> several physical networks.  I also need to collect data used by that
> realtime task from a third party server streaming data using a TCP
> based protocol.  My approach has been to run one realtime thread and
> one user-space thread in the same process.  The user space thread
> talks to the third party server and posts data to memory, while the
> realtime task reads from this memory and communicates with the
> embedded systems.
> 
> When I run the realtime thread alone, the 1 KHz timing is quite
> stable.  Currently, however, when I run the userspace thread as well
> and have it make networking calls, I lose timing precision in the
> realtime thread.  I'm still working on understanding why.

Any synchronization between the RT and NRT threads reading/writing to
the shared memory at work? a semaphore to get clean reads for instance,
or anything alike, that would actually propagate the NRT latencies to
the RT thread?

You may want to have a look at /proc/xenomai/stat for your RT thread as
well. Specifically the MSW counter: it's value should not increase over
time if that thread is expected to always work in primary (rt) mode.

> 
> Stuart
> 
> On Tue, Sep 8, 2009 at 6:53 PM, Guvenc Gulce<gulceg@domain.hid> wrote:
> > rt_net is nice but then all network participants have to use rt_net otherwise
> > the realtime communication is not guaranteed on the wire.. in some cases
> > the real-timeliness on the wire may not be needed but the determinism
> > of the rt-task may still be an issue..
> >
> > I think it is a great flexibility to give an rt task the chance to communicate
> > with non rt_net clients and servers in the network without worrying about
> > losing its determinism.
> >
> > Regards,
> >
> > Guvenc
> >
> >
> >
> > ----- Original Message ----
> > From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
> > To: Guvenc Gulce <gulceg@domain.hid>
> > Cc: xenomai@xenomai.org
> > Sent: Wednesday, September 9, 2009 12:44:23 AM
> > Subject: Re: [Xenomai-help] RT Task RPC over a POSIX/Native Queue
> >
> > Guvenc Gulce wrote:
> >> Guvenc Gulce wrote:
> >>
> >>>>> Leaving Xenomai domain is not bad per se. The reason why it is bad is
> >>>>> that when re-entering Linux domain, you may have to wait an unbounded
> >>>>> time for Linux to let your task run.
> >>>> Exactly and that would disturb the real-timeliness of the rt task.
> >>>>
> >>>>> With your approach, the first RT task would not leave the Xenomai
> >>>>> domain, but it would wait for the second RT task to complete. And the
> >>>>> second RT task would risk to wait for the same unbounded time.
> >>>> Why should the first RT Task wait for the second RT Task when
> >>>> the second RT Task has lower priority than the first one ? If Xenomai
> >>>> scheduler works as expected then the first rt task should be
> >>>> able to continue to run after writing into Posix Queue (marshalled Linux
> >>>> call) and collect the results of the called linux function when
> >>>> the second rt task gets them and marshalls them back to a second
> >>>> feedback Queue which can be read by the first RT Task when
> >>>> it is appropriate for it. (Feedback Queue needs to be polled by the
> >>>> first RT Task as there is no async communication possibility in
> >>>> Userspace Realtime Environment)
> >>
> >>>> The main advantage here is that the original RT Task never loses his
> >>>> determinism as it might be doing some other jobs other than waiting
> >>>> for the answers from the called linux functions.
> >>>>
> >>>>> So, in short, you gain nothing.
> >>>> I think the gain is that the original rt task stays deterministic and is still able
> >>>> to call the linux functions and can continue to do his job which needs
> >>>> determinism and may poll the feedback Queue some time later and
> >>>> get the results of the called linux function.
> >>>> Such a thing is impossible to do with the current Xenomai API,
> >>
> >>> Yes, you could do that, though, I do not see any real-world application
> >>> where this would make sense. I mean, if you call a function you
> >>> generally want to get the result immediately. What application do you
> >>> have in mind?
> >>
> >> Opps.. I didnt realize that I was replying to you and not to the list..
> >>
> >> A typical application would be for example to offer a rt task the
> >> possibility of network communication without disturbing its determinism.
> >> If you send a data over the network, you dont necessarily expect
> >> the reply immediately or write to the file system again without
> >> disturbing the determinism.
> >
> > We have rtnet, a deterministic networking stack. For writing to the
> > filesystem, we have rtdk.
> >
> > --
> >                        Gilles.
> >
> >
> >
> >
> >
> >
> > _______________________________________________
> > Xenomai-help mailing list
> > Xenomai-help@domain.hid
> > https://mail.gna.org/listinfo/xenomai-help
> >
> 
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help
-- 
Philippe.



