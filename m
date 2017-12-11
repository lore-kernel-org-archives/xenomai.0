Date: Mon, 11 Dec 2017 15:21:55 +0100
From: Henning Schild <henning.schild@siemens.com>
Message-ID: <20171211152155.54650ccd@md1em3qc>
In-Reply-To: <CAKJ14Nccx5_Up-7dDK1U1Meu_vQA5TgxoHkyML8dcFDZMdbYwA@mail.gmail.com>
References: <CAKJ14Nccx5_Up-7dDK1U1Meu_vQA5TgxoHkyML8dcFDZMdbYwA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] mode switch caused by __lll_lock_wait_private()
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Andreas Glatz <andi.glatz@gmail.com>
Cc: xenomai@xenomai.org

Am Fri, 8 Dec 2017 13:14:16 +0000
schrieb Andreas Glatz <andi.glatz@gmail.com>:

> Hi
> 
> We're testing our application now by running it continuously over
> weeks. I randomly reports the following mode switches in the log:
> 
> <SIGXCPU: MSW(invoked syscall) BT(4): 0x2ade5bc8 0x2af95840
> 0x2b03a420 0x93980 >
> 
> With the process memory map from /proc/<pid>/maps:
> 
> ...
> 2af68000-2b084000 r-xp 00000000 00:0d 22235 /lib/libc-2.14.1.so
> ...
> 
> and output from <cross-arm>-objdump -d /lib/libc-2.14.1.so
> 
> I could figure out that 0x2b03a420 corresponds to glibc's
> __lll_lock_wait_private() function, which seems to cause SIGXCPU.

I guess translating the other 3 ips to symbols would be helpfull as
well ;).

> Before digging any deeper did anyone else see Xenomai mode switches
> caused by this glibc function (google says that it's e.g. used for
> managing concurrent access to rand())?

There are probably a lot of glibc functions that you should not call.
With SIGXCPU and a backtrace such pits are easy to find and not fall
in. That said, i am afraid it will be hard to maintain a list of such
functions. Because people that find the problem will avoid the
function and maybe not report their finding. And whether or not a
function is affected depends on the library
implementation/version/configuration. But in general there is a
mechanism to mark evil functions that just modeswitch every one in a
while.
One example from libstdc++ are the static constructor functions
__cxa_guard_*.

Henning

> Cheers,
> 
> A.
> 
> _______________________________________________
> Xenomai mailing list
> Xenomai@xenomai.org
> https://xenomai.org/mailman/listinfo/xenomai


