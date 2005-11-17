From: Dmitry Adamushko <dmitry.adamushko@domain.hid>
Date: Thu, 17 Nov 2005 18:55:15 +0100
References: <437C8299.3010503@domain.hid>
	<OF84150644.927CE822-ONC12570BC.00531CC2-C12570BC.00536AFA@datacon.at>
	<17276.48309.803651.529811@domain.hid>
In-Reply-To: <17276.48309.803651.529811@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200511171855.15588.dmitry.adamushko@domain.hid>
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

My assertion was only based on the idea that nucleus::xnpipe_release() must be 
called as a result of any close() from the user space. And it, in turn, wakes 
up all the blocked readers. So the current implementation at least should 
have worked in sych a case. But, well, below is what I have observed.

Maybe your assertion may explain that.

The reason is actually not because of some problem in the xenomai codebase but 
because of the fact that nucleus::xnpipe_release() is _not_ called as I 
expected it to be :o)

The experiment was as follows (a slightly changed klatency test):

latency_module.ko uses a 10-second wait-interval for sending data

int fd; // pipe

thread#2
{
sleep(3);
close(fd); 

// closing a pipe. Here I expected that nucleus::xnpipe_release() would be 
// called as a result (== file_operations::release ).
}

thread#1
{
fd = open(/dev/rtpN);

pthread_create(thread#2);

read(fd, ...);	// blocked at least for 10 seconds so thread#2 closes a pipe 
		        //earlier 

...
if (error)
    break;

...
close(fd);
}

So xnpipe_release() is _not_ called as a result of the close() call in 
thread#2. close() returns 0 indeed.

10 seconds after its starting, thread#1 :: read() returns a valid block of 
data from the latency module and right after that - an error code is returned 
that the pipe is no longer valid.

I have taken a very brief look at the linux sources but it was not enough to 
get an explanation. So I'll take a closer look now :o)


---

Dmitry



