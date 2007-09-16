MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <18157.27836.667782.514635@domain.hid>
Date: Sun, 16 Sep 2007 19:49:48 +0200
In-Reply-To: <1189882379.25006.181.camel@domain.hid>
References: <200709071127.17913.peter.soetens@domain.hid>
	<1189882379.25006.181.camel@domain.hid>
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Subject: Re: [Xenomai-core] [FIX] Summary: Xenomai 2.3.2 and 2.4
	lock-ups	and OOPSes
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: rpm@xenomai.org
Cc: xenomai-core <xenomai@xenomai.org>

Philippe Gerum wrote:
 > 
 > Please try this patch against v2.3.x. A double free issue on a task TCB
 > already scheduled for memory release was causing all sorts of troubles,
 > basically trashing the system heap afterwards:

Is not there anything similar needed for the posix skin ?

-- 


					    Gilles Chanteperdrix.

