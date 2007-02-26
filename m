Message-ID: <bc4264770702261206v1e3d84cbhe94b923540dbaae6@domain.hid>
Date: Mon, 26 Feb 2007 20:06:22 +0000
From: "roland Tollenaar" <rolandtollenaar@domain.hid>
Subject: Re: [Xenomai-help] newby question, can/socket stuff
In-Reply-To: <45E33BA0.6080903@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <bc4264770702261108l6b3f60b2w53e9e90e40d79b92@domain.hid>
	<45E33BA0.6080903@domain.hid>
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


You must all be getting very exasperated with me. :)

> > I know too little of the basic socket programming. Not even sure my
> > wording in the previous sentence is capturing the correct area of
> > ignorance.
>
> There are plenty text books on BSD socket programming and the rational
> behind it.
These are the ones I need. But without the time to get hold of them I
will have to search the net.

> > ret = rt_dev_ioctl(can_fd, SIOCGIFINDEX, &ifr);
> >
> > and
> > ret = rt_dev_ioctl(can_fd, SIOCSCANBAUDRATE, &ifr);
> >
> > But exactly what is happening is beyond me at the moment.
>
> SIOCGIFINDEX gets the interface index for a named device and
> SIOCSCANBAUDRATE allows to set the baudrate. The RT-Socket-CAN utilities

My email must have been very bad. I realize roughly what SIOCGIFINDEX
and  SIOCSCANBAUDRATE do. This is described very nicely in your
documentation or rather the documentation that refers to you and which
Gilles kindly also pointed out to me but which I already knew about.

No my problem is with the
rt_dev_ioctl

part. I would like to have a better understanding of the part that
these functions play.

> are now even hyperlinked with the API doc (still not 100% perfect yet) e.g.:
>
> http://www.xenomai.org/documentation/trunk/html/api/rtcanconfig_8c-example.html

And by tremendous chance this was also the code I was studying when I
posted my email.

Sorry to be such a nuisance. I'll see if I can google for some info on
rt_dev_ioctl.

Regards,

Roland


>
> > Now I can obviously try to copy like a chinaman (no disrespect
> > intended!) and not understand what I am doing but it is not really a
> > mode of operation I relish.
> >
> > I have briefly tried to locate the rt_dev_ioctl back to a xenomai
> > header but have not managed to trace it yet.
>
> > Is it defined in the standard linux ioctl headers? Where can I find
> > some info on what arguments these functions are passed etc?
>
> Hm, try:
>
> $ cd <xenomai-root>
> $ find . -name '*.[ch]' | xargs grep SIOCSCANBAUDRATE
>
> > Much appreciated.
>
> Wolfgang.
>

