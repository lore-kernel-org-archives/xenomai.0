Message-ID: <f7e5785057e2a9f6fe8374e56cd44d47.squirrel@sourcetrek.com>
In-Reply-To: <E1Z6JYL-0001WU-7T@sd-51317.xenomai.org>
References: <E1Z6JYL-0001WU-7T@sd-51317.xenomai.org>
Date: Sat, 20 Jun 2015 16:41:49 +0200
From: "Gilles Chanteperdrix" <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Xenomai] [Xenomai-git] Jan Kiszka : cobalt/kernel: Fix mode of
 mayday syscall
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org


git repository hosting wrote:
> Module: xenomai-jki
> Branch: for-forge
> Commit: c806b60eaf505aafd4dbeeaf59cd3fc6d68703fa
> URL:
> http://git.xenomai.org/?p=xenomai-jki.git;a=commit;h=c806b60eaf505aafd4dbeeaf59cd3fc6d68703fa
>
> Author: Jan Kiszka <jan.kiszka@siemens.com>
> Date:   Fri Jun 19 15:59:15 2015 +0200
>
> cobalt/kernel: Fix mode of mayday syscall
>
> The oneway mode meant norestart, thus return -EINTR instead of retrying
> the syscall after signal processing. But this caused damaged to the
> register state of the mayday-interrupted thread, most visible on x86-64
> where RAX is holding the RIP.

And this can not be fixed, because ?


-- 
                                            Gilles.
https://click-hack.org


