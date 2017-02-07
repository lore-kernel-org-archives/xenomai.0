References: <CAJ2oMh+gxphHKPqo8QcJqZ5yH0LfdoEyJOsiqoRVNm5mVzrZhA@mail.gmail.com>
 <4fa097a7-96ec-608a-a16e-e70df2c639cb@xenomai.org>
 <CAJ2oMhJ91smOZqhdn3Qp75ZB+F=FYhMMh=ci=mRCLcz7fgee2A@mail.gmail.com>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <2480f267-48bd-5637-fbb9-176c285cc3c3@xenomai.org>
Date: Tue, 7 Feb 2017 10:31:38 +0100
MIME-Version: 1.0
In-Reply-To: <CAJ2oMhJ91smOZqhdn3Qp75ZB+F=FYhMMh=ci=mRCLcz7fgee2A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Switching between cobalt & mercury
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Ran Shalit <ranshalit@gmail.com>
Cc: xenomai@xenomai.org

On 02/07/2017 10:23 AM, Ran Shalit wrote:
> On Sun, Feb 5, 2017 at 4:11 PM, Philippe Gerum <rpm@xenomai.org> wrote:
>> On 02/05/2017 02:49 PM, Ran Shalit wrote:
>>> Hello,
>>>
>>> I am trying to evaluate  mercury and cobalt kernels from same version
>>> of kernel source code.
>>> I am using the documentation in
>>> https://xenomai.org/installing-xenomai-3-x/
>>> I am trying to see how simply it is to switch between the cores and
>>> test each of them.
>>> (without repeating the steps for each core using duplicated source folder)
>>>
>>>
>>> 1. I have applied the prepare-kernel script, can I now just add RT
>>> PREEMPT in order to use mercury kernel , or must I also disable all
>>> Xenomai configuration and build again ? Is it possible to use kernel
>>> which support both RT PRREMPT and Xenomai ?
>>>
>>
>> It is possible and has been done many times for custom kernel trees, but
>> then you would need an I-pipe patch merged with the RT-preempt patch for
>> the same target kernel. If you don't have such combo patch, then you
>> will most likely have to apply the RT-preempt patch to a fresh kernel
>> tree, without any I-pipe bits in, otherwise conflicts may appear at
>> source level.
>>
> 
> I meant that I am using released version (Xenomai 3.3) which should be
> applied to kernel 4.1.18.
> The patch was already applied without errors.
> What I try is to switch from cobalt to mercury.
> As I understand, I will need to disable xenomai and enable RT PREEMPT
> (because I better not enable both, I assume).
> 

To get PREEMPT_RT in, you will need to apply yet another patch to your
kernel. If the I-pipe patch is already applied there, then you may have
source code conflicts doing so, because both may touch to the same areas
in some occasions. If you want to switch to plain Mercury with
PREEMPT_RT in, then you may have to start from a fresh - unpatched -
kernel tree, before applying the PREEMPT_RT bits to that kernel.

It is possible to get them both in, and may have some value for some
particular use cases, but this would require to craft a combo patch
including both the I-pipe and the PREEMPT_RT bits.

-- 
Philippe.

