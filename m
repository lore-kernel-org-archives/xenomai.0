Message-ID: <47B053A2.9010503@domain.hid>
Date: Mon, 11 Feb 2008 14:54:42 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <51CAD0CE1504444DBE77CBBE51A0135D376AD7@domain.hid>
In-Reply-To: <51CAD0CE1504444DBE77CBBE51A0135D376AD7@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] overhead
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Steven Seeger <sseeger@domain.hid>
Cc: xenomai@xenomai.org

Steven Seeger wrote:
> Is it normal for Xenomai to have significant overhead in userspace
> compared to older software running RTAI with all realtime threads in
> kernel modules? My application makes heavy use of inb/outb with iopl().

Significant overhead in user land can come from significant task
switches or a significant number of syscalls. But direct I/O should not
bite you. Any suspicious number of faults under /proc/xenomai/faults?

How did you measure the overhead in both systems?

Jan

-- 
Siemens AG, Corporate Technology, CT SE 2
Corporate Competence Center Embedded Linux

