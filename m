MIME-Version: 1.0
In-Reply-To: <20111003103914.8A2B636C@centrum.cz>
References: <20110926090226.9C75AD68@domain.hid>
	<20111003103914.8A2B636C@centrum.cz>
Date: Mon, 3 Oct 2011 04:48:49 -0400
Message-ID: <CAGc_wL1ERAj565_sfKAvKPxnXzBHwEfZVV+4RHMEmFmRqu5bkA@mail.gmail.com>
From: Julien Delange <julien.delange@domain.hid>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Xenomai-help] Frequency downscaling of new intel CPU
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai-help <xenomai@xenomai.org>

On Mon, Oct 3, 2011 at 4:39 AM, Petr Cervenka <grugh@domain.hid> wrote:
> Any ideas that could help me?

What about looking at /proc/cpuinfo while running your system ? If you
see that the speed is not the maximal, indeed, the frequency scaling
system changes the speed of the processor.

