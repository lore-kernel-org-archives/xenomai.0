Message-ID: <4D1A135E.7060005@domain.hid>
Date: Tue, 28 Dec 2010 17:42:06 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <alpine.DEB.1.10.1012211818430.9596@domain.hid>	<4D110810.1090504@domain.hid>	<alpine.DEB.1.10.1012221012270.10955@domain.hid>
	<alpine.DEB.1.10.1012271521010.20479@domain.hid>
In-Reply-To: <alpine.DEB.1.10.1012271521010.20479@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] gdb/gdbserver and pthread_cond_wait
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Kolja Waschk <xenoka09@domain.hid>
Cc: Xenomai GNA <xenomai@xenomai.org>

Kolja Waschk wrote:
> Hi,
> 
> I've made up a small test program for my issue with pthread_cond_wait and gdb.
> Sorry for posting code again, I've made it as compact as possible.

It would have been nice if you had posted the code in the mail body,
instead of attaching it, this would have allowed us to comment it.

So, here is the comment without the code. When pthread_cond_wait fails,
if you enter pthread_cond_wait again, it will fail again, forever, and
you get a lockup. sched_yield will likely not change anything. What you
should do is remove the printf when there is no error. And when there is
an error, print the error, then exit.

Now, about pthread_cond_wait, the error looks a lot like something which
was supposed to be fixed in the 2.5 branch. Could you run the
posix-cond-torture test case to verify that what was supposed to be
fixed is indeed fixed with the libc/gdb combination you are using?

-- 
                                                                Gilles.

