From: Umair Ali <ali.umair@tut.fi>
Date: Fri, 18 Dec 2015 11:52:01 +0000
Message-ID: <2396B4D2166B62479FBBE370D4A7C1F30A716315@mb2010-1.intra.tut.fi>
References: <2396B4D2166B62479FBBE370D4A7C1F30A716241@mb2010-1.intra.tut.fi>,
 <5673D046.6090505@xenomai.org>
In-Reply-To: <5673D046.6090505@xenomai.org>
Content-Language: en-US
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
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
To: Philippe Gerum <rpm@xenomai.org>, "xenomai@xenomai.org" <xenomai@xenomai.org>

Hello Phillipe,

Thanks for you reply.

> For the sake of clarity, Gilles told you about the requirement for timerfd_create() to switch to secondary/linux mode for processing the request, which may induce delays. He certainly did not told you that reading from that Cobalt timerfd would induce jitter on a well-performing Xenomai setup

Yes Gilles told me that timerfd_create() causes switch to secondary mode. He told me to focus on the use of kernel timers for removing jitters. I hadshared the slackspot output file with him and he told me that timerfd_create() is called once in the code so after the creation it will work fine in the primary mode by reading the timerfd. Is there any way i can obtain the timer in userspace with very low jitter or  if i have to use kernel space timers for my purpose. What is suggestion or idea.

> You may convince yourself about this fact by running the latency test: it is based on a sampling thread synchronizing on a timerfd.

I have attached the latency test with this email for the reference. It will be nice of you if you look at the file and assure me if i have installed xenomai 3.0.1 correctly.

> Your code is wrong: mixing regular linux systems calls like sendto() over an AF_INET socket with Cobalt rt system calls will necessarily induce delays in your loop, up to the amount of jitter sendto() may suffer from the regular kernel.

> Actually, I don't understand the reasoning behind that code. You want to send a packet each 249 us precisely, but you do so traversing a non-deterministic network stack, most likely over a probabilistic (time-wise) medium, assuming this is 802.3 under the hood. You may want to consider RTNet instead.

I have followed the link https://xenomai.org/rtnet-programming/ for the UDP programming using Rtnet. More over i have read that "From an application point of view, using the Xenomai POSIX skin wrapped services allows for manipulation of file descriptors provided by the RTDM skin as if they were ordinary file descriptors" as in the link http://xenomai.org/2014/08/porting-a-linux-application-to-xenomai-dual-kernel/#Access_to_drivers. Therefore i thought that wrap function will automatically link the sendto() and socket() functions with Rtnet. Because before running the application, i have run the script attached with the email to bind the rt_8139too drivers and unmount the 8139too driver. Therefore i assume that rtnet is activated and i can link the application with the help of wrap function of xenomai POSIX skin

Please guide me how i can send the userdefined UDP packets using RTnet in Xenomai 3.0.1 or in other word avoid the jitter of sendto().

Thanks & BR
Ali
________________________________________
From: Philippe Gerum [rpm@xenomai.org]
Sent: Friday, December 18, 2015 11:22 AM
To: Umair Ali; =?UTF-8?Q?Xenomai_list_=e2=80=8e_[xenomai@
Subject: Re: [Xenomai] Possible sync problem with timerfd and application

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
-------------- next part --------------
A non-text attachment was scrubbed...
Name: initial.sh
Type: application/x-shellscript
Size: 1858 bytes
Desc: initial.sh
URL: <http://xenomai.org/pipermail/xenomai/attachments/20151218/91ecf2c1/attachment.bin>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: latency_test_output
Type: application/octet-stream
Size: 3042 bytes
Desc: latency_test_output
URL: <http://xenomai.org/pipermail/xenomai/attachments/20151218/91ecf2c1/attachment.obj>
