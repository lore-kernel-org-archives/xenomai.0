Message-ID: <4F6C35CA.8010506@domain.hid>
Date: Fri, 23 Mar 2012 09:35:22 +0100
From: Wolfgang Grandegger <wg@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-help] rt_pipe does not support POLLHUP on the Linux side
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai-help <xenomai@xenomai.org>

Hello,

while playing with rt_pipe, I realized that a select()/poll() function
does not unblock when the rt_pipe is deleted (via rt_pipe_delete) on the
other end. I think this is because the poll callback does not support
POLLHUP:

http://www.rts.uni-hannover.de/xenomai/lxr/source/ksrc/nucleus/pipe.c#1024

Is this by purpose? At least a blocking read() works as expected. It
does unblock and return 0 in that case.

Wolfgang.

