Subject: Re: xnsched_kick
References: <CAK6DXL2H4OuDGehPaHwDtArtg=Y2H+xs6eC49_9NueYPtxRCHA@mail.gmail.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <07f12d49-24fd-cc02-c5c6-143102e1c30f@siemens.com>
Date: Fri, 21 May 2021 13:47:55 +0200
MIME-Version: 1.0
In-Reply-To: <CAK6DXL2H4OuDGehPaHwDtArtg=Y2H+xs6eC49_9NueYPtxRCHA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Marco Barletta <barlettamarco8@gmail.com>, xenomai@xenomai.org, Philippe Gerum <rpm@xenomai.org>

On 21.05.21 13:21, Marco Barletta via Xenomai wrote:
> Hi everyone, related to the sched_quota patch I posted about one week ago.
> I'm trying to understand why xnsched_kick is needed, in which situation is
> called. Reading the code it seems it's called when there's a xeno thread
> that must be downgraded and scheduled in Linux, but I didn't understand why
> there's the need to run to complention without respecting group budget. Can
> you help me?

I think that is a valid question because sched-tp does not implement
such a scheme. Basic information can be found in

https://source.denx.de/Xenomai/xenomai/-/commit/cee27b2945f92857308dcde619a3e64607b5327e

I would forward this for further background to the designer...

Jan

-- 
Siemens AG, T RDA IOT
Corporate Competence Center Embedded Linux

