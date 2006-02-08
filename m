Message-ID: <43E9543C.8040906@domain.hid>
Date: Tue, 07 Feb 2006 23:15:24 -0300
From: Rodrigo Rosenfeld Rosas <lbocseg@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] RTDM mmap alternative
References: <20060203192739.87567.qmail@domain.hid>
	<200602061900.35411.lbocseg@domain.hid>
	<43E8DB10.5000901@domain.hid>
	<200602071722.06921.lbocseg@domain.hid>
	<43E8FD05.5060600@domain.hid>
In-Reply-To: <43E8FD05.5060600@domain.hid>
Content-Type: text/plain; charset="iso-8859-1"; format="flowed"
Content-Transfer-Encoding: quoted-printable
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Jan Kiszka <kiszka@domain.hid>
Cc: xenomai@xenomai.org

Jan Kiszka escreveu:
> Rodrigo Rosenfeld Rosas wrote:
>  =20
>> Hi Jan, thank you for your precious code! :)
>>
>> But, while it is executed in Linux context, ie, in a non-rt context, I c=
ould=20
>> register a normal Linux file descriptor and call mmap on it. Or I could =
mmap=20
>>    =20
>
> You still need the back-end, i.e. some Linux device being registered and
> catch your mmap call. That's how /dev/rtheap e.g. works.
>  =20
I know. I would register as something like "/dev/rtvideo".
>> the device /dev/mem for mapping the memory region I would need. I can ob=
tain=20
>> the absolute address from a RTDM ioctl call.
>>    =20
> /dev/mem is all or nothing: once you allow access, you cannot control
> which memory region gets mapped. Closing this loop in kernel space
> produces safer code with the option to get it even secure one day
> (current Xenomai APIs do not address the latter aspect yet).
>  =20
I know it is better but it will require extra effort from my part and=20
will be only temporary...
>> Anyway, I'll be missing the V4L2 compatibility but that is not a great i=
ssue.=20
>>    =20
> You mean some kind of rt_dev_mmap(..., rt-fildes, ...) (or wrapped mmap
> in the posix skin)?
Yes, I would like to use rt_dev_mmap... But I would be fine if I just=20
could do it anyway in RT-context...
>  We could define a standard RTDM-IOCTL and write the
> user-space lib functions so that interested drivers can receive such
> requests in a canonical way.
I really don't need the user-space lib functions and don't think others=20
will need it too... I would be just fine with a RTDM-IOCTL if it was in=20
RT-context...
>  The implementation in the driver would
> still be different to Linux (just rtdm_mmap_to_user, no page-on-demand
> e.g.).
>  =20
It will be different anyway as I'll be using rt_dev_open etc, but it=20
will be analogue to the ones used by V4L2. And I think very few people=20
would need the page-on-demand feature...
>> But since I only need to call this on initialization, I don't need to be=
 in=20
>> RT-context in my specific application. But since I'm also developing a=20
>> robotic programming framework it would be nice to have this mmap capabil=
ity=20
>> in real-time context.
>>    =20
> Dynamic mmap'ping in RT is contradictory: Touching your current process'
> mm creates dependencies on a lot of kernel code paths that can modify it
> as well - if such modifications can be made deterministic at all in
> Linux.
Unfortunately my knowledge of how linux deals with vma is very=20
limited... Actually, my knowledge of how memory access is made by the=20
processor is very limited too. I know that there are protected memory=20
and virtual memory but I'm not confortable with how it is achieved nor=20
by the processor nor by Linux. If it is too difficult to make it=20
deterministic, so I won't expect mmap to be made RT soon... Fortunately=20
I don't really need it for now.
> But I guess you don't means this.
Actually I did. But, as I said, I don't really need it. It would just be=20
nice to provide this option in my framework...
> Even V4L2 mmap's only during
> init and not during the critical capturing process - it's far to slow.
>  =20
I was not thinking in doing the mmap during the critical capturing=20
process, but maybe during a reconfiguration of the system by some reason...
> You know that, due to Xenomai's automatic mode switching, you would be
> free to call such rt_dev_mmap even from RT tasks? It would just switch
> you temporarily over.
>  =20
Yes, but I couldn't use it in hard real-time tasks... It is dangerous to=20
switch to secondary mode by a task of high priority... As I've said, I=20
don't know, from the moment, some real case where it would be necessary=20
to do so, but since I'm developing a framework, it would be nice to=20
provide this option...

Thank you for your concerns,

Best wishes,

Rodrigo.


=09

=09
	=09
_______________________________________________________=20
Yahoo! doce lar. Fa=E7a do Yahoo! sua homepage.=20
http://br.yahoo.com/homepageset.html=20



