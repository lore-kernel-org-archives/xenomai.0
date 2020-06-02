Subject: Re: an xhci problem on raspberry pi 4b
References: <5ed4bf2d.1c69fb81.29f0f.b36cSMTPIN_ADDED_BROKEN@mx.google.com>
 <CALLqZ8QXO7zg7a7qAFkSSHnY9jcv2bQs3L+cWNomYqBFS=Kz2A@mail.gmail.com>
From: chensong <chensong@tj.kylinos.cn>
Message-ID: <5ED59C6D.9020905@tj.kylinos.cn>+44AB2111EC4B8E4C
Date: Tue, 2 Jun 2020 08:25:17 +0800
MIME-Version: 1.0
In-Reply-To: <CALLqZ8QXO7zg7a7qAFkSSHnY9jcv2bQs3L+cWNomYqBFS=Kz2A@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Greg Gallagher <greg@embeddedgreg.com>
Cc: "Xenomai@xenomai.org" <xenomai@xenomai.org>



On 2020年06月01日 21:51, Greg Gallagher wrote:
> Hi,
>
> On Mon, Jun 1, 2020 at 4:41 AM chensong via Xenomai <xenomai@xenomai.org> wrote:
>>
>> hi guys,
>>
>> I have a raspberry pi 4b and i have had xenoami running on it. Here is
>> what i did:
>>
> I don't think anyone has tried this yet, so you are one of the first :)
lucky me.
>
>> 1,git clone https://github.com/raspberrypi/linux.git
>> 2,git checkout -b rpi-4.19.y remotes/origin/rpi-4.19.y
>> 3,./xenomai3.1-devel/scripts/prepare-kernel.sh --arch=arm64
>> --linux=rpi-kernel
>> --ipipe=./nudt-hgj-xenomai-tjrd/scripts/prepare-kernel.sh --arch=arm64
>
> What ipipe patch are you using?
ipipe-core-4.19.115-arm64-6.patch
>
>> --linux=rpi-kernel
>> 4,make bcm2711_xeno_defconfig
>> 5,make
>>
> I'm not sure if the rpi4 is in mainline yet but you may have more
> success trying this with the mainline kernel
>
>
>> As a result, usb is not working appropriately, there is no input devices
>> and sometimes system is hanging there when connecting an usb device.
>>
>> Has anyone managed to enable xenomai on rspberry pi 4b? Can you
>> reproduce this problem and how is it fixed? Please help, many thanks.
>
> If you use a serial terminal can you open a shell?
yes, shell works fine, so does ssh.
>>
>> BR
>>
>> chensong
>>
>>
> -Greg
>>
>



