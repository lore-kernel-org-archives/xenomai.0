Message-ID: <43EE3E81.80803@domain.hid>
Date: Sat, 11 Feb 2006 16:44:01 -0300
From: Rodrigo Rosenfeld Rosas <lbocseg@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] [PATCH] provide rtdm_mmap_to_user / rtdm_munmap
References: <43EBD9D6.5090404@domain.hid>
	<43EBE032.40302@domain.hid>	<200602101858.21108.lbocseg@domain.hid>
	<200602101928.52899.lbocseg@domain.hid>
	<43ED3165.3090300@domain.hid> <43EDE275.5040307@domain.hid>
	<43EDE6D7.8050506@domain.hid>
In-Reply-To: <43EDE6D7.8050506@domain.hid>
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
To: Jan Kiszka <jan.kiszka@domain.hid>, xenomai@xenomai.org

...
>> I understand your concernings but I really don't think they are
>> relevant... This checks will be much faster then the procedure itself
>> and it would conform to normal munmap behaviour. From man page:
>>
>> "The address start must be a multiple of the page size. All pages
>> containing a part of the indicated range are unmapped, and subsequent
>> references to these pages will generate SIGSEGV. It is not an error if
>> the indicated range does not contain any mapped pages."
>>    =20
>
> XENO_ASSERT will not be a procedure, it will be a macro containing the
> check for the assertion and the code to be executed on failure.
Yes, I understood, I just don't agree...
> The point is just to control if this code will make it into the kernel or
> not - via CONFIG_XENO_OPT_DEBUG. Kind of #ifdef CONFIG_XENO_OPT_DEBUG,
> just more comfortable. A typical bug-free driver will not need such
> checks
I'm not very sure about that. It can work for most situations but there=20
could be one situation where it would crash just because it was chosen=20
to have a little smaller code size and a little speed gain... I would=20
not like to think in the consequences of a crash in the driver while a=20
RT-system is working on real world...
> as it will just pass those values already use for or returned by
> rtdm_mmap_to_user. This is not just about speed, it's also about code siz=
e.
>
>  =20
>> I think that if there was an extra parameter for user_info, it would
>> also verify for validity. BTW, I think there is missing some
>> documentation about the user_info parameter. I had to remember our
>> conversation and look at the code to understand that I should record
>> "current" on this parameter on the moment I called mmap and passing it
>> again on munmap. And it would be good to see the rtdm_user_info_t
>> defined as struct task_struct on the documentation.
>>    =20
>
> This is intentionally opaque to the driver developer. As you receive a
> rtdm_user pointer via the device handler invocation (as documented in
> rtdm_mmap_to_user - feel free to improve my description!), you don't
> need to (and you actually shouldn't) deal with task_struct or even mm
> directly.
>  =20
Sorry, I didn't understand the description in documentation and continue=20
not understanding it. In which device handler invocation I did receive=20
this pointer? I didn't find reference for it anywhere else...
> Moreover, I have an experimental (and unreleased) Xenomai skin with RTDM
> support here which maps rtdm_user_info_t to a different type.
>
>  =20
>>>> I have not written the user-space program yet, so you'll have to wait
>>>> until monday, when I'll be able to test it, hopefully. But it seems
>>>> to be working... I changed my driver design. I do the mmap's on
>>>> driver initialization and just pass the returned addresses on the
>>>> IOCTL, so I can do them in a RT-context. The problem is that even if
>>>> the user call an IOCTL to    =20
>>>>        =20
>>> Hmm, I guess there is still some lacking documentation about what is
>>> possible with RTDM. If you call an IOCTL from RT context, you end up in
>>> the _rt-handler the driver of a device may have registered (if there is
>>> no _rt-handler at all, the _nrt one is invoked, but this is likely not
>>> relevant here).
>>>
>>> I assume that you were wondering how to call rtdm_mmap_to_user from this
>>> real-time handler, right?
>>>      =20
>> No. I know it is not possible from the moment. I think I did not explain
>> myself very well. I was wondering how to define a RT mmap like ioctl. As
>> I know I could not use rtdm_mmap_to_user then, I thought in another way
>> of doing it. So I mmaped on driver initialization. On the IOCTL I just
>> passed the already known addresses to the user requesting it. I would
>> have to explain you how these buffers work on V4L2. It is a bit long
>> explanation but I can explain it on other message if you wish.
>>    =20
>
> I had a look at a V4L2 tutorial, and I think I grabbed the idea. This
> idea does *not* include any mmap during runtime, just once after device
> opening and buffer setup. I think you shouldn't follow the syntactic
> V4L2 interface, rather grab it's overall model.
>  =20
Yes, but it would be simpler for new developers used to the V4L2 API to=20
migrate to a similar RT-Video interface. Anyway, as I've already said, I=20
don't think some users would do any mmap during runtime, but maybe for=20
some reconfiguration for some reason and they would like to make this in=20
a RT-context. I can't really imagine a practical situation from the=20
moment, but I think it is still possible to happen...
> That's also why I cannot follow your desire for a transparent rt-mmap
> implementation. I tried to define such a wrapper, but I didn't find it
> useful, rather problematic as a lot of restrictions from the normal mmap
> had to be defined.
>
> Don't forget that normal mmap is a very generic interface, covering also
> a lot of use cases (files e.g.) we will never see with RTDM. As it is
> the standard interface for mapping, V4L2 likely does this split-up of
> buffer allocation (via IOCTL) and mapping (via mmap). With
> rtdm_mmap_to_user, this is not required! There are a few DRM Linux
> driver unifying those steps as well, BTW.
>  =20
That is something I could change in my driver... Making the mmap on the=20
VIDIOC_REQBUFS ioctl request. But, as a driver could return a different=20
number of buffers than the requested, the user could not be satisfied=20
with the returned buffers and the mmap would have been useless... I=20
still don't know how will the final design be like, but I'm fine with=20
your already provided rtdm_mmap_to_user solution. But I still want to=20
keep the API as closer as possible to V4L2 for facilitating the users to=20
migrate to real-time while taking advantage of the already available=20
V4L2 documentation and examples all over the web and just doing the=20
minimal needed modifications.
>  =20
>>> Well, the trick is to return -ENOSYS for those
>>> IOCTL codes that can only be handled by the _nrt-handler. Xenomai will
>>> then switch your RT task to secondary mode, restart the IOCTL, and the
>>> mmap can safely be executed.
>>>  =20
>>>      =20
>> But as I've said, it is not the behaviour I want :)
>>
>>    =20
>>> Well, maybe you do not have any arguments for rtdm_mmap_to_user that
>>> should be influenced by the user's IOCTL.
>>>      =20
>> That is my case.
>>
>>    =20
>>> In this case your current driver design is ok as well. I just wanted
>>> to underline that it is not necessarily the only way.
>>>  =20
>>>      =20
>> But I couldn't find other way of doing it in a RT-context.
>>    =20
>
> As explained before, it doesn't make sense to mmap in time-constraint
> contexts, even if we are only talking about standard Linux. No
> high-speed capturing application will do this - especially under Linux.
>  =20
I know that. I was just wondering if someone would need to reconfigure=20
the system for some reason in a rt-context...
>  =20
>>>> munmap, it will still be possible to him to continue using the
>>>> provided address and this would result in a problem. But, as in all
>>>> situations, there    =20
>>>>        =20
>>> When rtdm_munmap is executed, the virtual address range becomes invalid
>>> for the user. Thus any further access to it will raise a segfault.
>>> That's the only problem, but it will not influence the driver integrity.
>>>  =20
>>>      =20
>> Yes, that is the problem. Since I only mark as unused on the munmap
>> IOCTL, it would be possible to the user to continue using that address
>> even after the munmap IOCTL call. It I was using a really rtdm_munmap,
>> it wouldn't be possible. It would be a better behaviour, but it would
>> not be run on RT-context. That is the trade-off.
>>    =20
>
> If you avoid mmap in RT, there will also be no need for munmap in this
> context. Just release it on closure.
>  =20
Not that there is a need for munmaping, but it is useful. If the user=20
frees some memory when not using it anymore but is still using the file=20
descriptor, that memory will be then available for use by another process.
>  =20
>>>> are trade-offs and I prefer to rely on the user, while providing a
>>>> RT-MMAP-IOCTL. Of course it isn't really a mmap, but if the user
>>>> don't mess with the pointers, it will work like if it was...
>>>>    =20
>>>>        =20
>>> The user can only access the window you mapped in and only as long as it
>>> is mapped.
>>>      =20
>> In my case, it is always mapped to make possible the RT-IOCTLs.
>>    =20
>>> And if you map it read-only, there is even no chance to
>>> destroy potential management structures of the hardware or the driver
>>> within this range.
>>>  =20
>>>      =20
>> I do not want to make it read-only because it will probably be very
>> usefull to the user to write on it. The user may want to capture a frame
>> and do some image processing routines on the same memory area when it is
>> possible, avoiding to copy that memory region.
>>    =20
>
> I see, this makes sense. Then just prepare enough buffers for the
> capturing, preprocessing, and potentially forwarding steps so that you
> can continue to capture even if the user still hogs on a few previously
> filled buffers. In the end it's just a cyclic process, and the only
> question is how many spare buffers have to be created to keep it running.
>  =20
This option is given to the user on V4L2 interface. That is not the=20
question. The problem arises on the follow situation (I'll try to be=20
more didactic this time):

1 - User A maps the buffer via ioctl.
2 - As the driver doesn't really do a mmap on ioctl, it just returns the=20
addresses to be used for the user.
3 - User A frees the buffer.
4 - The driver will mark that region as free but won't do any munmap for=20
keep doing it on RT-context.
5 - User B request buffer and mmap that same memory region via ioctl.
6 - Same goes on driver.
7 - A continue using the address he/she requested. If a munmap was=20
really called, this would result in SEGFAULT. But, in this case, he/she=20
will be able to continue messing with that area.
8 - User B will have unexpected behaviour.

That is the trade-off of using this approach for making it possible to=20
deal with buffers in a RT-context...

Best Regards,

Rodrigo.


	=09
_______________________________________________________
Yahoo! Acesso Gr=E1tis - Internet r=E1pida e gr=E1tis. Instale o discador a=
gora!
http://br.acesso.yahoo.com


