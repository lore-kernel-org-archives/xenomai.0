Subject: Re: rt_task_set_priority does not increase priority of other task
References: <777d8ed5-7f6a-4e56-7f65-7677f089527e@cs.ru.nl>
 <916ef19a754d4e42b0eaefa8a1a26060@EXPRD08.hosting.ru.nl>
 <5faff965-afc6-f70a-8d10-8f55c570fbf6@cs.ru.nl>
 <6318b8f4918243c891732fc8f79d11ab@EXPRD08.hosting.ru.nl>
From: Harco Kuppens <h.kuppens@cs.ru.nl>
Message-ID: <45fbf276-966a-75c3-0447-e0ec3b525e53@cs.ru.nl>
Date: Thu, 17 Sep 2020 15:59:10 +0200
MIME-Version: 1.0
In-Reply-To: <6318b8f4918243c891732fc8f79d11ab@EXPRD08.hosting.ru.nl>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
Content-Language: nl
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jan Kiszka <jan.kiszka@siemens.com>, "Xenomai@xenomai.org" <xenomai@xenomai.org>, Greg Gallagher <greg@embeddedgreg.com>, Philippe Gerum <rpm@xenomai.org>



On 17/09/2020 15:31, Jan Kiszka wrote:
>
> We maintain the demo image generator
> https://gitlab.denx.de/Xenomai/xenomai-images. There is no raspi target
> yet, but it would likely make sense to add one eventually so that you
> can easily generate SD card images, or even add own customizations on
> top. I'm happy to explain more if there is interest.
Adding a raspi target would be great!

The problem with the raspberry pi is that they don't use the vanilla 
kernel source,
but have their own patched kernel in a git repo. Then you have to apply 
the ipipe patch, and
a patch to get gpio to work. After some hacking I got it working,
but there was still a problem with interrupts in the pipeline not 
getting through to linux.
I reported that at the mailinglist:
   https://www.xenomai.org/pipermail/xenomai/2019-June/041023.html
but it never got resolved. But anyway, xenomai was working with xenomai,
so we could use it in the course. The only thing is that because the 
interrupts are not reaching
linux you still have less confidence in the image.
My installation instructions are also linked at 
http://www.cs.ru.nl/lab/xenomai/virtualbox.html

There is even a raspberrypi 4, but I couldn't that get to work with 
xenomai3 with gpio support.
Others seem to have more succes later: 
http://www.simplerobot.net/2019/12/xenomai-3-for-raspberry-pi-4.html
They also needed to do extra patching.

However it would be great if the raspberry pi would be officially 
supported, because
it is a very well known platform nowadays. Ideal for practica in teaching.

Finally it must be noted that the virtualbox image is just for intel 
architecture and
that was easy to setup without any hacking. There the problem with 
raising the priority
also happens, so the problem is unrelated to any problems with my rpi image.

Harco
>
> Jan
>


