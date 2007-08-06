MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <18103.38036.843037.110386@domain.hid>
Date: Mon, 6 Aug 2007 23:37:24 +0200
In-Reply-To: <e39c9190708061427y2d5ceed2td804b0990b88f282@domain.hid>
References: <a18a592b0708060815s4a1d30c0w906ff61d9acb0fab@domain.hid>
	<18103.24835.247952.219162@domain.hid>
	<e39c9190708061123k18f7e6afw260cc3ec5f3d18bb@domain.hid>
	<18103.30359.620591.697739@domain.hid>
	<e39c9190708061427y2d5ceed2td804b0990b88f282@domain.hid>
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Subject: Re: [Xenomai-help] newbie question
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: juanba romance <juanba.romance@domain.hid>
Cc: xenomai@xenomai.org

juanba romance wrote:
 > On 8/6/07, Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org> wrote:
 > >
 > > juanba romance wrote:
 > > > On 8/6/07, Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org> wrote:
 > > > >
 > > > >
 > > > > What you are referring to is the priority coupling between Xenomai and
 > > > > Linux schedulers, and can be disabled in Xenomai configuration.
 > > > >
 > > > > The linux kernel will keep the inherited priority until the RT-task
 > > > > calls xenomai again, or until it is suspended by Linux scheduler. If
 > > the
 > > > > RT-task does not call xenomai for a while (and is not suspended by
 > > Linux
 > > > > scheduler), then, well, it is an RT-task after all and should be able
 > > to
 > > > > run until it reaches a suspension point or wakes up another RT-task.
 > > >
 > > > Hello both, i have a newbie doubt
 > > >
 > > > What should i understand by a "xenomai" call ?
 > > > Does it simple means to call a symbol owned by the xenomai libs ?
 > >
 > > To summarize, we could say yes. But the situation is a little bit more
 > > complicated. Not all symbol owned by the Xenomai libs cause user-space
 > > applications to switch to primary mode. So, an RT-task will remain in
 > > secondary mode until it calls one of the Xenomai services which cause
 > > their caller to switch to primary mode.
 > >
 > > >
 > > > Note however that during this time, Linux interruptions will be allowed
 > > > > to preempt the RT-task.
 > > > >
 > > > I think  that if one design a source thread/rt-task whatever which is
 > > > focused on rt constrains,
 > > > one would like to acquire ASAP the same rt-context free of such preempt
 > > > policy.
 > >
 > > There is an option of Xenomai which prevents Linux interruptions from
 > > preempting an RT-task in secondary mode, it is called "interrupt shield"
 > > but is disabled by default.
 > >
 > > But you should understand that when you design a system "focused on rt
 > > constraints", your rt task should remain in primary mode. When going to
 > > secondary mode, you are loosing some determinism, because Xenomai may
 > > have to wait an unbounded time before the migrating task is allowed to
 > > run. Secondary mode is convenient for initializations (your system is
 > > not yet real-time), and for tasks which live near the frontier between
 > > real-time and non real-time world.
 > >
 > > > Right now i can hold a exhaustive monitoring related on my performed
 > > systems
 > > > calls
 > > > but i also suppose that at same place/time i will need some linux
 > > > service, and therefore a good practice could be quite useful, any hint
 > > > about?
 > >
 > > The only advice I can give you is not to call directly a Linux service
 > > from a task which is doing some real-time job. If you want to call some
 > > linux service call it from a task which will communicate with the
 > > real-time job using one of the IPCs proposed by Xenomai. Of course your
 > > real-time job should not depend on timely execution of the Linux
 > > service, otherwise you would loose determinism again.
 > 
 > 
 > OK, I got it,
 > 
 > As i said before, right now the sources are fully controlled but the stuff
 > will grow( as always ;-) ) a lot by myself and others, therefore i need to
 > transfer this stuff ASAP to the crew in order to hold the application
 > rt-coherency.
 > Any application will read at sometime the file system and therefore we would
 > like to be in advance. Our specifications do this kind of io/ operation when
 > the system changes to the service mode, right there we need a clear
 > description about the linux and xenomai domains exchange. Now, we're not too
 > much confidence about the design capabilities to decouple both stuffs on
 > such mode, we must deeply think about...
 > 
 > Thanks a lot about your hints.

Xenomai allows you to be notified (by a signal) when a thread switches
from primary to secondary mode. For an example, see
ksrc/skins/native/snippets/sigxcpu.c

-- 


					    Gilles Chanteperdrix.

