Message-ID: <53D01F05.8020608@xenomai.org>
Date: Wed, 23 Jul 2014 22:45:57 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <CAKc2Hpb0S50P=9iWvw3z9NexHmyZEjuAU=7SGyT77EPpub_D2A@mail.gmail.com>	<53B57361.1000603@xenomai.org>	<CAKc2HpZROnFhxVZo3PWQzAoTYZHvvRCydFqxokKS_bQT2LHYVg@mail.gmail.com>	<53BC20E5.6090607@xenomai.org>	<CAKc2HpbWrU7_1JG4_K9+P_3H8Vs5-xq6W7aZ4ELjVNB+ReOD0A@mail.gmail.com>	<53BD0AA6.30901@xenomai.org>	<CAKc2Hpaaqi69CSgJZc54kqAYNVdPyTS_D0hnXjKAKLDb41BSuw@mail.gmail.com>	<53BD4EBC.5010601@xenomai.org>	<CAKc2HpbbN+kY9h55iYGqTk4c9bxDEb-OZ2orN07wKuyi42KndA@mail.gmail.com>
 <CAKc2HpZ_VHevyV-Eh3jL5FhWub1LZjO=p3xBgesYdAgubN2H7Q@mail.gmail.com>
In-Reply-To: <CAKc2HpZ_VHevyV-Eh3jL5FhWub1LZjO=p3xBgesYdAgubN2H7Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Xenomai-forge: Deadlock in finalize_thread()
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Kim De Mey <kim.demey@gmail.com>
Cc: "Xenomai@xenomai.org" <xenomai@xenomai.org>

On 07/23/2014 10:31 AM, Kim De Mey wrote:
> 2014-07-09 17:05 GMT+02:00 Kim De Mey <kim.demey@gmail.com>:
> Philippe,
> 
> Could you explain this case of the async cancellation signal? I don't
> fully understand how this happens or why it causes the issue.
> 
> I also tested once with CONFIG_XENO_ASYNC_CANCEL OFF and then the
> issue doesn't occur anymore.
> 

There must be something fragile with respect to disabling the
cancellation signal when running the thread prologue, which causes the
finalizer to run while the thread holds its own lock, as it handles
SIGCANCEL from the wrong place. This requires an async notification to
take place, hence your observation after switching off ASYNC_CANCEL. I
did not track it down entirely yet.

I'm slightly buried alive in the preparation of the initial Xenomai 3
-rc release, and/but because of that, I will definitely address this
issue in the coming weeks, hopefully in two weeks from now.

> Thanks!
> 
> Kim
> 


-- 
Philippe.

