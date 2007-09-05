From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <43afefbf0709050215w4a5705b9x8397b2b58a573674@domain.hid>
References: <43afefbf0709050215w4a5705b9x8397b2b58a573674@domain.hid>
Content-Type: text/plain
Date: Wed, 05 Sep 2007 11:46:30 +0200
Message-Id: <1188985590.28092.293.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: Philippe Gerum <philippe.gerum@domain.hid>
Subject: Re: [Xenomai-core] Automated performance testings
Reply-To: rpm@xenomai.org
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Ravid Baruch Naali <ravidbn@domain.hid>
Cc: Jan Kiszka <jan.kiszka@domain.hid>, xenomai@xenomai.org

On Wed, 2007-09-05 at 11:15 +0200, Ravid Baruch Naali wrote:
> Moving to a new thread subject.
>  
> The following thread will be dedicated to development of the Automated
> performance testing and it's presentation.
>  
> At first stage an infrastructure will be design and created. later on
> the presentation and automation will be discussed.
>  
> Infrastructure design:
> Option 1:
> - The time measurements will based on the nucleus API functions.
> - On entering the function a timer will be activated and stop at the
> function exit point.
> - When test execution complete all the time measurements of each
> function will be summed up and average will be calculated.
>  
> Advantages:
> - One infrastructure for all skins
> Disadvantage:
> - The specific skin delays will not be measured.
> - Inserting a system delay
>  
> Implementation method:
> - Either by code integrated into the nucleus code scoped in a
> precomiplation define.
> - Or by a preloaded or statically compiled library which will grab
> every nucleus API function run its timer and only then call the origin
> nucleus function.
>  
> Option 2:
> - In the application level
>   - Create a library which calculate an present results.
>   - using it will require the test to call specific API functions.
> 
> Advantage:
> - A skin oriented result
> - No delay in the underlying system
> - provide any user the ability to test her own application
>  
> Option 3:
> - A combination of 1 and 2:
>   - A library which collect the data and later on will present it.
>   - An API for the application layer.
>   - Same/different API to integrate into the nucleus.
>  
> Advantage:
> - More flexibility
> - Can also provide a mean to hunt the exact delay factor.
> - Usable as developing tool
> Disadvantage:
> - Hard to maintain a uniform results.
>  

Actually, we do have the needed instrumentation support at function call
level already; it's the I-pipe latency tracer (see CONFIG_IPIPE_TRACE in
a Xenomai-enabled kernel configuration).

But beyond that, what we need is rather to collect the data produced by
existing programs from the testsuite, such as testsuite/latency. This
program provides global figures about dispatch latency for kernel and
user-space tasks, and raw interrupt latency. The data produced by this
program should be presented; the automated infrastructure would run the
latency test for instance, gather the results, format them so that we
could have meaningful charts.

Then, new tests could be developed, or only simple scripts gathering
data on the code size of a Xenomai-enabled kernel for instance.

To sum up, the data we are missing right now are global, integrated
figures, rather than performance evaluation at the routine level,
because we need to understand the general trend and situation, not
necessarily to spot an issue as closely as tracking a particular
routine. If a regression is visible from the charts, we would primarily
search for the problematic commit first, then analyse the situation from
there.

Afterwise, injecting the data produced by the latency tracer (the I-pipe
one from the kernel support, not to be confused with the
testsuite/latency test in user-space) could then be integrated in a way
or another into the framework too.

We do have a lot of pieces we could put together in order to build the
framework already; what we need is to define the initial set of
meaningful tests to produce the data to be monitored, then automate the
procedure to extract the code under test (i.e. commit#) from our SVN,
compile it, run the tests, collect the data and draw charts from them.

> Waiting for your comments/suggestions/corrections.
> Ravid
> 2007/9/4, Jan Kiszka <jan.kiszka@domain.hid>:
>         Ravid Baruch Naali wrote:
>         > The automated chart seems exactly the thing for me (I have
>         some testing 
>         > tools development experience).
>         >
>         > I'll look into it and will soon send a initial design.
>         
>         Hurray! You just deserved an option for a free beer! Now you
>         just need
>         to post the first related patch - and manage to meet me
>         personally (the 
>         latter may be a bit trickier than the former ;)).
>         
>         >
>         > Of course any pinters/advice/suggestions will be highly
>         appreciated.
>         
>         Let's start with creating the infrastructure for the targets
>         firsts. 
>         Once we have more tests with unified output locally on the
>         Xenomai
>         targets, we can think about how to transfer this data to a
>         central
>         database and how to visualise that database on the web.
>         
>         Jan
>         
>         
> 
> 
> 
> -- 
> Ravid Baruch Naali
> E-mail: ravidbn@domain.hid
> Mobile: 052-5830021
> Home/Office:04-6732729 
-- 
Philippe.



