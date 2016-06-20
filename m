From: Lowell Gilbert <kludge@be-well.ilk.org>
References: <447fdp9oue.fsf@be-well.ilk.org>
 <0b7ab1b8-8d53-069a-49b6-a3f289c0b43c@xenomai.org>
Date: Mon, 20 Jun 2016 11:19:49 -0400
In-Reply-To: <0b7ab1b8-8d53-069a-49b6-a3f289c0b43c@xenomai.org> (Philippe
 Gerum's message of "Sat, 18 Jun 2016 15:29:22 +0200")
Message-ID: <441t3rlwfe.fsf@be-well.ilk.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Xenomai] slackspot
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai@xenomai.org

Philippe Gerum <rpm@xenomai.org> writes:

> On 06/16/2016 04:43 PM, Lowell Gilbert wrote:
>>  I have not run /bin/relax,
>> mentioned in the manual page, because I don't have such a program and
>> can't find any reference to it.
>> 
>> I am using 3.0.2.
>
>
> /bin/relax is only the name of a fake executable that would have
> produced the typical output described in the example, read /foo/bar if
> that helps.

That seems obvious now that you've explained it. 

Maybe something like the following would help:
--- doc/asciidoc/man1/slackspot.adoc.~1~ 2016-02-18 07:17:40.000000000
-0500
+++ doc/asciidoc/man1/slackspot.adoc    2016-06-20 11:16:22.130252140
-0400
@@ -91,7 +91,7 @@

 In the following scenario, the _target_ system built with the
  CONFIG_XENO_OPT_DEBUG_TRACE_RELAX feature enabled in the kernel
  -configuration, just ran the _/bin/relax_ program.
  +configuration, just ran the Xenomai-enabled _/bin/relax_ program.

 This program caused a transition to secondary mode switch of the
  current task (_Task 2_) as a result of calling +putchar()+. The Cobalt

> Once TRACE_RELAX is enabled in the kernel, running any application that
> causes switches to secondary mode should populate
> /proc/xenomai/debug/relax with event records.

Hmm. I'm still not getting the records, and the SIGXCPU method isn't
giving me anything either. But the MSW, CSW, and XSC counts are all
rising at exactly the rate that the thread wakes up.

Here's the design: I have a POSIX thread which calls into an RTDM ioctl
which blocks on an RTDM event, then copies a couple of dozen bytes of
data back to the POSIX thread. The POSIX thread does some calculations
on the data, then uses another ioctl to write the results back to the
hardware. And repeats.

Is it possible that the thread might be relaxing in the kernel (RTDM
ioctl) and not receiving signals as as result?

I have two theories about what is happening.
   1. I have made an error somewhere that is resulting in unnecessary
      relax events. In that case, getting the stack traces is the key to
      finding said error. I can create a small example if that helps me
      get assistance in looking at it.
   2. Having a real-time pthread block in an RTDM ioctl may be an
      inherently bad idea. I notice that all synchronization primitives
      are characterized by "might-switch". Perhaps I should be using a
      device read to block the POSIX thread instead of doing it in an
      ioctl()?

My current plan is to use the I-pipe tracer, but if there is an easier
way to move forward, I would appreciate advice to that effect.

Thank you very much.

 - Lowell Gilbert

