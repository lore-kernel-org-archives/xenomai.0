Message-ID: <4D74B024.5010008@domain.hid>
Date: Mon, 07 Mar 2011 11:15:00 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <AANLkTik2mjdhFGGedWVVT=itGeusDPE=QbDhZCC7oD_+@mail.gmail.com>
In-Reply-To: <AANLkTik2mjdhFGGedWVVT=itGeusDPE=QbDhZCC7oD_+@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Program hangs using "rt_task_sleep" in a
 particular way
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Jonathan ILIAS-PILLET <ismael@domain.hid>
Cc: armadeus-forum@domain.hid, xenomai@xenomai.org

Jonathan ILIAS-PILLET wrote:
> Hello,
> 
> We encounter a problem in a particular situation. In the attached
> source, when we change the value passed to rt_task_sleep (line 35), the
> program never returns.
> 
> This appears only with values greater or equal to 100000 (and maybe some
> other values between 10000 and 100000) and only when we use
> rt_task_sleep between the two rt_task_spawn calls.
> 
> Is there something we've done wrong ?
> 
> We use and Armadeus APF27 platform. I don't know if this behavior is
> related to this architecture, to Xenomai or both.

We do not know anything about your setup (except the platform). See:
http://www.xenomai.org/index.php/Request_for_information

It would also be interesting to know if you have root thread priority
coupling enabled.

In any case, your real-time tasks should never use all the cpu without
letting Linux run. The only way to guarantee the stability of the system
is by letting Linux run from time to time.

-- 
					    Gilles.

