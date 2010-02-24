Message-ID: <4B853245.3080603@domain.hid>
Date: Wed, 24 Feb 2010 15:05:57 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <4B8445C0.2010101@domain.hid>
In-Reply-To: <4B8445C0.2010101@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Interpreting the ksrc/arch/arm/patches directory
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Bob Feretich <bob.feretich@domain.hid>
Cc: xenomai@xenomai.org

Bob Feretich wrote:
> The ksrc/arch/arm/patches directory for xenomai-2.5.git shows entries
> for Linux 2.6.28.10, 2.6.29, and 2.6.30 kernels. The release news for
> xenomai-2.5.1 states that its "preparing support for the upcoming 2.6.33
> kernel", implying that 2.6.32 is the latest kernel supported.
> 
> Am I correct as interpreting this to mean xenomai-2.5.1 supports 2.6.32
> on some architectures, but for the arm architecture 2.6.30 is the latest
> supported level?

Yes, ARM support lags behind. I need to work on that. We will probably
skip 2.6.31 et go to 2.6.32 directly.

> 
> Also the patches README file doesn't list the BeagleBoard as being
> supported, however other news states that BeagleBoard support was added
> in xenomai-2.5. Is BeagleBoard support still in xenomai-2.5.1?

The beagle is supported. That is a mistake in the README, and in fact,
the README should not mention any board name at all, because this is the
kind of file we always forget.

> 
> Regards,
> Bob
> 
> 
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help
> 


-- 
					    Gilles.

