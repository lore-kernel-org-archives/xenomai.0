Message-ID: <48612393.1090405@domain.hid>
Date: Tue, 24 Jun 2008 18:40:51 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <4861045E.4010106@domain.hid>
	<14a573dd7f3ed8e10e00a083480c4622@domain.hid>
In-Reply-To: <14a573dd7f3ed8e10e00a083480c4622@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] xenomai scheduler's ticks period
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: matthieu.connaulte_xenomai@domain.hid
Cc: Xenomai help <xenomai@xenomai.org>

Matthieu wrote:
> 
> On Tue, 24 Jun 2008 16:27:42 +0200, Gilles Chanteperdrix
> <gilles.chanteperdrix@xenomai.org> wrote:
>> Matthieu wrote:
>>> Let me know if I've done something wrong ...
>> rt_timer_read belongs to the native skin, not to the vxworks skin !
>>
>> --
>>                                                   Gilles.
> 
> Ok, but I don't really see why does mixing vxworks task with a xenomai
> instruction that not depends on vxworks scheduler is a problem. if I just
> get time, does the task switch to xenomai scheduler ?. However, if it's
> really a problem, what can I use to get a pricise time, as I can't use
> getTick anymore. Philippe suggested xntbase time base services ?

You can use rt_timer_read(), but you should not assume that this returns
a nanoseconds count, this depends on the timing configuration of the
native skin.

-- 
                                                 Gilles.

