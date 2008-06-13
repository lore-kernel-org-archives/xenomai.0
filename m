Message-ID: <2ff1a98a0806130843u17a146c5g38daf88bcd5ab7f6@domain.hid>
Date: Fri, 13 Jun 2008 17:43:47 +0200
From: "Gilles Chanteperdrix" <gilles.chanteperdrix@xenomai.org>
In-Reply-To: <3380.62.39.72.60.1213367793.squirrel@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <16474.81.252.86.91.1211199249.squirrel@domain.hid>
	<5871.81.252.86.91.1211789666.squirrel@domain.hid>
	<18491.29266.196753.611570@domain.hid>
	<2766.81.252.86.91.1211992159.squirrel@domain.hid>
	<2ff1a98a0805280931j611ae10er69b968ae8699d63d@domain.hid>
	<16273.81.252.86.91.1212060383.squirrel@domain.hid>
	<2ff1a98a0805290614w3d846e6by69b033204f912391@domain.hid>
	<13639.81.252.86.91.1212153659.squirrel@domain.hid>
	<18496.31292.674733.417262@domain.hid>
	<3380.62.39.72.60.1213367793.squirrel@domain.hid>
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

On Fri, Jun 13, 2008 at 4:36 PM, Fabien MAHOT
<fabien.mahot@domain.hid> wrote:
> There is a problem with threadTimeOut. Maybe, this thread runs in linux
> domain and must come back in xenomai domain, but there is a
>
> problem.

Do you run your program on UP, or on SMP ?
By the way, testing that pthread_mutex_unlock returns EINTR should be
useless now, this bug also has been fixed.

-- 
 Gilles

