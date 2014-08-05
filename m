MIME-Version: 1.0
Sender: patrickdepinguin@gmail.com
In-Reply-To: <53E0B5BA.8010102@xenomai.org>
References: <CAKc2Hpb0S50P=9iWvw3z9NexHmyZEjuAU=7SGyT77EPpub_D2A@mail.gmail.com>
 <53B57361.1000603@xenomai.org>
 <CAKc2HpZROnFhxVZo3PWQzAoTYZHvvRCydFqxokKS_bQT2LHYVg@mail.gmail.com>
 <53BC20E5.6090607@xenomai.org>
 <CAKc2HpbWrU7_1JG4_K9+P_3H8Vs5-xq6W7aZ4ELjVNB+ReOD0A@mail.gmail.com>
 <53BD0AA6.30901@xenomai.org>
 <CAKc2Hpaaqi69CSgJZc54kqAYNVdPyTS_D0hnXjKAKLDb41BSuw@mail.gmail.com>
 <53BD4EBC.5010601@xenomai.org>
 <CAKc2HpbbN+kY9h55iYGqTk4c9bxDEb-OZ2orN07wKuyi42KndA@mail.gmail.com>
 <CAKc2HpZ_VHevyV-Eh3jL5FhWub1LZjO=p3xBgesYdAgubN2H7Q@mail.gmail.com>
 <53D62F5B.5040208@xenomai.org>
 <CAKc2HpZOrT=VJnwi5q0W1FmPHQjDYHBpjpNjp+NUAn=txDU3UA@mail.gmail.com>
 <53D6C634.3040700@xenomai.org>
 <CAKc2HpZZRA-364=tTdK94bUc3a2kK05xDMu3=YNgMzZp0XNEzg@mail.gmail.com>
 <53DFBD97.4000001@xenomai.org>
 <CAKc2HpYWmoGQmF6gcA3W5QDPZYX6DAU0Cyt0E5+XWF3p=KdPcw@mail.gmail.com>
 <53E0B5BA.8010102@xenomai.org>
From: Thomas De Schampheleire <patrickdepinguin+xenomai@gmail.com>
Date: Tue, 5 Aug 2014 14:39:01 +0200
Message-ID: <CAAXf6LXR18BRS-+-2m25UDUYa6wcEww_b7dZ2CeT3TV_+vO9Jg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Xenomai] Xenomai-forge: Deadlock in finalize_thread()
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>
Cc: "Xenomai@xenomai.org" <xenomai@xenomai.org>

Philippe,

On Tue, Aug 5, 2014 at 12:45 PM, Philippe Gerum <rpm@xenomai.org> wrote:
>>
>> I have tried the test with your patch and the issue no longer occurs.
>> Yes, I am indeed running a multi-core board (cpu: Cavium Octeon II - 8
>> cores).
>
> Then make sure to pass --enable-smp to the build configuration line. The
> Xenomai 3 libraries issue memory barriers internally in some lockless
> operations which are required for proper ordering, but only when this
> switch was given.
>


I assume that if you pass --enable-smp at the configure stage, but
then run the resulting library on a single-core (or under a 'taskset'
cpu affinity of a single core), things will still work fine, is that
correct?

Thanks,
Thomas

