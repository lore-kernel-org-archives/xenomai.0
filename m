Date: Mon, 4 Dec 2006 19:07:11 +0300
From: Anthony Sharobaiko <anthony@domain.hid>
Subject: Re: [Xenomai-help] Xenomai install problems
Message-ID: <20061204160711.GA8055@domain.hid>
References: <20061204133717.GA20186@domain.hid> <4574268C.7000705@domain.hid>
	<20061204143948.GA20411@domain.hid> <45743D46.8000502@domain.hid>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <45743D46.8000502@domain.hid>
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: xenomai@xenomai.org

On Mon, Dec 04, 2006 at 04:22:46PM +0100, Jan Kiszka wrote:
> You said you merged the patch for 2.6.15 on 2.6.16 and applied some
> hunks manually. Did you check that the merge is obviously not hiding any
> functional changes of the kernel?

Well, I looked through all places with fuzz > 1. Some of them were not
very clear to me, and when that test passed, I've decided I made them ok =)
I'll check them again and post (to adeos-main@ ?).

> Do you have a chance to test a 2.6.15 kernel as well to see if this works?

Unforunately, no. Vendor-specific patch is available only for 2.6.16.


-- 
	WBR, Anthony Sharobaiko.


