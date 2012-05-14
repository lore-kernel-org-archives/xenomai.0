Message-ID: <4FB18FFA.5020602@domain.hid>
Date: Tue, 15 May 2012 01:06:34 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <201205140945.34788.leo@domain.hid>
	<4FB0BEB4.9000408@domain.hid>
In-Reply-To: <4FB0BEB4.9000408@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Xenomai on kernel 3.x and x86
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai@xenomai.org

On 05/14/2012 10:13 AM, Philippe Gerum wrote:
> There is an upcoming patch for linux 3.2, which is the first of the new 
> pipeline "core" series, a massive refactoring of the I-pipe 
> implementation and API, aimed at a better integration with Xenomai:
> http://git.denx.de/?p=ipipe-2.6.git;a=shortlog;h=refs/heads/core-3.2

For those interested, here are a few latency measurements made with this
new patch on the various platforms I have, in order to compare Xenomai
2.6.1 with the current state of the upcoming 3.x branch.

The graphs show clearly that Xenomai 3.x has better average and minimum
latencies on low end platforms. The lower end the platform, the more the
latency graph is shifted to the left.

http://sisyphus.hd.free.fr/~gilles/core-3.2-latencies/

-- 
                                                                Gilles.

