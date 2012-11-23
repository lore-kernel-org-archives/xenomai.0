Message-ID: <50AF5ADF.4090502@siemens.com>
Date: Fri, 23 Nov 2012 12:15:43 +0100
From: Jan Kiszka <jan.kiszka@siemens.com>
MIME-Version: 1.0
References: <50AE49ED.9020804@ruggedcom.com> <50AE4F97.8030102@xenomai.org>
	<990B36E792F1A4488D3E2B1C46FD62D69A13775FD4@corpmail2>
In-Reply-To: <990B36E792F1A4488D3E2B1C46FD62D69A13775FD4@corpmail2>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Mutex enhancement for Auto relaxed threads
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Michael Pustylnik <MichaelPustylnik@ruggedcom.com>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

On 2012-11-22 17:55, Michael Pustylnik wrote:
> Although you can use mutexes in this order, why would you want to do that? Logically, unlocking mutex1 would mean finishing some operation started when mutex1 was locked. If as a part of the operation you locked mutex2 and haven't unlocked it yet, that would mean you haven't completed your operation yet, and unlocking mutex1 at this point would probably be a bug. Am I wrong?

I'm not aware that POSIX or some other APIs Xenomai implements forbid
such an ordering. And you never know if there is weird convoluted legacy
code out there that depends on exactly this.

However, I think you can avoid the limitation by attaching the property
"trap to kernel on mutex lock" to the thread instead of some mutex,
analogously to xeno_current_mode.

Jan

PS: Please no top postings!

> -----Original Message-----
> From: xenomai-bounces@xenomai.org [mailto:xenomai-bounces@xenomai.org] On Behalf Of Gilles Chanteperdrix
> Sent: Thursday, November 22, 2012 11:15 AM
> To: Makarand Pradhan
> Cc: xenomai@xenomai.org
> Subject: Re: [Xenomai] Mutex enhancement for Auto relaxed threads
> 
> On 11/22/2012 04:51 PM, Makarand Pradhan wrote:
>> Greetings,
>>
>> I have a proposal for enhancing the process of locking a real-time mutex in auto-relaxed Xenomai threads. It will  save a lot of CPU cycles in some scenarios, and I would like to get your expert opinion about it (I have coded the enhancement for native skin and changes are attached to this email).
>>
>> Xenomai mutex is designed in such a way that trapping to the kernel is not needed.This is a very efficient design which saves a great deal of CPU cycles.
>> However, there is an exception to this efficient behavior: if the Xenomai thread is an auto-relaxed thread (i.e. running with priority 0), locking a mutex always traps to the kernel because the current implementation handles auto-relaxing upon exiting the system call.
>>
>> Look at this scenario:
>>
>> A Xenomai thread
>> 1) locks a mutex (which is an OUTER mutex in this scenario)
>> 2) then loops multiple times through some operation that requires locking an unlocking some other mutex (INNER mutex)
>> 3) unlocks the OUTER mutex
> 
> I did not look in details at your code, but what if I do
> 
> lock mutex1
> lock mutex2
> unlock mutex1
> unlock mutex2
> 
> ?
> 

-- 
Siemens AG, Corporate Technology, CT RTC ITP SDP-DE
Corporate Competence Center Embedded Linux

