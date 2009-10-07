Message-ID: <4ACC9C6F.5070601@domain.hid>
Date: Wed, 07 Oct 2009 15:49:35 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <DIIE.000001A60000AC7F@192.168.2.103>
In-Reply-To: <DIIE.000001A60000AC7F@192.168.2.103>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [Xenomai-help] Re-6:  rt_printf with daemonized task
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
> 
> 
> in the glibc documentation it's specified as a void function :
> 
> 18.2.2 syslog, vsyslog
> 
> The symbols referred to in this section are declared in the file syslog.h.
> — Function: void syslog (int facility_priority, char *format, ...)

So, the first argument is a format string? You should pass "%s" followed
by head->text then, not head->text directly. If head->text contains the
% characters, you will get errors. I do not think fixing this will fix
your issues though.

I have no idea why it fails. Did you try to put a printf as well as the
syslog call to check whether syslog is really called? Are you 100% sure
that you do not close file descriptors when daemonizing your process?


-- 
                                          Gilles


