References: <CAOuPNLgxO=tNBOAhJ_FO2Qo4chhi1BvCNSYqCL-TX0yA=9rqsw@mail.gmail.com>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <35bb959b-9fa6-e8c6-6ed4-d0f454a0d2ae@xenomai.org>
Date: Thu, 8 Mar 2018 16:19:45 +0100
MIME-Version: 1.0
In-Reply-To: <CAOuPNLgxO=tNBOAhJ_FO2Qo4chhi1BvCNSYqCL-TX0yA=9rqsw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] [xenomai] inconsistency in latency behavior
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Pintu Kumar <pintu.ping@gmail.com>, "Xenomai@xenomai.org" <xenomai@xenomai.org>, Greg Gallagher <greg@embeddedgreg.com>, Jan Kiszka <jan.kiszka@web.de>

On 03/08/2018 03:16 PM, Pintu Kumar wrote:
> Hi,
> 
> On x86_64 machine (with xenomai 3.0) sometimes I observed a huge
> variance and inconsistency in latency data when measuring latency
> delay using clock_nanosleep.
> I observed this inconsistency in both normal kernel, as well as xenomai kernel.
> I observed the same, even when using the direct xenomai API such as:
> rt_time_read().
> 
> So, I wanted to know if anybody observed the similar behavior.
> Or I am not sure if I am doing some thing wrong in measurement itself.
> 
> I will explain my scenario below.
> 1) I created a single thread using the pthread API.
> 2) Inside the thread function, I just print one message and sleep for
> 100 micro-seconds using the clock_nanosleep() API.
> 3) Then I calculate the time difference before and after sleep.
> 4) I repeat this for 10 times, and then calculate the average.
> 5) I build this application for normal kernel and for xenomai using posix skin.
> 6) Then I compare the latency between both.
> 
> What I observed is as follows:
> 1) Even if I give sleep for 100 micro-seconds, the timing difference
> comes in: 150, 160, and even in 600, 1000. Thus the average difference
> shows very high.
> 
> 2) Sometimes, the xenomai timing difference is much larger than normal kernel.
> LIKE: Normal kernel => Average time taken  = 232.288 us
>        Xenomai kernel => Average time taken  = 427.478 us
> 
> 3) If I give sleep in less than 5 mirco-seconds, then xenomai shows
> better. But still the time taken is not accurate.
>     Normal kernel => Average time taken  = 42.989 us
>  Xenomai kernel => Average time taken  = 26.264 us
> 
> 4) If I give sleep in 100 milli-seconds, then only the results are
> coming some what proper.
>     Normal kernel => Average time taken  = 100.465 us
>  Xenomai kernel => Average time taken  = 100.409 us
> 
> 
> What could be the cause of this inconsistency ?
> Did anybody observed the similar issue on some system?

1. Does the standard latency test from the Xenomai distribution perform
properly on your hw? If so, then the issue is most likely in your
application.

2. Did you read [1][2], are you aware of the existence of so-called
"mode switches", and how they can ruin the latency figures? If not,
please read that document.

3. Did you read [3], particularly section #3, with the admonition
regarding the effect of "xeno-config --posix --ldflags"? Please do,
reviewing all your libc calls in this light, including printf().

[1] http://xenomai.org/2014/06/finding-spurious-relaxes/
[2]
http://xenomai.org/2014/08/porting-a-linux-application-to-xenomai-dual-kernel/
[3]
http://www.xenomai.org/documentation/xenomai-3/html/man1/xeno-config/index.html

PS: no need to Cc: contributors and maintainers along with posting to
xenomai@xenomai.org. We all read this list.

-- 
Philippe.

