Message-ID: <43EFFB80.1080104@domain.hid>
Date: Mon, 13 Feb 2006 00:22:40 -0300
From: Rodrigo Rosenfeld Rosas <lbocseg@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] [PATCH] provide rtdm_mmap_to_user / rtdm_munmap
References: <43EBD9D6.5090404@domain.hid>
	<43EBE032.40302@domain.hid>	<200602101858.21108.lbocseg@domain.hid>
	<200602101928.52899.lbocseg@domain.hid>
	<43ED3165.3090300@domain.hid> <43EDE275.5040307@domain.hid>
	<43EDE6D7.8050506@domain.hid> <43EE3E81.80803@domain.hid>
	<43EFBA92.3030306@domain.hid>
In-Reply-To: <43EFBA92.3030306@domain.hid>
Content-Type: text/plain; charset="iso-8859-1"; format="flowed"
Content-Transfer-Encoding: quoted-printable
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: xenomai@xenomai.org

Jan Kiszka escreveu:
> ...
>> I'm not very sure about that. It can work for most situations but there
>> could be one situation where it would crash just because it was chosen
>> to have a little smaller code size and a little speed gain... I would
>> not like to think in the consequences of a crash in the driver while a
>> RT-system is working on real world...
>>    =20
>
> And I would not like to think of having instrumented RTOS cores and a
> drivers in the field. This would rather indicate to me that someone did
> not do his/her homework: testing and debugging the system before
> delivering it.
>  =20
Ok, I'm not really interested on this topic for continue discussing it.=20
It is fine for me to do that checks on my own code before calling=20
rtdm_mmap_to_user...
> ...
> Via any invocation, just check the handler prototypes:
> rtdm_open_handler_t, rtdm_close_handler_t, rtdm_ioctl_handler_t, ...
>  =20
Now I've found them! I think I was a bit lazy at that time... :) Thanks!

>>> ... =20
>>>      =20
>> Yes, but it would be simpler for new developers used to the V4L2 API to
>> migrate to a similar RT-Video interface. Anyway, as I've already said, I
>> don't think some users would do any mmap during runtime, but maybe for
>> some reconfiguration for some reason and they would like to make this in
>> a RT-context. I can't really imagine a practical situation from the
>> moment, but I think it is still possible to happen...
>>    =20
>
> Ok, but then you can still offer mmap via secondary mode even to RT
> tasks.
But I would lose the determinism...
> It's a corner case, and mmap will never have a deterministic
> execution time without changing the vmm rather fundamentally, so the
> user can't expect such behaviour. If (s)he does so, the application
> design is broken anyway.
>  =20
I agree. That is why I'm trying to provide an alternative solution. It=20
is not quite a mmap, but it is similar...

>>> ... =20
>>>      =20
>> That is something I could change in my driver... Making the mmap on the
>> VIDIOC_REQBUFS ioctl request. But, as a driver could return a different
>> number of buffers than the requested, the user could not be satisfied
>> with the returned buffers and the mmap would have been useless... I
>> still don't know how will the final design be like, but I'm fine with
>> your already provided rtdm_mmap_to_user solution. But I still want to
>> keep the API as closer as possible to V4L2 for facilitating the users to
>> migrate to real-time while taking advantage of the already available
>> V4L2 documentation and examples all over the web and just doing the
>> minimal needed modifications.
>>    =20
>
> Ok, I see the idea behind it, and under those constraints it does make
> sense to provide some wrapper for mmap over the RT capturing device.
>
> ...
> I think I now got your goals completely:
>
>  1. keep the interface of V4L2
>  =20
... as closer as possible.
>  2. completely provide it a deterministic way
>  =20
I'm not really worried about that, but if I could do it in some not very=20
sofisticated way, I would like to provide such behaviour. But I=20
recognize that for must situations the user won't need deterministic mmap.
> I can understand the first goal. Keeping the V4L2 interface for a
> potential RTDM frame grabbing device profile can make sense if it
> doesn't complicate the rt-driver internals too much or stresses it
> rt-guarantees.
>
> But I still have some doubts that aiming for 2. regarding mmap is worth
> the effort. The problem is that you cannot predict how many buffers have
> to be pre-mapped in order to provide them with bounded delay via some
> rt-mmap. I wouldn't spent time on this.
>  =20
This could be another module parameter. If the user is not satisfied=20
with the default limits, (s)he could override them. But I really don't=20
pretend to spent more time on this... I'm very worried about my=20
deadline... :( I still have too much to do in 4 months... :((
> Ok, but even if you decide to let rt-mmap be non-deterministic, you
> still need some means to prevent the scenario you described above.
> Actually, all you need is some callback when the mapped memory block was
> actually released (munmap/application exit). Such a callback can be
> registered inside the rtdm_mmap handler as a vma_fileop.
I have never worked with vma_fileop... I would need to learn it first.
>  It will run in
> non-RT, and could be used to mark the related hardware buffer as finally
> free for re-allocation.
Now, I did realize that there is one more problem on my current design.=20
If the user application exits or is terminated, I'm not sure if the=20
close handler is called if the user forgot/was not able to. If it is=20
not, the buffer would be marked as used until I reloaded the driver...=20
Is the close handler invocated on application termination?
> I will draft some extension of the current
> rtdm_mmap_to_user function, but likely not before tomorrow evening or so.
>  =20
Thank you.

Rodrigo.


=09

=09
	=09
_______________________________________________________=20
Yahoo! doce lar. Fa=E7a do Yahoo! sua homepage.=20
http://br.yahoo.com/homepageset.html=20



