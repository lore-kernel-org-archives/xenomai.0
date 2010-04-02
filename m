Message-ID: <4BB5AA70.10203@domain.hid>
Date: Fri, 02 Apr 2010 10:27:28 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <20100401230843.GF3755@domain.hid>		<4BB53566.3010601@domain.hid>
	<4BB53643.2080604@domain.hid>	<j2yb88603c31004020058i3aae7947s1428f1b87f4b1097@domain.hid>
	<4BB5A57B.8070403@domain.hid>
In-Reply-To: <4BB5A57B.8070403@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] New scheduler class
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Henri Roosen <henriroosen@domain.hid>
Cc: xenomai@xenomai.org, Jan Kiszka <jan.kiszka@domain.hid>

Gilles Chanteperdrix wrote:
> Henri Roosen wrote:
>> We have the same requirement for which we also have no solution. One
>> of our threads has a configurable priority of which at the lowest
>> priority the thread should behave like an idle task that is only
>> scheduled when all xenomai threads are idle and also the Linux domain
>> is idle. The thread might use rtdm-drivers and xenomai mutexes and
>> therefore has to be moved to the Xenomai domain. But then it always
>> has higher priority than any threads scheduled in linux.

Ok. Got it. So what we want is that a thread with SCHED_IDLE priority is
less priority than a thread running with SCHED_OTHER scheduling policy.
Now, giving it a lower priority than other Linux thread probably
requires defining a new scheduling policy for Xenomai, yes.

-- 
					    Gilles.

