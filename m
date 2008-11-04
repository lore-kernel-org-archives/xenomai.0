Message-ID: <49108663.4060202@domain.hid>
Date: Tue, 04 Nov 2008 18:29:07 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <20081030094458.GA13464@domain.hid>
	<20081104132227.GA25486@domain.hid>
In-Reply-To: <20081104132227.GA25486@domain.hid>
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] RTDM driver hangs
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Juan Antonio Garcia Redondo <juan-antonio.garcia@domain.hid>
Cc: jagredondo@domain.hid, xenomai@xenomai.org

Juan Antonio Garcia Redondo wrote:
> Hi all,
> 
> I've been invetigating further the problem and I've found that the
> crash occurs in the following situation (now just one process using a
> rtdm driver):
> 
> o A real time process call to rtdm_ioctl function.
> o The rtdm_ioctl function blocks at rtdm_task_sleep (or any other blocking
> system call).
> o Arrive a signal which switch the process to executable state. The
> blocking system call returns -EINTR.
> o Whithout exit the RTDM driver, call to another blocking system call
> (rtdm_task_timedwait for instance). This system call returns -EINTR and the
> rtdm_ioctl function retuns -EINTR.

This is most probably the primary error: You should return to userspace
quickly, without further blocking, if a signal is pending.

However, the following crash is not OK. Maybe some code path lacks a
robustness check, maybe something more seriously is broken. Will try to
debug this with your test once time permits.

Thanks for reporting,
Jan

-- 
Siemens AG, Corporate Technology, CT SE 2 ES-OS
Corporate Competence Center Embedded Linux

