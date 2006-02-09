From: Rodrigo Rosenfeld Rosas <lbocseg@domain.hid>
Subject: Re: [Xenomai-help] RTDM mmap alternative
Date: Thu, 9 Feb 2006 15:58:45 -0200
References: <20060203192739.87567.qmail@domain.hid>
	<200602091404.11342.lbocseg@domain.hid> <43EB737A.3010704@domain.hid>
In-Reply-To: <43EB737A.3010704@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Message-Id: <200602091558.46201.lbocseg@domain.hid>
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: xenomai@xenomai.org

Em Quinta 09 Fevereiro 2006 14:53, Jan Kiszka escreveu:

> ...
>>> But I think we still need a cleanup on RTDM device closure to avoid
>>> access to the mapped physical buffers after that point. I wonder how
>>> this is done in standard drivers, will have to look at some of them.
>>
>> Sorry, I can't help here, since the user munmap don't pass through the
>> driver... :( I don't know if it is even done by the drivers. The mmap man
>> page states:
>>
>> "The  munmap()  system  call deletes the mappings for the specified
>> address range, and causes further references to addresses within the ran=
ge
>> to generate invalid memory references.  The region is  also automatically
>> unmapped when the process is terminated.  On the other hand, closing the
>> file descriptor does not unmap the region."
>>
>> So, the mmap will be undone when the program finishes, I think.
>
>Indeed, this is also what I quickly verified in practice. E.g., if you
>do not munmap the region I provided in my test driver, the user-space
>tool will still be able to access the physical memory behind it.

Even if the application was closed and then rerun using a stored address? I=
t=20
would not conform to documentations in this case... I think you're talking =

about just closing the file descriptor with rtdm_dev_close, right?

>In that case, the user kmalloc'ing (or whatever) that region again after a
>kfree would access memory that is probably used in a totally different way
>meanwhile. Dangerous!

But, anyway it would be a user error. Not a driver issue... But I agree tha=
t=20
it would be great to undone the mapping on closing the file descriptor,=20
although it would not be compatible with normal mmap behaviour.

>If it is just RAM, you may track the releases (register vma_fops) and
>call kfree only when the last user finished. But when it's physical
>device memory, you may want to have access earlier. Thus we need
>"enforced" munmap on rt_dev_close, maintained by the individual driver.
>Therefore, I will introduce also rtdm_munmap() or so.

It would be nice to be able to call rtdm_munmap. :)

Rodrigo.

=09

=09
	=09
_______________________________________________________=20
Yahoo! doce lar. Fa=E7a do Yahoo! sua homepage.=20
http://br.yahoo.com/homepageset.html=20



