MIME-Version: 1.0
In-Reply-To: <4fa097a7-96ec-608a-a16e-e70df2c639cb@xenomai.org>
References: <CAJ2oMh+gxphHKPqo8QcJqZ5yH0LfdoEyJOsiqoRVNm5mVzrZhA@mail.gmail.com>
 <4fa097a7-96ec-608a-a16e-e70df2c639cb@xenomai.org>
From: Ran Shalit <ranshalit@gmail.com>
Date: Tue, 7 Feb 2017 11:23:14 +0200
Message-ID: <CAJ2oMhJ91smOZqhdn3Qp75ZB+F=FYhMMh=ci=mRCLcz7fgee2A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Xenomai] Switching between cobalt & mercury
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai@xenomai.org

On Sun, Feb 5, 2017 at 4:11 PM, Philippe Gerum <rpm@xenomai.org> wrote:
> On 02/05/2017 02:49 PM, Ran Shalit wrote:
>> Hello,
>>
>> I am trying to evaluate  mercury and cobalt kernels from same version
>> of kernel source code.
>> I am using the documentation in
>> https://xenomai.org/installing-xenomai-3-x/
>> I am trying to see how simply it is to switch between the cores and
>> test each of them.
>> (without repeating the steps for each core using duplicated source folder)
>>
>>
>> 1. I have applied the prepare-kernel script, can I now just add RT
>> PREEMPT in order to use mercury kernel , or must I also disable all
>> Xenomai configuration and build again ? Is it possible to use kernel
>> which support both RT PRREMPT and Xenomai ?
>>
>
> It is possible and has been done many times for custom kernel trees, but
> then you would need an I-pipe patch merged with the RT-preempt patch for
> the same target kernel. If you don't have such combo patch, then you
> will most likely have to apply the RT-preempt patch to a fresh kernel
> tree, without any I-pipe bits in, otherwise conflicts may appear at
> source level.
>

I meant that I am using released version (Xenomai 3.3) which should be
applied to kernel 4.1.18.
The patch was already applied without errors.
What I try is to switch from cobalt to mercury.
As I understand, I will need to disable xenomai and enable RT PREEMPT
(because I better not enable both, I assume).

Best Regards,
Ran


>> 2. I also assume that I will also need to install the correct build of
>> the Xenomai library (there is a build for mercury and another one for
>> cobalt).
>>
>
> Correct.
>
> --
> Philippe.

