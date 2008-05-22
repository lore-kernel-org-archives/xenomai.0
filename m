Message-ID: <2ff1a98a0805220809y47663735s3f05e9db51945d29@domain.hid>
Date: Thu, 22 May 2008 17:09:56 +0200
From: "Gilles Chanteperdrix" <gilles.chanteperdrix@xenomai.org>
In-Reply-To: <12142.81.252.86.91.1211467896.squirrel@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <16474.81.252.86.91.1211199249.squirrel@domain.hid>
	<12036.62.39.72.60.1211212126.squirrel@domain.hid>
	<2ff1a98a0805190857s1ad98139h9abe63b743dda35@domain.hid>
	<5481.62.39.72.60.1211293804.squirrel@domain.hid>
	<18483.10408.141546.420660@domain.hid>
	<2336.81.252.86.91.1211379896.squirrel@domain.hid>
	<2ff1a98a0805210733u39894a17tca5420ae8f7ce5ca@domain.hid>
	<15059.81.252.86.91.1211386718.squirrel@domain.hid>
	<18484.28025.505865.374746@domain.hid>
	<12142.81.252.86.91.1211467896.squirrel@domain.hid>
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

On Thu, May 22, 2008 at 4:51 PM, Fabien MAHOT
<fabien.mahot@domain.hid> wrote:
> Hello,
>
> Thanks to a serial console, I obtained the kernel traces before the crash
> when I executed Cyclictest.
> However, I could not have the same error : kernel panic - not syncing:
> Aiee, killing interrupt handler. The system crashed like before, without
> error message.

I do not understand what you mean. You tell us that you get no traces,
but then shows some traces.

Anyway, could you enable the Xenomai nucleus debugging ? In
particular, I would be interested to know if you get the fatal "Error
relaxing a kicked thread".

-- 
 Gilles

