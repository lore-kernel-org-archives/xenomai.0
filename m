Message-ID: <2ff1a98a0711130246sc56a332n4a782fa9b470d662@domain.hid>
Date: Tue, 13 Nov 2007 11:46:10 +0100
From: "Gilles Chanteperdrix" <gilles.chanteperdrix@xenomai.org>
In-Reply-To: <e4ef24880711121452p631a5e05ud7ada7595fd1f4e3@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <e4ef24880711121452p631a5e05ud7ada7595fd1f4e3@domain.hid>
Subject: Re: [Xenomai-help] Time critical tasks
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Robert Gubler <rgubler@domain.hid>
Cc: xenomai@xenomai.org

On Nov 12, 2007 11:52 PM, Robert Gubler <rgubler@domain.hid> wrote:
> Hello,
>
> I have a task that is very time critical.  I used the xenomai/bin/latency
> program to get an idea of my worst case latency; its about 30 us.  Is there
> a facility in POSIX or the POSIX skin, that will allow me to account for
> this worst case latency? Does clock_nanosleep() provides this?

No, you have to measure this with clock_gettime, the way cyclictest do it.
If you use CLOCK_MONOTONIC, the tsc will be used as the time source.

-- 
                                               Gilles Chanteperdrix

