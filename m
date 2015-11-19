MIME-Version: 1.0
Message-ID: <trinity-4e7fb472-a4bb-442c-a8c9-6c8a9ebe09cc-1447920592443@3capp-webde-bap51>
From: JK.Behnke@web.de
Content-Type: text/plain; charset=UTF-8
Date: Thu, 19 Nov 2015 09:09:52 +0100
Subject: Re: [Xenomai] rtdm_clock_read overhead/accuracy question
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

>On Wed, Nov 18, 2015 at 06:11:00PM +0100, JK.Behnke at web.de wrote:
>> Hello Gilles,
>> 
>> >On Wed, Nov 18, 2015 at 03:36:25PM +0100, JK.Behnke at web.de wrote:
>> >> Hello Gilles,
>> >>
>> >> thanks for your quick response.
>> >> See my comments/questions below.
>> >>
>> >> >On Wed, Nov 18, 2015 at 02:34:56PM +0100, JK.Behnke at web.de wrote:
>> >> >> Hello,
>> >> >>
>> >> >> I'm currently debugging a problem in my xenomai application.
>> >> >> In order ot get timing information I do the following inside the
>> >> >> read-handler of my rtdm driver.
>> >> >>
>> >> >> // --- start code snippet ---------------------------------
>> >> >> nanosecs_abs_t t1, t2;
>> >> >> rtdm_lock_get_irqsave(&lockobj, lockctx);
>> >> >>
>> >> >> t1=rtdm_clock_read();
>> >> >> rtdm_task_busy_sleep(10000); // code block to be measured.
>> >> >> t2=rtdm_clock_read();
>> >> >>
>> >> >> rtdm_lock_put_irqrestore(&lockobj, lockctx);
>> >> >> // --- end code snippet ---------------------------------
>> >> >>
>> >> >> I observe the following time differences t2-t1:
>> >> >> min=10176 ns, max=10737 ns, avg=10314 ns
>> >> >>
>> >> >> This means in this case the average overhead of the two rtdm_clock_read
>> >> >> calls is
>> >> >> approximately 314 ns/2 = 157 ns.
>> >> >
>> >> >No, this means that the average overhead of rtdm_clock_read is
>> >> >314ns.
>> >> >
>> >> >what you do is:
>> >> >read time
>> >> >convert to ns
>> >> >busy sleep
>> >> >read time
>> >> >convert to ns
>> >> >
>> >> >As you can see, between the two time reads, there is only one
>> >> >conversion to nanoseconds, (which we assume is the bulk of the
>> >> >overhead). And more generally, the overhead of the second time read
>> >> >is not counted either.
>> >> >
>> >> >
>> >> >>
>> >> >> Is that realistic?
>> >> >
>> >> >This seems to be a lot. The "tsc" test will measure the average
>> >> >difference between two time reads, and the "arith" test will measure
>> >> >the average time for a "multiply then shift" operation, adding the
>> >> >two should give you an idea of the overhead. From what I recall,
>> >> >reading the tsc on an atom N230 (a very old one) had an overhead
>> >> >around 20ns.
>> >> Where do I find the "tsc test", which test application do I have to run?
>> >
>> >The application is named "tsc".
>> 
>> Thanks, meanwhile I found the tsc tool under
>> /usr/xenomai/bin/regression
>
>Yeah, well, not a very good default directory. You can onverride it
>with an option from the configure script.
>
>> 
>> Here are my "tsc" results
>> Atom E640 (1.0 GHz): min: 26, max: 936, avg: 34.0001 -> 0.0262211 us  ==> 26 ns
>> Atom E660 (1.3 GHz): min: 26, max: 1105, avg: 34.0001 -> 0.0262211 us ==> 26 ns
>
>Well, there is a problem with the time conversion routines. 34
>cycles on a 1.0 GHz machine should be 34ns, not 26ns. Other than
>that, it seems consistent with what I observe on my old atom.

What can I do about that?

By the way, I measured the difference of two consecutive xnarch_get_cpu_tsc() calls.
Atom E640 (1.0 GHz): min=30 max=40 avg=30.2

As in my case I have disabled interrupts using rtdm_lock_get_irqsave() during
execution of xnarch_get_cpu_tsc(), I wonder why I get different min/max values at all?
I assume that xnarch_get_cpu_tsc() is compiled to a single RDTSC instruction.
Doesn't a RDTSC machine instruction have a deterministic number of cpu cycles?
Aah, obviously this has something to do with so called serializing instructions inside the cpu.
Some people recommend using the new RDTSCP instruction to measure execution times.
Is it for performance reasons that xnarch_get_cpu_tsc uses RDTSC instruction?


Regards
Jochen

