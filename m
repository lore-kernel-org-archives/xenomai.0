Message-ID: <437C8299.3010503@domain.hid>
Date: Thu, 17 Nov 2005 14:16:09 +0100
From: =?ISO-8859-1?Q?Ignacio_Garc=EDa_P=E9rez?= <iggarpe@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] Blocking reads from pipes
References: <OF53595BAB.2AA49C4A-ONC12570BA.0035EF11-C12570BA.0036F2D4@domain.hid>	<437B2D05.6070003@domain.hid>
	<437C5119.4060100@domain.hid>
	<200511171921.43221.rlenglet@domain.hid>
In-Reply-To: <200511171921.43221.rlenglet@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Romain Lenglet <rlenglet@domain.hid>
Cc: xenomai@xenomai.org


>As a conclusion, the behaviour that you observed with Xenomai 
>pipes seems consistent with that of Linux' named pipes, except 
>that in Linux read() returns 0, and not an error code as you 
>observed with Xenomai.
>  
>
The read() call does *not* return when you close the *same* file handle
from another pthread in the same process.

Is that the expected posix behaviour?

Nacho.


