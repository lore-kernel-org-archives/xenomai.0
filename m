Message-ID: <5256B03C.8080909@xenomai.org>
Date: Thu, 10 Oct 2013 15:48:44 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <FA4CEC4EBE2FA145A7663764A1CCB31EC74CB0DA@VOITV-EXCH-BE02.transas.com>
In-Reply-To: <FA4CEC4EBE2FA145A7663764A1CCB31EC74CB0DA@VOITV-EXCH-BE02.transas.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Kernel 2.6.32 patched with xenomai 2.6.0 and 2.6.3
 crashes on a Core i5 / QM77 system
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "Zemskov, Evgeny" <Evgeny.Zemskov@transas.com>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

On 10/10/2013 01:57 PM, Zemskov, Evgeny wrote:
> Greetings !
>
> I'm trying to run Xenomai system on an industrial computer with
> Core i5-3610ME 2.70GHz and 8Gb RAM on QM 77 chipset.
>
> Any attempts to boot xenomai-patched kernel fail with a stack stace stated below.
> I've tried vanilla kernel 2.6.32 patched with Xenomai 2.6.0 and 2.6.3 (Adeos 2.7-03).
> Xenomai 2.6.0 works fine on a number of other machines with Pentium4, Code 2 Duo and Core i7.
>
> Regretably, we are unable to try use newer kernels (2.6.38 or 3.x) and Adeos versions,
> since we're bound to a certified distrubution of Linux with 2.6.32 kernel.
>
> Any suggestions are wery welcome.

Could you try a recent kernel, just to see if the issue is still there? 
Could you also try to compile your kernel as a 64 bits kernel?

-- 
					    Gilles.

