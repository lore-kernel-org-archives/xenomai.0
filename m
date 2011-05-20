From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <BANLkTinYewN9P3qLqRwP_XZw0HSaAvRfrw@domain.hid>
References: <BANLkTinYewN9P3qLqRwP_XZw0HSaAvRfrw@domain.hid>
Content-Type: text/plain; charset="UTF-8"
Date: Fri, 20 May 2011 16:11:53 +0200
Message-ID: <1305900713.2109.23.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Meaning of -ENOMEM in rt_pipe_write
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Hadrien Caron <hadrienstegosaure@domain.hid>
Cc: xenomai@xenomai.org

On Fri, 2011-05-20 at 15:27 +0200, Hadrien Caron wrote:
> Hello, I am new to using the Xenomai API and I have a basic question
> regarding
> the error indicator I just received.
> 
> I send large amount of data through pipe using rt_pipe_read and

You likely mean rt_pipe_write().

>  eventually get a return error of -ENOMEM
> 
> On the documentation I saw that :
> 
> -ENOMEM is returned if not enough buffer space is available to
> complete the operation.
> 
> I suppose the buffer refers to the internal buffer of the pipe to
> which the data is copied.
> I don't understand what I am supposed to do in order to free space on
> that buffer so that there
> is enough memory.
> 
> Could someone give some information about how the buffer is handled ?
> 

The real-time sender via rt_pipe_write() pulls memory from an internal
allocator, and that memory is released when the non real-time side reads
from its endpoint. So you get -ENOMEM likely because the latter does not
read fast enough.

Possible options:

- increase the size of the system heap, which is being used when no
private memory pool has been defined for the pipe. See
CONFIG_XENO_OPT_SYS_HEAP in your kernel .config.

- assign a private memory pool to the pipe via rt_pipe_create()'s
poolsize parameter, large enough to cope with the throughput. The
message space won't be pulled from the system heap in that case, but
from the private pool, which will be entirely reserved for that purpose.

- implement some sort of congestion control between the write and the
read sides, to avoid depleting the memory pool on the write side, by
waiting for the read side to pick up the messages when some watermark is
reached. Of course, this introduces a priority inversion, so whether it
is acceptable depends on your requirements.

- read the data faster from the non real-time endpoint, or send it
slower from the write side.

> Thank you very much in advance.
> 
> Regards,
> 
> Hadrien Caron 
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help

-- 
Philippe.



