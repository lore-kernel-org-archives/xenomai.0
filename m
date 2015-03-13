MIME-Version: 1.0
Sender: had2006@gmail.com
Date: Fri, 13 Mar 2015 18:40:32 +0000
Message-ID: <CAKk99t1V-yP_QqD1_zZM3of8o7USJirH6kytBtND-+UuuKx6Hw@mail.gmail.com>
From: Helder Daniel <hdaniel@ualg.pt>
Content-Type: text/plain; charset=UTF-8
Subject: [Xenomai] RTDM suport in kernel space over Mercury?
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "Xenomai@xenomai.org" <xenomai@xenomai.org>, hdaniel@iualg.pt

I tried unsuccessfully to compile kernel modules with RTDM suport over
Mercury.

That was before I learned that in v3.x /usr/xenomai/include is just for
user space.

So I guess that since the kernel supporting headers are patched to the
kernel source tree with ipipe-core patch, RTDM support for kernel space is
only available in Cobalt.

Can you tell me if is this right?
