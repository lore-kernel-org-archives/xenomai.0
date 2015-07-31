Date: Fri, 31 Jul 2015 16:04:54 +0000 (UTC)
From: Frederik Bayart <frederik_bayart@yahoo.co.uk>
Message-ID: <1296936493.6476410.1438358694470.JavaMail.yahoo@mail.yahoo.com>
In-Reply-To: <55BA5273.8020402@xenomai.org>
References: <55BA5273.8020402@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] xenomai-3.0-rc5 : binding named semaphores from
 external process
Reply-To: Frederik Bayart <frederik_bayart@yahoo.co.uk>
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "xenomai@xenomai.org" <xenomai@xenomai.org>

>On Thursday, 30 July 2015, 18:36, Philippe Gerum <rpm@xenomai.org> wrote:
>On 07/30/2015 04:28 PM, Frederik Bayart wrote:
>>> On 07/29/2015 08:27 PM, Philippe Gerum wrote:
>>>>
>>>> Please merge the commit on top of -rc6 I mentioned this morning, which
>>>> fixes the spurious wake up:
>>>>
>>>> http://git.xenomai.org/xenomai-3.git/commit/?h=next&id=081cbb8b150f30a019245dfb0e2f0b92cc7f2dfd
>>>>
>>>
>>> Actually, I did not mention it, that's why we don't seem to be on the
>>> same page, sorry for this. We should resume the discussion from the
>>> situation obtained with this commit on top of -rc6.
>>
>> I have build a new rc6 kernel & libraries with the new kernel/cobalt/posix/sem.c
>> The rt_sem_p problem is now solved, the first process is not interrupted anymore.
>>
>> I still doesn't see the fuse file system like you do.  I'm looking to other problems (select/connect/send/recv on UNIX domain sockets) so I hope that this is not the cause.
>>
>> I found already that 'select' on  socket(PF_UNIX, SOCK_STREAM, 0)  causes Interrupted system call (errno 4).
>> If I replace 'select' with '__real_select' the problem seems to be solved, and the select timeout works.
>> But the select doesn't seem to react on connect. I'm looking at the problem.
>>
>> Maybe I will see more if I build with --enable-debug.
>>
>> This is the fuse data of the system :
>>
>> $ sudo ./stest  --dump-config|grep REGISTRY
>> based on Xenomai/cobalt v3.0-rc6 --
>> CONFIG_XENO_REGISTRY=1
>> CONFIG_XENO_REGISTRY_ROOT="/var/run/xenomai"
>>
>> Is this what I'm supposed to see ?
>>
>
>Yes.
>
>> I configured CONFIG_FUSE_FS=m in the kernel, module fuse is loaded.
>> The fuse packages are installed :
>> ii  fuse            2.9.3-15+b1  amd64    Filesystem in Userspace
>> ii  gvfs-fuse        1.22.2-1    amd64    userspace virtual filesystem - fuse server
>> ii  libfuse-dev      2.9.3-15+b1  amd64    Filesystem in Userspace (development)
>> ii  libfuse2:amd64  2.9.3-15+b1  amd64    Filesystem in Userspace (library)
>>
>> $ xeno-config --info
>> Xenomai version: Xenomai/cobalt v3.0-rc6 --
>> Linux dev-x10sae 3.18.12-x86-64-xeno-3.0.rc6.1 #1 SMP PREEMPT Thu Jul 30 12:38:10 CEST 2015 x86_64 GNU/Linux
>> Kernel parameters: BOOT_IMAGE=/boot/vmlinuz-3.18.12-x86-64-xeno-3.0.rc6.1 root=UUID=fc8ecefa-fc73-487f-a045-cffa99c38a11 ro quiet console=tty0 console=ttyS0,115200n8
>> I-pipe release #1 detected
>> Cobalt core 3.0-rc6 detected
>> Compiler: gcc version 4.9.2 (Debian 4.9.2-10)
>> Build args: --prefix=/usr --includedir=/usr/include/xenomai --mandir=/usr/share/man --with-testdir=/usr/lib/xenomai/testsuite --with-core=cobalt --enable-smp --enable-pshared --enable-registry --build x86_64-linux-gnu build_alias=x86_64-linux-gnu
>>
>>
>> If I run the 2 stest processes, this is what I see :
>> $ find /var/run/xenomai/
>> /var/run/xenomai/
>> /var/run/xenomai/root
>> /var/run/xenomai/root/foo
>> /var/run/xenomai/root/foo/20678
>> /var/run/xenomai/root/foo/20667
>> /var/run/xenomai/root/foo/system
>>
>> $ mount | grep fuse
>> fusectl on /sys/fs/fuse/connections type fusectl (rw,relatime)
>> sysregd on /run/xenomai/root/foo/system type fuse.sysregd (rw,nosuid,nodev,relatime,user_id=0,group_id=0,default_permissions)
>> stest on /run/xenomai/root/foo/20667 type fuse.stest (rw,nosuid,nodev,relatime,user_id=0,group_id=0,default_permissions)
>> stest on /run/xenomai/root/foo/20678 type fuse.stest (rw,nosuid,nodev,relatime,user_id=0,group_id=0,default_permissions)
>
>I suspect a permission issue, since you attempt to traverse the mount
>points apparently with regular user privileges. Any luck with "sudo find
>..." ?
>
>Alternatively, passing --shared-registry to your app would enable public
>access to the registry of your application.

This was the cause, thank you !

Frederik
>
>-- 
>Philippe.

