Date: Mon, 1 Oct 2018 02:42:18 -0500 (CDT)
From: Per Oberg <pero@wolfram.com>
Message-ID: <590994061.262338.1538379738455.JavaMail.zimbra@wolfram.com>
In-Reply-To: <759115071.1538372023382.JavaMail.root@webmail>
References: <759115071.1538372023382.JavaMail.root@webmail>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai] What does activating SMP mean?
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai <xenomai@xenomai.org>

Hello

----- Den 1 okt 2018, p=C3=A5 kl 7:33, =EB=B0=95=EC=9E=AC=ED=98=B8 jaeho@se=
oultech.ac.kr skrev:

> Hi, all

> I thought that activating SMP makes tasks using all cpu cores, but I real=
ized
> that it doesn't.

> I did not explicitly specify the CPU when I created the task.

> I have created two xenomai tasks and checked to see how much cpu share th=
e task
> has on any cpu with / proc / xenomai / stat.

> As a result, we confirmed that only one cpu of two cpu works.

> So we used T_CPU () to allocate different CPU cores for each task when we
> created the task.

> As a result, you can see that both tasks are running on two CPUs.

> I expected to use both CPUs when I enabled SMP, but I did not. Why is not=
 it?

> Also, does one task only run on one cpu?

> The environment I used is shown below.

> ------------------------------------------------------------------------

> zybo-z7-20(zynq-7000)

> Dual-Core ARM Coretex-A9 MPCore Up to 866MHz

> xenomai 2.6.5

> kernel 3.14.2

> ubuntu 14.04

> ------------------------------------------------------------------------

> thank you for your advice.

> _______________________________________________
> Xenomai mailing list
> Xenomai@xenomai.org
> https://xenomai.org/mailman/listinfo/xenomai

Not sure that I can answer your question as it was formulated, but perhaps =
I can contribute with something. Do your test-task use all your CPU time or=
 do you have idling? I would -guess- that as long as one CPU is sufficient =
the scheduler won't use any other unless it was specified on the command-li=
ne.

I answer, even though I am not sure about this  because I would like to be =
corrected if I'm wrong.=20

Regards
Per =C3=96berg

