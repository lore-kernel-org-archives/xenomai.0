Date: Fri, 4 Mar 2022 21:09:16 +0100 (CET)
From: Richard Weinberger <richard@nod.at>
Message-ID: <2141336610.110112.1646424555986.JavaMail.zimbra@nod.at>
In-Reply-To: <87fsnxr3nc.fsf@xenomai.org>
References: <1971847999.108624.1646393705887.JavaMail.zimbra@nod.at>
 <7cc78732bf4902691e4194f52738ef1380c52ca6.camel@siemens.com>
 <1918812394.108775.1646396125911.JavaMail.zimbra@nod.at>
 <87fsnxr3nc.fsf@xenomai.org>
Subject: Re: Questiion on commit: demo/cyclictest: fix time delta calculation
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
Cc: Florian Bezdeka <florian.bezdeka@siemens.com>, xenomai <xenomai@xenomai.org>

Philippe,

----- Urspr=C3=BCngliche Mail -----
> Von: "Philippe Gerum" <rpm@xenomai.org>
> Florian pointed in the right direction when mentioning autotune: if the
> core timer is not calibrated properly, Cobalt might try to compensate
> for the basic latency of the platform too much, leading to early timer
> shots. If such an early shot arrives and the test loop wakes up too
> early, say in the code implementing clock_nanosleep (-n) case, 'next'
> might actually be later in the timeline than 'now', leading to negative
> differences in calcdiff().

I did some more experiments. The system was already autotuned.
But raising the base interval from 1000 (default) to 5000 made the issue
go away.

Thanks,
//richard

