Message-ID: <43EDE275.5040307@domain.hid>
Date: Sat, 11 Feb 2006 10:11:17 -0300
From: Rodrigo Rosenfeld Rosas <lbocseg@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] [PATCH] provide rtdm_mmap_to_user / rtdm_munmap
References: <43EBD9D6.5090404@domain.hid>
	<43EBE032.40302@domain.hid>	<200602101858.21108.lbocseg@domain.hid>
	<200602101928.52899.lbocseg@domain.hid> <43ED3165.3090300@domain.hid>
In-Reply-To: <43ED3165.3090300@domain.hid>
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
> Rodrigo Rosenfeld Rosas wrote:
>  =20
>> Hi Jan, it just happened once and I couldn't reproduce (I didn't want to=
=20
>> reproduce it too since I would need to restart my computer because the d=
river=20
>> wouldn't unload)...
>>
>> When it happened I forgot to start the timer running the latency program=
 and=20
>>    =20
>
> Already running latest SVN version?
Almost there ;) That is why your patch didn't apply cleany, but I just=20
needed to include two "#include" and "#define" lines to drvlib.c or=20
something like...

>  rt_timer_start&friends became
> deprecated last weekend, so you can't forget this step anymore.
>  =20
I didn't use rt_timer_start at all. I was doing as you suggested,=20
calling another program to start the timer, like "latency".

>> my driver failed to load and due to some mistake I've made (I have not=20
>> indentified it yet), it crashed on rmmoding. I need to check this, but I=
=20
>> still think it is a good idea to make the sanity checks...
>>    =20
>
> We need some XENO_ASSERT that is only active when CONFIG_XENO_OPT_DEBUG
> is set. I don't want to put such checks in production code, but I see
> that they may help debugging early drivers.
>  =20
I understand your concernings but I really don't think they are=20
relevant... This checks will be much faster then the procedure itself=20
and it would conform to normal munmap behaviour. From man page:

"The address start must be a multiple of the page size. All pages=20
containing a part of the indicated range are unmapped, and subsequent=20
references to these pages will generate SIGSEGV. It is not an error if=20
the indicated range does not contain any mapped pages."

I think that if there was an extra parameter for user_info, it would=20
also verify for validity. BTW, I think there is missing some=20
documentation about the user_info parameter. I had to remember our=20
conversation and look at the code to understand that I should record=20
"current" on this parameter on the moment I called mmap and passing it=20
again on munmap. And it would be good to see the rtdm_user_info_t=20
defined as struct task_struct on the documentation.

>> I have not written the user-space program yet, so you'll have to wait un=
til=20
>> monday, when I'll be able to test it, hopefully. But it seems to be=20
>> working... I changed my driver design. I do the mmap's on driver=20
>> initialization and just pass the returned addresses on the IOCTL, so I c=
an do=20
>> them in a RT-context. The problem is that even if the user call an IOCTL=
 to=20
>>    =20
>
> Hmm, I guess there is still some lacking documentation about what is
> possible with RTDM. If you call an IOCTL from RT context, you end up in
> the _rt-handler the driver of a device may have registered (if there is
> no _rt-handler at all, the _nrt one is invoked, but this is likely not
> relevant here).
>
> I assume that you were wondering how to call rtdm_mmap_to_user from this
> real-time handler, right?
No. I know it is not possible from the moment. I think I did not explain=20
myself very well. I was wondering how to define a RT mmap like ioctl. As=20
I know I could not use rtdm_mmap_to_user then, I thought in another way=20
of doing it. So I mmaped on driver initialization. On the IOCTL I just=20
passed the already known addresses to the user requesting it. I would=20
have to explain you how these buffers work on V4L2. It is a bit long=20
explanation but I can explain it on other message if you wish.

> Well, the trick is to return -ENOSYS for those
> IOCTL codes that can only be handled by the _nrt-handler. Xenomai will
> then switch your RT task to secondary mode, restart the IOCTL, and the
> mmap can safely be executed.
>  =20
But as I've said, it is not the behaviour I want :)

> Well, maybe you do not have any arguments for rtdm_mmap_to_user that
> should be influenced by the user's IOCTL.
That is my case.

> In this case your current driver design is ok as well. I just wanted to u=
nderline that it is not necessarily the only way.
>  =20
But I couldn't find other way of doing it in a RT-context.

>> munmap, it will still be possible to him to continue using the provided =

>> address and this would result in a problem. But, as in all situations, t=
here=20
>>    =20
>
> When rtdm_munmap is executed, the virtual address range becomes invalid
> for the user. Thus any further access to it will raise a segfault.
> That's the only problem, but it will not influence the driver integrity.
>  =20
Yes, that is the problem. Since I only mark as unused on the munmap=20
IOCTL, it would be possible to the user to continue using that address=20
even after the munmap IOCTL call. It I was using a really rtdm_munmap,=20
it wouldn't be possible. It would be a better behaviour, but it would=20
not be run on RT-context. That is the trade-off.

>> are trade-offs and I prefer to rely on the user, while providing a=20
>> RT-MMAP-IOCTL. Of course it isn't really a mmap, but if the user don't m=
ess=20
>> with the pointers, it will work like if it was...
>>    =20
>
> The user can only access the window you mapped in and only as long as it
> is mapped.
In my case, it is always mapped to make possible the RT-IOCTLs.
> And if you map it read-only, there is even no chance to
> destroy potential management structures of the hardware or the driver
> within this range.
>  =20
I do not want to make it read-only because it will probably be very=20
usefull to the user to write on it. The user may want to capture a frame=20
and do some image processing routines on the same memory area when it is=20
possible, avoiding to copy that memory region.
>> Hope you understood me, I wrote it a little confusing... :)
>>    =20
>
> We will see...
>  =20
:)
> Happy WE,
>  =20
Happy weekend for you too,

Rodrigo.


	=09
_______________________________________________________
Yahoo! Acesso Gr=E1tis - Internet r=E1pida e gr=E1tis. Instale o discador a=
gora!
http://br.acesso.yahoo.com


