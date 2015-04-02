MIME-Version: 1.0
In-Reply-To: <20150402090400.GC31175@hermes.click-hack.org>
References: <20150321131111.GA20203@hermes.click-hack.org>
 <20150321132130.GC20203@hermes.click-hack.org>
 <CAKC9m6ceEi593XX04-dLfQaVYHmQHmwe75oC+d4Qu-t9q1G9_A@mail.gmail.com>
 <550FD6CA.7080407@web.de>
 <20150323095340.GA5299@hermes.click-hack.org>
 <55101C6F.2030207@web.de>
 <20150323152540.GC5299@hermes.click-hack.org>
 <55117747.6040807@web.de>
 <20150324152749.GA15125@hermes.click-hack.org>
 <CAKC9m6e24UQg6NiYc+tJbQH-txLF6fvYKH-jca0oEnVMavmjpQ@mail.gmail.com>
 <20150402090400.GC31175@hermes.click-hack.org>
Date: Thu, 2 Apr 2015 10:56:36 -0700
Message-ID: <CAKC9m6cVoXA0nHTobW-aFuPwH2023UxKp4SFyTaUd7SfK7b-iQ@mail.gmail.com>
From: Hongfei Cheng <hongfei@mperpetuo.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Xenomai] ARMv8 (ARM64) port of Xenomai
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: Jan Kiszka <jan.kiszka@web.de>, xenomai@xenomai.org

Thank you, Gilles, for the clarification.

Our immediate goal is to enable/port the minimum ipipe-core code for
Aarch64 so we can successfully build an image with ipipe enabled. We
can then start to work on irq interception, timer interception, etc.
By then we should be able to ask I-pipe specific questions for the
arm64 port.

Thanks again,
Hongfei

On Thu, Apr 2, 2015 at 2:04 AM, Gilles Chanteperdrix
<gilles.chanteperdrix@xenomai.org> wrote:
> On Thu, Apr 02, 2015 at 01:12:11AM -0700, Hongfei Cheng wrote:
>> Thank you all again for the clear and prompt responses, along with
>> the informative discussions.
>>
>> A follow-up question to the kernel module(s) requiring changes for
>> supporting I-pipe for Aarch64/arm64: After enabling I-pipe (but with
>> xenomai-3 disabled) in the kernel with the ipipe-core patch for
>> Aarch32/arm, building the Aarch64 kernel image shows clear dependency on
>> I-pipe specific code in arch/arm64/kernel. This observation appears
>> to deviate from Gilles' earlier advice -- "there is no reason to touch
>> boot, kernel, mm".
>>
>> Since the Aarch64 code in arch/arm64/kernel differs quite a bit from the
>> Aarch32 code in arch/arm/kernel, porting the ipipe-core code from
>> arch/arm/kernel to arch/arm64/kernel will require significant amount of
>> work. I'd appreciate if anyone can affirm or refute the need to touch
>> arch/arm64/kernel for Aarch64/arm64, before I go too far and veer off the
>> road.
>
> Speaking in directory/files is meaningless, what matters is what you
> change. I think I have given you a list of what to change already.
> If some files to change are in the kernel directory, then OK, I was
> wrong.
>
> --
>                                             Gilles.

