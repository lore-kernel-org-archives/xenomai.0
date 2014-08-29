MIME-Version: 1.0
In-Reply-To: <CAEGbdicZrgw-jNGnanSRh96Gy9Hfr1xsYJq8sQFLDyWg8hvnuQ@mail.gmail.com>
References: <CAEGbdifyuoCnxOnSfo7gXY0Ra1yUcJQY-7HXto5EvsjXEGXFNw@mail.gmail.com>
 <53FF8E93.6060704@xenomai.org>
 <CAEGbdif6aQxxZQnjkTGMizuCCZkGUED73XtKt1cOvX3o3vUMVg@mail.gmail.com>
 <53FF9C43.5080706@xenomai.org>
 <CAEGbdie+U8zP4-CPfW6v3kh1LHz2NNVh+t7YW6tiXwPJ_ohgHg@mail.gmail.com>
 <CAEGbdicZrgw-jNGnanSRh96Gy9Hfr1xsYJq8sQFLDyWg8hvnuQ@mail.gmail.com>
Date: Fri, 29 Aug 2014 11:35:25 -0400
Message-ID: <CAEGbdif9bXEF+cjR_qiXgH0ZZ4vb-RjNgFkyZz3muB2jtoVfkQ@mail.gmail.com>
From: Matthew Lindner <mattlindn@gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Xenomai] Linux ATA driver issues and lockups
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>, xenomai@xenomai.org

On Fri, Aug 29, 2014 at 11:33 AM, Matthew Lindner <mattlindn@gmail.com> wrote:
> On Fri, Aug 29, 2014 at 9:00 AM, Matthew Lindner <mattlindn@gmail.com> wrote:
>> On Thu, Aug 28, 2014 at 5:16 PM, Gilles Chanteperdrix
>> <gilles.chanteperdrix@xenomai.org> wrote:
>>> On 08/28/2014 11:15 PM, Matthew Lindner wrote:
>>>> I have not tried those. What do you mean by "if kernel configuration
>>>> is changed"?
>>>
>>> whatever you mean by "suggesting kernel settings are changed".
>>>
>>>
>>
>> The suggestions here:
>> http://xenomai.org/2014/06/configuring-for-x86-based-dual-kernels/
>
> Things have changed. Apparently this issue is not related to Xenomai
> or the I-pipe. I was just able to generate the error on my
> self-compiled 3.10.32 kernel (with settings created from taking
> ubuntu's older 3.8.0 kernel and using makedefconfig with linux stock
> 3.10.32 kernel). Now I have the fun time of tracking down if this is
> hardware related or our kernel related. Trying testing now with 3.8.0
> stock kernel.

Just realized I had been hitting "reply" instead of "reply all".
Responding to this so the info is on the mailing list.

Matthew Lindner

