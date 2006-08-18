MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17637.63696.703047.258987@domain.hid>
Date: Fri, 18 Aug 2006 19:28:48 +0200
Subject: Re: [Xenomai-core] [PATCH] speed up building of posix apps
In-Reply-To: <44E5ED9A.9040201@domain.hid>
References: <44E5ACFA.50905@domain.hid>
	<17637.50472.580142.331066@domain.hid>
	<44E5ED9A.9040201@domain.hid>
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: xenomai-core <xenomai@xenomai.org>

Jan Kiszka wrote:
 > Ok, here comes version 2, now with detection of the required ld feature.
 > Falls back to normal behaviour if ld is too old. Could you test it please?
 > 
 > [Grmbl, the fun stops where autoconf begins...]

Seems to work. But maybe we could find the bottleneck and fix it in a
general way. What part of the process is slow ?

-- 


					    Gilles Chanteperdrix.

