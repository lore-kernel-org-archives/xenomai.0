References: <CALLqZ8Qt5w=_W0nU=vhMNtS-Tx-zwE9Nnp-COV9YOK3OX57jTQ@mail.gmail.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <ff1c8ec5-420c-29cc-7f6e-6067bdfd2a99@siemens.com>
Date: Wed, 30 May 2018 16:03:44 +0200
MIME-Version: 1.0
In-Reply-To: <CALLqZ8Qt5w=_W0nU=vhMNtS-Tx-zwE9Nnp-COV9YOK3OX57jTQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Reference Images Alpha Release
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Greg Gallagher <greg@embeddedgreg.com>, "Xenomai@xenomai.org" <xenomai@xenomai.org>

On 2018-05-18 04:00, Greg Gallagher wrote:
> https://github.com/ggallagher31/xenomai-3-alpha-images/blob/master/README.md
> 
> 
> Here is the first attempt of Xenomai-3 reference images, this is based
> on 4.14 ipipe kernel and the rootfs is a Ubuntu based.  Xenomai was
> built off the stable-3.0.x branch.  The images are currently hosted on
> google drive which may change later but for now it should work.  Ping
> me if there are access problems.
> 
> Currently only RPI2 is in included with a extremely simple RT app.
> Zynq boards and gpio examples will be posted this weekend (yay long
> weekend).
> 
> Please send any feedback or suggestion of improvements directly to me
> greg@embeddedgreg.com
> 

Thanks for taking actions here, Greg! I think this is a step in the
right direction. I didn't have the time to try out the image yet, though.

To my understanding, you are manually creating those images so far,
right? Or did you also share somewhere some generation script or tool?

I've started some similar effort for our Jailhouse hypervisor, but there
with the idea to let the user build the images themselves:

https://github.com/siemens/jailhouse-images

This is currently limited to x86 and ARM64 (the latter is optional
because the build is not yet optimized), and we do not have a real board
in the portfolio yet, only QEMU / KVM. But that may change soon (I'm
planning to look into enabling some OrangePi next - Raspis are way too
broken for virtualization).

Maybe such a generating approach could be valuable for us as well (once
the remaining issues of that approach are solved). What do you think?

Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

