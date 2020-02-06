Subject: Re: IPIPE patch for 32-bit 4.19 LTS kernel
References: <CAOtEsNiOhntwWoOzf6hquHv9v962aLhA=L49-vtUw1izNYgFmA@mail.gmail.com>
 <20200206173523.77e086a3@md1za8fc.ad001.siemens.net>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <e9e17ff7-618c-dc0e-f80b-f3871a3d9fd4@siemens.com>
Date: Thu, 6 Feb 2020 17:46:22 +0100
MIME-Version: 1.0
In-Reply-To: <20200206173523.77e086a3@md1za8fc.ad001.siemens.net>
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
To: Henning Schild <henning.schild@siemens.com>, Matthias Winkler <spmmaze@gmail.com>, Xenomai <xenomai@xenomai.org>

On 06.02.20 17:35, Henning Schild via Xenomai wrote:
> Hi,
> 
> Am Thu, 6 Feb 2020 16:55:15 +0100
> schrieb Matthias Winkler via Xenomai <xenomai@xenomai.org>:
> 
>> Hello Xenomai-Users,
>>
>> Has anybody ported the xenomai patch
>> for kernel 4.19.101 in 32-Bit?
> 
> That target has not been looked at in a long time, i am not sure
> whether it is officially discontinued or just happened like that.

I assume everyone is talking about x86 here.

For I-pipe, x86-32 is discontinued:

Kconfig:
    select HAVE_IPIPE_SUPPORT if X86_64

> 
> I remember multiple discussions around it and nobody stood up and said
> they cared about it.
> 
>> We need to support also our older devices with 32bit CPUs.
>> Help or hints would be appreciated!
> 
> I think ipipe-4.4.y has 32bit support and still has long lifetime ahead
> of it combined with CIP https://www.cip-project.org/
> 

While the code is still present, it is not tested anymore, just like the
kernel itself is barely testing x86-32. So the risk is high that
something is obviously (build) or subtly (runtime) broken.

It's not that this would not be fixable, it's just that no one takes
care of it, as Henning said. We don't have internal use cases for
Xenomai on x86-32 anymore (all targets are are least on x86-64 kernels),
and the community does not look into this as well. If someone steps up,
I would support that effort, no question.

Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

