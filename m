MIME-Version: 1.0
From: C Smith <csmithquestions@gmail.com>
Date: Sun, 18 Nov 2018 22:38:37 -0800
Message-ID: <CA+K1mPFcJwvsSJQP_qAs0F01zPqzPtHD7fA6AqFXX71vrSyD0w@mail.gmail.com>
Subject: spinlock_irq...() supported in Xenomai 2.6.5 ?
Content-Type: text/plain; charset="UTF-8"
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

I am porting an old Linux kernelspace driver to Xenomai 2.6.5 using RTDM
API.
I see calls to spinlock_irq_save() and spin_unlock_irqrestore() in the old
kernel driver code, right in the middle of an interrupt handler.

Are those spinlock calls 'wrapped' by Xenomai 2.6.5 such that they work,
and execute in Primary mode? Is calling these a bad thing to do in the
middle of an RTDM interrupt, will it try to switch to Secondary mode ?

thanks,
C Smith
