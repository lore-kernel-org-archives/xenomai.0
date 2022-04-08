Date: Fri, 8 Apr 2022 12:49:22 +0200 (CEST)
From: Richard Weinberger <richard@nod.at>
Message-ID: <271523130.229269.1649414962370.JavaMail.zimbra@nod.at>
In-Reply-To: <87v8vjonxz.fsf@xenomai.org>
References: <20220408080401.22235-1-richard@nod.at>
 <20220408080401.22235-4-richard@nod.at>
 <7aa1e2f14db4438eeae8225d143c1836aee42879.camel@siemens.com>
 <87v8vjonxz.fsf@xenomai.org>
Subject: Re: [PATCH 3/6] testsuite: Add a simple test driver for alchemytests
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
>> Why is this "special" cpu-affinity necessary? What would happen if we
>> remove that? Asking because I want to make sure that we do not miss any
>> concurrency problems by adding this constraint.
>>
>=20
> The reason to pin the threads on the same CPU is to guarantee an ideal
> execution sequence for some tests provided the scheduling policy and/or
> the synchronization mechanisms do behave as intended. Concurrency on
> multiple CPU would break the assumptions about that ideal sequence.
>=20
> For instance, you could not resort to any inter-thread synchronization
> to prevent unwanted SMP concurrency when checking that a scheduling
> policy is properly undergone, that would make the test irrelevant by
> papering over local preemption issues if any.  So we pin all the threads
> on the same CPU to exclude SMP, and only that.

So the tests have assumptions about the scheduling order of threads?
I always thought even with a single CPU such assumptions can break.

Thanks,
//richard

