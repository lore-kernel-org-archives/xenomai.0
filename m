Message-ID: <44DD08A0.5000603@domain.hid>
Date: Fri, 11 Aug 2006 16:45:52 -0600
From: Jim Cromie <jim.cromie@domain.hid>
MIME-Version: 1.0
References: <44DA896F.9060102@domain.hid> <44DB1865.90004@domain.hid>
	<44DB9958.10109@domain.hid> <44DCAF88.2060801@domain.hid>
In-Reply-To: <44DCAF88.2060801@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-core] Re: Test, benchmark, demo frameworks
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: xenomai-core <xenomai@xenomai.org>

Jan Kiszka wrote:
> Hi all,
>
> Jim raised these issues nicely to a generic level. I would like to pick
> it up and add some thoughts.
>
> Jim Cromie wrote:
>   
>> ...
>> FWIW, I noted that xeno-test is not running these:
>> - switchbench
>> - switchtest
>> - irqbench
>>
>> Im not sure they belong in xeno-test though, since they dont
>> appear to produce output that shows good vs bad performance,
>> only an informal 'sanity' check.
>>     
>
> Including switchtest depends on if xeno-test should also do some
> elementary stability tests. This can be derived from performance tests
> as well, but Gilles' switchtest does it for the various switching
> constellations more systematically.
>
>   
elementary stability says make it 1st test. before longer running 
latency tests. TBD..

> Including irqbench is more tricky as "real" hardware and a second box
> are always involved here (so far it only works over null-modem, need to
> be extended to some GPIOs or parallel port).
>
> Regarding the output of the various benchmarks I would like to cite
> myself here:
>
> https://mail.gna.org/public/xenomai-core/2006-06/msg00195.html
>
> [And as one of the major xeno-test contributors, you may feel included
> by the term "test team". ;)]
>
>   
LOL at 2nd-to-last paragraph.

wrt data collection, any updates on LTT or relayfs ?
iirc LTT was split to create relayfs and LTT++, but the latter is WIP.
With them, data-collection becomes comparatively limitless.

also, Niklaus will be happy to hear I feel ownership (ie guilt) about a 
xeno-test bug
where workloads get orphaned by middle 'workload-manager' shell not catching
a terminating condition and cleaning up.  Im not thrilled about bashing my
way thru this jobctl problem, but I'll knuckle down someday (soon?), 
reduce it
to an context-free bash script/apparatus for us to kick tires on 
busybox, etc..
Then fold into xeno-test and submit


>> And technically, dont regression tests have to yield
>> a PASS / FAIL decision ?  ;-)
>>
>>     
>
> Simple regular output is a good idea whenever the result is simple to
> express. A fatally crashing switch test due to broken support on arch
> XYZ will make it hard to issue "FAIL"... :)
>
>   
True, but that tells us something, doesnt it ?

presume a regression test that prints this --

    1..4
    ok 1 - Creating test program
    ok 2 - Test program runs, no error
    not ok 3 - infinite loop # TODO halting problem unsolved
    not ok 4 - infinite loop 2 # TODO halting problem unsolved

we can know:
- prog expects to complete 4 tests, and does so. (no segfault)
- fails 2 of them - and which ones.

http://jc.ngo.org.uk/trac-bin/trac.cgi/wiki/LibTap
has a nice code sample, which, at its core, is:
   

 #include "tap.h"
 plan_tests(4);
 ok(0, "Creating test prog");
 ok(some_function(), "Test program runs, no error\n");
  ...


I havent looked, but it looks purely header / macros / static inlines.
Theres a full TAP model, but we can use just the basics.

http://search.cpan.org/dist/Test-Harness/lib/Test/Harness/TAP.pod#Got_spare_tuits%3F

One aspect we might reject is the rule about other print output starting 
with "# ".
such other output is allowed by test harness, which complains otherwize.


>> Speaking more broadly, there are 3 possible kinds of test-progs
>>
>> - regression tests
>>    PASS / FAIL - either by exit(rc),
>>       or by printf( "%s\n", rc ? "not-ok" : "ok")
>>       see perl's regression test suite ( 100k separate tests )
>>       usually test details, are not tutorial
>>     
>
> Have you checked what is already under sim/skins/*/testsuite? I must
> confess I don't know if it is easily compilable for non-simulated
> execution as well. The best thing would be a test framework that builds
> both for the simulator and for "real" usage on the target.
>
>   
<sheepishly> never have tried the sim, beyond 1,2x, punted on some 
dependency issues..
Obviously thats no longer sufficient :-}
>> - performance tests
>>    progs stress xenomai, print performance data
>>    should help see performance problems, expose bugs
>>    xeno-test aims to collect performance data
>>    performance data must be expressive
>>       (switchtest is perhaps insufficient here)
>>     
>
> See my note above. I think some approach with a generic data collection
> suite + various data generators would be really fantastic! Just takes
> some brain(s) to design it and some hands to hack it...
>
>   
Taking the vision apart (for inspection), we have :

- xeno-test - shell based, semi-primitive,
     captures logs while running:
     machine-factors probes/reports, and performance tests
    workload management (semi-broken)
    semi-functional data delivery service (environmental challenges)
       email delivery wont work for me, others w/o local mail set up.

- Niklaus' ruby-on-rails ideas 
    (his xeno-test++ code to list was tantalizing, but Ill admit, havent 
looked since :-(

- big issue - server side availability

- klive.org
    python based client & server system
    uses twisted library - very network apps centric.
    implies server-side sophistication
    maybe even extensible, perhaps such that we could piggyback on their 
service (pipe dream ?)

- analysing the data (phase 2)
    big brains - think here !
    gnuplot has capabilties, but ideosyncracys too.
       also is flat-file centric, and *needs* massaging scripts.  
tedious, lots of moving parts.
    'R' is an analytical system
       big, powerful, complex, -ENOTIME
    punt on this:
       hacker exploration project(s)
       if we can just deliver good data regularly from a bunch of 
machines,  phase 1 is done.



>> - examples / tutorials
>>    ex: satch.c    simple, clear progs (low feature clutter, etc)
>>    Id like to see all demo/**/ progs in single dir
>>       forex satch-native, satch-vxworks, etc ..
>>       makes for easier browsing
>>    simple makefile
>>       builds out-of-tree
>>       handles kernel-modules and user-progs
>>       (Ive seen some clean ones, cant find now.  Mine are crufty:-(
>>    'patterns' of usage
>>       IWBGreat if we had common usage patterns isolated,
>>       named, and described
>>     
>
> Basically full ack! Wolfgang and I had this discussion recently in a
> private thread on how to deal with demos for the new CAN stack. Xenomai
> really needs more of this, and it needs it in a structured, regularly
> organised way. Some of my thoughts on a demo repository:
>
>  o Should be located in the same SVN repos, maybe under /demo, in order
>    to keep it in sync with ongoing API enhancements/modifications.
>    But the distribution should be separate from the release (just like
>    the simulator).
>
>   
im just happy to pull it from SVN.
a separate cd demos ; make is fine.

>  o Must be well commented, i.e. should not only show how things can be
>    done, but also why (or why not). That matches very well with your
>    patterns.
>
>  o Should include both simple beginners examples as well as a few more
>    complex demos.
>   
>  o Full ack to your Makefile requirement: stand-alone kernel (Hannes has
>    a nice generic one for both 2.4 and 2.6) and user-space makefiles. No
>    autotool stuff here. At the same time, we need a script to build and
>    maybe even run them automatically to detect breakages.
>
> This will certainly be a longer process and will take some helping
> hands, but we first of all need to agree on the basic structure and
> requirements, and then give it an (even small) start.
>
>   
>> Towards this last item, Ive done 2 things:
>>
>> - poached code from Hannes Mayer :-)
>>    http://www.captain.at/xenomai.php
>>    task-timers.c does periodic timer 3 ways:
>>       sleeper, waiter, alarm.
>>
>> - scrounged old rtai/fusion code (ls -l says Jul 05 ;-)
>>    cleaned up, 1/2 compile now
>>    maybe theres examples-tutorials-patterns fodder in here.
>>
>>
>> attached tarball has these in 2 top-level dirs.
>> Id like to see if theres a place for them long-term, and clean
>> them up so theyre correct and helpful.
>>
>>     
>
> They can serve as a source, but may need to be aligned to a fairly
> strict quality level we should apply on all examples. You know, the
> clearer the code is, the better the user can adopt it, the less
> questions pop up on xenomai-help - and the more time we have to hack
> nice new features instead. =8)
>
> So, how to proceed?
>   
<aside> wiki++ </>

1 file at a time - I suppose..

I'll start by poaching Hannes' Makefile, bundling it into an examples/ 
dir with
my 3-way version of his timer programs.  Id like see the target files 
appear as 0 len files,
( presuming this necessary for svn diff to see code I drop in )

Then we can discuss the more nuanced improvements /* adding tutorial, 
guidance */


After that, its just step and repeat, tossing crap along the way.

Of course, if anyone wants to pick up bits of the tarball, feel welcome :-D.
I stopped fixing compile errors where they 1st became unobvious.


> Jan
>
>
>
>   

-jimc

