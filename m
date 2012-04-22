Message-ID: <4F93CAF4.9050105@domain.hid>
Date: Sun, 22 Apr 2012 11:10:12 +0200
From: Wolfgang Grandegger <wg@domain.hid>
MIME-Version: 1.0
References: <mailman.0.1334997334.18156.xenomai@xenomai.org>
	<4F931496.1060607@domain.hid>
In-Reply-To: <4F931496.1060607@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] linux 2.6.11
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenophile <xenophile@domain.hid>
Cc: xenomai@xenomai.org

On 04/21/2012 10:12 PM, xenophile wrote:
> Hi,
> 
> I am trying to see why a trivial driver reading an ADC on an EP9312 ARM
> board has slowed by a factor of three. Since I installed it under 2.6.29
> a couple fo years ago.
> 
> It's looking like this is due to a kernel update I did in the mean time
> to 2.6.32
> 
> 
> I have just built a new toolchain and rebuilt the kernel to 2.6.33 and
> the result is about the same.
> 
> I recall a number of years ago running a 2.6.11 kernel and the system
> was incredibily responsive. I could be building kde-libs, downloading at
> full speed browsing and listening to mp3 decoded music all without the
> slightest lack of responsiveness in the browser not a glitch in the mp3
> playback.
> 
> It was truly impressive.
> 
> Now I find if I am rebuilding the toolchain , the browser or any other
> window can take over a second to respond to a redraw ( 2.6.32 on this
> machine).

What premption mode does the kernel use? CONFIG_PREEMPT should be enabled.

> Now I've seen comments on audio forums that there was nothing better
> than linux 2.6.11 for real time audio work. I'm wondering  whether there
> is not a general degradation in the linux kernel as time goes on.  It
> certainly seems to be getting forever bigger and slower.

Yes, there is definitively a degradation which will hurt especially
low-end systems. Just compare the size of the kernel. It's getting
bigger and bigger. Also the timer now runs at 250 Hz and there are many
more features, interfaces, etc.. You may regain some degradation by
optimizing the kernel configuration. On low-end systems, if it's an
option, choose a 2.4 kernel.

> Would there be any value in trying to rebuild a 2.6.11 based system for
> realtime work ?

Well, then I would prefer 2.4.x but for both Xenomai support (for your
board) is not available, I guess. But normally it's not an option as
people do want more recent kernel features and drivers.

But all this does not explain a factor of 3 with your driver. I doubt
that it's due to a move from 2.6.29 -> 2.6.32. Try using ftrace to find
out what's going on (if it's already available).

Wolfgang.

