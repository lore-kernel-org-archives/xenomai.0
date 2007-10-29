Message-ID: <2ff1a98a0710290946t33fb649aw6bb3822d73dfac32@domain.hid>
Date: Mon, 29 Oct 2007 17:46:07 +0100
From: "Gilles Chanteperdrix" <gilles.chanteperdrix@xenomai.org>
In-Reply-To: <1193675423.47260a9f317e3@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <1193662459.4725d7fbcf9e6@domain.hid>
	<2ff1a98a0710290638i7204c9f7pfe4a26ecbe07af9f@domain.hid>
	<1193675423.47260a9f317e3@domain.hid>
Subject: Re: [Xenomai-help] imx1 port.
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: garryt <garryt@domain.hid>
Cc: xenomai@xenomai.org

On 10/29/07, garryt <garryt@domain.hid> wrote:
> Please correct me if i am wrong, this will help, my understanding from the
> comment in the function (in 1.7-06.patch), was that if another domain (xenomai)
> has stolen the timer we should do nothing neither ack it (already done), nor
> reprogram the timer in linux interrupt handler...just run timer_tick. (should i
> used time_lock)
>
> I though that if we enter the loop this means that the timer programming is
> still held by linux not xenomai.

Right, the only thing which should be skipped is what is in
__ipipe_mach_acktimer. So, sorry for the noise, your patch is OK.

-- 
                                               Gilles Chanteperdrix

