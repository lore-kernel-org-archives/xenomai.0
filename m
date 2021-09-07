Subject: Re: (rt_)printf and virtual memory
References: <cf751850-8771-6120-e615-1fb80566a9a5@tin.it>
From: "Mauro S." <mau.salvi@tin.it>
Message-ID: <32fca36e-6daa-e112-2440-0f3b4e204867@tin.it>
Date: Tue, 7 Sep 2021 11:23:26 +0200
MIME-Version: 1.0
In-Reply-To: <cf751850-8771-6120-e615-1fb80566a9a5@tin.it>
Content-Language: it-IT
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-15"; Format="flowed"
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Il 07/09/21 11:21, Mauro S. via Xenomai ha scritto:
> Hi all,
> =

> consider the simple code attached.
> =

> I'm using Xenomai 3.1 on a x86_64 CPU, 2GB RAM.
> =

> I compile and link the code using "xeno-config --skin=3Dalchemy --cflags" =

> and "xeno-config --skin=3Dalchemy --ldflags"
> =

> * Scenario 1)
>  =A0 #define printf rt_printf commented out (use printf for prints)
> =

>  =A0 Changing the NUM_TASKS value, in top command I see these results:
> =

>  =A0 - NUM_TASKS 2
> =

>  =A0=A0=A0 PID=A0 PPID USER=A0=A0=A0=A0 STAT=A0=A0 VSZ %VSZ %CPU COMMAND
>  =A0=A0=A0 496=A0=A0 480 root=A0=A0=A0=A0 S=A0=A0=A0 80068=A0=A0 4%=A0=A0=
 0% ./test
> =

>  =A0 - NUM_TASKS 4
> =

>  =A0=A0=A0 PID=A0 PPID USER=A0=A0=A0=A0 STAT=A0=A0 VSZ %VSZ %CPU COMMAND
>  =A0=A0=A0 496=A0=A0 480 root=A0=A0=A0=A0 S=A0=A0=A0 80204=A0=A0 4%=A0=A0=
 0% ./test
> =

>  =A0 - NUM_TASKS 5
> =

>  =A0=A0=A0 PID=A0 PPID USER=A0=A0=A0=A0 STAT=A0=A0 VSZ %VSZ %CPU COMMAND
>  =A0=A0=A0 496=A0=A0 480 root=A0=A0=A0=A0 S=A0=A0=A0 80272=A0=A0 4%=A0=A0=
 0% ./test
> =

>  =A0 - NUM_TASKS 6
> =

>  =A0=A0=A0 PID=A0 PPID USER=A0=A0=A0=A0 STAT=A0=A0 VSZ %VSZ %CPU COMMAND
>  =A0=A0=A0 496=A0=A0 480 root=A0=A0=A0=A0 S=A0=A0=A0 80340=A0=A0 4%=A0=A0=
 0% ./test
> =

> Virtual memory size increases in a linear way.
> =

> =

> * Scenario 2)
>  =A0 #define printf rt_printf not commented (use rt_printf for prints)
> =

>  =A0 Changing the NUM_TASKS value, in top command I see these results:
> =

>  =A0 - NUM_TASKS 2
> =

>  =A0=A0=A0 PID=A0 PPID USER=A0=A0=A0=A0 STAT=A0=A0 VSZ %VSZ %CPU COMMAND
>  =A0=A0=A0 496=A0=A0 480 root=A0=A0=A0=A0 S=A0=A0=A0 80068=A0=A0 4%=A0=A0=
 0% ./test
> =

>  =A0 - NUM_TASKS 4
> =

>  =A0=A0=A0 PID=A0 PPID USER=A0=A0=A0=A0 STAT=A0=A0 VSZ %VSZ %CPU COMMAND
>  =A0=A0=A0 496=A0=A0 480 root=A0=A0=A0=A0 S=A0=A0=A0 80204=A0=A0 4%=A0=A0=
 0% ./test
> =

>  =A0 - NUM_TASKS 5
> =

>  =A0=A0=A0 PID=A0 PPID USER=A0=A0=A0=A0 STAT=A0=A0 VSZ %VSZ %CPU COMMAND
>  =A0=A0=A0 496=A0=A0 480 root=A0=A0=A0=A0 S=A0=A0=A0=A0 142M=A0=A0 4%=A0=
=A0 0% ./test
> =

>  =A0 - NUM_TASKS 6
> =

>  =A0=A0=A0 PID=A0 PPID USER=A0=A0=A0=A0 STAT=A0=A0 VSZ %VSZ %CPU COMMAND
>  =A0=A0=A0 496=A0=A0 480 root=A0=A0=A0=A0 S=A0=A0=A0=A0 206M=A0=A0 4%=A0=
=A0 0% ./test
> =

> =

> Starting from a number of tasks > 4, the VMEM got a jump and then =

> increases very rapidly.
> =

> Is it normal? Or I'm misusing the rt_printf?
> =

> Thanks in advance, regards

Damn, I forgot the attachment, sorry.

-------------- next part --------------
A non-text attachment was scrubbed...
Name: main.c
Type: text/x-csrc
Size: 1229 bytes
Desc: not available
URL: <http://xenomai.org/pipermail/xenomai/attachments/20210907/0e3c2f5b/at=
tachment.c>
