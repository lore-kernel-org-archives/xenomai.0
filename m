MIME-Version: 1.0
Sender: jhnphm@gmail.com
In-Reply-To: <32348a0f3aab4463894a5a65efe02ab8@BLUPRD0113HT002.prod.exchangelabs.com>
References: <201302141227.05428.paul_c@tuxcnc.org>
	<51229E79.7030607@xenomai.org>
	<loom.20130702T010738-643@post.gmane.org>
	<32348a0f3aab4463894a5a65efe02ab8@BLUPRD0113HT002.prod.exchangelabs.com>
From: John Pham <jpham4@gmu.edu>
Date: Mon, 8 Jul 2013 18:59:29 -0400
Message-ID: <CAOfKkXF3x7wMhpW3HHXCtLt+MuhsF4evD0sZHGjD0oUzmaMwHg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Xenomai] Xenomai, Raspberry Pi, 3.5.7 kernel
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Paul <paul_c@tuxcnc.org>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

Hi,

They seem to apply and the compiled kernel boots and apparently runs
correctly, although I haven't run any xenomai applications on it. I'll
post if any problems come up. Thanks!


On Thu, Jul 4, 2013 at 7:14 AM, Paul <paul_c@tuxcnc.org> wrote:
> On Tuesday 02 July 2013, John Pham wrote:
>> I've run into problems compiling the kernel with the above patch from
>> git when sound drivers are enabled. It looks like some DMA code from
>> commit
>> https://github.com/torvalds/linux/commit/64ccc9c033c6089b2d426dad3c56
>>477ab066c999 was missing. I've added them in the patch inlined below
>> (to be applied after Paul's patch).
>>
>> Thanks for the work with getting Xenomai on the Pi! :)
>
> Sound has never been a high priority for me, so I don't generally enable
> the drivers - Hence the reason I missed this... That said, got a "real
> time" voice recognition project surfacing at work.
>
> Could you try the two attached patches - These are intended for
> the "official" Rasperry Pi kernel from
> https://github.com/raspberrypi/linux (rpi-3.8.y branch). Apply the
> *-pre.patch, followed by the ipipe-core.patch, and finish with the
> *-post.patch - Any failed hunks or other issues, let me know and I'll
> take a look when time allows.
>
>
> Regards, Paul.
>
>
>
>
>

