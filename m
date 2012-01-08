Message-ID: <4F0A1A38.1070506@domain.hid>
Date: Sun, 08 Jan 2012 22:35:36 +0000
From: Jakub Nowacki <j.s.nowacki@domain.hid>
MIME-Version: 1.0
References: <000301cccaed$80667540$81335fc0$@soterem.fr>	<4F046865.9000408@domain.hid>	<000001cccafd$1c6046b0$5520d410$@soterem.fr>	<4F049054.4000302@domain.hid>	<4F062D33.3060606@domain.hid>
	<4F06C191.1090704@domain.hid> <4F09FEA8.9080001@domain.hid>
	<4F0A1422.5010304@domain.hid>
In-Reply-To: <4F0A1422.5010304@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] unresolved symbol -
	check	the	xenomai	installation
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai@xenomai.org

On 08/01/12 22:09, Philippe Gerum wrote:
> References should precede definitions. Try swapping libxenomai.so and
> libnative.so in your link order. As Gilles already suggested, using the
> xeno-config script in your Makefile to get the proper link flags would
> have prevented this issue.
>
Thanks for the answer. The problem is I do not have just a Makefile but 
it is generated with autotools. In autotools xeno-config is used but 
apparently order is not OK.

Cheers,

Jakub

