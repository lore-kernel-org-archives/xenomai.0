Message-ID: <468A8599.60305@domain.hid>
Date: Tue, 3 Jul 2007 13:21:29 -0400
From: Will Wiles <wilesw@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Adeos-main] kernel boot problem, possibly hanging on interrupts
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: adeos-main@gna.org

I'm working with a PXA based embedded board attempting to get Adeos on 
it's feet.  Right now at boot after the pipeline is enabled (a few 
printk's for devices later) the process stalls without any information 
as to why.

I've checked arch/arm/mach-pxa/time.c & irq.c against the information here,

http://www.xenomai.org/index.php/I-pipe:ArmPorting

and everything seems to be in order.  I'm not too versed in interrupt 
handling as it relates specifically to the linux implementation, but 
Gilles was mentioning this as a likely culprit, and it seems fairly 
plausible.

If anyone has seen a similar problem (I'm hoping it's something simple 
as an incorrect register name), or a good strategy for trying to track 
down the offending routine, information would be appreciated.

Will Wiles

