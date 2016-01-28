References: <DUB122-W12189AD8672E553549138CC5DA0@phx.gbl>
From: Elmar Grom <elmar@grom.net>
Message-ID: <56AA34E3.40205@grom.net>
Date: Thu, 28 Jan 2016 07:33:55 -0800
MIME-Version: 1.0
In-Reply-To: <DUB122-W12189AD8672E553549138CC5DA0@phx.gbl>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Xenomai on Raspberry Pi 2
Reply-To: elmar@grom.net
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Gianmarco,

unless you need to compile for a very specific reason, you could try the 
following:

Here is what to do:

  * Install the kernel image
  * Make a backup copy of the existing kernel
  * Rename the Xenomai kernel
  * Reboot

|sudo apt-get install linux-image-xenomai
sudo mv /boot/kernel.img /boot/kernel.img.bck
sudo cp /boot/vmlinuz* /boot/kernel.img
sudo shutdown -r now
|
This will install the ready made image for 3.10. I have it running on a 
Pi2 just fine. Of course make sure you have an image for your SD card 
ready, in case things go bad.

Elmar


On 1/28/2016 7:19 AM, Gianmarco Ottavi wrote:
> I'm trying to make xenomai works on Pi 2 but i get some building errors while compiling the kernel. I've looked it up online for some guide on how to make it works, tried for example https://github.com/awesomebytes/xenorasp, and seems to work and boot on Pi b+ but if i try it on Pi 2 it won't boot up(maybe becasue works only on 3.18 and newer, and xenorasp is on 3.10).The error i get while compiling for xenomai 3.0 on kernel 3.18 is:"undefined reference to '__ipipe_mach_get_tscinfo'
> any idea? 		 	   		
> _______________________________________________
> Xenomai mailing list
> Xenomai@xenomai.org
> http://xenomai.org/mailman/listinfo/xenomai
>

