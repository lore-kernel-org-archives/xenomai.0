Message-ID: <4777785F.2030903@domain.hid>
Date: Sun, 30 Dec 2007 11:52:15 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <4776D48E.7050002@domain.hid>
In-Reply-To: <4776D48E.7050002@domain.hid>
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Sender: Philippe Gerum <philippe.gerum@domain.hid>
Subject: Re: [Adeos-main] [PATCH 4/5] remove legacy code
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

Jan Kiszka wrote:
> This patch gets rid of code that is no longer needed or valid:
> 
>  - x86_64 APIC frequency is now delivered via ipipe_request_tickdev

Ack.

>  - __ipipe_tick_irq is maintained via ipipe_update_tick_evtdev also on
>    x86_64

Client RTOS may/do assume that timing is always delivered through the
local APIC timer on x86_64. We could merge that and allow the 8253 to be
used as the timer device, but this would not work in practice.

>  - global_clock_event is no longer needed by ipipe_32.c

Ack.

>  - ipipe_tune_timer was dead code in x86_64 (there was no prototype in
>    whatever header), and this arch does not really have a legacy code
>    base to maintain, so kill this function
> 

Ack.

-- 
Philippe.


