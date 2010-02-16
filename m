MIME-Version: 1.0
In-Reply-To: <4B7AEBEC.5000902@domain.hid>
References: <2b490f271002161033i3b9f3cf3xda2451fd4efae0c9@domain.hid>
	<4B7AEBEC.5000902@domain.hid>
Date: Tue, 16 Feb 2010 21:23:31 +0200
Message-ID: <2b490f271002161123h5f8f4c85i25ce1516c82ed96b@domain.hid>
From: Dehann Fourie <dehann.fourie@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
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
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: xenomai@xenomai.org

Thanks, explains alot.

Regards,
Dehann

On Tue, Feb 16, 2010 at 9:03 PM, Jan Kiszka <jan.kiszka@domain.hid> wrote:
> Dehann Fourie wrote:
>> Hi,
>>
>> Quick question. Can you write to a rt device (say "rtser0") from the
>> main thread, ie not in a rt_task?
>
> Short answer: Nope.
>
> Longer version: You must call this service over a Linux task that was
> shadowed for use with Xenomai. That can also be the main thread of some
> application, though (check rt_task_shadow if use the native skin).
>
> Jan
>
> --
> Siemens AG, Corporate Technology, CT T DE IT 1
> Corporate Competence Center Embedded Linux
>



-- 
Dehann Fourie

