References: <7EBABB3E-8E3D-4AD0-9C08-5B1C464690BF@bela.io>
 <e5832242-8d40-2ee7-929c-fd7c167434d4@xenomai.org>
From: Harco Kuppens <h.kuppens@cs.ru.nl>
Message-ID: <b3864278-15ec-365d-d86c-4b7a8c17e90f@cs.ru.nl>
Date: Tue, 18 Jul 2017 20:27:49 +0200
MIME-Version: 1.0
In-Reply-To: <e5832242-8d40-2ee7-929c-fd7c167434d4@xenomai.org>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
Subject: Re: [Xenomai] Porting Xenomai 3 cobalt to Raspberry Pi 3
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

I recently succeeded to get it working on the pi3.

At 30th of may I also discussed the problem with xenomai 3 on the 
mailing list
  see https://www.mail-archive.com/xenomai@xenomai.org/msg12101.html

In the mail response see 
https://www.mail-archive.com/xenomai@xenomai.org/msg12102.html
it was brought to my attention that there was already a port to the pi1.
I tried this out and  it worked fine on a pi1.
There was also something for the pi3 but that didn't work, I thought it 
crashed on boot,
but I'm not sure anymore. (some time ago I tried this)

I previously already try to get it working on the pi3 using online the 
instructions
at
http://www.blaess.fr/christophe/2016/05/22/xenomai-3-sur-raspberry-pi-2/
http://wiki.csie.ncku.edu.tw/embedded/xenomai#xenomai-3-on-raspberry-pi-3

They are in french and japanese but if you use google translate then 
they are readable.

However when applying the patches in these instructions xenomai 3 
worked, but not with
gpio interrupts. When an interrupt happened the pi crashed.

In the mail response see 
https://www.mail-archive.com/xenomai@xenomai.org/msg12102.html
Philippe told me :

    In short, each IRQ controller which may be active on a SoC must be
    driven by I-pipe aware code. For instance, the bcm2835 family has common
    GPIOs controlled by the driver at drivers/pinctrl/pinctrl-bcm2835.c. If
    that driver has not been patched specifically for supporting the IRQ
    pipeline, then this won't work with Xenomai, and may well end up with
    painful IRQ storms causing a machine hang.



I found out that in the pi1 port there where also patches to the linux 
gpio driver pinctrl-bcm2835.
But in the instructions in the above urls they didn't patch this driver.
The rpi1  uses the same gpio-chip as the rpi2 and rpi3 so this code 
should work also find for the pi2 and pi3.
So my solution was to   add to above instructions an extra  patched 
version of pinctrl-bcm2835.c from the official ipipe patch
for the  rpi1 which you can find at

http://git.xenomai.org/ipipe.git/plain/drivers/pinctrl/bcm/pinctrl-bcm2835.c?h=vendors/raspberry/ipipe-4.1

and then the gpio interrupts worked!!
I really believe this is not the final version, because If I compared 
the amount of patches done for the pi3 on the xenomai git repository 
(which didn't work) compared to the patches from the above online 
instructions , then the latter had less code patched. So it works, but
I can imagine that in special cases it can still crash because not 
everything is rightly patched.
But for now I'm happy my solution works.

My build instructions are in a text file at :

    https://github.com/harcokuppens/xenomai3_rpi_gpio/blob/master/install/install_xenomai-3-3.0.5_on_rpi2__using_official_ipipe_patch__external_bcm_patch__pinctrl-bcm2835_patchfrom_ipipe_repos.txt


I also already build debian packages which you can install to install 
the patched kernel and the linux kernel header files.
I made this packages to get the linux kernel headers installed so that I 
could also build kernel modules on the pi3.
This is also described in mine instructions above.

I just finished today in making an image file for all pi's 
(pi0,pi1,pi2,p3) which supports xenomai 3.
Then you only have to install that image on a sd card to get xenomai3 
running on any of the pi's.  (xenomai 3.0.5)
You can download this image at

    http://www.cs.kun.nl/lab/xenomai/-> go to "Raspberry Pi zero,1,2,3
    Image" <http://www.cs.kun.nl/lab/xenomai/raspberrypi.html>


We are going to use the pi3 with xenomai coming semester within a course 
at the Radboud University Nijmegen.
The course website is at : http://www.cs.ru.nl/~hooman/DES/

So also experimented a lot with the new xenomai  3.  Many years ago we 
started using xenomai 2.4 on old pentium pc's,
and I'm glad we can now replace them.

When experimenting I put some example code, circuit drawings and all my 
notes in the github repository for anyone to read:

    https://github.com/harcokuppens/xenomai3_rpi_gpio


Disclaimer : this are not cleanest notes and there can be offcourse some 
mistakes in these notes.
But still hope these are maybe helpfull for also somebody else!
Note: these notes contain also my install descriptions for the pi1 and 
the pi2.

For the students we also provide  a virtualbox image with xenomai3 to 
make it possible to do some programming
outside our lab. This image you can  also download at :

    http://www.cs.kun.nl/lab/xenomai/-> go to VirtualBox Image
    <http://www.cs.kun.nl/lab/xenomai/virtualbox.html>



Best regards,
Harco Kuppens







On 18/07/17 10:06, Philippe Gerum wrote:
> On 07/17/2017 06:20 PM, Liam Donovan wrote:
>> Hello
>>
>> I’m attempting to port the xenomai cobalt core to the pi3 (actually to a compute module 3, but as far as I can tell they use the same chip) with a 4.9 kernel, and am having some trouble. The ipipe patch applies successfully and the kernel compiles (with CONFIG_IPIPE set and CONFIG_XENOMAI not set) but it fails with the following oops during boot:
>>
> <snip>
>
> It looks like the timer interrupt does not go through the pipeline but
> directly to the regular kernel core instead, which is the basic issue.
> This patch may be missing significant portions of the interrupt pipeline
> logic.
>
> There is an ongoing port of Xenomai 3.x to rpi3. I'll follow up on it.
>

