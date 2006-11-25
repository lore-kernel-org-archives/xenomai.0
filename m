Subject: Re: Aw: Re: Aw: Re: [Xenomai-help] Strange SIGXCPU signal at
From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <24272255.1164380283049.JavaMail.ngmail@domain.hid>
References: <1164379061.4973.65.camel@domain.hid> <1164377274.4973.62.camel@domain.hid>
	<29451992.1164376099993.JavaMail.ngmail@domain.hid>
	<29192885.1164378650832.JavaMail.ngmail@domain.hid>
	<24272255.1164380283049.JavaMail.ngmail@domain.hid>
Content-Type: text/plain
Date: Sat, 25 Nov 2006 18:03:25 +0100
Message-Id: <1164474205.4973.120.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
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
To: "M. Koehrer" <mathias_koehrer@domain.hid>
Cc: xenomai@xenomai.org

On Fri, 2006-11-24 at 15:58 +0100, M. Koehrer wrote:
> HI Philippe, 
> 
> > > unfortunately this patch did not help.
> > > It is the same situation as before.
> > > 
> > 
> > Mm, ok, thanks for trying this out. Is T_WARNSW passed to
> > rt_task_create() in your case?
> No, I pass T_FPU | T_CPU(0)
> 
> Well, I have decided to restructure the application to create the tasks
> only once during lifetime (which has some other benefits as well).
> That means, that this issue hopefully will no longer hurt...

Ok; still, I'd like to figure out what's been going on since this might
hide a problem.

Do you invoke rt_task_set_mode() from any context before the issue
starts showing up?

> 
> Thanks a lot
> 
> Mathias
> 
-- 
Philippe.



