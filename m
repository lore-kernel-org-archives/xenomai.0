Message-ID: <2ff1a98a0804010616o6fceb71qd44ffc0cc6da7d7d@domain.hid>
Date: Tue, 1 Apr 2008 15:16:43 +0200
From: "Gilles Chanteperdrix" <gilles.chanteperdrix@xenomai.org>
In-Reply-To: <d6c8ef150804010614h6ef82911iaab0f797f38cf969@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <d6c8ef150804010441wdcdbf6cr16423c9ff30f419a@domain.hid>
	<2ff1a98a0804010520h7399794fy79695a1eafc2e2f3@domain.hid>
	<d6c8ef150804010614h6ef82911iaab0f797f38cf969@domain.hid>
Subject: Re: [Xenomai-help] Handling interrupt, again
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Bosko Radivojevic <bosko.radivojevic@domain.hid>
Cc: xenomai-help <xenomai@xenomai.org>

On Tue, Apr 1, 2008 at 3:14 PM, Bosko Radivojevic
<bosko.radivojevic@domain.hid> wrote:
> On Tue, Apr 1, 2008 at 2:20 PM, Gilles Chanteperdrix
>  <gilles.chanteperdrix@xenomai.org> wrote:
>  >  On past versions of Xenomai you needed to call rt_intr_enable after
>  >  rt_intr_create. But I thought this was no longer needed. You can try
>  >  this anyway.
>
>  OK, now I have some progress. But, somehow I get the same interrupt
>  two times, at the falling edge. I change pin state from 0 to 1, wait a
>  while, and again, return pin from 1 to 0. There is no interrupt on the
>  rising edge. Is there a way to set trigger type of an interrupt? (like
>  RISING_EDGE, or FALLING_EDGE)
>
>  I have to be triggered at the rising edge of a pulse signal tied to IO pin.

The way used under Linux should continue to work with Adeos.


-- 
 Gilles

