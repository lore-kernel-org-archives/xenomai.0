Message-ID: <4B869C4A.6030002@domain.hid>
Date: Thu, 25 Feb 2010 16:50:34 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <20100224161747.77015rxwv9jyh5a8@domain.hid>
	<4B8548E4.3060505@domain.hid>
	<20100225164651.15503clnikl4sq5k@domain.hid>
In-Reply-To: <20100225164651.15503clnikl4sq5k@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Adeos-main] port to s3c2440  /  mini2440
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: Michel He <michel.he@domain.hid>
Cc: adeos-main@gna.org

Michel He wrote:
> Ok many thanks for the tips.
> 
> Refering to the webpage, actually the cause should be :
>      *  If the kernel locks at "Calibrating delay loop...", it means  
> that the timer interrupt is not ticking and that the delay calibration  
> routine is running an infinite loop at while (ticks == jiffies) in  
> function calibrate_delay, file init/calibrate.c. To help debugging  
> this situation, you can put printks in the while (ticks == jiffies)  
> loop, printing any hardware timer registers or status register you want.
> 
> It seems that S3C2440 / Mini2440 Timer has changed. There is no more  
> register named S3C2410_T...

If a define had changed name, the I-pipe support would not even compile.
However, it still compiles. So, the problem is probably not as simple as
this.

> 
> But I have no experience in debugging ARM cpu hardware timer... Nor  
> have time to investigate further how to debug the port...
> 
> You can still find the kernel on FriendlyARM.net

I have neither time, nor the hardware to check. So, if you are
interested in the port, I am afraid you will have to debug it yourself.

-- 
					    Gilles.

