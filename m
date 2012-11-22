Message-ID: <50AE4F97.8030102@xenomai.org>
Date: Thu, 22 Nov 2012 17:15:19 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <50AE49ED.9020804@ruggedcom.com>
In-Reply-To: <50AE49ED.9020804@ruggedcom.com>
Content-Type: text/plain; charset=UTF-8
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
To: Makarand Pradhan <makarandpradhan@ruggedcom.com>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

On 11/22/2012 04:51 PM, Makarand Pradhan wrote:
> Greetings,
> 
> I have a proposal for enhancing the process of locking a real-time mutex in auto-relaxed Xenomai threads. It will  save a lot of CPU cycles in some scenarios, and I would like to get your expert opinion about it (I have coded the enhancement for native skin and changes are attached to this email).
> 
> Xenomai mutex is designed in such a way that trapping to the kernel is not needed.This is a very efficient design which saves a great deal of CPU cycles.
> However, there is an exception to this efficient behavior: if the Xenomai thread is an auto-relaxed thread (i.e. running with priority 0), locking a mutex always traps to the kernel because the current implementation handles auto-relaxing upon exiting the system call.
> 
> Look at this scenario:
> 
> A Xenomai thread
> 1) locks a mutex (which is an OUTER mutex in this scenario)
> 2) then loops multiple times through some operation that requires locking an unlocking some other mutex (INNER mutex)
> 3) unlocks the OUTER mutex

I did not look in details at your code, but what if I do

lock mutex1
lock mutex2
unlock mutex1
unlock mutex2

?

-- 
					    Gilles.

