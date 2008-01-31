Message-ID: <2ff1a98a0801310126m4487d52an51a8f5df0ee1a60c@domain.hid>
Date: Thu, 31 Jan 2008 10:26:23 +0100
From: "Gilles Chanteperdrix" <gilles.chanteperdrix@xenomai.org>
In-Reply-To: <8b3b30860801310010w2234d82ds4c78205b308a0c05@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <8b3b30860712271756n526daf67yc8e5be203ae5421d@domain.hid>
	<8b3b30860712301217p6ee4e724lebd1b1c2740d2ebf@domain.hid>
	<2ff1a98a0712310616n58d0a63en4c36e75e5ed2ab53@domain.hid>
	<8b3b30860712310658n4729fc2bo300f01a59b333b06@domain.hid>
	<2ff1a98a0712310704s65b6d7fbv106c7a4bd17d4677@domain.hid>
	<8b3b30860712310723y39bae134o8bcefbd16f582541@domain.hid>
	<2ff1a98a0801230610t366862dbmcb36ff9fb50604c4@domain.hid>
	<8b3b30860801290115m197afc80p3ee98cb42bea334f@domain.hid>
	<2ff1a98a0801290705g54e4d98alfc11990d8098e33e@domain.hid>
	<8b3b30860801310010w2234d82ds4c78205b308a0c05@domain.hid>
Subject: Re: [Xenomai-help] update from fusion 0.9.1 to xenomai 2.4.0
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Racconico Lambrati <racconico.lambrati@domain.hid>
Cc: xenomai-help <xenomai@xenomai.org>

On Thu, Jan 31, 2008 at 9:10 AM, Racconico Lambrati
<racconico.lambrati@domain.hid> wrote:
> I've make a more clever test program (I hope).
>
> The scheduler work fine but there is some other problem
>
> First of all I've reduced the working time into the two task (to avoid
> deadlock as you suggested). I also insert the code that in corresponding of
> the two task high a bit on the parallel port.
>  Then I use the oscilloscope to test that every 5 milliseconds the TaskPlc
> start it's execution. In normal condition there's no problem, but when I
> make a write on the disk, or I mount an external device the time of High
> priority task increase in considerable  manner.
>
> I cannot explain this situation, that is not respecting the priority of the
> task...

Setting the task mode to primary mode before calling
rt_task_wait_period is just wasting time for a useless syscall:
rt_task_wait_period already migrates the calling task to primary mode.

-- 
                                               Gilles Chanteperdrix

