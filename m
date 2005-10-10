Message-ID: <434A5389.2060905@domain.hid>
Date: Mon, 10 Oct 2005 13:42:01 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <OF67718347.A739127D-ONC1257096.003D7ADA-C1257096.003F7677@domain.hid>
In-Reply-To: <OF67718347.A739127D-ONC1257096.003D7ADA-C1257096.003F7677@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-core] Re: [syscall.c] rt_bind_queue/heap()
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Dmitry Adamushko <dmitry.adamushko@domain.hid>
Cc: xenomai@xenomai.org

Dmitry Adamushko wrote:
> Philippe Gerum <rpm@xenomai.org> wrote on 10.10.2005 13:09:13:
> 
>  > Dmitry Adamushko wrote:
>  > > Philippe Gerum <rpm@xenomai.org> wrote on 05.10.2005 14:13:07:
>  > >
>  > >  >
>  > >  > Your patch is ok, my implementation was uselessly convoluted.
>  > >
>  > > Ok, then it's enclosed.
>  > >
>  > > 2005-10-05  Dmitry Adamushko  <dmitry.adamushko@domain.hid>
>  >
>  > Applied, thanks.
>  > ...
> 
> btw,
> 
> It looks like something wrong with the xenomai mailing list. I have got 
> your answer but only one copy (you specified my own e-mail) and I 
> haven't got my own message on the list (but I've cc'ed "xenomai-core").
>

Your mail to the list was blocked since you used an unregistered address to send 
it (datacon.at).

> One more thing. I had a discussion with Steven Seeger regarding the use 
> of NULL-named objects from the user space. I cc'ed you but probably you 
> were too buzy at that time. The problem is that one may create 
> successfully a NULL-named object but then there is no way to use it 
> since all further calls give an error (some funny stuff there indeed :)
> 
> So a simple fix would look like:
> 
> for all rt_OBJECT_create() calls in libnative:
> 
> int rt_mutex_create(RT_MUTEX *mutex, const char *name)
> {
> 
> + if (!name)
> + return -E_SOMETHING; // E_INVAL?
> 
> return XENOMAI_SKINCALL2(__xeno_muxid,
> __xeno_mutex_create,
> mutex,
> name);
> }
> 
> What do you think? Or are there any reasons to keep it as is now?
> 

The reason is to allow anonymous objects to be created, so that the descriptor 
could only be shared by tasks belonging to the same address space if they happen 
to all have access to the descriptor's memory. Kind of semi-private object if 
you want. The fact that such an object is non-bindable should not make it 
unusable actually.

> 
> p.s. I have cc'ed "xenomai@xenomai.org" for both reasons to test the 
> mailing list and, well, maybe someone else has an opinion on the matter.
> 
> 
>  > --
>  >
>  > Philippe.
> 
> ---
> Best regards,
> Dmitry
> 


-- 

Philippe.

