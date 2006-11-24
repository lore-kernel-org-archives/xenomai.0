Subject: Re: Aw: Re: [Xenomai-help] Strange SIGXCPU signal at
	rt_task_trampoline
From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <29192885.1164378650832.JavaMail.ngmail@domain.hid>
References: <1164377274.4973.62.camel@domain.hid>
	<29451992.1164376099993.JavaMail.ngmail@domain.hid>
	<29192885.1164378650832.JavaMail.ngmail@domain.hid>
Content-Type: text/plain
Date: Fri, 24 Nov 2006 15:37:41 +0100
Message-Id: <1164379061.4973.65.camel@domain.hid>
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

On Fri, 2006-11-24 at 15:30 +0100, M. Koehrer wrote:
> Hi Philippe,
> 
> unfortunately this patch did not help.
> It is the same situation as before.
> 

Mm, ok, thanks for trying this out. Is T_WARNSW passed to
rt_task_create() in your case?

-- 
Philippe.



