Subject: Re: [Xenomai-help] Linux + PREEMPT_RT + LTTng + Xenomai
From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <200609111418.25324.Serge.Noiraud@domain.hid>
References: <200609071445.53611.Serge.Noiraud@domain.hid>
	<4500182A.6000009@domain.hid> <200609111418.25324.Serge.Noiraud@domain.hid>
Content-Type: text/plain
Date: Mon, 11 Sep 2006 18:31:48 +0200
Message-Id: <1157992308.4991.34.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
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
To: Serge Noiraud <serge.noiraud@domain.hid>
Cc: xenomai@xenomai.org

On Mon, 2006-09-11 at 14:18 +0200, Serge Noiraud wrote:

[...]

> I would like Xenomai manage IRQs for some specific cards.
> The others could be managed by linux-rt.
> If I understand correctly how it works, I must rewrite my drivers. is it correct ?
> 

"Adapt" them would be more appropriate. Xenomai's RTDM layer usually
makes this quite straightforward.

-- 
Philippe.



