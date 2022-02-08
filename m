References: <PH1P110MB1050B0A0FEC4B2688FA36C01E22C9@PH1P110MB1050.NAMP110.PROD.OUTLOOK.COM>
From: Philippe Gerum <rpm@xenomai.org>
Subject: Re: Shared memory in evl driver
Date: Tue, 08 Feb 2022 11:35:32 +0100
In-reply-to: <PH1P110MB1050B0A0FEC4B2688FA36C01E22C9@PH1P110MB1050.NAMP110.PROD.OUTLOOK.COM>
Message-ID: <87h799y69l.fsf@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Russell Johnson <russell.johnson@kratosdefense.com>
Cc: xenomai@xenomai.org


Russell Johnson via Xenomai <xenomai@xenomai.org> writes:

> Hello,
>
> I currently have a linux driver used by my application that contains
> some global buffers that are updated based on various ioctl calls. If
> I add the EVL ioctl file descriptor to the driver, can I access the
> same buffer that is referenced by the normal ioctl call? As in, can
> both ioctl() and oob_ioctl() reference the same memory?

Yes. EVL files are regular linux VFS files extended with oob operations.
IOW, there is no separate "real-time file domain", there are real-time
operations added to the common linux files.

> If so, what
> would I need to keep in mind?

Nothing particular. You driver would accept both ways of accessing the
memory from oob and inband contexts, the onus is on the implementor for
avoiding access conflicts. In fact, the whole EVL core is based on this
approach: each basic mechanism (thread, monitor, proxy etc.) is
implemented as a mini linux driver, which exports a set of struct
file_operations mixing regular/inband and oob operations.

e.g. kernel/evl/proxy.c

static const struct file_operations proxy_fops = {
	.open		= evl_open_element,
	.release	= proxy_release,
	.oob_write	= proxy_oob_write,
	.oob_read	= proxy_oob_read,
	.oob_poll	= proxy_oob_poll,
	.write		= proxy_write,
	.read		= proxy_read,
	.poll		= proxy_poll,
	.mmap		= proxy_mmap,
};

As you can see, the usual ops make sense inband-wise, other oob-specific
ones are provided in order to control the device from the real-time
side as well.

> How would mutexes work since there is an
> interaction between evl and non-evl calls?

(EVL/glibc) mutexes won't do it, since they cannot serialize
inter-stage. If you really need to serialize access to these buffers
from threads which belong to different stages - at the expense of a
potential priority inversion though - I would suggest to have a look at
the so-called EVL stage exclusion lock, aka "stax" mechanism in the
kernel API. The doc is still WIP [1], but it gives the basic information
already.

In short, a stax allows you to temporarily exclude "the other side"
stage-wise. Say you have an oob thread currently traversing a
stax-guarded section of code, another oob thread would be allowed to
enter it as well, but inband threads would have to wait until the stax
is fully released by all oob holders. This works the converse way if the
stax is originally grabbed by an inband thread.

[1] https://evlproject.org/core/kernel-api/stax/

-- 
Philippe.

