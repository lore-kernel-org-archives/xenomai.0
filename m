Message-ID: <44E9E31C.9020008@domain.hid>
Date: Mon, 21 Aug 2006 13:45:16 -0300
From: Rodrigo Rosenfeld Rosas <lbocseg@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] x86 based SBC with PCI slot expansions and Xenomai
	support?
References: <20060820183657.87007.qmail@domain.hid>
In-Reply-To: <20060820183657.87007.qmail@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
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
To: Cedric Herreman <glocker50@domain.hid>, xenomai@xenomai.org

Hi Cedric,

thank you very much for your precious information! I was really 
expecting an answer not so great as yours, like "There are the boards 
ECM-5718, xxx, yyy.", but your answers were much more complete.

I really appreciated your message. Again, thank you very much!

Best Regards,
Rodrigo.

P.S: I think a 600 Mhz would suffice for my application because I think 
this processor can process a 480x240 color image for, basically, 
threshold processing. Other required processing have few processing 
power requirements. But for sensor data reading, I would need to have 
maximum latencies of 20 us. But the data reading processing is very 
simple and takes much less than 1 us. But anyway, it is not a commercial 
application. It is just my robot with a sample program for validating 
the framework developed in my Master thesis. I will not implement it 
with SBC, but I want to be more specific when arguing that it would be 
possible to use a SBC and show an example of SBC that could be used. But 
I really like your message because I may need to develop real 
applications in future and it is good to see your suggestions. Thank you.

Cedric Herreman escreveu:
> Rodrigo,
>
> Here are some suppliers :
> - AAEON
> - Kontron
> - Evalue
> - Advantech
> - Axiomtek
> - ..
>
> Some provide pc-boards in a small casing (pc-box).
> Most boards have one or more extensions : PCI, PC-104, Cardbus, ..
>
> Pc-boards also come in different formats :
> 5.25"
> 3.5"
> PC-104
> mini-ITX (http://www.mini-itx.com/)
>
> A lot of those boards are based on a x86 architecture. Xenomai 
> supports this. The only way you can find out if your board has good 
> real time behavior is by testing it. Some BIOS settings can affect the 
> real time behavior. Typically some USB configurations can increase 
> latencies (USB keyboard support).
>
> Also the Geode processor is known to have "issues" when it comes to 
> real time behavior. But this processor is phasing out.
>
> I am currently testing an evalue ECM-5718. It has low latencies. There 
> is a PCI slot. It is based on a Celeron M 600 MHz (maybe too slow for 
> your application). I have already run Linux+RTAI and Linux+Xenomai on it.
>
> Cedric.
>
> */Rodrigo Rosenfeld Rosas <lbocseg@domain.hid>/* wrote:
>
>     Does someone here know about some commercial x86 based SBC
>     (preferently
>     low cost) with PCI slot expansions that work on Xenomai? I was
>     looking
>     for processors higher than 500MHz (preferently, higher than 1GHz).
>
>     Thanks in advance,
>
>     Rodrigo.
>


		
_______________________________________________________ 
Novidade no Yahoo! Mail: receba alertas de novas mensagens no seu celular. Registre seu aparelho agora! 
http://br.mobile.yahoo.com/mailalertas/ 
 



