Message-ID: <48ECA7AD.1020909@domain.hid>
Date: Wed, 08 Oct 2008 14:29:33 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <581220.10282.qm@domain.hid>
In-Reply-To: <581220.10282.qm@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] trap exceptions in user
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Gabriele Moabiti <gabmoa@domain.hid>
Cc: Xenomai help <xenomai@xenomai.org>

Gabriele Moabiti wrote:
> I had read Adeos is the low level of the real time part and Xenomai is one of the possible
> domain. Do I Have to use the rthal_trap_catch function to alter Xenomai? Is there some examples
> to better understand how to do? 

Xenomai uses rthal_trap_catch, so, you can use Xenomai code as an example.

> NOTE: I have to used rtnet too. Can this customization alterate the behaviour of rtnet?

well, if your real-time task has a huge cli/sti critical section, it
will affect the latencies of pretty much everything on the system,
including rtnet.

-- 
                                                 Gilles.

