Message-ID: <45EC4111.6070104@domain.hid>
Date: Mon, 05 Mar 2007 17:10:57 +0100
From: Markus Franke <Markus.Franke@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-help] rt_pipe_write() returns -ENOMEM
Reply-To: Markus.Franke@domain.hid
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org

Dear Xenomai Developers/Users,

I want to exchange data between User Space and Kernel Space via a
Message Pipe. Therefore I set up a pipe via rt_pipe_create() and write
to the pipe using rt_pipe_write(). After a few writes rt_pipe_write()
returns -ENOMEM what means that memory is exhausted. What happens if I
just ignore this error code? Does it simply mean that values are dropped
until the first value is read from the pipe by the User-Space Task? If
so, how can I increase the size of the message pipe? rt_pipe_alloc()
doesn't seem to solve the problem, isn't it?

Thanks in advance,


Markus Franke

