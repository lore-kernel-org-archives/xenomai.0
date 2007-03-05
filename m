Message-ID: <45EC428E.5060306@domain.hid>
Date: Mon, 05 Mar 2007 17:17:18 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] rt_pipe_write() returns -ENOMEM
References: <45EC4111.6070104@domain.hid>
In-Reply-To: <45EC4111.6070104@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Markus.Franke@domain.hid
Cc: xenomai@xenomai.org

Markus Franke wrote:
> Dear Xenomai Developers/Users,
> 
> I want to exchange data between User Space and Kernel Space via a
> Message Pipe. Therefore I set up a pipe via rt_pipe_create() and write
> to the pipe using rt_pipe_write(). After a few writes rt_pipe_write()
> returns -ENOMEM what means that memory is exhausted. What happens if I
> just ignore this error code? Does it simply mean that values are dropped
> until the first value is read from the pipe by the User-Space Task? If
> so, how can I increase the size of the message pipe? rt_pipe_alloc()
> doesn't seem to solve the problem, isn't it?

The fourth argument of rt_pipe_create is the size of the reserved pool
used by the pipe. If you pass 0, the system heap is used. The size of
the system heap is configured via the kernel configuration.

rt_pipe_alloc allocates a message from the used pool (the rt_pipe pool
if you passed a non 0 pool size to rt_pipe_create, or the system heap if
you passed a null pool size to rt_pipe_create).

-- 
                                                 Gilles Chanteperdrix

