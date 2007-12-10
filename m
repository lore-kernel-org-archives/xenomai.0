Message-ID: <475D7B40.7080408@domain.hid>
Date: Mon, 10 Dec 2007 18:45:36 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <475D76FE.4090100@domain.hid>
In-Reply-To: <475D76FE.4090100@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: Philippe Gerum <philippe.gerum@domain.hid>
Subject: Re: [Xenomai-help] multiple tasks calling rt_pipe_write() on same
 pipe
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
To: Theo Veenker <Theo.Veenker@domain.hid>
Cc: Xenomai <xenomai@xenomai.org>

Theo Veenker wrote:
> Hi,
> 
> I have multiple tasks all calling rt_pipe_write() to send some data
> through the same pipe. Is my assumption that rt_pipe_write() won't be
> interupted when a higher priority thread becomes ready correct?
>

Messages are always atomically queued on the write side, so the contents
of two distinct messages won't be mixed. Of course, the priority may
still affect the queuing order of both messages, though. Does this
answer your question?

-- 
Philippe.

