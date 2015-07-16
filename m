References: <55A4DC2F.1090608@xenomai.org>
 <1504864203.3834276.1436964349384.JavaMail.yahoo@mail.yahoo.com>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <55A7CF2E.40508@xenomai.org>
Date: Thu, 16 Jul 2015 17:35:10 +0200
MIME-Version: 1.0
In-Reply-To: <1504864203.3834276.1436964349384.JavaMail.yahoo@mail.yahoo.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] xenomai-3.0-rc5 : binding named semaphores from
 external process
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Frederik Bayart <frederik_bayart@yahoo.co.uk>, "xenomai@xenomai.org" <xenomai@xenomai.org>

On 07/15/2015 02:45 PM, Frederik Bayart wrote:
> This works. I still notice 2 issues :
> 
> 1) If you execute reversely
> 
> ./stest --session=foo 0
> ./stest --session=foo 1
> 
> The first process binds to the named semaphore which is not yet created. According to the description of rt_sem_bind,  if the object does not exist on entry, the caller may block until a semaphore of the given name is created.
> 
> So based on this description, I would I expect that if the second process is started, the first process would bind and continue and blocks in the p operation. The same for the 2nd process. Is this correct ? At the moment, if I start the 2nd process, I get a segfault in rt_sem_create :
> 
> [ 9758.887921] [Xenomai] switching main to secondary mode after exception #14 from user-space at 0x7f6ad8c4a43e (pid 9256)
> [ 9758.887930] main[9256]: segfault at 7f903bf6e038 ip 00007f6ad8c4a43e sp 00007fffbd2c2eb8 error 6 in libcobalt.so.2.0.0[7f6ad8c3d000+1e000]
>

Looking at the copperplate code, yep, this definitely can't work. Ok,
queued.

> 
> 2)
> 
> The fuse filesystem is not unmounted. This is because in xenomai-3.0-rc5/lib/copperplate/regd/regd.c the fullpath is hardcoded to fusermount and umount
> 
> I could fixed it, with the diff below. It's not clear to me why access of umount is tested and not from fusermount.
> 

Piping the "which" output seems seriously overkill. Besides, we don't
want to rely on the environment to find those paths, we are running with
supervisor privileges (i.e. we don't want to run what the user tells us
what "umount" should be, but rather what the distro actually says
"umount" is).

Per LSB 3.0, /bin/umount would be the place to find this, so basically,
testing a couple of reasonable locations should be enough.

-- 
Philippe.

