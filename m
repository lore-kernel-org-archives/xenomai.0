Message-ID: <463B5A11.8080406@domain.hid>
Date: Fri, 04 May 2007 18:06:41 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <1178268043.5391.47.camel@domain.hid>	
	<463B0A58.4070206@domain.hid> <1178287470.22169.9.camel@domain.hid>
In-Reply-To: <1178287470.22169.9.camel@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Latencies while ethernet access
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: CAMUS Benoit <benoit.camus@domain.hid>
Cc: Xenomai help <xenomai@xenomai.org>

CAMUS Benoit wrote:
> / # rtnet -v start
> Turning on verbose mode
> 
> *** RTnet 0.9.9 - built on May  4 2007 13:20:37 ***
> 
> RTnet: initialising real-time networking
> LAN91C111: You shouldn't use auto-probing with insmod!
>  Adresse recue: 0
>  entraine une detection ? --> 0 
>  Detection brutale des adresses
>  Demande de region avec l'adresse: 512
>  Demande acceptee, selection du banc de registre sur 512 + 14
> Unable to handle kernel NULL pointer dereference at virtual address
> 0000020e

Jan will probably be of more help here. However, 0x20e is the
hexadecimal value of 512 + 14. What about passing the correct I/O
address of your card at insmod time using its "io" parameter ?

-- 
                                                 Gilles Chanteperdrix

