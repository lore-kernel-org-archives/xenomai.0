MIME-Version: 1.0
In-Reply-To: <4E75ED9E.9000708@domain.hid>
References: <CABm7fFPcAjLu3_xVi+t8fCYy_VYKR6A7pgTF-WeHv4ifw9V5qA@mail.gmail.com>
	<4E75ED9E.9000708@domain.hid>
Date: Sun, 18 Sep 2011 16:43:39 +0200
Message-ID: <CABm7fFP-zWkpqqmSVxuK-996LsW2xkG6g7L7SVHk2kcCnRpoSQ@mail.gmail.com>
From: Bertold Van den Bergh <vandenbergh@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai-core] Port to stmp3xxx (arm based)
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai@xenomai.org

Hello,

Thanks for the reply. The timer register has the following layout: bit
0-15: reload, bit 16-31: counter. Thats why I put 0xFFFF0000. Looking
at the code this cannot work so I added an extra field to indicate the
shift after applying the mask.

Now the userspace latency test prorgam gives valid latencies, sadly
it's still -1ms to 3ms latency.

How should I proceed troubleshooting this?
Looking at the ipipe trace it looks the task is brought op quite fast
after the interrupt fires so I think it is set at the wrong time, I'm
going to look into this.

Sincerely,
Bertold Van den Bergh
On Sun, Sep 18, 2011 at 3:09 PM, Gilles Chanteperdrix
<gilles.chanteperdrix@xenomai.org> wrote:
> On 09/17/2011 05:15 PM, Bertold Van den Bergh wrote:
>> Hello,
>>
>> I am trying to port Xenomai to the freescale stmp3xxx cpu (I.MX233).
>>
>> I added TSC code from plat-s3c24xx as this processor also uses a 16
>> bit downcounter based timer. I run the system tick counter and the TSC
>> freerunning counter at 32KHz (I plan to speed it up to increase
>> precision but I have a question about that). I have monitored the TSC
>> output and it is a monotonic count without jumps forward or backward.
>> Xenomai and linux boots fine. I can also start xenomai tasks, and they
>> even appear to work to some extent.
>
> The mask member filled by __ipipe_mach_get_tscinfo is wrong, the right
> mask for a 16 bits counter is 0x0000ffff
>
> --
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0Gilles.
>

