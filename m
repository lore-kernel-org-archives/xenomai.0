References: <2396B4D2166B62479FBBE370D4A7C1F30A716241@mb2010-1.intra.tut.fi>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <5673D046.6090505@xenomai.org>
Date: Fri, 18 Dec 2015 10:22:14 +0100
MIME-Version: 1.0
In-Reply-To: <2396B4D2166B62479FBBE370D4A7C1F30A716241@mb2010-1.intra.tut.fi>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Possible sync problem with timerfd and application
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Umair Ali <ali.umair@tut.fi>, =?UTF-8?Q?Xenomai_list_=e2=80=8e_, , xenomai@xenomai.org, , _=e2=80=8e?= <xenomai@xenomai.org>

On 12/17/2015 03:07 PM, Umair Ali wrote:
> Hello there,
> 
> I am using the timerfd to produce the required sleep function for sending the raw ethernet packets using rtnet driver periodically. I read the file using the mmap() function and mlockall(MCL_CURRENT|MCL_FUTURE). My code is attached with this email. Gilles have already explained me with the jitter problem with timerfd but it is acceptable so far with me.

For the sake of clarity, Gilles told you about the requirement for
timerfd_create() to switch to secondary/linux mode for processing the
request, which may induce delays. He certainly did not told you that
reading from that Cobalt timerfd would induce jitter on a
well-performing Xenomai setup. You may convince yourself about this fact
by running the latency test: it is based on a sampling thread
synchronizing on a timerfd.

Unless you do observe high latencies with this test program, you should
probably assume a bug in the application rather than suspecting any core
operating system services, at least during the early stage of your
investigations.

 Now the problem is that the code runs ok for more or less 30 secs. For
this period of running of code the jitter is acceptable. But after some
time the jitter increases very much and causes  problem. I thought that
this may be because the timerfd has lost the synchronization with
application. Or timerfd is not working fine. I tried to use the poll()
and epoll() also but the problem persist.  Can you guide me how i can
find the problem when running the application or do you need more
information regarding this problem. Please feel free to ask for more.
> 

Your code is wrong: mixing regular linux systems calls like sendto()
over an AF_INET socket with Cobalt rt system calls will necessarily
induce delays in your loop, up to the amount of jitter sendto() may
suffer from the regular kernel.

Actually, I don't understand the reasoning behind that code. You want to
send a packet each 249 us precisely, but you do so traversing a
non-deterministic network stack, most likely over a probabilistic
(time-wise) medium, assuming this is 802.3 under the hood. You may want
to consider RTNet instead.

You are using a dual kernel system: real-time behavior is achievable
only if your application exclusively uses services from the real-time
co-kernel during the time-critical phases.

This is explained here:
http://xenomai.org/start-here/#How_does_Xenomai_deliver_real-time

-- 
Philippe.

