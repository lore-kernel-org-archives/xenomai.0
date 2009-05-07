From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <24870972-4150-4835-9564-0ED960A6FD44@domain.hid>
References: <24870972-4150-4835-9564-0ED960A6FD44@domain.hid>
Content-Type: text/plain
Date: Thu, 07 May 2009 18:45:13 +0200
Message-Id: <1241714713.26544.735.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Desktop randomly freezes after install of
 Xenomai 2.4.7
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: John Yamokoski <yamokosk@domain.hid>
Cc: xenomai@xenomai.org, adeos-main <adeos-main@gna.org>

On Thu, 2009-05-07 at 12:36 -0400, John Yamokoski wrote:
> Since my freezing problems may not be related to other people's  
> freezing problems I have started a new thread.
> 
> I compiled/installed/ran kernel 2.6.28.7 using the standard install  
> procedure for Xenomai 2.4.7. I have not yet compiled and installed the  
> xenomai user libraries nor am I running any custom code which is  
> making real-time calls. The desktop just seems to freeze at very  
> random times. Can happen when the desktop is just beginning to  
> populate or much later after the desktop has been running for several  
> minutes. I tried to catch some diagnostic information using netconsole  
> but I don't get any messages when the computer freezes. Attached are a  
> netconsole dump as well as my .config from the kernel compile.

... and also disable HPET and X86_PM_TIMER from your configuration. This
is a known pending bug.

> 
> _______________________________________________ Xenomai-help mailing list Xenomai-help@domain.hid https://mail.gna.org/listinfo/xenomai-help
-- 
Philippe.



