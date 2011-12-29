Message-ID: <4EFCA9DC.4060509@domain.hid>
Date: Thu, 29 Dec 2011 18:56:44 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <CA+eKTkZ_ymqXx_Nc_9v1HRtYTqSjYqzdN56HCjzO+x14zcUwcg@domain.hid>	<4ECA2FF8.7040406@domain.hid>	<CA+eKTkZuNknobLhsgqU8jjkKboL3jNLhMPoG82fkjD6sZfyXgA@mail.gmail.com>	<4ECA5E12.5040907@domain.hid>	<CAMesUR7edxnPvpLu0kajLWGtVBwK65m27kssOjh=JViVhPeXJQ@mail.gmail.com>	<4ECB967C.70509@domain.hid>	<CA+eKTkbcBYnoRnBZrrBQ-Br2h2HPrVdyVLs2V3F4WOvcvhpDxA@mail.gmail.com>	<CAMesUR6Jx7WuZNsY6WmomD-ExoJ9hhKovKiekrr71Kbrk7Jb_A@mail.gmail.com>	<4ECCB27F.3040903@domain.hid>	<CA+eKTkZp5M8OTHyLBBM=S5=5C-WaVrLgSsWOtzA1_y=z4ujTJw@domain.hid>	<CA+eKTkZFiMTFZe4jyhhD3b064bQDQMMcgVW+YMU5SJKeVnCiZA@mail.gmail.com>	<CA+eKTkbcuv6GkD1mwz_p++F7144fF3Eq0gisg69yAdH9KneD3w@domain.hid>	<4EEB4599.3030707@domain.hid>	<4EEB590A.2090108@domain.hid>	<4EEB5ABF.8020201@domain.hid>
	<CA+eKTkanSObCHedoDfLEJAJrpxB-8AoO_Q-RosTNykxOhqCM-A@mail.gmail.com>
In-Reply-To: <CA+eKTkanSObCHedoDfLEJAJrpxB-8AoO_Q-RosTNykxOhqCM-A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] [xenomai-help] Error return with a4l_sync_write
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Hadrien Caron <hadrien.caron@domain.hid>
Cc: xenomai@xenomai.org

On 12/29/2011 06:22 PM, Hadrien Caron wrote:
> Hello !
> 
> Sorry for the delay, I was out of town for the week.
> Hope you all had a nice christmas.
> Thanks for the input. In fact I am sorry but I didn't find what it means to
> compile with -fno-omit-frame-pointer
> 
> I found a SCHED_OMIT_FRAME_POINTER option in the kernel but it was already
> enabled so I doubt you were talking about that.
> 
> Is it an option to pass to the compiler ? I found -fomit-frame-pointer in
> the gcc manual . . . Should I modify xenomai's Makefile to add this option
> to the compilation ?
> 
> Thanks again ! And happy new year ;)

It is an option to pass to gcc (every time there is -ffoo there is also
the -fno-foo). You can pass additional flags to gcc using configure
CFLAGS variable.

Using for instance:
/path/to/xenomai/configure CFLAGS="-fno-omit-frame-pointer -g -O2"

-- 
                                                                Gilles.

