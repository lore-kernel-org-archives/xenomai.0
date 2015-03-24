MIME-Version: 1.0
Date: Tue, 24 Mar 2015 13:54:42 +0200
Message-ID: <CAOgYGPq2882YFEd+r97TTO41u-KD1GTfVzUtoH3jjVz9NUM42Q@mail.gmail.com>
From: r t <rolandtollenaar@gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: [Xenomai] xenomia on virtual box
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Hi,

perhaps a silly question but we are trying to get our pre- xenomai patched
kernel to run on VirtualBox. Playing about a bit. Well we already have it
running that is not the problem.

The question is whether there is any chance that we will get good (or any)
latency/ realtime performance if the kernel was compiled on another machine
other than the host environment currently hosting the VirtualBox?

Instructions to achieve what we are playing with explicitly state that the
kernel must be compiled on the host then installed on the guest which leads
to believe (as I would intuitively expect) that it is not possible to
abstract a xenomai environement from the hardware. However to my surprize
the xenomai patched kernel does noet seeem to have to run on the host.  How
does xenomai on the guest machine achieve good realtime performance if the
host is still free to act as it wishes in terms of accessing hardware?


Can anyone perhaps shed some light on this?

Regards,

Roland
