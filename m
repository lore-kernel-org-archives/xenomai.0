Date: Mon, 13 Nov 2006 15:37:16 +0100 (CET)
From: Klaas Gadeyne <klaas.gadeyne@domain.hid>
Subject: Re: [Xenomai-help] [ANNOUNCE] Orocos Real-Time Toolkit 1.0
In-Reply-To: <200611131419.37071.peter.soetens@domain.hid>
Message-ID: <Pine.LNX.4.64.0611131532450.8135@domain.hid>
References: <200611131055.00633.peter.soetens@domain.hid>
	<45586AF7.9030504@domain.hid>
	<200611131419.37071.peter.soetens@domain.hid>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Peter Soetens <peter.soetens@domain.hid>
Cc: Xenomai-help@domain.hid, jan.kiszka@domain.hid

>> What is
>> the status of driver support? And were you able to collect any practical
>> experience on larger setups over Xenomai already?
>
> The components which address hardware were written for RTAI/LXRT some years
> ago. We're building up experience with the RTDM and a port is a matter of
> time, although that is in the hands of our friends at the university (which
> have said hardware).

>From my point of view, the only reason why most of the existing (and
some of the new) applications have not being converted to xenomai is
the fact that most applications make extensive use of comedi (in
real-time, that is).  We are thus eagerly awaiting comedi-over-rtdm,
but time lacks to help speed up the development ourselves :-(

regards,

Klaas


