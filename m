From: Dmitry Adamushko <dmitry.adamushko@domain.hid>
Date: Thu, 17 Nov 2005 20:40:49 +0100
References: <437C8299.3010503@domain.hid>
	<OF84150644.927CE822-ONC12570BC.00531CC2-C12570BC.00536AFA@datacon.at>
	<17276.48309.803651.529811@domain.hid>
In-Reply-To: <17276.48309.803651.529811@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="koi8-r"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200511172040.50829.dmitry.adamushko@domain.hid>
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
To: xenomai@xenomai.org, xenomai-core <xenomai@xenomai.org>

On Thursday 17 November 2005 18:24, Gilles Chanteperdrix wrote:
> Dmitry Adamushko wrote:
>  > > >As a conclusion, the behaviour that you observed with Xenomai
>  > > >pipes seems consistent with that of Linux' named pipes, except
>  > > >that in Linux read() returns 0, and not an error code as you
>  > > >observed with Xenomai.
>  > >
>  > > The read() call does *not* return when you close the *same* file
>  > > handle from another pthread in the same process.
>  >
>  > I confirm that and as I pointed it out in my previous mail - this is not
>  > how it's supposed to be.
>  > I'm currently on it. More news later.
>
> I am not sure about that: Linux regular pipes follow the same behaviour
> (the real destruction of the file descriptor is delayed until read()
> really returns).

Ok, it's me who is a stupid uneducated zorr... I mean bozzo :o)

The reason is quite simple indeed.

The file_operations::release() is called when a <file *> object is about to be 
destroyed (file * object is created for each open file). It happens when its 
refference count becomes 0.

Rigth after open() the counter == 1. As one may guess, close() decrease it on 
1.

There is another entity - file_operations::flush() which is called on each 
close() call. But file_operations::release() is called only when all the 
references on the object have been closed.

There can be N:1 relation. Imagine, dup() or fork() make a copy of the file 
descriptor and as a result - the regerence is increased appropriately.

Now what happens is that read/write() calls increase the counter before using 
a file object and decrease it right before returning.


thread1::open() --> file_operations::open() == xnpipe_open()   ---> counter=1

thread1::read() --> ... counter=2 .. -> file_operations::read() == 
xnpipe_read() - blocked ... (*)

thread2::close() --> ... -> file_operations::flush() [ we don't make use of 
this one in pipe.c ] --> counter = 1

So that's why xnpipe_release() is not called!

10 seconds have elapsed

thread1::read (*) - unblocked() --> copies data to the user's buffer ---> 
counter = 0. Oooops!

As a result -> file_operations::release() is called! Next thread1::read() call 
returns an error code.

So that's what happens. We can define file_operations::flush() and wake up all 
the readers there. But we can't know that this is a last reference on the 
file (ok, we can actually but with a bit of hacking).
I mean :

f = open() -> 1 reference
f2 = dup(f)    -> the 2-nd

close(f);
close(f2);

2 flush() calls but only 1 release() so do we need to wake up all the readers 
if the file is still valid?

So well, at least, there is no problem with the xenomai codebase, that's 
good :o)


---

Dmitry

 




