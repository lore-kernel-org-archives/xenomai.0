Message-ID: <5386505E.2030904@xenomai.org>
Date: Wed, 28 May 2014 23:08:46 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <CAO0fa7ZiofUS3wsbx89uYsnt6icuv+DVcDbiEfVyG5DUeprj2w@mail.gmail.com>
 <5382E8B1.8070402@xenomai.org>
 <CAO0fa7YQ0TxiAhbmFmt+41o+rugoLXKjXxtHygpthNOiu8gd9w@mail.gmail.com>
 <5383406C.4070902@xenomai.org>
 <CAO0fa7YavfJxxLW6h3Wm8CRmS2+yb9Uhv5RDfsv04+pcpvorFg@mail.gmail.com>
 <CAO0fa7byLgJQ2_sLDtJLmjsf=oh2NF7k37qnWWxmwhZW6N1ksw@mail.gmail.com>
 <CAO0fa7YGSCmPducStbh7sM=HJtPYq86iO1e2ZAaKyjUjzPMEUA@mail.gmail.com>
 <5385F190.7050303@xenomai.org>
 <C528C59E-AFE8-4810-AC6F-E58A2C1DA47D@mah.priv.at>
 <538622C8.6000906@xenomai.org>
 <E8636526-7C80-4789-99F1-C570732F6928@mah.priv.at>
 <538648DB.1000008@xenomai.org>
 <CAO0fa7aDo1fzGfvYUt89-vMrt9oksJhQdGSdfN8LMBzRc_FtVQ@mail.gmail.com>
In-Reply-To: <CAO0fa7aDo1fzGfvYUt89-vMrt9oksJhQdGSdfN8LMBzRc_FtVQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] gdb / threads on beaglebone black
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Drew <pythondrew@gmail.com>, Philippe Gerum <rpm@xenomai.org>
Cc: "Xenomai@xenomai.org" <xenomai@xenomai.org>

On 05/28/2014 11:01 PM, Drew wrote:
> I've only been using the machinekit pre-built kernel so rebuilding might
> take me a little while figure out.
> 
> Gilles: you think you have this bug in a corner (entry.S?)

I can reproduce the bug. It is most certainly related to system call
restarting, but I am not quite sure of what happens yet. My BUG_ON
trigs, but I do not understand why, and the reason of the BUG_ON is not
what causes the -ENOSYS. I can not really use the I-pipe tracer, because
everything happens in assembly code with very few function calls.

So, it may be a while before I produce a fix.

-- 
                                                                Gilles.

