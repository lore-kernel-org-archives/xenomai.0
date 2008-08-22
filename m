Message-ID: <48AF1FFF.7050906@domain.hid>
Date: Fri, 22 Aug 2008 22:22:23 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <406CC9939904F143B9D42CEEA3E56E563AC067@domain.hid>	<48918FF9.6030804@domain.hid>
	<406CC9939904F143B9D42CEEA3E56E563AC08E@oab1mx1.oneaccess.intra>
	<489194FD.8000004@domain.hid>
	<406CC9939904F143B9D42CEEA3E56E563AC093@domain.hid>
	<4891D5A3.1060004@domain.hid>
	<406CC9939904F143B9D42CEEA3E56E563EE103@domain.hid>
	<4891DEBC.2050400@domain.hid>
	<406CC9939904F143B9D42CEEA3E56E563EE1D6@domain.hid>
In-Reply-To: <406CC9939904F143B9D42CEEA3E56E563EE1D6@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] xnpipe EPOLLIN starvation
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
To: Filip Van Rillaer <Filip.VanRillaer@domain.hid>
Cc: xenomai@xenomai.org

Filip Van Rillaer wrote:
> Hello Philippe,
> 
> FYI: As I was not 100% sure that the EPOLLET of a read on a fd didn't
> impact the write on the same fd, I just made a new version of xenopipe
> (still with epoll) with separate filedescriptors for read and write in
> the epoll_ctl.   So epoll_wait has 4 entries : fd_tty1_read,
> fd_tty1_write, fd_pipe_read, fd_pipe_write ... but the problem remains.
> 
> To be able to open a pipe (e.g. /dev/rtp1) once as O_WRONLY and once as
> O_RDONLY, I had to hack the pipe-code.  It would be nice if this would
> be possible without hacking the code.
>

You may want to retry using epoll() with the latest updates committed.

> Best regards,
> Filip
> 
> 


-- 
Philippe.

