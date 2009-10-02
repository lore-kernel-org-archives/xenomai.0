Message-ID: <4AC5FCC4.5090700@domain.hid>
Date: Fri, 02 Oct 2009 15:14:44 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <47a3101a0910011923t7a002c9av7f7df5c666f0cf1@domain.hid>
	<47a3101a0910020554n39297325x72cd9b7adde9ab9f@domain.hid>
In-Reply-To: <47a3101a0910020554n39297325x72cd9b7adde9ab9f@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Fwd: Xenomai 2.4.9.1
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
> Hi.
> 
> I am installing xenomai on a Gumstix Verdex pro (Marvell PXA270 with
> XScale). I am fowling this wiki:
> http://www.gumstix.net/wiki/index.php?title=Xenomai_-_Mini_Howto
> 
> It compiles fine and works fine.
> But it would be nice to have at least 2.4.8 because it hangs when doing the
> xeno-test on the latency part. I read that it is an overflow bug already
> fixed.

No, latency hangs because the period is too short. But nevertheless, you
should upgrade to 2.4.9.1, because previous versions have a bug.

-- 
					    Gilles.

