References: <PH1P110MB10502A1DEB9D85DE57CD10ACE2A49@PH1P110MB1050.NAMP110.PROD.OUTLOOK.COM>
From: Philippe Gerum <rpm@xenomai.org>
Subject: Re: Track down in-band switches
Date: Wed, 08 Jun 2022 08:50:36 +0200
In-reply-to: <PH1P110MB10502A1DEB9D85DE57CD10ACE2A49@PH1P110MB1050.NAMP110.PROD.OUTLOOK.COM>
Message-ID: <87o7z3ws8m.fsf@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Russell Johnson <russell.johnson@kratosdefense.com>
Cc: xenomai@xenomai.org


Russell Johnson via Xenomai <xenomai@xenomai.org> writes:

> Hello,
>
>  
>
> I am currently working on porting my realtime threads in my app to EVL. I am
> using "evl ps -l" to track whether or not there are any in-band switches on
> my EVL threads. Is there any recommended tool or method for tracking down
> what specifically is causing the in-band switches on an EVL thread? 
>

There are two additional options provided by the health monitoring
interface [1], both enabled with [2]:

- using the legacy signal-based method (T_HMSIG), which sends SIGDEBUG
  (a Xenomai alias to SIGXCPU) to the thread which switches in-band,
  with the cause for switch available from the siginfo data.

- using the 'observable' interface of any EVL thread (T_HMOBS) to
  receive message-based notifications instead of signals. In this case,
  a thread can observe other threads, i.e. receive those
  notifications. [4] is a simple test which illustrates how to use this
  interface.

[1] https://evlproject.org/core/user-api/thread/#health-monitoring
[2] https://evlproject.org/core/user-api/thread/#evl_set_thread_mode
[3] https://evlproject.org/core/user-api/observable/#observable-thread
[4] https://source.denx.de/Xenomai/xenomai4/libevl/-/blob/master/tests/observable-hm.c

-- 
Philippe.

