Message-ID: <46B87E23.5020601@domain.hid>
Date: Tue, 07 Aug 2007 16:13:55 +0200
From: Johan Borkhuis <j.borkhuis@domain.hid>
MIME-Version: 1.0
References: <46B1A842.1090708@domain.hid>	
	<1186049556.6611.319.camel@domain.hid>
	<46B1B7DE.3080404@domain.hid>	
	<1186053839.6611.326.camel@domain.hid>
	<46B2E1B3.2020102@domain.hid>	
	<2ff1a98a0708060208k1d217ae6ge20389074d9bf1bd@domain.hid>	
	<18103.2297.602539.889750@domain.hid>	
	<46B85236.9010107@domain.hid>
	<2ff1a98a0708070549m4c4a5dffq92370ef61247b5c8@domain.hid>
In-Reply-To: <2ff1a98a0708070549m4c4a5dffq92370ef61247b5c8@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Unexpected switch to secondary mode
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: Xenomai-help@domain.hid

Gilles Chanteperdrix wrote:
> The code I sent only access writable pages, and apparently you need to
> also access read-only pages.
>
> Why not doing something like:
> else if(buffer[1] == 'r')  {
>     static voltatile int dummy;
>     dummy = *(volatile int *)begin;
> }
>
>   
I tried this code first, but it did not make any difference. The problem 
is (at least, that is what I expect) that you access the page as data, 
opposed to code, when you execute something in the page.

Kind regards,
    Johan Borkhuis

