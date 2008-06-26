Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"
Date: Thu, 26 Jun 2008 12:03:40 +0200
From: "Karl Reichert" <Karl-Trampe@domain.hid>
Message-ID: <20080626100340.308320@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] Problems with Threads and RTnet
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: rtnet-users@domain.hid
Cc: xenomai@xenomai.org

> Karl Reichert wrote:
> > Hello list,
> > 
> > I have some problems with RTnet and threads. I create two thread via
> rt_task_spawn(), one is sending and one is receiving (non-blocking) frames
> over rtnet.
> > 
> > Each task is existed with return (I also tried rt_task_delete()) and the
> main-function is waiting for task-termination via rt_task_join().
> > 
> > When I run this program the first time, everything is fine. When I run
> it a second time without rebooting, I can't receive any more frames
> (returnvalue -1).
> > 
> > So it seems that the termination of the tasks and the main-function from
> the first run failed to free the "RTnet resources", too.
> > 
> > Any idea, what I'am doing wrong?
> 
> What version of Xenomai are you running ? Do not you get error messages 
> in the console ?
> 
> -- 
>                                                   Gilles.

I'm running Xenomai 2.4.3 with Rtnet 0.9.10

And sorry for the mistake, rt_dev_recv() returns with -110 which means "connection timeout". There might be some problems with the socket, but I don't have a clue, what's going on.

I do not get any error messages in console. Neither dmesg nor /var/log/sys reports an error.

Best regards,
Karl

-- 
von Karl Reichert


