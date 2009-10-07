Message-ID: <4ACC94B7.9040506@domain.hid>
Date: Wed, 07 Oct 2009 15:16:39 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <DIIE.000001A80000AC7B@192.168.2.103>
In-Reply-To: <DIIE.000001A80000AC7B@192.168.2.103>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Re-2:  rt_printf with daemonized task
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
Cc: xenomai@xenomai.org

oliver.schlenker@domain.hid wrote:
> The syslog() call is not doing any output the syslog file, it doesn't matter
> if the process is daemonized or not.

The syslog() syscall is handled by the syslogd daemon. So, you should
check if the syslogd daemon is running and if it is correctly configured.

-- 
                                          Gilles


