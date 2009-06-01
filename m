Message-ID: <4A23D8C7.4020208@domain.hid>
Date: Mon, 01 Jun 2009 15:33:59 +0200
From: Antoine Nourry <nourry@domain.hid>
MIME-Version: 1.0
References: <4A157FD9.40106@domain.hid> <4A23B35E.7010005@domain.hid>
In-Reply-To: <4A23B35E.7010005@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] About HARD real time... and USB
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
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>


> The current roadmap is to let Xenomai 3 come in two flavors: one based
> on PREEMPT-RT (Xenomai/Solo), the other (Xenomai/Duo) using Adeos/I-pipe
> and a second scheduler like Xenomai 2 does, but supporting much less
> legacy than the latter (no kernel 2.4, no in-kernel RT applications
> etc.). So depending on your requirements and PREEMPT-RT's progress,
> you'll be able to chose the fitting platform or even switch between them
> without too much effort.
>
> Jan
>
>   
Thanks again Jan.

Another point; for RT USB developers, do you think we could use Linux 
native USB stack with PREEMPT_RT in the same way as Xenomai / USB4RT ?

I'm pleased with this last solution but the USB4RT bug (need to send a 
command twice) is a real problem for performances (i'd like to increase 
my acquisition rate within a fixed cycle). My only approach to real time 
for the moment is USB driver, and in the Open world i cannot find what 
could be the "right" or "best" solution...




