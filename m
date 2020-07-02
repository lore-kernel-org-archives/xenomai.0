MIME-Version: 1.0
From: Richard Weinberger <richard.weinberger@gmail.com>
Date: Thu, 2 Jul 2020 10:32:39 +0200
Message-ID: <CAFLxGvxru2Y==qboUgwHdsQvOT5MEL2O8CexkhkQpKz0Qj+jqw@mail.gmail.com>
Subject: RTDM module ownership
Content-Type: text/plain; charset="UTF-8"
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Xenomai <xenomai@xenomai.org>

Hi!

I'm working on a kernel module which is used on plain Linux and
Xenomai (RTDM), while reviewing RTDM to understand refcounting I found
something that is not entirely clear to me.

Why does __rtdm_dev_open() not grab a reference on the RTDM module owner?
This leads to the case where one can rmmod the module while it is in use.
Unloading will block uninterruptible in rtdm_dev_unregister() in the
module's cleanup funktion.

In contrast, on regular Linux rmmod will refuse to unload the module
if the device node is still open because fops_get() or other helpers
gained a reference on the owner.

-- 
Thanks,
//richard

