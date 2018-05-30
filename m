MIME-Version: 1.0
In-Reply-To: <693dba0f-7963-251d-4fed-9dce2f1be05c@siemens.com>
References: <CALLqZ8Qt5w=_W0nU=vhMNtS-Tx-zwE9Nnp-COV9YOK3OX57jTQ@mail.gmail.com>
 <ff1c8ec5-420c-29cc-7f6e-6067bdfd2a99@siemens.com>
 <CALLqZ8SuFNKfmXrNPHm1yVDPD8PRN4W2k5aCvU_EKGbyyQWZHA@mail.gmail.com>
 <693dba0f-7963-251d-4fed-9dce2f1be05c@siemens.com>
From: Greg Gallagher <greg@embeddedgreg.com>
Date: Wed, 30 May 2018 13:06:16 -0400
Message-ID: <CALLqZ8TWDnR8or+znARodu8jPw5zcCd-MUcSUZoXm=g_NWLEiQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Xenomai] Reference Images Alpha Release
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: "Xenomai@xenomai.org" <xenomai@xenomai.org>

Okay, I briefly looked at a couple Debian options that I can script
the generation of the needed image.  I'll go down that path and see
what how that goes. I'll hopefully post an update in the next week or
so :)

-Greg

On Wed, May 30, 2018 at 12:59 PM, Jan Kiszka <jan.kiszka@siemens.com> wrote:
> On 2018-05-30 17:46, Greg Gallagher wrote:
>> I agree, after the first run of building the images myself I think
>> having the user generate the images would make more sense.  I'm
>> looking into doing that with an existing tool I think yocto may be a
>> good choice.  I've been generating some images with buildroot as well
>> which seems to be pretty straight forward to do and looks to only
>> require minimal changes.  The other long term goal for this would be
>> to make sure a certain set of boards are always sane and new users
>> just have to learn the new tools and not debug boot issues.  I'll
>> hopefully post an update to this soon, I just finished the work to
>> bring the bcm2835 to the 4.14 ipipe so it looks like we should be able
>> to try more raspberry pi builds.
>
> Going with a complete our-of-source image is surely an option and has a
> value (many users are still basing their development on such
> approaches). The disadvantage is that customizations require the user to
> rebuild everything. Generating a distro-based image (no, yocto is no
> distro) is much faster in this regard, both for rebuilds as well as
> extensions. That was my motivation to pick that Debian path for the
> Jailhouse demo/reference images.
>
> Jan
>
>>
>> -Greg
>>
>> On Wed, May 30, 2018 at 10:03 AM, Jan Kiszka <jan.kiszka@siemens.com> wrote:
>>> On 2018-05-18 04:00, Greg Gallagher wrote:
>>>> https://github.com/ggallagher31/xenomai-3-alpha-images/blob/master/README.md
>>>>
>>>>
>>>> Here is the first attempt of Xenomai-3 reference images, this is based
>>>> on 4.14 ipipe kernel and the rootfs is a Ubuntu based.  Xenomai was
>>>> built off the stable-3.0.x branch.  The images are currently hosted on
>>>> google drive which may change later but for now it should work.  Ping
>>>> me if there are access problems.
>>>>
>>>> Currently only RPI2 is in included with a extremely simple RT app.
>>>> Zynq boards and gpio examples will be posted this weekend (yay long
>>>> weekend).
>>>>
>>>> Please send any feedback or suggestion of improvements directly to me
>>>> greg@embeddedgreg.com
>>>>
>>>
>>> Thanks for taking actions here, Greg! I think this is a step in the
>>> right direction. I didn't have the time to try out the image yet, though.
>>>
>>> To my understanding, you are manually creating those images so far,
>>> right? Or did you also share somewhere some generation script or tool?
>>>
>>> I've started some similar effort for our Jailhouse hypervisor, but there
>>> with the idea to let the user build the images themselves:
>>>
>>> https://github.com/siemens/jailhouse-images
>>>
>>> This is currently limited to x86 and ARM64 (the latter is optional
>>> because the build is not yet optimized), and we do not have a real board
>>> in the portfolio yet, only QEMU / KVM. But that may change soon (I'm
>>> planning to look into enabling some OrangePi next - Raspis are way too
>>> broken for virtualization).
>>>
>>> Maybe such a generating approach could be valuable for us as well (once
>>> the remaining issues of that approach are solved). What do you think?
>>>
>>> Jan
>>>
>>> --
>>> Siemens AG, Corporate Technology, CT RDA IOT SES-DE
>>> Corporate Competence Center Embedded Linux
>
>
> --
> Siemens AG, Corporate Technology, CT RDA IOT SES-DE
> Corporate Competence Center Embedded Linux

