From: "Sam Claassens" <sam@domain.hid>
Date: Wed, 17 Feb 2010 08:52:10 +0200
Message-ID: <000401caaf9d$bc9666a0$35c333e0$@com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Language: en-za
Subject: [Xenomai-help] FW: RT serial port (rt_dev_write()) question
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org

Hi,

Is there any reason you shouldn't rt_task_shadow() the main thread?

Regards,
Sam

-----Original Message-----
From: xenomai-help-bounces@domain.hid [mailto:xenomai-help-bounces@domain.hid] On
Behalf Of Dehann Fourie
Sent: 16 February 2010 09:24 PM
To: Jan Kiszka
Cc: xenomai@xenomai.org
Subject: Re: [Xenomai-help] RT serial port (rt_dev_write()) question

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

_______________________________________________
Xenomai-help mailing list
Xenomai-help@domain.hid
https://mail.gna.org/listinfo/xenomai-help


