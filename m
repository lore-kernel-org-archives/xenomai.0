Message-ID: <bc4264770702261237v2cdd380ag128ed0cfb703b281@domain.hid>
Date: Mon, 26 Feb 2007 20:37:24 +0000
From: "roland Tollenaar" <rolandtollenaar@domain.hid>
Subject: Re: [Xenomai-help] newby question, can/socket stuff
In-Reply-To: <45E34014.6080105@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <bc4264770702261108l6b3f60b2w53e9e90e40d79b92@domain.hid>
	<45E33BA0.6080903@domain.hid>
	<bc4264770702261206v1e3d84cbhe94b923540dbaae6@domain.hid>
	<45E34014.6080105@domain.hid>
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

Hi,

> > You must all be getting very exasperated with me. :)
>
> How did you guess this? ;)
It generally happens when one asks silly questions .:)


>
> "man" is your friend (if installed on your linux distro). E.g.
>
> # man recvmsg
I have man but seem to have no entry for recvmsg, recv or recvfrom. I
hope this does not mean the functions will not be available on my
system.....

>
> Then there is the OpenGroups spec:
>
> http://www.opengroup.org/onlinepubs/009695399/
>
> But I thing before diving too deep into this, rather apply the
> Chinaman's tactic.
Had a look at it and you know what? I think you are right :(
I will settle for the semi-chinaman technique.....

> > No my problem is with the
> > rt_dev_ioctl
> >
> > part. I would like to have a better understanding of the part that
> > these functions play.
>
> Add 1 to 1: The CAN profile describes what IOCTLs are available for CAN
> sockets. rt_dev_ioctl() (or ioctl() with the POSIX skin) is the way to
> pass these IOCTLs down to the CAN stack.

Actually this sheds quite a bit of light on matters. If you would be
so kind as to give a brief explanation of what a "stack" is exactly. I
have been confronted with the term quite a lot now but its not
becoming clearer. I used to think it was a buffer of some kind. Kind
of like the ones that one "pushes" and "pops" on but I can't see a
connection between that concept and what you say above.


>
> I think this should be visible when making one step back, looking at the
> whole picture of the documentation pieces and the examples, no?
Absolutely. Thanks.


Regards,

Roland.


>
> >
> >> are now even hyperlinked with the API doc (still not 100% perfect yet)
> >> e.g.:
> >>
> >> http://www.xenomai.org/documentation/trunk/html/api/rtcanconfig_8c-example.html
> >>
> >
> > And by tremendous chance this was also the code I was studying when I
> > posted my email.
> >
> > Sorry to be such a nuisance. I'll see if I can google for some info on
> > rt_dev_ioctl.
> >
> > Regards,
> >
> > Roland
> >
>
> Jan
>
>
>

