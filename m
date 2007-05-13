From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <4646E606.8050505@domain.hid>
References: <4646E606.8050505@domain.hid>
Content-Type: text/plain
Date: Sun, 13 May 2007 15:02:09 +0200
Message-Id: <1179061329.28847.0.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: Philippe Gerum <philippe.gerum@domain.hid>
Subject: Re: [Adeos-main] [PATCH] cleanup legacy sched hacks
Reply-To: rpm@xenomai.org
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: adeos-main <adeos-main@gna.org>

On Sun, 2007-05-13 at 12:18 +0200, Jan Kiszka wrote:
> I don't think we need those two legacy hacks anymore as we killed
> preempt_disable/enable calls over non-root domain. I converted them
> into context checks and got no warnings so far.

Merged, thanks.

-- 
Philippe.



