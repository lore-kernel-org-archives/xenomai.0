Message-ID: <4AFA8197.7070005@domain.hid>
Date: Wed, 11 Nov 2009 10:19:19 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <200911111422.11402.anisha.kaul@domain.hid>
In-Reply-To: <200911111422.11402.anisha.kaul@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] unable to open serial port from a kernel module
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Anisha Kaul <anisha.kaul@domain.hid>
Cc: xenomai@xenomai.org

Anisha Kaul wrote:
> hi,
> 
> when i use rt_dev_open ("/dev/ttyS0", 0); from the function init_module () of 
> a self written kernel module, it returns -19 ! What must be the reason, can't 
> a file be opened from a kernel module ?

Please read documentation and examples more carefully: "rtdev0" is the
answer.

Jan

-- 
Siemens AG, Corporate Technology, CT SE 2
Corporate Competence Center Embedded Linux

