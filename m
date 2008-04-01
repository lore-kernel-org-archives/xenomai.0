Message-ID: <47F23E9E.7060801@domain.hid>
Date: Tue, 01 Apr 2008 09:54:38 -0400
From: Tomas Kalibera <kalibera@domain.hid>
MIME-Version: 1.0
References: <47ED5DE3.60202@domain.hid>	<18413.32341.751841.753799@domain.hid>	<18413.34914.638951.575098@domain.hid>	<47ED9D05.7060707@domain.hid>	<18415.63399.305120.344817@domain.hid>	<47F062DE.5000709@domain.hid>	<18417.18371.183857.809430@domain.hid>	<18417.18921.588809.645062@domain.hid>	<47F17B32.7070505@domain.hid>
	<18417.52630.8850.939898@domain.hid>
In-Reply-To: <18417.52630.8850.939898@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] Kernel crash with Xenomai (caused by fork?)
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai-core <xenomai@xenomai.org>

Gilles Chanteperdrix wrote:
> Tomas Kalibera wrote:
>  > 
>  > I added a missing underscore and re-tried, and none of the debug 
>  > messages was printed. I added another one to make sure that there is not 
>  > a problem with getting printk messages to the serial console. The 
>  > resulting highmem_32.c and the output is attached.
>  > 
>  > T
>
> The interesting part of the output is the printk which occurs right
> before the first bug, what happens afterwards is of little use. Do you
> get any output before the first bug ?
>   
There is no output before the first bug. This is why I added the other 
printk to make sure there is always one on the path leading to the 
BUG(). After I did that, the newly added message ("type is NOT 
KM_USER0") appeared in the serial console log after the bug. This is 
what made me believe that this is the printk we care about, and why I 
included the longer output.

Tomas


