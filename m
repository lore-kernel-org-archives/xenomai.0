Message-ID: <4DB3F350.2060701@domain.hid>
Date: Sun, 24 Apr 2011 11:54:24 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <BANLkTi=fGeGY0h0WXfXH=jgcJ9PG3H_b7w@domain.hid>
In-Reply-To: <BANLkTi=fGeGY0h0WXfXH=jgcJ9PG3H_b7w@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Adeos-main] Adeos-patch for OMAP kernel 2.6.38 for Gumstix
 Overo COM?
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/options/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: aungkyas@domain.hid
Cc: adeos-main@gna.org

AKS wrote:
> Hi
> 
> Happy Easter holidays!

Hi,

> 
> I am a newbie to Adeos although I have worked with real time
> kernel and drivers from Monta Vista Linux. I have been using
> Gumstix Overo COM with OMAP kernel 2.6.38 and I need to
> make my embedded Linux to hard real time. So I have found
> xenomai-adeos pipes - and xenomai-skin combination.
> 
> But I could not find a patch for OMAP kernel 2.6.38 and so
> I downloaded kernel 2.6.33-arm which supports TI OMAP 3
> arm CPU. May I know where can I get the adeos patch for
> OMAP3 kernel 2.6.38?

The closest we have is an Adeos port for linux 2.6.37. It is currently
being modified, but has been validated on an IGEPv2 board. The only
current way to download it is via git:
http://git.xenomai.org/?p=ipipe-gch.git;a=shortlog;h=refs/heads/for-ipipe-2.6.37-arm

Beware, it is sometime rebased.

> Or I will be grateful if anyone could
> give me helpful pointers to make xenomai framework runs
> on my Gumstix Overo OMAP 3530 based board. Thanks!

There should not be anything special for Gumstix overo, the generic
installation instructions should apply. But feel free to to browse the
Xenomai-help/Xenomai-core/adeos-main mailing list archives, there were
some posts about Overo.

-- 
                                                                Gilles.

