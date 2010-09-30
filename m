Message-ID: <4CA490C8.9040901@domain.hid>
Date: Thu, 30 Sep 2010 15:29:44 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <j2yb88603c31004020058i3aae7947s1428f1b87f4b1097@domain.hid>	<4BB5B64B.6040803@domain.hid>
	<4BB5B7C1.4020301@domain.hid>	<4BB5B874.5090904@domain.hid>	<k2pb88603c31004020232z28e10d59vc546b1b8803113f2@domain.hid>	<4BB5BA2D.1080604@domain.hid>	<245373446233674495BCA5CA2FC1EB17378D015932@domain.hid>	<4BBAD880.5040603@domain.hid>	<20100415001912.GB26116@domain.hid>	<1271322120.2365.605.camel@domain.hid>	<20100420141227.GB9203@domain.hid>	<1272020058.9515.753.camel@domain.hid>
	<AANLkTi=0WtJnPrX1GX-Hd+erzABbNPVP=o5zr4-4=p5Q@mail.gmail.com>
In-Reply-To: <AANLkTi=0WtJnPrX1GX-Hd+erzABbNPVP=o5zr4-4=p5Q@mail.gmail.com>
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
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>, Jan Kiszka <jan.kiszka@domain.hid>

Henri Roosen wrote:
> On Fri, Apr 23, 2010 at 12:54 PM, Philippe Gerum <rpm@xenomai.org> wrote:
>> On Tue, 2010-04-20 at 10:12 -0400, Andreas Glatz wrote:
>>> Just one more questions: Philippe said that you have something similar in
>>> 2.5. How do you enable it there? By setting the correct sheduling policy?
>>>
>> There are plans to have it. That behavior would be enabled whenever the
>> linux policy is SCHED_OTHER, and the base priority is 0 Xenomai-wise.
>> The latter would be enough for now, but it seems more future-proof not
>> to assume that only SCHED_OTHER tasks could be assigned Xenomai priority
>> 0.
>>
> 
> Is there any update on the plans to have Xenomai base priority 0
> threads to be operating by default in relaxed mode? We are using 2.5.4
> and currently apply the patch below as a workaround. The patch is
> similar to the 2.4 patch of Andreas in that it actively switches back
> base prio 0 shadowed threads into relaxed mode, but doesn't take any
> held locks into account.
> 
> Please comment on this patch. If there is any preliminary code for
> 2.5.x available regarding this functionality I'll be happy to test it
> ;-)

The implementation for this feature needs breaking the ABI, so it will
never be done in 2.5 branch. Fortunately, the 2.6 branch development is
almost started, to fix this issue, as well as a few other ones.

-- 
					    Gilles.

