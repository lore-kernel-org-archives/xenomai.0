Message-ID: <4C572FF7.5090200@domain.hid>
Date: Mon, 02 Aug 2010 13:52:07 -0700
From: Bob Feretich <bob.feretich@domain.hid>
MIME-Version: 1.0
References: <4C562838.8050000@domain.hid>	
	<1280727778.6700.70.camel@domain.hid>	
	<4C565F26.5090200@domain.hid>
	<1280770720.6700.82.camel@domain.hid>
	<4C5706E9.50101@domain.hid>
In-Reply-To: <4C5706E9.50101@domain.hid>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Shared memory between a Xenomai user task and a
 standard Linux process?
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>, Philippe Gerum <rpm@xenomai.org>, xenomai@xenomai.org

  Thank you for the solution. Using Linux shm shared memory should have 
been obvious. :-[

I was still thinking of Xenomai user tasks as running in a walled of 
environment. I've got to remember that when a rt user task is in 
secondary mode it has full access to Linux facilities.

When my rt user task starts and ends it is in secondary mode. It can 
easily shmat() and shmdt() during these start and end periods.

As Philippe states, I just need to be careful about the synchronization 
method I use. The Linux process must never be able to block the rt task. 
(If the rt task wraps the buffer, we'll just throw away the history data 
until space becomes available and report a "data overrun" on the next 
block written.) As I said before, the buffer should be large enough so 
that never happens anyway.

Yes, I am using the OMAP3 chip so the D-cache is VIPT, therefore shared 
memory operations should not cause cache flushes to prevent aliasing.

Regards,
Bob Feretich

On 8/2/2010 10:56 AM, Gilles Chanteperdrix wrote:
> Philippe Gerum wrote:
>> On Mon, 2010-08-02 at 08:01 +0200, Gilles Chanteperdrix wrote:
>>> Due to their limitations on ARM platform (they are uncached on pre-v6
>>> ARMs), RT_HEAP should more be reserved to communications between
>>> user-space tasks and kernel-space tasks on these platforms. For
>>> communications between two user-space processes, using plain Linux
>>> shared memories is recommended.
>>>
>> ARM VIVT caching kills common sense. Note that in the particular case of
>> a rt / non-rt communication, standard shm would imply priority inversion
>> induced by heavyweight synchronization between rt senders and non-rt
>> receivers, so that would not fly that well. This is still possible to
>> use a lockless approach to queue data though. YMMV.
> Well, in fact, with the native API, you have the choice to use cached or
> non-cached heaps. So, if you know the heap will be used only by
> user-space applications, you can keep the heap cached, and forgot what I
> said. And Bob uses an OMAP3 anyway if I am not mistaken, so he has a
> shiny VIPT cache.
>

