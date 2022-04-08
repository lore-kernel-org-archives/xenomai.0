References: <20220408080401.22235-1-richard@nod.at>
 <20220408080401.22235-4-richard@nod.at>
 <7aa1e2f14db4438eeae8225d143c1836aee42879.camel@siemens.com>
From: Philippe Gerum <rpm@xenomai.org>
Subject: Re: [PATCH 3/6] testsuite: Add a simple test driver for alchemytests
Date: Fri, 08 Apr 2022 12:34:09 +0200
In-reply-to: <7aa1e2f14db4438eeae8225d143c1836aee42879.camel@siemens.com>
Message-ID: <87v8vjonxz.fsf@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "Bezdeka, Florian" <florian.bezdeka@siemens.com>
Cc: "richard@nod.at" <richard@nod.at>, xenomai@xenomai.org


"Bezdeka, Florian via Xenomai" <xenomai@xenomai.org> writes:

> Hi Richard,
>
> On Fri, 2022-04-08 at 10:03 +0200, Richard Weinberger via Xenomai
> wrote:
>> +static int __run_extprog(struct smokey_test *t, int argc, char *const argv[])
>> +{
>> +	int ret;
>> +	char *tst_path;
>> +
>> +	ret = asprintf(&tst_path, "%s/%s --cpu-affinity=0", mydir, t->name);
>> +	if (ret == -1)
>> +		return -ENOMEM;
>
> Why is this "special" cpu-affinity necessary? What would happen if we
> remove that? Asking because I want to make sure that we do not miss any
> concurrency problems by adding this constraint.
>

The reason to pin the threads on the same CPU is to guarantee an ideal
execution sequence for some tests provided the scheduling policy and/or
the synchronization mechanisms do behave as intended. Concurrency on
multiple CPU would break the assumptions about that ideal sequence.

For instance, you could not resort to any inter-thread synchronization
to prevent unwanted SMP concurrency when checking that a scheduling
policy is properly undergone, that would make the test irrelevant by
papering over local preemption issues if any.  So we pin all the threads
on the same CPU to exclude SMP, and only that.

-- 
Philippe.

