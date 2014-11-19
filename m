Resent-Message-ID: <20141119115640.GB29491@sisyphus.hd.free.fr>
Resent-To: xenomai@xenomai.org
Date: Wed, 19 Nov 2014 12:51:36 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20141119115136.GA29491@sisyphus.hd.free.fr>
References: <314E5ECDAA86314791309FA670550F89C9C3743B@SINTEFEXMBX05.sintef.no>
 <20141119082140.GX3177@sisyphus.hd.free.fr>
 <314E5ECDAA86314791309FA670550F89C9C3972E@SINTEFEXMBX05.sintef.no>
 <20141119102352.GC25848@sisyphus.hd.free.fr>
 <314E5ECDAA86314791309FA670550F89C9C397B8@SINTEFEXMBX05.sintef.no>
 <20141119104519.GD25848@sisyphus.hd.free.fr>
 <314E5ECDAA86314791309FA670550F89C9C39892@SINTEFEXMBX05.sintef.no>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <314E5ECDAA86314791309FA670550F89C9C39892@SINTEFEXMBX05.sintef.no>
Subject: Re: [Xenomai] xnintr_irq_handler: IRQ135 not handled. Disabling IRQ
 line.
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Terje =?utf-8?Q?Fr=C3=B8ysa?= <Terje.Froysa@sintef.no>

On Wed, Nov 19, 2014 at 11:28:06AM +0000, Terje Frøysa wrote:
> How can I wee better?

I meant "see" better, sorry.

> 
> I have checked the posix-api.pdf ... It has 37 references to "struct timespec" but no definitions.
> The Xenomai API have 203 documents referring the "struct timespec", but I simply can't find the definition...?
> (But, the "nanosecs_abs_t" definition is easy to find though).
> 
> Have tested it in my program by (long)time_now =  tp.tv_nsecs.
> No warning....

The struct timespec is part of the POSIX standard, and documented by
the glibc, so since Xenomai uses the glibc definition, there is no
need to document it in Xenomai documentation.

The glibc documentation:
http://www.gnu.org/software/libc/manual/html_node/Elapsed-Time.html



> 
> The only timespec definition I can find on the web is the open-source:
> 
> struct timespec
> {
>   time_t tv_sec;
>   long tv_nsec;
> };

So, it turns out the struct has two members and not only one 32 bits
member. How strange? Does not it fit my anwer?

-- 
					    Gilles.

