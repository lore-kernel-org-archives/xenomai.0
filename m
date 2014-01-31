Message-ID: <52EC054C.9070707@xenomai.org>
Date: Fri, 31 Jan 2014 21:19:24 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <CAN1+YZVvgPNNHFub5QAkw6SeSUPuf1dv_94kYGqhbjMpNt70Sg@mail.gmail.com>
 <CAN1+YZWOjxf=s+6LH3Xymzx_mwWa6XmO_Xt7SHF589RzJCANBA@mail.gmail.com>
 <52D8609C.5050903@xenomai.org>
 <CAN1+YZW+nJgMb0hLy2JWZW6JrxA+mZzA+-oN-gjQgeGTcoe0jg@mail.gmail.com>
 <CAN1+YZUY_3FExF=qrUtMQDQxTqossnQsPCy6zfPjfqp8PitZCg@mail.gmail.com>
 <52D9984F.9080203@xenomai.org>
 <CAN1+YZWnLC=MLxWqYd9xH1URimWnOdEhU4mwZ0S3QFdpghUaGQ@mail.gmail.com>
 <52DAE756.3070606@xenomai.org>
 <CAN1+YZWmjvsu7My92EBktFhWYhheRJvdYrEq=r3+Ravp_Wzoyw@mail.gmail.com>
 <52DBC5FE.6060806@xenomai.org> <52DBD649.2000908@xenomai.org>
 <CAN1+YZWCMh4mR0ccw2v7FeuLKpYDUoPoB-FGHZmutj623DW7hw@mail.gmail.com>
 <52EB6BBC.8040600@xenomai.org>
 <CAN1+YZUhzb1zRE=dhjX+_1_b2cD2vEWatP6-je7b9NdNPosFvA@mail.gmail.com>
 <52EBE4B7.6060800@xenomai.org>
 <CAN1+YZXKAen4YAxKfG9TZTL8B5qXqA-u7O41-ZJqbHqCdbcyow@mail.gmail.com>
In-Reply-To: <CAN1+YZXKAen4YAxKfG9TZTL8B5qXqA-u7O41-ZJqbHqCdbcyow@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Fwd: Kernel Compilation Problems
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Andy Pugh <andy@bodgesoc.org>
Cc: xenomai <xenomai@xenomai.org>

On 01/31/2014 09:15 PM, Andy Pugh wrote:
> On 31 January 2014 18:00, Gilles Chanteperdrix
> <gilles.chanteperdrix@xenomai.org> wrote:
> 
>> I am afraid this is off-topic on this mailing list.
> 
> OK, thanks.
> 
> I will just say that, having figured out how to set the command line
> parameters (I needed a serial terminal that did actual terminal
> emulation, and I needed to edit a non-standard environment file) I
> seem to be able to isolate a CPU, but xeno-test fails when I also add
> the supported_cpus parameter (it runs fine without the parameter):
> 
> andypugh@udoo:~$ xeno-test

Ok, let us forget about xeno-test, could you try latency -c 0 (if 0 is
the supported cpu).

What do the kernel log say? Has xenomai started correctly?

-- 
                                                                Gilles.

