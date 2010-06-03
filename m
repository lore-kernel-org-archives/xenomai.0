Message-ID: <4C07ABC9.3040204@domain.hid>
Date: Thu, 03 Jun 2010 15:19:05 +0200
From: Daniele Nicolodi <daniele@domain.hid>
MIME-Version: 1.0
References: <AANLkTimHOPpI3mst8-fM4Atf6V_-kurbqD-RKZdWDbUY@mail.gmail.com>
	<4C038E30.5070606@domain.hid>
	<AANLkTimSJSagZ2zccsNZbgNE0RDP5ECPjSNqhyvVBtgk@domain.hid>
	<AANLkTimVOpXi7D_speJ1AuygscOt8NxGt4ZP_o8Vjrql@domain.hid>
	<20100602210634.GB2590@domain.hid>
In-Reply-To: <20100602210634.GB2590@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] How to generate a waveform / digital output
	(Alexis)
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Alexis Berlemont <alexis.berlemont@domain.hid>
Cc: xenomai@xenomai.org

On 02/06/10 23:06, Alexis Berlemont wrote:
> Hi,
> 
> Ettore Pedretti wrote:
>> Hi Daniele,
>>
>> Thanks again for your code. It works when I select range=0
>>
>> ./analogy-waveform --r 0
>> ./analogy-phasemod --r 0
>>
>> I get a sine wave out of the card
>>
> 
> If you are OK with it, I will integrate this code into cmd_write (or
> instead of it).

You can of course include this code in the analogy distribution.
Be warned, however, that this is just proven at the "works for me"
level, and the option parsing and wrong usage reporting sections can see
some nice improvements.

I would like however to retain the copyright on the code, the license
should be GPL v3 or later, it this suits in xenomai. Otherwise GPL v2 is
fine also.

Thanks. Cheers,
-- 
Daniele

