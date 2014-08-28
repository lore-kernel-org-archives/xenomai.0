Message-ID: <53FF7649.30907@xenomai.org>
Date: Thu, 28 Aug 2014 20:34:49 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <CACreCV+9seA7yp8gmjvOb6CQ7-Fbt-HyQ6YAoB_dqtmqmyvy7Q@mail.gmail.com>	<53FDFD27.2010207@xenomai.org>	<CACreCV+cQTO-5iFCCvC15VxNzXuvKkLN+_gUTex-r3Y1cByUkw@mail.gmail.com>	<53FF33CE.10303@xenomai.org>	<D024AFFD.53F9%donald.poole@swri.org>	<CACreCV+8qTgd6y0UuRmMQEhX_mM4PfxP2yjANerZ07SmwkmkEg@mail.gmail.com>	<53FF5B81.7030408@xenomai.org>
 <CACreCVJ+2nEakHkkZgL=c+u7rW8S2tY-3qTWyw=AtkCH39n=rw@mail.gmail.com>
In-Reply-To: <CACreCVJ+2nEakHkkZgL=c+u7rW8S2tY-3qTWyw=AtkCH39n=rw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] ODROID-U3 porting problems
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: GP Orcullo <kinsamanka@gmail.com>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

On 08/28/2014 07:05 PM, GP Orcullo wrote:
> On Fri, Aug 29, 2014 at 12:40 AM, Gilles Chanteperdrix
> <gilles.chanteperdrix@xenomai.org> wrote:
>> On 08/28/2014 06:34 PM, GP Orcullo wrote:
>>> So far it passes all the regression tests except for the switchtest.
>>
>> What error do you get with switchtest ? If pthread_create fails with
>> resource unavailable error, see:
>>
>> http://xenomai.org/troubleshooting-a-dual-kernel-configuration/#pthread_create_Resource_temporarily_unavailable
>>
>> If this is another error, please post the error message and kernel log here.
>>
>> --
>>                                                                 Gilles.
> 
> Running "switchtest rtk0" fails with "Xenomai: suspending kernel
> thread f00bb710 ('rtk1/0') at 0xc0020c8c after exception #0x0"
> 
> The address is traced to the I-pipe timer interrupt call-back. I think
> I maybe missing some spinlocks somewhere.

If you are using per-cpu hardware timers, no spinlock is needed, since
each cpu accesses its own timer. If you are using the same (hardware)
timer on several cpus, then it is not going to work anyway, Xenomai
wants one hardware timer per cpu.

-- 
                                                                Gilles.

