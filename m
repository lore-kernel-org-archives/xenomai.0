References: <5734D92F.1000206@siemens.com> <57350331.1020302@xenomai.org>
 <57356C0E.6080205@siemens.com> <5735D8E0.3040202@xenomai.org>
 <5735F39A.8050204@siemens.com> <57601E35.3010101@siemens.com>
 <5a98b862-5b1f-449c-8989-f7e3d4fe8255@xenomai.org>
 <5760227A.3010203@siemens.com> <20160614153852.GC23680@hermes.click-hack.org>
 <57602631.10900@siemens.com> <20160614155112.GD23680@hermes.click-hack.org>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <57602AC8.3070506@siemens.com>
Date: Tue, 14 Jun 2016 18:03:20 +0200
MIME-Version: 1.0
In-Reply-To: <20160614155112.GD23680@hermes.click-hack.org>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] RTDM syscalls & switching
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: Xenomai <xenomai@xenomai.org>

On 2016-06-14 17:51, Gilles Chanteperdrix wrote:
>> Sorry, there *is*: Shadowed thread (anything created by wrapped
>> pthread_create) calls, say, read() on some Linux file descriptor, read()
>> is wrapped, first probes the call on RTDM, which means migration to RT
>> (for currently relaxed threads, like SCHED_WEAK), no RTDM match in the
>> kernel, and finally the migration to NRT in order to do the Linux read()
>> syscall. That didn't happen with the original design.
> 
> The wrapped read does not get ping-pong when calling the Linux I/O
> syscalls. The term syscall means something very precise, and
> __wrap_read is not a syscall. It gets ping-pong because it calls
> RTDM I/O. But if you call directly Linux I/O syscall, with say
> __real_read, you do not get ping-pong. Linux I/O syscall work as
> they have always have: they require xenomai threads to run in
> secondary mode and will cause them to switch to secondary mode to
> handle the syscall.

__real_* are a non-portable workarounds for special cases. It's not what
Xenomai developers are supposed to use in their applications.

If it were, we could also give up on wrapping and have rt_task_create
etc. again, ie. separate APIs for RT and non-RT.

Jan

-- 
Siemens AG, Corporate Technology, CT RDA ITP SES-DE
Corporate Competence Center Embedded Linux

