Message-ID: <e39c9190707291316l237d572btd75f570d39ab75e@domain.hid>
Date: Sun, 29 Jul 2007 22:16:10 +0200
From: "juanba romance" <juanba.romance@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Subject: [Xenomai-help] RTDM driver hints
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org

Hello all, i am re-writing a old linux driver which i did myself some
time ago, cause i am in charge to provide a RT system framework. This
is one of the first steps so i have followed the RTDM model to do the
stuff.
Now i also have enough time to change its ugly capabilities/defects
but i am a little stuck right now..

I would like to improve my previous design fully buffering the
incoming user data flow on write method so a input FIFO it's planned.
The FIFO will be emptied using a rt-task created from the "open"
procedure and signalled from the "write" method before the user flow
exit. The point is:
where the FIFO handler references should be defined ?

I have take a look to the serial driver 16550 and my code is really
biased by its data device definition strategy ( obviously this is my
first RTDM monster ;-) and i need some guide ), instead of my
proposal, its design empty the TX FIFO from the IRQ service stuff
where the user context was passed as argument at the "open" call, so
all the parts are softly linked..

I would prefer to add the above program capability to avoid rewrite as
much as possible the current ISR symbol.
but i don't know the beast strategy to be applied to overcome the .

I have pass the "context" field dev_private area pointer to the
rt_task "by hand" but its value is really weird. Should this kind of
information be defined globally trough the "static" stuff and pass
this argument to the rt_task_init symbol

Any hints, advices.. ?
Thanks in advance

PD: Sorry about the brick..

