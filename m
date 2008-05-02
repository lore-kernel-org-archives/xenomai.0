From: Sebastian Smolorz <Sebastian.Smolorz@domain.hid>
Date: Fri, 2 May 2008 09:53:10 +0200
References: <15468836.10944871209713748048.JavaMail.www@domain.hid>
In-Reply-To: <15468836.10944871209713748048.JavaMail.www@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200805020953.10455.Sebastian.Smolorz@domain.hid>
Subject: Re: [Xenomai-help] problem patching xenomai with arm
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: "kerhoas.vincent" <kerhoas.vincent@domain.hid>, xenomai@xenomai.org

kerhoas.vincent wrote:
> I'm trying to patch a linux kernel 2.6.8 or 2.15 with the  following
> command :
>
> sudo scripts/prepare-kernel.sh  --arch=arm
> \--adeos=/usr/src/adeos-ipipe-2.6.24-arm-1.9-01.patch
> \--linux=/usr/src/linux-2.6.8.1
>
>
> and  I've got an error for both of them.

No suprise. You try to patch a 2.6.8 kernel with a patch that was made for 
kernel 2.6.24. The adeos patch must match the linux kernel version you try to 
patch.

> Is Xenomai realy working for  ARM ?

Yes, as long as you follow the advise given above and your ARM platform is 
supported.

> The patch is ok with those version of linux (I've got an error with  the
> other ARM patches given with xenomai 2.4.3) ?

See above.

-- 
Sebastian

