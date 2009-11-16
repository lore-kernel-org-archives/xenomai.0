From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <181804936ABC2349BE503168465576460CBA4A79@domain.hid>
References: <181804936ABC2349BE503168465576460CBA4A79@domain.hid>
Content-Type: text/plain; charset="UTF-8"
Date: Mon, 16 Nov 2009 18:11:51 +0100
Message-ID: <1258391511.2348.105.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Killing Xenomai task on kernel shutdown
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Steve Deiters <SteveDeiters@domain.hid>
Cc: xenomai@xenomai.org

On Mon, 2009-11-16 at 09:22 -0600, Steve Deiters wrote:
> Are Xenomai tasks supposed to outlive the kernel?  I have a Xenomai
> task that continues to run after the kernel is shut down.
>  

No provision is made to stop the real-time core upon shutdown, unless
the nucleus is compiled as a module and the Xenomai system gets
unloaded.

> I have a PowerPC board which has an external watchdog.  To keep this
> happy I have a periodic Xenomai task that I create early in the kernel
> startup with an initcall.  However, when the kernel shuts down I would
> like to stop/delete the task so that the watchdog will restart the
> processor.  Right now it seems that the task continues to run after
> kernel shutdown.  If nothing else I can just manually stop it on
> shutdown.
>  
> I'm not sure if there's a way to hook into the kernel shutdown.  I
> have found the exitcall macros, but they seem to be only used for
> module unloading and do not seem to be called on a regular shutdown.
> The initcall is in a board specific startup file.  If possible, I'd
> like to keep the task deletion also in the same file.  I just do not
> know if there is a hook available for this.

Linux provides one, see register_reboot_notifier().

>  
> Thanks.
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help


-- 
Philippe.



