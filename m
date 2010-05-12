Message-ID: <4BEA9F96.7020207@domain.hid>
Date: Wed, 12 May 2010 14:31:18 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <AANLkTinbt2EqgVr_rzyJJEgOVfgRYgHEhQB8CtBOCGsr@domain.hid>
In-Reply-To: <AANLkTinbt2EqgVr_rzyJJEgOVfgRYgHEhQB8CtBOCGsr@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] my first test run on beagleboard
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Everett Wang <everteq@domain.hid>
Cc: xenomai@xenomai.org

Everett Wang wrote:
> Hi all,
> 
> I finally managed to compile and install xenomai on my beagleboard C4.
> I just did a
> kernel latency test and this is the result. Does it look reasonable?
> the board is not running
> anything except the kernel latency in the testsuit directory (C4
> running at 720Mhgz)

Hi,

You are probably running latency on an idle board. With more load, you
should get latencies around 70us.

Note that for correct behaviour of floating point operations, you should
use Xenomai 2.5.3 with the patches it contains for Linux 2.6.31 or 2.6.33.

Regards.

-- 
					    Gilles.

