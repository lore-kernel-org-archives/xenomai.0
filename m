Message-ID: <4B7AEBEC.5000902@domain.hid>
Date: Tue, 16 Feb 2010 20:03:08 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <2b490f271002161033i3b9f3cf3xda2451fd4efae0c9@domain.hid>
In-Reply-To: <2b490f271002161033i3b9f3cf3xda2451fd4efae0c9@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] RT serial port (rt_dev_write()) question
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Dehann Fourie <dehann.fourie@domain.hid>
Cc: xenomai@xenomai.org

Dehann Fourie wrote:
> Hi,
> 
> Quick question. Can you write to a rt device (say "rtser0") from the
> main thread, ie not in a rt_task?

Short answer: Nope.

Longer version: You must call this service over a Linux task that was
shadowed for use with Xenomai. That can also be the main thread of some
application, though (check rt_task_shadow if use the native skin).

Jan

-- 
Siemens AG, Corporate Technology, CT T DE IT 1
Corporate Competence Center Embedded Linux

