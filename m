MIME-Version: 1.0
From: Richard Weinberger <richard.weinberger@gmail.com>
Date: Tue, 25 Sep 2018 21:30:50 +0200
Message-ID: <CAFLxGvzkpeCRKVJ6O5LDpjFJ=oT7g4=5mQyCKVgwywtTchyvkQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: [Xenomai] compat_ioctl?
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Hi!

I'm evaluating how to migrate an 32-bit system to x86_64.
The plan is having just the kernel 64-bit and userspace still 32-bit.
Since we have plenty of custom kernel drivers which are used by the
real-time application,
I wonder whether Xenomai has a concept like Linux's compat_ioctl()?
Somehow I have to convert data when userspace does ioctl() to 64-bit
kernel drivers.

-- 
Thanks,
//richard

