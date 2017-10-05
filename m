References: <CADXNiGXZ7sCz8ZZ0TUtPGuWzCvdyBueeAm0oqeBWs=WccZk-YA@mail.gmail.com>
 <c296ac71-b3e0-c790-6af3-b64f54a2cf2b@xenomai.org>
 <CANXti+dsa30duyCYtuiN6OWvg+AoknE_mE8qzUME3wqemzv+ag@mail.gmail.com>
 <CADXNiGUhf39WezJ543W6+tk-YSwanFQsF64gxA=ZCFQ77BirBA@mail.gmail.com>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <c62e7217-5026-d9a1-1c49-3dde4392d5ba@xenomai.org>
Date: Thu, 5 Oct 2017 11:57:10 +0200
MIME-Version: 1.0
In-Reply-To: <CADXNiGUhf39WezJ543W6+tk-YSwanFQsF64gxA=ZCFQ77BirBA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Xenomai] rt_task_set_affinity causes hang
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jackson Jones <jackson.jones@gmail.com>, Xenomai@xenomai.org

On 10/04/2017 10:57 PM, Jackson Jones wrote:
> I am running on an i.MX6 quad core. It is running Debian Jessie with an
> NXP/Varscite kernel 4.1.15. So it is a 32bit ARM platform like the Pi.
> 
> What I meant by freeze is it hangs the entire OS/SoC, a hard reset is the
> only way out. I will check the status of all the return codes (I did not
> write this example but I should have cleaned it up when the problem was
> tossed to me).
> 
Confirmed, I can badly break a couple of SoCs here using this test
program, provided I run it twice. The first run passes, second time is
always lethal. The Cobalt core seems to be doing silly things in this case.

An additional bug also affects the interrupt pipeline for any release
starting with kernel 4.4 onward actually hides the issue in Cobalt,
making the affinity setting a nop, sort of.

Ok, I'll follow up on this.

-- 
Philippe.

