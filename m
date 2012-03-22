Message-ID: <4F6B45B3.7080904@domain.hid>
Date: Thu, 22 Mar 2012 16:30:59 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <4F6A065E.9030309@domain.hid>
In-Reply-To: <4F6A065E.9030309@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] Using xenomai with standard ethernet driver
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Roberto Bielli <roberto.bielli@domain.hid>
Cc: xenomai@xenomai.org

On 2012-03-21 17:48, Roberto Bielli wrote:
> Hi,
> 
> i want to use xenomai for sending standard tcp/ip packets.
> Is it possible to rewrite the ethernet driver for xenomai without using
> rtnet ?
> Or if i use rtnet is there a way to send standard tcp packet instead
> rtnet packets ?

Is the TCP/IP communication itself part of your time-critical path, or
could it run with lower priority as well?

Jan

-- 
Siemens AG, Corporate Technology, CT T DE IT 1
Corporate Competence Center Embedded Linux

