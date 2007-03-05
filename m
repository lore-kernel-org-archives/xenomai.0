Message-ID: <45EC4AF4.7000808@domain.hid>
Date: Mon, 05 Mar 2007 17:53:08 +0100
From: Markus Franke <Markus.Franke@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] rt_pipe_write() returns -ENOMEM
References: <45EC4111.6070104@domain.hid>
	<45EC428E.5060306@domain.hid>
In-Reply-To: <45EC428E.5060306@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
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
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

Gilles Chanteperdrix wrote:
> The fourth argument of rt_pipe_create is the size of the reserved pool
> used by the pipe. If you pass 0, the system heap is used. The size of
> the system heap is configured via the kernel configuration.
> 
> rt_pipe_alloc allocates a message from the used pool (the rt_pipe pool
> if you passed a non 0 pool size to rt_pipe_create, or the system heap if
> you passed a null pool size to rt_pipe_create).

Yes, this I know already. But what happens if rt_pipe_write() returns
-ENOMEM? Does the data to be written simply get lost or is it simply
enqeued at the end and the first element in the pipe get's lost?

