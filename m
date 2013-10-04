MIME-Version: 1.0
In-Reply-To: <2dd3a285e2284e2576787348a4fafc72.squirrel@127.0.0.1>
References: <CAK4EZFSLBBOs174xP+JAsqgJgG-MJ5UxMsj_FD5Pzjh1BHz7gw@mail.gmail.com>
	<52435E3D.7020202@xenomai.org>
	<201309261032.30542.paul_c@tuxcnc.org>
	<201310041336.33020.paul_c@tuxcnc.org>
	<CAK4EZFRUKBxu-sW68LoGF0w+PdoMxa2wK9eRB3-eYZPtFY_UDg@mail.gmail.com>
	<2dd3a285e2284e2576787348a4fafc72.squirrel@127.0.0.1>
Date: Fri, 4 Oct 2013 13:19:39 -0400
Message-ID: <CAK4EZFSCvgirOV=ZfsD__fyTL2y3SWBq7XBALTvPg3Z7NaJHOg@mail.gmail.com>
From: Adam Vaughan <vaughana@umich.edu>
Content-Type: text/plain; charset=ISO-8859-1
Subject: Re: [Xenomai] Raspberry Pi patch issue?
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

Oh wow, thank you for that reference.

One thing that I'm curious about is how "disable_pvt=1" would affect
the Raspberry Pi's 24-hour latency numbers.  I hope to run such a test
in the next month or so after I get my code finished, but it might be
of interest to others to look at too since it can add 8-16 us latency
for SDRAM transactions every 500 ms (see [1]).

[1] http://www.raspberrypi.org/phpBB3/viewtopic.php?f=37&t=7696


On Fri, Oct 4, 2013 at 12:44 PM, Gilles Chanteperdrix
<gilles.chanteperdrix@xenomai.org> wrote:
>
> Adam Vaughan wrote:
>> Hi Paul,
>>
>> Thank you!  I really do appreciate your efforts putting the patches
>> together.  Just to get a rough idea what latency to expect, will these
>> patches achieve similar performance compared to the older patches for
>> Linux 3.5.7 provided at [1] and tested at [2]?  For quick reference,
>> I've attached the 24 hour GPIO latency test histogram under high load
>> from [2].
>>
>> Finally, would like to just briefly mention that I think the Raspberry
>> Pi is a great hobbyist board for Xenomai to support because of it's
>> low cost and reasonably fast hardware FPU.  I've been really happy
>> with how easy it is to implement Xenomai code, and that incorporating
>> double precision matrix algebra support from the Eigen library has
>> been a breeze so far.
>
> From the comparisons made on other ARMs, 3.8 and 3.5 look pretty similar:
> http://www.xenomai.org/~gch/core-3.8-latencies/
>
> --
>                                               Gilles
>

