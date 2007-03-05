From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17900.31172.233075.597047@domain.hid>
Date: Mon, 5 Mar 2007 21:12:52 +0100
Subject: Re: [Xenomai-help] rt_pipe_write() returns -ENOMEM
In-Reply-To: <45EC61B0.3020907@domain.hid>
References: <45EC4111.6070104@domain.hid>
	<45EC428E.5060306@domain.hid>
	<45EC4AF4.7000808@domain.hid>
	<45EC4F8E.905@domain.hid>
	<45EC5946.9030508@domain.hid>
	<45EC61B0.3020907@domain.hid>
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Markus.Franke@domain.hid, xenomai@xenomai.org

Gilles Chanteperdrix wrote:
 > Markus Franke wrote:
 > > OK. And if there is an overflow is there anything I can do during
 > > runtime, e.g. just to overwrite the data in the queue?
 > 
 > Why not something like:
 > 
 > while (-ENOMEM == rt_pipe_write(pipe, buf, size, mode)) {
 > 	RT_PIPE_MSG *msg;
 > 	rt_pipe_receive(pipe, &msg, TM_INFINITE);
 > 	rt_pipe_free(pipe, msgp);
 > }

This will not work: pipe are a two-ways communication channel, so that
calling rt_pipe_receive returns messages that were sent from
user-space, and not the messages previously sent with rt_pipe_write. I
am afraid what you want to do is not what rt pipes were designed for.

-- 


					    Gilles Chanteperdrix.

