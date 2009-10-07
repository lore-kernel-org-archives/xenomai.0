Message-ID: <4ACC99FF.3040808@domain.hid>
Date: Wed, 07 Oct 2009 15:39:11 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <DIIE.000001A70000AC7D@192.168.2.103>
In-Reply-To: <DIIE.000001A70000AC7D@192.168.2.103>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Re-4:  rt_printf with daemonized task
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
> syslogd/klogd daemon is running correctly, it's used on the same
> system by a lot of other processes.

Did you try to check the return value of the syslog() syscall?

-- 
                                          Gilles


