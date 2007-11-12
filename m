Message-ID: <2ff1a98a0711120748y1dd6e3a7je7fac0908c590c7d@domain.hid>
Date: Mon, 12 Nov 2007 16:48:55 +0100
From: "Gilles Chanteperdrix" <gilles.chanteperdrix@xenomai.org>
In-Reply-To: <200711121400.lACE0Q7w015963@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <4729B715.9060706@domain.hid>
	<200711121400.lACE0Q7w015963@domain.hid>
Subject: Re: [Xenomai-help] RT, nonRT communication
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Patrick <kpa_info@domain.hid>
Cc: xenomai@xenomai.org, jan.kiszka@domain.hid

On Nov 12, 2007 3:00 PM, Patrick <kpa_info@domain.hid> wrote:
>
> Hi,
>
> I have another error when I try to compile Xenomai with g++ :
>
> /usr/xenomai/include/native/task.h:292: error: expected ',' or '...' before
> 'protected'
>
> I have tried to include this file with and without extern "C" but the issue
> is the same.
>
> Do you have an idea ?

Please post some example code that we can compile, because simply
#including <native/task.h> in a C++ program works here.


-- 
                                               Gilles Chanteperdrix

