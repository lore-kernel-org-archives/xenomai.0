Date: Fri, 4 Nov 2016 16:59:28 +0100
From: Henning Schild <henning.schild@siemens.com>
Message-ID: <20161104165928.63865836@md1em3qc>
In-Reply-To: <581CAD5C.1090600@numalliance.com>
References: <581A1E18.7040405@numalliance.com>
 <20161103093605.2228191c@md1em3qc>
 <581B57C4.8020609@numalliance.com>
 <20161103173838.16bf77c9@md1em3qc>
 <581CAD5C.1090600@numalliance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai] ipipe tracer question
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: =?UTF-8?B?U3TDqXBoYW5l?= ancelot <sancelot@numalliance.com>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

Am Fri, 4 Nov 2016 16:46:36 +0100
schrieb St=C3=A9phane ancelot <sancelot@numalliance.com>:

>    On 03/11/2016 17:38, Henning Schild wrote:
>=20
> Am Thu, 3 Nov 2016 16:29:08 +0100
> schrieb St=C3=A9phane ancelot [1]<sancelot@numalliance.com>:
>=20
>=20
> On 03/11/2016 09:36, Henning Schild wrote:
>=20
> Am Wed, 2 Nov 2016 18:10:48 +0100
> schrieb St=C3=A9phane ancelot[2]<sancelot@numalliance.com>:
>=20
>=20
>=20
> Hi,
> I have got an RT task that seems being disturbed by some system
> driver.
>=20
> So, I have setted up ipipe tracer in kernel.
>=20
>=20
> The tracing uses the kernel tracing infrastructure. Use the
> sysfs-Interface or a tool like trace-cmd or perf to collect traces.
> [3]https://www.kernel.org/doc/Documentation/trace/ftrace.txt
>=20
>=20
>=20
> I am now able to trace in the kernel.
> I made some function trace in  the shell, but I have not managed to
> find where is my problem.
> I want to find where my tasks spend more time than usuallly. e.g.
> (end task - start task) > 500us
>=20
> I have some references to cobalt_head_sysentry , cobalt_head_sys
> I made a trace with trace-cmd and I am able to load it with
> kernelshark. a bit difficult to understand the graph.
>=20
> I have never worked with kernelshark, usually i read the traces in a
> pager or text-editor.
> To get a better correlation with the RT task activity and the kernel,
> you should leave traces from the application.
> Have a look at include/cobalt/trace.h to see functions that help you
> do that. Some of them are used in some of the examples, i did not find
> documentation, but the names sound kind of meaningful.
>=20
>=20
>    I found some informations in web archives regarding these
> functions:
> [4]https://mail.gna.org/public/xenomai-core/2006-06/msg00180.html I
> used xntrace_special() in my program, but unfortunately, altough it
> does not reply with ENOSYS error, I can't sea really how it is
> reported in trace log. how can I watch the numbered given in
> parameters.???

I have not used them before so i am not sure. Maybe worth reading the
code to see how they eventually make their way to ftrace calls. Maybe
they depend on some CONFIG_
I have once used invalid syscalls for somthing like that, not knowing
about the official "trace api".
That should create trace points, but be carefull not to run into valid
syscall numbers. And doing that should be a last resort if for some
reason you really can not use xntrace_*

> XENOMAI_SYSCALL0(-1);
> XENOMAI_SYSCALL0(-2);
> ...
>     (skin max syscall number + 1)



> It is best if you stop tracing as soon as you detected a violation.
>=20
> Filter the trace ie with grep after you collected them, the first
> thing to read it backwards from the spike filtering by CPU. If you
> are lucky you have left a "all good" mark somewhere close above the
> problem.
>=20
> If you still have trouble to read it, maybe kernelshark can process
> parts of a whole trace. Or you will at least have a better idea where
> to zoom in.
>=20
>=20
>=20
> But I do not know where to  go  now ?
> I suppose being on the right way, but what to do next ?
>=20
> Regards,
> S.Ancelot
>=20
>=20
> _______________________________________________
> Xenomai mailing list
> [5]Xenomai@xenomai.org
> [6]https://xenomai.org/mailman/listinfo/xenomai
>=20
>=20
> _______________________________________________
> Xenomai mailing list
> [7]Xenomai@xenomai.org
> [8]https://xenomai.org/mailman/listinfo/xenomai
>=20
> References
>=20
>    1. mailto:sancelot@numalliance.com
>    2. mailto:sancelot@numalliance.com
>    3. https://www.kernel.org/doc/Documentation/trace/ftrace.txt
>    4. https://mail.gna.org/public/xenomai-core/2006-06/msg00180.html
>    5. mailto:Xenomai@xenomai.org
>    6. https://xenomai.org/mailman/listinfo/xenomai
>    7. mailto:Xenomai@xenomai.org
>    8. https://xenomai.org/mailman/listinfo/xenomai
> _______________________________________________
> Xenomai mailing list
> Xenomai@xenomai.org
> https://xenomai.org/mailman/listinfo/xenomai


