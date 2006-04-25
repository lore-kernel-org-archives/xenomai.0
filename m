Date: Tue, 25 Apr 2006 14:37:11 -0400
From: Kent Borg <kentborg@domain.hid>
Subject: Re: [Xenomai-help] syslog safe?
Message-ID: <20060425143711.E5934@domain.hid>
References: <20060425134048.D5934@domain.hid> <444E61F0.9000606@domain.hid>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <444E61F0.9000606@domain.hid>;
	from rpm@xenomai.org on Tue, Apr 25, 2006 at 07:52:48PM +0200
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai@xenomai.org

On Tue, Apr 25, 2006 at 07:52:48PM +0200, Philippe Gerum wrote:
> No problem using it, but it will trigger an automatic switch to 
> secondary mode in order to issue the right Linux syscalls. The thread 
> will switch back to primary automatically again as soon as a (usually 
> blocking) Xenomai syscall is issued.

And, looking at strace output, it appears that is a syslog() is too
low a priority to be logged it doesn't make a system call and so will
not drop us out of realtime.


Thanks,

-kb


