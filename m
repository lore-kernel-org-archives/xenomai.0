Message-ID: <45EC61B0.3020907@domain.hid>
Date: Mon, 05 Mar 2007 19:30:08 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] rt_pipe_write() returns -ENOMEM
References: <45EC4111.6070104@domain.hid>
	<45EC428E.5060306@domain.hid>
	<45EC4AF4.7000808@domain.hid>
	<45EC4F8E.905@domain.hid>
	<45EC5946.9030508@domain.hid>
In-Reply-To: <45EC5946.9030508@domain.hid>
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
> OK. And if there is an overflow is there anything I can do during
> runtime, e.g. just to overwrite the data in the queue?

Why not something like:

while (-ENOMEM == rt_pipe_write(pipe, buf, size, mode)) {
	RT_PIPE_MSG *msg;
	rt_pipe_receive(pipe, &msg, TM_INFINITE);
	rt_pipe_free(pipe, msgp);
}

-- 
                                                 Gilles Chanteperdrix

