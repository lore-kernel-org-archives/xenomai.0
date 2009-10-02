MIME-Version: 1.0
Sender: peter.soetens@domain.hid
In-Reply-To: <4AC4CC11.9010806@domain.hid>
References: <634c78ce0910010730t29137af8w95b63ae21183b52b@domain.hid> 
	<4AC4C11F.2030806@domain.hid>
	<634c78ce0910010818o20965233v7e19ed7a7180f503@domain.hid> 
	<4AC4CC11.9010806@domain.hid>
From: Peter Soetens <peter@domain.hid>
Date: Fri, 2 Oct 2009 11:31:00 +0200
Message-ID: <634c78ce0910020231q4186a30fpc96547f89b768e5a@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Subject: Re: [Xenomai-core] [Xenomai-help] select: native tasks with posix
	skin mqueues
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: Xenomai core <Xenomai-core@domain.hid>

On Thu, Oct 1, 2009 at 17:34, Gilles Chanteperdrix
<gilles.chanteperdrix@xenomai.org> wrote:
> Peter Soetens wrote:
>> On Thu, Oct 1, 2009 at 16:47, Gilles Chanteperdrix
>> <gilles.chanteperdrix@xenomai.org> wrote:
>>> Peter Soetens wrote:
>>>> Hi,
>>>>
>>>> I'm creating my RT threads using the native API and I'm creating
>>>> mqueues, wrapped to the pthread_rt library.
>>>> I can read and write the mqueue (and it goes through Xenomai), but
>>>> when I select() on a receiving mqd_t, the select() calls returns that
>>>> there is data available on the mq (it fills in the FD_SET), but keeps
>>>> doing so even when it's empty (the select() is in a loop). Also, it's
>>>> modeswitching like nuts.
>>>>
>>>> I found out that the __wrap_select is correctly called, but returns
>>>> -EPERM. Kernel sources indicate that this is caused by
>>>> pse51_current_thread() alias thread2pthread() returning null. Since
>>>> EPERM is returned to userspace, the __real_select is called from user
>>>> space, causing the mode switches and bad behaviour. This is almost
>>>> certainly the thing that native + RTDM + select() is seeing too.
>>>>
>>>> My mqueues-only work probably because mq.c only uses
>>>> pse51_current_thread() in the mq_notify function. I'm guessing that
>>>> mq_notify would also not work in combination with native skin.
>>>>
>>>> I had two options in fixing this: add a xnselector to the native task
>>>> struct or to the nucleus xnthread_t. I choose the latter, such that
>>>> every skin kan use select() + RTDM and migrate gradualy to the RTDM
>>>> and/or Posix skin.
>>>> I needed to free the xnselector structure in xnpod_delete_thread() , I
>>>> chose a spot, but it causes a segfault in my native thread (which did
>>>> the select) during program cleanup. Any advice ? Also, maybe we should
>>>> separate select() from the posix skin and put it in a separate place
>>>> (in RTDM as rtdm_select() ?), such that we can start building around
>>>> it (posix just forwards to rtdm_select() then).
>>>>
>>>> A second patch was necessary to return the timeout case properly to
>>>> userspace (independent of first patch).
>>>>
>>>> Tested with native + posix loaded and mq. If you never quit your
>>>> application, this works :-)
>>>>
>>>> (maybe we discuss this better further on xenomai-core)
>>> Ok. Got it now. My idea with that the nucleus service xnselect could be
>>> used to implement select-like services which would have different
>>> semantics depending on the skins.
>>>
>>> So, the select service with posix semantics was reserved to posix skin
>>> threads.
>>
>> Yes. The segfaults I'm seeing is not related to the cleanup of my
>> xnselector struct in xnpod_delete_thread, because when removing the
>> cleanup code, still leads to the segfault. Probably Posix does
>> something special to let the thread leave select() earlier.
>
> To know whether the bug comes from your code or from an unseen bug in
> xnselect implementation (there is a suspicious access to the xnselector
> structure when waking up), could you try the same test with the original
> support, simply using posix skin threads.

Will do next week.

>
> Other than that, the support is really tied to the posix skin: this
> version of select will only accept file descriptors which were returned
> by the posix skin or the rtdm skin. So, I am afraid making it a generic
> service is a bit hard.

I don't have a clear view like you have, but clearly, being able to
use select() on the rtdm user API while using any other skin than
Posix looks like a big plus to me. I thought this was also in the line
of what Philippe was thinking of, ie to center our file descriptors
around the rtdm. Moving select() to rtdm, and having the Posix skin as
the first 'compatible with rtdm' skin, changes the perspective for the
better imho.

I'm not looking for making select() generic for all skins, but
adapting the existing skins to opt-in for using 'rtdm_select()', which
is something we can merge in gradually. Do you think this is
feasible/desired ?

Peter

