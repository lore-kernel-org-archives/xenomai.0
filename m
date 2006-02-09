From: Rodrigo Rosenfeld Rosas <lbocseg@domain.hid>
Subject: Re: [Xenomai-help] RTDM mmap alternative
Date: Thu, 9 Feb 2006 14:04:11 -0200
References: <20060203192739.87567.qmail@domain.hid>
	<200602081928.17224.lbocseg@domain.hid> <43EB02F5.4040001@domain.hid>
In-Reply-To: <43EB02F5.4040001@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Message-Id: <200602091404.11342.lbocseg@domain.hid>
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

Em Quinta 09 Fevereiro 2006 06:53, Jan Kiszka escreveu:

>Rodrigo Rosenfeld Rosas wrote:
>> One more doubt: how would I munmap that memory? do_munmap and passing
>> current->mm as the first parameter and the physical address as start? I'm
>> not
>
>Yes, but better save current->mm at mmap time and pass *this* value on
>unmap. I'm thinking about a way to include this in RTDM.

Why should I make a backup of mm? Why would it change? Just for curiosity...

>> sure... Maybe the user can call munmap directly since it doesn't need the
>> file descriptor. But which address should (s)he pass to start parameter,
>> the virtual or the physical one?
>
>This is also an option. The user would have to pass the virtual address
>the driver returned.

I'm curious. How do you know in which circunstances should one pass the=20
virtual or the physical address? I never know which to use...

>But I think we still need a cleanup on RTDM device closure to avoid
>access to the mapped physical buffers after that point. I wonder how
>this is done in standard drivers, will have to look at some of them.

Sorry, I can't help here, since the user munmap don't pass through the=20
driver... :( I don't know if it is even done by the drivers. The mmap man=20
page states:

"The  munmap()  system  call deletes the mappings for the specified address=
=20
range, and causes further references to addresses within the range to=20
generate invalid memory references.  The region is  also automatically=20
unmapped when the process is terminated.  On the other hand, closing the fi=
le=20
descriptor does not unmap the region."

So, the mmap will be undone when the program finishes, I think.

Rodrigo.

=09

=09
	=09
_______________________________________________________=20
Yahoo! doce lar. Fa=E7a do Yahoo! sua homepage.=20
http://br.yahoo.com/homepageset.html=20



