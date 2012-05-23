Message-ID: <4FBCA055.9060607@mind.be>
Date: Wed, 23 May 2012 10:31:17 +0200
From: Arnout Vandecappelle <arnout@mind.be>
MIME-Version: 1.0
References: <4FBBBA25.5010308@mind.be> <4FBBECA0.4020502@xenomai.org>
In-Reply-To: <4FBBECA0.4020502@xenomai.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] CPU occupation without context switches?
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai@xenomai.org

On 05/22/12 21:44, Philippe Gerum wrote:
> On 05/22/2012 06:09 PM, Arnout Vandecappelle wrote:
>> Hoi,
>>
>> After a few minutes of running my application, I see this:
>>
>> # cat /proc/xenomai/stat
>> CPU PID MSW CSW PF STAT %CPU NAME
>> 1 828 22 65 0 00300182 9.8 bench_RTnet_scope_thread_loop
>> 1 839 2 46627538 0 00300186 53.8 bench_RTnet
>> ...
>>
>> i.e. the bench_RTnet_scope_thread_loop takes 10% CPU but no
>> context switches. How is this possible? I've looked at the
>> source code and can't find an explanation: when the exectime
>> accounting is updated, the csw is incremented as well (in
>> __xnpod_schedule()).
>>
>
> Unless your thread which seems to repeatedly attempt to pend on some sync object has its wait condition satisfied on
> entry to the syscall most of the time, which may cause __xnpod_schedule() to leave it running without incrementing the
> switch count.

  It is indeed possible that my application does something like that.  But
wouldn't the switch count be incremented every time the bench_RTnet thread
is executed?  That thread runs at 20kHz and at higher priority so it should
pre-empt the other one, which should lead to context switches in the _loop
thread.

  Unfortunately, I can't reproduce the situation anymore...  If I can I'll
try with Xenomai 2.6.0.


  Regards,
  Arnout

-- 
Arnout Vandecappelle                               arnout at mind be
Senior Embedded Software Architect                 +32-16-286540
Essensium/Mind                                     http://www.mind.be
G.Geenslaan 9, 3001 Leuven, Belgium                BE 872 984 063 RPR Leuven
LinkedIn profile: http://www.linkedin.com/in/arnoutvandecappelle
GPG fingerprint:  7CB5 E4CC 6C2E EFD4 6E3D A754 F963 ECAB 2450 2F1F

