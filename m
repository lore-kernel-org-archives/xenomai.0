Message-ID: <a7e2b8e6e4623f66073ed7256f00d22f.squirrel@sourcetrek.com>
In-Reply-To: <558579E2.9070507@web.de>
References: <558579E2.9070507@web.de>
Date: Sat, 20 Jun 2015 16:46:57 +0200
From: "Gilles Chanteperdrix" <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Xenomai] Mayday issues again
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jan Kiszka <jan.kiszka@web.de>
Cc: Xenomai <xenomai@xenomai.org>


Jan Kiszka wrote:
> Hi Philippe,
>
> the mayday mechanism is causing troubles to me again.
>
> First of all, there is a bug /wrt restarting the mayday syscall. We
> current don't restart on pending signals, thus destroy the register of
> the interrupted thread that contains the syscall return code. See my
> for-forge branch for a fix proposal.
>
> But actually I would like to get rid of the syscall trampoline
> completely if somehow possible, at least for certain archs. The reason
> is that it ruins debuggability. If a RT thread is stopped by gdb with
> the help of the mayday mechanism, it ends up waiting for resumption on
> the mayday page. Even worse, backtracing is broken, at least on x86.

The problem here seems to be mixing mayday with gdb. As its name
indicates, the mayday mechanism is something exceptional, that should not
happen during a casual debugging session with gdb.


-- 
                                            Gilles.
https://click-hack.org


