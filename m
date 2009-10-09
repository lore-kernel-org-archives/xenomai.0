Message-ID: <4ACF3F5C.2020203@domain.hid>
Date: Fri, 09 Oct 2009 15:49:16 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <0000AD00.4ACF580B@192.168.2.103>
In-Reply-To: <0000AD00.4ACF580B@192.168.2.103>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] :: rt_printf with daemonized task
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: oliver.schlenker@domain.hid
Cc: jan.kiszka@domain.hid, xenomai@xenomai.org

oliver.schlenker@domain.hid wrote:
> +#define RT_PRINT_SYSLOG_STREAM	((FILE *)-9999)

-9999 may be a valid pointer. Only values between -4096 and 4095 can not
be valid pointers.

-- 
                                          Gilles


