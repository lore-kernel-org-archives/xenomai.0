Message-ID: <581CAD5C.1090600@numalliance.com>
Date: Fri, 04 Nov 2016 16:46:36 +0100
From: =?UTF-8?B?U3TDqXBoYW5lIGFuY2Vsb3Q=?= <sancelot@numalliance.com>
References: <581A1E18.7040405@numalliance.com>	<20161103093605.2228191c@md1em3qc>	<581B57C4.8020609@numalliance.com>
 <20161103173838.16bf77c9@md1em3qc>
In-Reply-To: <20161103173838.16bf77c9@md1em3qc>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Subject: Re: [Xenomai] ipipe tracer question
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
Content-Transfer-Encoding: 8bit
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

   On 03/11/2016 17:38, Henning Schild wrote:

Am Thu, 3 Nov 2016 16:29:08 +0100
schrieb Stéphane ancelot [1]<sancelot@numalliance.com>:


On 03/11/2016 09:36, Henning Schild wrote:

Am Wed, 2 Nov 2016 18:10:48 +0100
schrieb Stéphane ancelot[2]<sancelot@numalliance.com>:



Hi,
I have got an RT task that seems being disturbed by some system
driver.

So, I have setted up ipipe tracer in kernel.


The tracing uses the kernel tracing infrastructure. Use the
sysfs-Interface or a tool like trace-cmd or perf to collect traces.
[3]https://www.kernel.org/doc/Documentation/trace/ftrace.txt



I am now able to trace in the kernel.
I made some function trace in  the shell, but I have not managed to
find where is my problem.
I want to find where my tasks spend more time than usuallly. e.g.
(end task - start task) > 500us

I have some references to cobalt_head_sysentry , cobalt_head_sys
I made a trace with trace-cmd and I am able to load it with
kernelshark. a bit difficult to understand the graph.

I have never worked with kernelshark, usually i read the traces in a
pager or text-editor.
To get a better correlation with the RT task activity and the kernel,
you should leave traces from the application.
Have a look at include/cobalt/trace.h to see functions that help you do
that. Some of them are used in some of the examples, i did not find
documentation, but the names sound kind of meaningful.


   I found some informations in web archives regarding these functions:
   [4]https://mail.gna.org/public/xenomai-core/2006-06/msg00180.html
   I used xntrace_special() in my program, but unfortunately, altough it
   does not reply with ENOSYS error, I can't sea really how it is reported
   in trace log.
   how can I watch the numbered given in parameters.???

It is best if you stop tracing as soon as you detected a violation.

Filter the trace ie with grep after you collected them, the first thing
to read it backwards from the spike filtering by CPU. If you are lucky
you have left a "all good" mark somewhere close above the problem.

If you still have trouble to read it, maybe kernelshark can process
parts of a whole trace. Or you will at least have a better idea where to
zoom in.



But I do not know where to  go  now ?
I suppose being on the right way, but what to do next ?

Regards,
S.Ancelot


_______________________________________________
Xenomai mailing list
[5]Xenomai@xenomai.org
[6]https://xenomai.org/mailman/listinfo/xenomai


_______________________________________________
Xenomai mailing list
[7]Xenomai@xenomai.org
[8]https://xenomai.org/mailman/listinfo/xenomai

References

   1. mailto:sancelot@numalliance.com
   2. mailto:sancelot@numalliance.com
   3. https://www.kernel.org/doc/Documentation/trace/ftrace.txt
   4. https://mail.gna.org/public/xenomai-core/2006-06/msg00180.html
   5. mailto:Xenomai@xenomai.org
   6. https://xenomai.org/mailman/listinfo/xenomai
   7. mailto:Xenomai@xenomai.org
   8. https://xenomai.org/mailman/listinfo/xenomai
