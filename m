Message-ID: <2ff1a98a0806160233o1e37d876xc5210aa16ade0f70@domain.hid>
Date: Mon, 16 Jun 2008 11:33:41 +0200
From: "Gilles Chanteperdrix" <gilles.chanteperdrix@xenomai.org>
In-Reply-To: <3842.81.252.86.91.1213598456.squirrel@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <16474.81.252.86.91.1211199249.squirrel@domain.hid>
	<2766.81.252.86.91.1211992159.squirrel@domain.hid>
	<2ff1a98a0805280931j611ae10er69b968ae8699d63d@domain.hid>
	<16273.81.252.86.91.1212060383.squirrel@domain.hid>
	<2ff1a98a0805290614w3d846e6by69b033204f912391@domain.hid>
	<13639.81.252.86.91.1212153659.squirrel@domain.hid>
	<18496.31292.674733.417262@domain.hid>
	<3380.62.39.72.60.1213367793.squirrel@domain.hid>
	<2ff1a98a0806130843u17a146c5g38daf88bcd5ab7f6@domain.hid>
	<3842.81.252.86.91.1213598456.squirrel@domain.hid>
Subject: Re: [Xenomai-help] Problem with time-out ends
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Fabien MAHOT <fabien.mahot@domain.hid>
Cc: xenomai@xenomai.org

On Mon, Jun 16, 2008 at 8:40 AM, Fabien MAHOT
<fabien.mahot@domain.hid> wrote:
> Hello,
>
> I enabled debug traces for rtc drivers.

This will not help. What you need to enable are the "frame pointers",
in the kernel configuration, menu kernel hacking, enable "Kernel
debugging", then enable frame pointers.

-- 
 Gilles

