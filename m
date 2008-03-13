Message-ID: <2ff1a98a0803130832u43e8caa2j9820b558a96ac5@domain.hid>
Date: Thu, 13 Mar 2008 16:32:30 +0100
From: "Gilles Chanteperdrix" <gilles.chanteperdrix@xenomai.org>
In-Reply-To: <258212.32312.qm@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <2ff1a98a0803130718k1c93d405vc76fc97459acc6ed@domain.hid>
	<258212.32312.qm@domain.hid>
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

On Thu, Mar 13, 2008 at 3:55 PM, Michael Trimarchi
<trimarchimichael@domain.hid> wrote:
> Hi,
>  --- Gilles Chanteperdrix
>  <gilles.chanteperdrix@xenomai.org> ha scritto:
>
> > >  I don't see the patch but
>  > >  I think that Gilles use TC0 and TC1 on a chain.
>  > >  Is correct?
>  >
>  > No, I use only one TC. I have seen some patches for
>  > vanilla Linux
>  > which use two TC, but it seems that they use the
>  > slow clock, which I
>  > find much too slow: 32 kHz give us a resolution
>  > around 30 us.
>  >
>
>  I don't understand. The slow clock is of 32khz or not?

The slow clock is 32kHz. This would give us a resolution of 30us, which sucks.


-- 
 Gilles Chanteperdrix

