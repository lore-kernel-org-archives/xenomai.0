Message-ID: <5137496C.4090908@xenomai.org>
Date: Wed, 06 Mar 2013 14:49:32 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <CAMJ=MEfo5EU2mnM4=JDNU4QXX00W=0aC2+m5LucPYiN39W5wcQ@mail.gmail.com>
	<512FB9B5.9040709@xenomai.org>
	<CAAXf6LXDSxU_eASbHOgQzw_2xSpZua2BaORAiJ59KoPitFNEcg@mail.gmail.com>
	<51306545.1010200@xenomai.org> <5130663F.7070209@xenomai.org>
	<51306710.5030201@xenomai.org> <5130673D.2090700@xenomai.org>
	<513069D5.1090508@xenomai.org>
	<CAMJ=MEdAfvwWhjc4SLPk5smh+vNbPDJP=kM3bBFdw6n3bJd_mg@mail.gmail.com>
In-Reply-To: <CAMJ=MEdAfvwWhjc4SLPk5smh+vNbPDJP=kM3bBFdw6n3bJd_mg@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Xenomai-forge: thread using 100% cpu load
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Ronny Meeus <ronny.meeus@gmail.com>
Cc: xenomai@xenomai.org

On 03/02/2013 12:13 PM, Ronny Meeus wrote:

> An update on the investigation:
> I was able to make this issue disappear by changing the timeout value
> of the smallest timers we use.
> We use a couple of timers with a timeout of 25ms. By enlarging these
> to 25sec and the problem is gone.
>
> Yesterday I was also able to see (using the"strace" tool) the process
> executing constantly "clone" system calls.
> Note that the process we use is large (2Gb) and uses an mlockall call.
>
> In http://stackoverflow.com/questions/4263958/some-information-on-timer-helper-thread-of-librt-so-1/4935895#4935895
> I see that a new thread is created when the timer_create is called for
> the first time. This thread stays alive until the program exits and is
> used to process the timer expiries.

Looking at the code, glibc 2.9 not only forks one helper thread once, 
but also creates a dedicated short-lived thread for running the user 
handler at each timer expiration. This implementation is still current 
with 2.15. Which makes quite too many clones out there for my taste.

-- 
Philippe.

