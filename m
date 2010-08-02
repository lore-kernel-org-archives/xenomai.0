Message-ID: <4C5706E9.50101@domain.hid>
Date: Mon, 02 Aug 2010 19:56:57 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <4C562838.8050000@domain.hid>	
	<1280727778.6700.70.camel@domain.hid>	
	<4C565F26.5090200@domain.hid>
	<1280770720.6700.82.camel@domain.hid>
In-Reply-To: <1280770720.6700.82.camel@domain.hid>
Content-Type: text/plain; charset=UTF-8
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
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai@xenomai.org, Bob Feretich <bob.feretich@domain.hid>

Philippe Gerum wrote:
> On Mon, 2010-08-02 at 08:01 +0200, Gilles Chanteperdrix wrote:
>> Due to their limitations on ARM platform (they are uncached on pre-v6
>> ARMs), RT_HEAP should more be reserved to communications between
>> user-space tasks and kernel-space tasks on these platforms. For
>> communications between two user-space processes, using plain Linux
>> shared memories is recommended.
>>
> 
> ARM VIVT caching kills common sense. Note that in the particular case of
> a rt / non-rt communication, standard shm would imply priority inversion
> induced by heavyweight synchronization between rt senders and non-rt
> receivers, so that would not fly that well. This is still possible to
> use a lockless approach to queue data though. YMMV.

Well, in fact, with the native API, you have the choice to use cached or
non-cached heaps. So, if you know the heap will be used only by
user-space applications, you can keep the heap cached, and forgot what I
said. And Bob uses an OMAP3 anyway if I am not mistaken, so he has a
shiny VIPT cache.

-- 
					    Gilles.

