Message-ID: <bc4264770702261242s6d074eeq5ac2c36a181b5128@domain.hid>
Date: Mon, 26 Feb 2007 20:42:08 +0000
From: "roland Tollenaar" <rolandtollenaar@domain.hid>
Subject: Re: [Xenomai-help] newby question, can/socket stuff
In-Reply-To: <45E34223.4010505@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <bc4264770702261108l6b3f60b2w53e9e90e40d79b92@domain.hid>
	<45E33BA0.6080903@domain.hid>
	<bc4264770702261206v1e3d84cbhe94b923540dbaae6@domain.hid>
	<45E34223.4010505@domain.hid>
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Wolfgang Grandegger <wg@domain.hid>
Cc: xenomai@xenomai.org

Hi,

> > You must all be getting very exasperated with me. :)
>
> Why, you seem to be exasperated ;-).
But I have good cause to be. I am the one not understanding what you
all find so obviously clear. :)

> Unfortunately, there is a problem with hyperlinking rt_dev_ioctl() in
> Doxygen :-(.
Pity, but don't worry. Jan's explanation earlier elucidates matters
tremendously.

Thanks,

Roland


>
> Wolfgang.
>
> >
> > Regards,
> >
> > Roland
> >
> >
> >>
> >> > Now I can obviously try to copy like a chinaman (no disrespect
> >> > intended!) and not understand what I am doing but it is not really a
> >> > mode of operation I relish.
> >> >
> >> > I have briefly tried to locate the rt_dev_ioctl back to a xenomai
> >> > header but have not managed to trace it yet.
> >>
> >> > Is it defined in the standard linux ioctl headers? Where can I find
> >> > some info on what arguments these functions are passed etc?
> >>
> >> Hm, try:
> >>
> >> $ cd <xenomai-root>
> >> $ find . -name '*.[ch]' | xargs grep SIOCSCANBAUDRATE
> >>
> >> > Much appreciated.
> >>
> >> Wolfgang.
> >>
> >
> >
>
>

