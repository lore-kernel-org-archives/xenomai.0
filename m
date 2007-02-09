Message-ID: <45CCA96C.7080605@domain.hid>
Date: Fri, 09 Feb 2007 18:03:40 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] Multiple NIC trouble
References: <cbe23c50702061337yc411319l881b9402e4677d6d@domain.hid>	<17864.63903.244809.994959@domain.hid>	<cbe23c50702062357m6d8b913fsc65af3339ba092de@domain.hid>	<45C9B7C4.8050705@domain.hid>	<cbe23c50702080711s18459ea7le22545518bfc7c6f@domain.hid>	<45CB4291.408@domain.hid>
	<cbe23c50702090849i3bfff5a0j64acbcd58163f880@domain.hid>
In-Reply-To: <cbe23c50702090849i3bfff5a0j64acbcd58163f880@domain.hid>
Content-Type: text/plain; charset=ISO-8859-15
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
To: Eric Noulard <eric.noulard@domain.hid>
Cc: Xenomai help <xenomai@xenomai.org>, Jan Kiszka <jan.kiszka@domain.hid>

Eric Noulard wrote:
> 2007/2/8, Jan Kiszka <jan.kiszka@domain.hid>:
> 
>>Can you attach a serial console to your system (see
>>linux/Documentation/serial-console.txt) and grab the full kernel log up
>>to the hang?
> 
> 
> Here you go.
> I recompile a linux 2.6.19  + adeos-ipipe-2.6.19-i386-1.7-01.patch
> for xenomai 2.3 in order to avoid to look at may be previous ipipe bugs.
> 
> I did:
> 1- attached the serial console
> 2- login on serial console as root
> 3- launch xeno-test (no args)
> 
> Then the machine freeze....
> 
> 
>>Maybe we have an oops that just cannot come out anymore.
> 
> 
> No oops anywhere :(((

Maybe you should enable kernel debugging and xenomai debugging. If I
were you, I would reserve the console for error logging, I would not use
it to log in.

>From your logs, there is one thing you should try first: disable HPET
timer, since the box seems to have one and it is used by Linux, and
there is no support whatsoever of the HPET timer by Xenomai.

-- 
                                                 Gilles Chanteperdrix

