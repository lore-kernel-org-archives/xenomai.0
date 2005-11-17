From: Dmitry Adamushko <dmitry.adamushko@domain.hid>
Date: Thu, 17 Nov 2005 20:45:43 +0100
References: <437C8299.3010503@domain.hid>
	<200511171855.15588.dmitry.adamushko@domain.hid>
	<17276.55104.956181.681355@domain.hid>
In-Reply-To: <17276.55104.956181.681355@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200511172045.43942.dmitry.adamushko@domain.hid>
Subject: [Xenomai-core] Re: [Xenomai-help] Blocking reads from pipes
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org, xenomai-core <xenomai@xenomai.org>

On Thursday 17 November 2005 20:17, you wrote:
> Dmitry Adamushko wrote:
>  > On Thursday 17 November 2005 18:24, Gilles Chanteperdrix wrote:
>  > > Dmitry Adamushko wrote:
>  > >  > > >As a conclusion, the behaviour that you observed with Xenomai
>  > >  > > >pipes seems consistent with that of Linux' named pipes, except
>  > >  > > >that in Linux read() returns 0, and not an error code as you
>  > >  > > >observed with Xenomai.
>  > >  > >
>  > >  > > The read() call does *not* return when you close the *same* file
>  > >  > > handle from another pthread in the same process.
>  > >  >
>  > >  > I confirm that and as I pointed it out in my previous mail - this
>  > >  > is not how it's supposed to be.
>  > >  > I'm currently on it. More news later.
>  > >
>  > > I am not sure about that: Linux regular pipes follow the same
>  > > behaviour (the real destruction of the file descriptor is delayed
>  > > until read() really returns).
>  >
>  > My assertion was only based on the idea that nucleus::xnpipe_release()
>  > must be
>  >
>  > called as a result of any close() from the user space.
>
> If we have a look at the sources, sys_read uses fput_light and
> fget_light, which increment and decrement the file descriptor
> reference count (member f_count of the file structure) used by fget and
> fput when the file descriptor is shared between. open and close call
> fget and fput.
>
> "release" only get called through __fput when f_count reaches 0.

Exactly, I have just found out that and posted actually a long mail just 
before getting this mail from you :o)

Yep, and before getting blocked, read() increments the counter as well, that's 
why we don't have a xnpipe_realease() called as a result of close().
So everything is correct.


---

Dmitry

