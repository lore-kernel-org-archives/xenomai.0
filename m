From: oliver.schlenker@domain.hid
Date: Wed, 7 Oct 2009 13:37:18 +0000
Message-ID: <DIIE.000001A70000AC7D@192.168.2.103>
MIME-Version: 1.0
Content-Type: text/plain;
 charset="ISO-8859-1"
Content-Transfer-Encoding: 7Bit
Subject: [Xenomai-help] Re-4:  rt_printf with daemonized task
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: gilles.chanteperdrix@xenomai.org
Cc: xenomai@xenomai.org






Subject: Re: Re-2: [Xenomai-help] rt_printf with daemonized task (07-Okt-2009 15:16)
From:    Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
To:      oliver.schlenker@domain.hid

> oliver.schlenker@domain.hid wrote:
> > The syslog() call is not doing any output the syslog file, it doesn't 
> > matter
> > if the process is daemonized or not.
> 
> The syslog() syscall is handled by the syslogd daemon. So, you should
> check if the syslogd daemon is running and if it is correctly configured.
> 
> -- 
>                                           Gilles
> 

syslogd/klogd daemon is running correctly, it's used on the same system by a lot of other processes.


Oliver





To: gilles.chanteperdrix@xenomai.org
Cc: xenomai@xenomai.org



