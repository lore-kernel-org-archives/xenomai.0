Message-ID: <5152CAC6.1020304@xenomai.org>
Date: Wed, 27 Mar 2013 11:32:38 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <5151F44F.3050306@siemens.com> <5151F730.4090507@siemens.com>
	<5152C8FC.10705@xenomai.org> <5152C990.9050101@siemens.com>
In-Reply-To: <5152C990.9050101@siemens.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] New domain migration process with ipipe-core and forge
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Xenomai <xenomai@xenomai.org>

On 03/27/2013 11:27 AM, Jan Kiszka wrote:

>> Nitpicking: in theory, the code should expect the migration hook to have
>> actually done the work, and not delayed it like Xenomai currently does
>> in practice.
>
> Where does Xenomai do that? I was looking for it but didn't find a log
> flush.
>

You mean delaying? Check per-arch xnarch_escalate(). Flushing occurs as 
soon as the xnpod_schedule() caller unstalls the head domain, which has 
to happen quickly after the delay was enforced.

>> diff --git a/kernel/ipipe/core.c b/kernel/ipipe/core.c
>> index 96b3a98..c4598ad 100644
>> --- a/kernel/ipipe/core.c
>> +++ b/kernel/ipipe/core.c
>> @@ -1102,6 +1102,8 @@ static void complete_domain_migration(void) /* hw
>> IRQs off */
>>
> OK, will queue this up here for the next pull request.
>

Ok.


-- 
Philippe.

