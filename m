Message-ID: <44047AC6.907@domain.hid>
Date: Tue, 28 Feb 2006 17:31:02 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] Page faults
References: <fd6a47a90602280622o4cfb2b79g@domain.hid>
In-Reply-To: <fd6a47a90602280622o4cfb2b79g@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Jeroen Van den Keybus <jeroen.vandenkeybus@domain.hid>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

Jeroen Van den Keybus wrote:
> I'm observing a considerable amount of Page Faults (5090 after an hour 
> or so), each one associated with a MSW increase in /proc/xenomai/stat. 
> I'm missing RT deadlines on those occasions and I want to fix it, so I 
> would like to know what Page Faults actually are.
>  

Since page faults cause mode switches as you observed, you might want to try using 
a built-in feature that sends a SIGXCPU signal to a task going back to the Linux 
domain (e.g. typically relaxing to process a fault). The way to do this is as follows:

- set the T_WARNSW bit for your task using the rt_task_set_mode() call. Something 
like rt_task_set_mode(0,T_WARNSW,NULL) would do.

- code a Linux signal handler, and register it for receiving SIGXCPU.

The signal is always sent on behalf of the relaxing task, so you just need to 
inspect the backtrace to discover the cause of the mode switch by analysing the 
inner frames. You may either use GDB and set a breakpoint in the handler, or play 
with the backtrace_*() routines available from the glibc.

ksrc/skins/native/snippets/sigxcpu.c gives an example of such use.

>  
> Jeroen.
> 
> 
> ------------------------------------------------------------------------
> 
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help


-- 

Philippe.

