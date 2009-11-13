Message-ID: <4AFD4C7F.1000106@domain.hid>
Date: Fri, 13 Nov 2009 13:09:35 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <4AFD01D3.1070604@domain.hid>
In-Reply-To: <4AFD01D3.1070604@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] What has highest priority RTcap or
	TDMA-synchronization reception?
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Benjamin Biegel <biegel@domain.hid>
Cc: xenomai@xenomai.org

Benjamin Biegel wrote:
> What has highest priority RTcap or TDMA-synchronization reception?
> 
> We have a PC with two NICs, so one has TDMA, and one other captures with 
> RTcap. If two frames arrive at the same time on both NICS, which is 
> handled? Is it the first one, or does one have higher priority than the 
> other?
> 
> Any help directly or where to look is appreciated.

Timestamping and packet queuing of both sources work at exactly the same
priority and even go through a common path, the Stack Manager task. So
the ordering is more or less random. But the final delivery happens at
different level: TDMA is handled at high RT prio, RTcap captured frames
are forwarded to Linux, thus are then saved at the according low prio.

But why are you running two NICs instead of attaching RTcap to the
TDMA-managed interface? Or are they connected to different Ethernets?

Jan

-- 
Siemens AG, Corporate Technology, CT SE 2
Corporate Competence Center Embedded Linux

