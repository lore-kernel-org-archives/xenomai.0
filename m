From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17992.16937.797697.933278@domain.hid>
Date: Mon, 14 May 2007 13:04:09 +0200
In-Reply-To: <7289437c0705140221tb124a04mcbf9910e47d3ac2e@domain.hid>
References: <7289437c0705140221tb124a04mcbf9910e47d3ac2e@domain.hid>
Subject: Re: [Xenomai-help] Problem with Message queue
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Perrine Martignoni <perrmart@domain.hid>
Cc: xenomai@xenomai.org

Perrine Martignoni wrote:
 > Hello,
 > 
 > I'm writing an application using Message queue and mq_send returns the errno
 > value EBADF.
 > I don't understand what I'm doing wrong, I need some help.
 > 
 > Here's my code :

Next time, please do not omit the #includes, I need them to compile your
program.

 > (...)
 >             if (mq1=mq_open("/mq1", O_CREAT|O_RDWR, 0, &qattr1) ==
 > (mqd_t)(-1)) {

Here gcc gives the following message:
test_mq.c:186: warning: suggest parentheses around assignment used as truth value

Which should be the sign that something is not correct, 

a=b == c is interpreted by the compiler as a=(b == c), whereas you would
like
(a = b) == c.

So, add the parentheses, and everything should work fine.

However, I do not understand what your program is supposed to do, here
it dies without printing anything.

-- 


					    Gilles Chanteperdrix.

