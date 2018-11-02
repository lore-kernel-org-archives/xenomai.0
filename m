From: Sebastian Smolorz <Sebastian.Smolorz@gmx.de>
Subject: Re: [PATCH 0/4] net/tcp: Fix several bugs and allow rttcp to be built
Date: Fri, 02 Nov 2018 15:41:46 +0100
Message-ID: <4717946.93qni4ym1a@lenni>
In-Reply-To: <62f6ce84-8672-c6d4-a1a2-d9bc996c9ef0@siemens.com>
References: <1539775907-5124-1-git-send-email-sebastian.smolorz@gmx.de>
 <C2EC5BA46D13CD44B5915A8FEEB4C44EE545BC96@DDCEXCH.ddc-ny.com>
 <62f6ce84-8672-c6d4-a1a2-d9bc996c9ef0@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: "Pham, Phong" <phamp@ddc-web.com>, "Hillman, Robert" <hillman@ddc-web.com>, "xenomai@xenomai.org" <xenomai@xenomai.org>

On 31.10.18 19:18, Jan Kiszka wrote:
> On 31.10.18 17:55, Pham, Phong wrote:
> > Hi Sebastian,
> > 
> > The issue has to do with endianness.  We are running PowerPC (big
> > endian).  So in rt_tcp_set_flags(), flags is 32-bit wide and *tf is
> > 16-bit wide.  I modified the line from:
> > 
> > *tf = flags;
> > 
> > to
> > 
> > *tf = *(__be16 *)&flags;
> 
> Something is fishy with rt_tcp_set_flags. Shouldn't we rather ensure
> that only a __be16 flag value is passed to it?

I think the reason why flags are passed as __be32 is that they are defined 
with the help of __constant_cpu_to_be32().

After reading some TCP related code in the kernel I think that this 
issue is properly fixed by

tcp_flag_word(th) = flags;

I will test this for little endian. Phong, can you test this on your 
machine?

-- 
Sebastian




