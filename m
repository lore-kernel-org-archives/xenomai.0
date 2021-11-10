Subject: Re: [xenomai-images][PATCH v2 3/8] kas: Introduce kas option file for
 CI builds
References: <20211013121732.140595-1-florian.bezdeka@siemens.com>
 <20211013121732.140595-4-florian.bezdeka@siemens.com>
 <4904b421-4c6a-91d7-5ff0-14066517ab04@siemens.com>
 <4f247c90da63fb084b9f95ecbc4c1c4d6443f010.camel@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <b6743cba-3df1-ba91-4f0c-e5defe1f33c0@siemens.com>
Date: Wed, 10 Nov 2021 14:42:35 +0100
MIME-Version: 1.0
In-Reply-To: <4f247c90da63fb084b9f95ecbc4c1c4d6443f010.camel@siemens.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "Bezdeka, Florian (T RDA IOT SES-DE)" <florian.bezdeka@siemens.com>, "xenomai@xenomai.org" <xenomai@xenomai.org>

On 10.11.21 14:23, Bezdeka, Florian (T RDA IOT SES-DE) wrote:
> On Wed, 2021-10-13 at 14:22 +0200, Jan Kiszka wrote:
>> On 13.10.21 14:17, Florian Bezdeka wrote:
>>> For now the difference between the demo and the "ci image" is the
>>> removed sshd-regen-keys. That reduces the (first) boot time especially
>>> on low end CI hardware. Helps to stay within LAVA timeouts.
>>>
>>> CI builds will now use that file.
>>>
>>
>> Too many options. Can't we consolidate over a single CI/CT thing that
>> also includes the changes for ci-board?
> 
> It has been a while, but coming back to this now...
> 
> I agree, we have a lot of such option files, but after checking them
> all again: They all have a unique purpose.

For users? I doubt that. We have

- opt-ext4-gz.yml: It enables QEMU targets, and only those, to be
  compatible with the LAVA test setup by compressing its ext4 images

- opt-lava-test.yml: It switches wic-based targets, and that are only
  the physical ones, to tarballs - again for LAVA purposes

- opt-ci.yml: Removes packages, not relevant for the above images, and
  only those

I really see no separate purposes, just separate files. That is likely
only for technical reasons.

> 
> We don't have a single CI/CT option file because the qemu test targets
> are different in comparison to the real board targets. We do not boot
> up a "disk"/wic image, we pass a kernel image to qemu.
> 
> Without introducing opt-ci.yml I would have to spread the ci
> optimizations into several board specific configs, which would enable
> the ci optimization for "real board builds" as well. That is not what
> we want.
> 
> Further ideas?
> 
> What about introducing a ci image? Does that make sense? The content
> would nearly be the same as within opt-ci.yml now.

An image alone would not consolidate those changes above into a single
one that can be controlled from a single opt-ci.yml file.

We likely need a CI_BUILD bitbake variable that controls with bitbake
logic the changes needed for CI, with bitbake conditionals.

Jan

-- 
Siemens AG, T RDA IOT
Corporate Competence Center Embedded Linux

