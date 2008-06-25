Message-ID: <48626A92.70409@domain.hid>
Date: Wed, 25 Jun 2008 17:56:02 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <20080625154936.18590@domain.hid>
In-Reply-To: <20080625154936.18590@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
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
To: Karl Reichert <Karl-Trampe@domain.hid>
Cc: xenomai@xenomai.org

Karl Reichert wrote:
> Hello list,
> 
> I have some problems with RTnet and threads. I create two thread via rt_task_spawn(), one is sending and one is receiving (non-blocking) frames over rtnet.
> 
> Each task is existed with return (I also tried rt_task_delete()) and the main-function is waiting for task-termination via rt_task_join().
> 
> When I run this program the first time, everything is fine. When I run it a second time without rebooting, I can't receive any more frames (returnvalue -1).
> 
> So it seems that the termination of the tasks and the main-function from the first run failed to free the "RTnet resources", too.
> 
> Any idea, what I'am doing wrong?

What version of Xenomai are you running ? Do not you get error messages 
in the console ?

-- 
                                                  Gilles.

