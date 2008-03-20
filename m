Message-ID: <d6c8ef150803200231q42d8dcfev2e5837958b98b4b@domain.hid>
Date: Thu, 20 Mar 2008 10:31:30 +0100
From: "Bosko Radivojevic" <bosko.radivojevic@domain.hid>
In-Reply-To: <18401.32383.382321.517340@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <d6c8ef150803180527h71adc568o612fec284f8d096@domain.hid>
	<2ff1a98a0803180723i17d6d6e1p619b9c8948b6e542@domain.hid>
	<d6c8ef150803190410l48c36687odd494d3966407a8@domain.hid>
	<18401.32383.382321.517340@domain.hid>
Subject: Re: [Xenomai-help] Handling irq
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai-help <xenomai@xenomai.org>

On Wed, Mar 19, 2008 at 9:58 PM, Gilles Chanteperdrix
<gilles.chanteperdrix@xenomai.org> wrote:
>  Yes, it is possible. But what is also possible is that you get a cache
>  flush due to the cache line you are memcpying to being shared with some
>  unrelated piece of memory. Only the tracer [1] may tell you what
>  happens.

Yes, sounds reasonable. The 'delaying' happens in all other stages,
not only in memcpy. How I could disable "all" interrupt handlings
during my task execution? And, of course, enable them, after it :)

>  [1] http://www.xenomai.org/index.php/I-pipe:Tracer

I've already tried with Tracer, but system just hangs when I load my
module (with Tracer enabled). I'll try with CONFIG_IPIPE_TRACE_VMALLOC
enabled.

>  What hardware are you using ? If it is an ARM, you have to realize that
>  ARM is slow hardware, and that there is little we can do against this.

Yes, ARM9 based, AT91SAM9260.

Kind regards,
Bosko

