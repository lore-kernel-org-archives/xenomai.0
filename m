From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <18034.62364.810306.484577@domain.hid>
Date: Fri, 15 Jun 2007 22:16:28 +0200
In-Reply-To: <20070615153844.itkoim0sywn4wwkk@domain.hid>
References: <20070615153844.itkoim0sywn4wwkk@domain.hid>
Subject: Re: [Xenomai-help] Beginner's Question: Does Xenomai require
	APIC	capabilitie
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Lauren L White <llwhite@domain.hid>
Cc: xenomai@xenomai.org

Lauren L White wrote:
 > Does Xenomai require APIC capabilities. If not, what are the advantages to using
 > the local APIC setting? Thanks!

No, like the RTAI project likes to advertise it, Xenomai works with or
without APIC and with or without TSC. If you do not want Xenomai to use
APIC, you have to deselect the "local APIC" option in kernel
configuration. When not using the APIC, Xenomai uses the PIT, which has
the big drawback of taking more time to program. Since reprogramming the
timer happens at some critical times, not using the APIC increases the
latency of time triggered tasks.

-- 


					    Gilles Chanteperdrix.

