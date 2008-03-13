Message-ID: <2ff1a98a0803130718k1c93d405vc76fc97459acc6ed@domain.hid>
Date: Thu, 13 Mar 2008 15:18:03 +0100
From: "Gilles Chanteperdrix" <gilles.chanteperdrix@xenomai.org>
In-Reply-To: <41911.59200.qm@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <d6c8ef150803130636h7f064e2cof5d82676f1e19af@domain.hid>
	<41911.59200.qm@domain.hid>
Subject: Re: [Adeos-main] New I-pipe patch for ARM.
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: Michael Trimarchi <trimarchimichael@domain.hid>
Cc: adeos-main <adeos-main@gna.org>

On Thu, Mar 13, 2008 at 3:11 PM, Michael Trimarchi
<trimarchimichael@domain.hid> wrote:
> Hi,
>  --- Bosko Radivojevic <bosko.radivojevic@domain.hid> ha
>  scritto:
>
>
>
>  > On Thu, Mar 13, 2008 at 2:21 PM, Gilles
>  > Chanteperdrix
>  > <gilles.chanteperdrix@xenomai.org> wrote:
>  >
>  > >  The master clock is at 99 MHz, I am afraid the TC
>  > wraps too fast. I
>  > >  will try and use another sub-multiple of the Main
>  > clock frequency, but
>  > >  it takes some time that I have not before
>  > tuesday.
>  >
>  > If my math is correct, TC wraps in 655us (TC is
>  > 16bits long).
>  >
>  >
>  I don't see the patch but
>  I think that Gilles use TC0 and TC1 on a chain.
>  Is correct?

No, I use only one TC. I have seen some patches for vanilla Linux
which use two TC, but it seems that they use the slow clock, which I
find much too slow: 32 kHz give us a resolution around 30 us.

-- 
 Gilles Chanteperdrix

