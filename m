Message-ID: <4D3E372F.8060500@domain.hid>
Date: Tue, 25 Jan 2011 03:36:31 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <AANLkTi=wo34Zr40GZ+HKegcFKYYcDqj8uzgEqyDCqDj=@mail.gmail.com>
In-Reply-To: <AANLkTi=wo34Zr40GZ+HKegcFKYYcDqj8uzgEqyDCqDj=@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Segmentation Fault when writing in
 registers	(AT91SAM - ARM9)
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: at91_enthus <nwromania@domain.hid>
Cc: xenomai-help <xenomai@xenomai.org>

at91_enthus wrote:
> Hi.
> 
> I  was testing Xenomai on my AT91SAM9G20-based board and tried to adapt the
> code found here:
> http://www.armadeus.com/wiki/index.php?title=Xenomai:Blinking_LEDs .
> The only difference between my code and theirs was the access to hardware. I
> used open("/dev/mem", ...) and mmap().
> The program compiles fine and both functions are executed. However,  when I
> place values in PIO registers, I get Segmentation Fault.
> 
> I tested my code without Xenomai and it does what it is suppose to do.
> 
> Here's the configuration of my system:
> Processor: AT91SAM9G20
> Xenomai version: 2.5.5.2
> Kernel: 2.6.33-5
> GCC 4.3.2 (I compile the code on the board)
> 
> ----------------  Code snippet  -------------------
> unsigned char *pioa_base, *aic_base;
> 
> void open_controller(){
> 
> 
>     if((fd = open("/dev/mem", O_RDWR | O_SYNC)) == -1)
>     {
>     ....
>     }
>     printf("/dev/mem opened.\n");
> 
>     /* mapping of PIOB */
>     aic_base =  mmap(0, MAP_SIZE, PROT_READ | PROT_WRITE, MAP_SHARED, fd,
> AT91C_BASE_PIOB & (~MAP_MASK));
>     piob_base = aic_base + AT91C_BASE_PIOB - AT91C_BASE_AIC;
> 
>     if( (pioa_base == (void *) -1)) {
>         ...
>     }

Wrong test here. Should be "if (aic_base == MAP_FAILED)"

-- 
                                                                Gilles.

