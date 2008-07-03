Message-ID: <486CF5BE.9050907@domain.hid>
Date: Thu, 03 Jul 2008 17:52:30 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <486CE4C5.8050309@domain.hid> <486CEF87.6060504@domain.hid>
	<486CF1C5.9020704@domain.hid> <486CF261.5010804@domain.hid>
	<486CF405.4070206@domain.hid>
In-Reply-To: <486CF405.4070206@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] How can I make Xenomai share a mii bus with the
 kernel?
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: rpm@xenomai.org
Cc: xenomai@xenomai.org

Philippe Gerum wrote:
> The drivers don't do much, except IRQ handling. Most of them route their
> requests to the generic PHY layer, therefore a parallel implementation would be
> needed. Still, concurrency on the bus would not be solved.

My reference ethernet driver is some proprietary crap, so I should stop 
assuming too much about its compliance to any Linux programming good rule...

-- 
                                                  Gilles.

