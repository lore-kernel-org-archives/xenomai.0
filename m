MIME-Version: 1.0
References: <CAFLxGvzkpeCRKVJ6O5LDpjFJ=oT7g4=5mQyCKVgwywtTchyvkQ@mail.gmail.com>
 <a8f62c37-5c4c-a85a-1638-95efb38d55b3@siemens.com>
In-Reply-To: <a8f62c37-5c4c-a85a-1638-95efb38d55b3@siemens.com>
From: Richard Weinberger <richard.weinberger@gmail.com>
Date: Tue, 25 Sep 2018 22:23:09 +0200
Message-ID: <CAFLxGvxMG7K-v_xmGzqdb2OwzGA=yqvJ1nj8GZvcvQ9-ZAPaZw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Xenomai] compat_ioctl?
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "J. Kiszka" <jan.kiszka@siemens.com>
Cc: xenomai@xenomai.org

On Tue, Sep 25, 2018 at 10:16 PM Jan Kiszka <jan.kiszka@siemens.com> wrote:
>
> On 25.09.18 21:30, Richard Weinberger wrote:
> > Hi!
> >
> > I'm evaluating how to migrate an 32-bit system to x86_64.
> > The plan is having just the kernel 64-bit and userspace still 32-bit.
> > Since we have plenty of custom kernel drivers which are used by the
> > real-time application,
> > I wonder whether Xenomai has a concept like Linux's compat_ioctl()?
> > Somehow I have to convert data when userspace does ioctl() to 64-bit
> > kernel drivers.
>
> Yes, this exists in Xenomai / RTDM as well, see e.g. the drivers under
> kernel/drivers/ipc.

Ahh, rtdm_fd_is_compat() is the key to success.
Thanks for pointing me in the right direction!

-- 
Thanks,
//richard

