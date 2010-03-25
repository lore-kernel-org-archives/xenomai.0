Message-ID: <4BAB6947.8020803@domain.hid>
Date: Thu, 25 Mar 2010 14:46:47 +0100
From: Daniele Nicolodi <daniele@domain.hid>
MIME-Version: 1.0
References: <4BA416AA.6050603@domain.hid>
	<4BA4C5EF.6020003@domain.hid>	<20100321205955.GB3505@domain.hid>
	<4BA9EDEE.6070500@domain.hid>	<20100324234409.GA3247@domain.hid>
	<4BAAA8C0.2080003@domain.hid>
In-Reply-To: <4BAAA8C0.2080003@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] [PULL REQUEST] analogy: bug fixes
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Alexis Berlemont <alexis.berlemont@domain.hid>
Cc: xenomai-core <xenomai@xenomai.org>

Daniele Nicolodi wrote:
> Alexis Berlemont wrote:
>> If you want to test infinite acquisitions right now, you can clone my
>> git repository. I just pushed the modifications on it. I have not made
>> a pull request yet because I want to be sure there is no regression. 
> 
> Thanks! I'll test it as soon as possible.

I'm testing it now.

> I think I just stumbled into the ring buffer bug you fixed in your
> repository :-) It took me a while to understand if the problem was in
> the hardware, in my code, or somewhere else in the stack...

Unfortunately my ring buffer problem is not fixed by you patch. What I'm
experiencing is exposed by this (pseudo) code:

a4l_open(dsc, device)
a4l_mmap(dsc, subdevice, bufsize, &map)
a4l_snd_command(dsc, cmd)

/* preload buffer */
written = write_to_buffer(map, bufsize)

/* send internal trigger */
a4l_snd_insn(dsc,

cnt = 0;
while (1)
  a4l_mark_bufrw(dsc, subdevice, written, towrite);
  cnt += written;
  /* 1 */
  written = write_buffer(map + (cnt % bufsize), towrite)


The problem is that at the place marked with (1) the total extension of
the buffer region that gets written exceeds the ring buffer allocated
memory. That is ((cnt % bufsize) + towrite) > bufsize !

I do not know if this should be handled in my code, or in the driver.
This situation is not handled in the cmd_write example code (where a
simple memcpy() is done).

What do you think?

Cheers,
-- 
Daniele

