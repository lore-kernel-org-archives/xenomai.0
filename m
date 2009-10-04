Message-ID: <4AC85FE7.8060503@domain.hid>
Date: Sun, 04 Oct 2009 10:42:15 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <47a3101a0910021728p63da56f7g59edabc521cc4dfe@domain.hid>
	<4AC72281.9090901@domain.hid>
	<47a3101a0910032303n54357389nd8573284eadba063@domain.hid>
In-Reply-To: <47a3101a0910032303n54357389nd8573284eadba063@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Xenomai on gumstix
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Linus Casassa <linus@domain.hid>
Cc: xenomai@xenomai.org

Linus Casassa wrote:
> I don't understand. The example is for a periodic task. What did I miss? :S

The configuration of the skin timer. The skin timer may be periodic or
aperiodic. Whereas everyone chooses to run an aperiodic timer since it
gives a much better precision, you seem to have chosen to run a periodic
timer.

-- 
					    Gilles.

