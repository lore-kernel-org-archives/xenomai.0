Date: Tue, 7 May 2019 01:53:35 -0500 (CDT)
From: Per Oberg <pero@wolfram.com>
Message-ID: <1907767262.9872848.1557212015078.JavaMail.zimbra@wolfram.com>
In-Reply-To: <4c39d8ca-3c98-4b35-6b06-2013dc80134b@xenomai.org>
References: <1823257552.1557117297954.94.KebiMail.daeyoungsong@cnu.ac.kr>
 <4c39d8ca-3c98-4b35-6b06-2013dc80134b@xenomai.org>
Subject: Re: Xenomai Mercury and PREEMPT_RT
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>
Cc: =?utf-8?B?7Iah64yA7JiB?= <daeyoungsong@cnu.ac.kr>, xenomai <xenomai@xenomai.org>


----- Den 6 maj 2019, p=C3=A5 kl 10:07, xenomai xenomai@xenomai.org skrev:
> On 5/6/19 6:34 AM, =EC=86=A1=EB=8C=80=EC=98=81 via Xenomai wrote:
> > [webmailreconf.public.do?24538165]

> > Hello, expert.

> > I have a question about Xenomai Mercury and PREEMPT_RT.
> > Following "Xenomai 3 =E2=80=93 An Overview of the Real-Time Framework f=
or
> > Linux", Mercury is based on PREEMPT_RT and only offers API emulation.
> > Is Mercury's latency performance better than PREEMPT_RT?

> No, it merely uses what native preemption provides for.

So, just to be clear. Are you saying that it should be "Just as good" as PR=
EEMPT.RT when the kernel is fully patched? (Whatever that means...)

Now, I don't want to start a flame-war here, that would be stupid. But I re=
ally want to know your opinion on this (see for eaxmple claims made in [1])=
. May we assume that the Mercury performance would be quite close to Cobolt=
 performance ?

And how about communication with hardware communication in a PREEMT_RT setu=
p? Without special RT-drivers what can we expect?  For me it's not about wh=
en something can be computed but rather when it can be commuicated.


[1] http://linuxgizmos.com/real-time-linux-explained/

Qute: "While Xenomai performed better on most tests, and offered far less j=
itter, the differences were not as great as the 300 to 400 percent latency =
superiority claimed by some Xenomai boosters, said Altenberg. When tests we=
re performed on userspace tasks =E2=80=94 which Altenberg says is the most =
real-world, and therefore the most important, test =E2=80=94 the worst-case=
 reaction was about 90 to 95 microseconds for both Xenomai and RTL/PREEMPT.=
RT, he claimed."


> --
> Philippe.



Per =C3=96berg=20

