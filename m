Date: Fri, 22 Feb 2008 08:31:06 -0500
References: <200802202358.25792.ngustavson@domain.hid>
	<200802212145.31122.ngustavson@domain.hid>
	<47BE8E0E.7060104@domain.hid>
In-Reply-To: <47BE8E0E.7060104@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200802220831.06639.ngustavson@domain.hid>
From: NZG <metalninjadragon@domain.hid>
Subject: Re: [Xenomai-help] writing from user space through fifo problems
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: rpm@xenomai.org
Cc: Jan Kiszka <jan.kiszka@domain.hid>, xenomai@xenomai.org

On Friday 22 February 2008 3:55:42 am Philippe Gerum wrote:
> O_SYNC support has to be implemented by the driver, and Xenomai
> implements this for the pipe driver since 2.4-rc1. Therefore, passing
> O_SYNC to open() using 2.3.1 will just lead to a nop.
Ah, well then first thing to try is to just upgrade Xenomai.
I'll give it a shot, 

thanks for confirming this,
NZG



