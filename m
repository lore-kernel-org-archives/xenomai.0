From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <E5E9C6CC7DC8844A8DA7A9EFE7B5350E016387F8@domain.hid>
References: <E5E9C6CC7DC8844A8DA7A9EFE7B5350E016387F8@domain.hid>
Content-Type: text/plain
Date: Thu, 18 Oct 2007 15:27:22 +0200
Message-Id: <1192714042.5884.20.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: Philippe Gerum <philippe.gerum@domain.hid>
Subject: Re: [Xenomai-help] xnpod_announce_tick when migrating from 2.3
	to	2.4
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
To: Thomas Necker <thomas.necker@domain.hid>
Cc: xenomai@xenomai.org

On Thu, 2007-10-18 at 14:11 +0200, Thomas Necker wrote:
> Hello
> 
> I'm trying to migrate our software from 2.3 to 2.4 and I'm struggling
> with the new timebase concept.
> Here is how it works in 2.3:
> - I have a small kernel module that calls xnpod_stop_timer and then
> xnpod_start_timer with a handling function of my own.
> - This handling function does some housekeeping and then calls
> xnpod_announce_tick to trigger the nucleus (and eventually the pSOS
> skin).
> This is basically what Philippe suggested about a year ago.
> Now, all these functions are gone in 2.4, how's the best way to do
> something similar now?
> I couldn't figure out how the new timebase concept can be used for that.
> Thanks in advance.
> 

It's actually much simpler with 2.4. You may install a hook into the
periodic tick handler by calling the following helper, somewhere in your
module init code:

	xntbase_set_hook(psos_tbase, your_psos_hook);

The only difference compared to your current approach is that Xenomai
will have processed the incoming tick before calling your hook, so you
don't need to forward the tick anymore. Sidenote: this only works with
periodic timebases so far.

You may want to have a look at the VxWorks skin (sysLib.c), which
interposes on the global tick this way.

> Regards,
> Thomas
> 
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help
-- 
Philippe.



