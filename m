Message-ID: <518A78DF.7020300@xenomai.org>
Date: Wed, 08 May 2013 18:10:07 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <51826EEA.1090202@mitrol.it>
	<51830D98.7090309@xenomai.org>	<5183CDD6.80400@mitrol.it>
	<518A06C9.50204@mitrol.it> <518A4C09.8030906@xenomai.org>
	<518A505C.2090207@mitrol.it> <518A52A7.5000801@xenomai.org>
	<518A5600.20508@mitrol.it> <518A6195.7030206@mitrol.it>
	<518A77F8.3070404@xenomai.org>
In-Reply-To: <518A77F8.3070404@xenomai.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Re : Sporadic problem : rt_task_sleep locked after
 debugging
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Paolo Minazzi <Paolo.Minazzi@mitrol.it>
Cc: xenomai@xenomai.org

On 05/08/2013 06:06 PM, Philippe Gerum wrote:
> On 05/08/2013 04:30 PM, Paolo Minazzi wrote:
>> I think to be very near to the solution of this problem.
>> Thanks to Gilles for his patience.
>>
>> Now I will retry to make a summary of the problem.
>>
>
> <snip>
>
>> The thread 1 finds thread 70 in debug mode !
>>
>
> Which is expected. thread 70 has to be scheduled in with no pending ptrace signals for leaving this mode, and this may happen long after the truckload of other threads releases the CPU.
>
>> My patch adjust this problem.
>>
>> I realize that it is a very special case, but it is my case.
>>
>> I'd like to know if the patch is valid or can be written in a different
>> way.
>> For example, I could insert my patch directly in xnpod_delete_thread().
>>
>> The function unlock_timers() cannot be called from
>> xenomai-2.5.6/ksrc/skins/native/task.c
>> because it is defined static. This is a detail. There are simple ways to
>> solve this.
>>
>
> No, really the patch is wrong, but what you expose does reveal a bug in the Xenomai core for sure. As Gilles told you, you would be only papering over that real bug, which would likely show up in a different situation.
>
> First we need to check for a lock imbalance, I don't think that code is particularly safe.

I mean a lock imbalance introduced by an unexpected race between the 
locking/unlocking calls. The assertions introduced by this patch might 
help detecting this, with some luck.

-- 
Philippe.

