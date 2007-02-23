Subject: Re: [Xenomai-core] [PATCH] Catch HPET conflict
From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <45DB66B4.6050700@domain.hid>
References: <45DB66B4.6050700@domain.hid>
Content-Type: text/plain
Date: Fri, 23 Feb 2007 19:57:49 +0100
Message-Id: <1172257069.26738.102.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: Philippe Gerum <philippe.gerum@domain.hid>
Reply-To: rpm@xenomai.org
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: xenomai-core <xenomai@xenomai.org>

On Tue, 2007-02-20 at 22:23 +0100, Jan Kiszka wrote:
> As long as there is obviously a conflict, catch it during kernel
> configuration and urge the user to disable CONFIG_HPET_TIMER.
> 

Applied, thanks.

-- 
Philippe.



