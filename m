From: Philippe Gerum <rpm@xenomai.org>
References: <CADXNiGXZ7sCz8ZZ0TUtPGuWzCvdyBueeAm0oqeBWs=WccZk-YA@mail.gmail.com>
 <c296ac71-b3e0-c790-6af3-b64f54a2cf2b@xenomai.org>
 <CANXti+dsa30duyCYtuiN6OWvg+AoknE_mE8qzUME3wqemzv+ag@mail.gmail.com>
 <CADXNiGUhf39WezJ543W6+tk-YSwanFQsF64gxA=ZCFQ77BirBA@mail.gmail.com>
 <c62e7217-5026-d9a1-1c49-3dde4392d5ba@xenomai.org>
Message-ID: <07431c38-2c9e-be66-a243-8d567739e07a@xenomai.org>
Date: Sun, 29 Oct 2017 18:20:50 +0100
MIME-Version: 1.0
In-Reply-To: <c62e7217-5026-d9a1-1c49-3dde4392d5ba@xenomai.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] rt_task_set_affinity causes hang
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jackson Jones <jackson.jones@gmail.com>, Xenomai@xenomai.org, Piotr Piorkowski <qba100@gmail.com>

On 10/05/2017 11:57 AM, Philippe Gerum wrote:
> On 10/04/2017 10:57 PM, Jackson Jones wrote:
>> I am running on an i.MX6 quad core. It is running Debian Jessie with an
>> NXP/Varscite kernel 4.1.15. So it is a 32bit ARM platform like the Pi.
>>
>> What I meant by freeze is it hangs the entire OS/SoC, a hard reset is the
>> only way out. I will check the status of all the return codes (I did not
>> write this example but I should have cleaned it up when the problem was
>> tossed to me).
>>
> Confirmed, I can badly break a couple of SoCs here using this test
> program, provided I run it twice. The first run passes, second time is
> always lethal. The Cobalt core seems to be doing silly things in this case.
> 
> An additional bug also affects the interrupt pipeline for any release
> starting with kernel 4.4 onward actually hides the issue in Cobalt,
> making the affinity setting a nop, sort of.
> 
> Ok, I'll follow up on this.
> 

That one was pretty ugly, and affects all Xenomai releases, 2.x, 3.x,
all of them. Fixed in 3.x by this commit:

http://git.xenomai.org/xenomai-3.git/commit/?id=59344943b0c58d5f0c8b58d2ad97f2d894d33354

Thanks for the test code, that helped a lot.

-- 
Philippe.

