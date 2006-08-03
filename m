Subject: Re: [Xenomai-help] Re: problem with reading from rt_pipe with a
	normal linux process
From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <eas7hg$umm$1@domain.hid>
References: <eaqrtk$vkb$1@domain.hid>	<eaqsbk$vkb$2@domain.hid>
	<44D0F5DE.3010508@domain.hid>	<eaqt5i$4l0$1@domain.hid>
	<44D0FF4C.9090006@domain.hid>  <eas7hg$umm$1@domain.hid>
Content-Type: text/plain
Date: Thu, 03 Aug 2006 19:46:38 +0200
Message-Id: <1154627199.5010.135.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Reply-To: rpm@xenomai.org
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Marco Jackel <ich@domain.hid>
Cc: xenomai@xenomai.org

On Thu, 2006-08-03 at 09:10 +0200, Marco Jackel wrote:
> Jan Kiszka wrote:
> > Marco Jackel wrote:
> >> Jan Kiszka wrote:
> >>> Hint: read returns its error code in errno. What does that one tell you?
> >> read returns -1, "operation not permitted"
> >>
> > 
> > errno == EPERM? A bit weird. Try strace'ing both your program and the
> > cat tool to look for a difference.
> strace says "-1" in this case is ENOBUFS
> 
> The failure in my programm is that it writes binary data to a pipe with
> rt_pipe_write (preserves message boundary) and normal linux process
> wants to read it byte by byte with read(). Read wants to receive the
> whole message, but the message is bigger than 1 byte, so it returns ENOBUFS.
> 

Yep. Well, I agree that this is clearly not the best designed part of
the entire interface...

> The solution is to use rt_pipe_stream (don't preserves message
> boundary). Do I have to use rt_pipe_alloc before? 

No, rt_pipe_stream() manages an internal buffer to convey the byte
stream, and deals with the rt_pipe_alloc/free interface on its own. You
just need to pass it the raw data buffer and size.

> Is there a small
> sample program somewhere?
> 
> 
> Thanks,
> Marco
> 
> 
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help
-- 
Philippe.



