From: Andreas Glatz <andreasglatz@domain.hid>
In-Reply-To: <DIIE.000001A80000AC7B@192.168.2.103>
References: <DIIE.000001A80000AC7B@192.168.2.103>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Wed, 07 Oct 2009 09:38:21 -0400
Message-Id: <1254922701.3718.35.camel@domain.hid>
Mime-Version: 1.0
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

Hi,

On Wed, 2009-10-07 at 13:13 +0000, oliver.schlenker@domain.hid
wrote:
> 
> 
> 
> After tracking down the issue a little bit further, it seems not to be a problem of daemonizing a server task,
> but to change a line of code in rtprint.c
> 
> What I would like to achieve :
> - My server process is setting up two Xenomai threads
> - Both Xenomai should report some messages with rt_printf()
> - rt_printf-function should write not to stdout or stderr but to the syslog
> 

FYI: That's how we tackled this problem:

We created a RT_PIPE object. Both threads are writing their messages to
the pipe. Together with the Xenomai application we have 'logger' 
running: 'logger -f /dev/rtpXX -t <your process name> &' which takes 
everything which gets written to RT_PIPE and sends it to the syslog
daemon. 

Andreas





