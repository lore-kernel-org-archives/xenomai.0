References: <20170907153622.Horde.hT_sRaGS6VmkuifQTO4pqBa@office.mrmoco.com>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <2ceb59af-770f-d99f-1f6a-553a669d20b5@xenomai.org>
Date: Fri, 8 Sep 2017 20:07:09 +0200
MIME-Version: 1.0
In-Reply-To: <20170907153622.Horde.hT_sRaGS6VmkuifQTO4pqBa@office.mrmoco.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Questions around porting app to Xenomai/Cobalt
 resulting in SIGABRT ?
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Paul Wilkinson <paul.w@mrmoco.com>, xenomai@xenomai.org

On 09/07/2017 05:36 PM, Paul Wilkinson wrote:
> XenomaiDemo Server listening for clients on port 26000
> [New Thread 0x7fffef7fe700 (LWP 3493)]
> terminate called after throwing an instance of 'std::system_error'
>   what():  Operation not permitted
> 
> Program received signal SIGABRT, Aborted.
> [Switching to Thread 0x7fffef7fe700 (LWP 3493)]
> 0x00007ffff69fc067 in __GI_raise (sig=sig@entry=6) at
> ../nptl/sysdeps/unix/sysv/linux/raise.c:56
> 56    ../nptl/sysdeps/unix/sysv/linux/raise.c: No such file or
> directory.
> (gdb) bt
> #0  0x00007ffff69fc067 in __GI_raise (sig=sig@entry=6) at
> ../nptl/sysdeps/unix/sysv/linux/raise.c:56
> #1  0x00007ffff69fd448 in __GI_abort () at abort.c:89
> #2  0x00007ffff72e9b3d in __gnu_cxx::__verbose_terminate_handler() () from
> /usr/lib/x86_64-linux-gnu/libstdc++.so.6
> #3  0x00007ffff72e7bb6 in ?? () from
> /usr/lib/x86_64-linux-gnu/libstdc++.so.6
> #4  0x00007ffff72e7c01 in std::terminate() () from
> /usr/lib/x86_64-linux-gnu/libstdc++.so.6
> #5  0x00007ffff733fa01 in ?? () from
> /usr/lib/x86_64-linux-gnu/libstdc++.so.6

Do you have the libstdc++ debug package installed? It would be useful to
know which source location issues the exception. GDB is not able to
resolve the symbols in the libstdc++ DSO it seems.

-- 
Philippe.

