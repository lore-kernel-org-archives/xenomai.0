Message-ID: <4B67EE95.9090509@domain.hid>
Date: Tue, 02 Feb 2010 10:21:25 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <b88603c31001260616wf2194d3t193de281af1318ad@domain.hid>	
	<4B675733.3040902@domain.hid> <4B676938.4070805@domain.hid>
	<b88603c31002020118n20fd45ddqc723221174a48691@domain.hid>
In-Reply-To: <b88603c31002020118n20fd45ddqc723221174a48691@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Xenomai 2.5.0: rt_task_shadow fails when
 libnative is statically linked.
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
Cc: xenomai@xenomai.org

Henri Roosen wrote:
> I can confirm this works for me too.
> 
> But aren't there any reasons to declare those functions with the
> 'weak' attribute?

The weak attribute is a directive to the linker or the loader, so, we do
not need it when we declare things, only when we define them.

-- 
					    Gilles.

