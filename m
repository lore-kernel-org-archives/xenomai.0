From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <da7cbdb7-b3fc-c09b-1df3-63d7602ac35e@xenomai.org>
Date: Sun, 17 Dec 2017 20:20:23 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: [Xenomai] Looking ahead, for fun
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "Xenomai@xenomai.org" <Xenomai@xenomai.org>


Dual kernel systems such as Cobalt need Linux to exhibit a high-priority
execution stage, for running out of band co-kernel activities. This is
the purpose of the I-pipe layer, patched in the mainline kernel for
supporting Cobalt.

In order to keep pace with mainline Linux development, this mechanism
should be simple, and properly integrated as a plain Linux feature, not
sideways. In other words, it must be possible to maintain it with common
kernel development knowledge, at a fraction of the engineering and
maintenance cost native preemption requires. For multiple reasons, the
I-pipe can not fully qualify.

So I started experimenting with new ideas, trying new options, with no
pressure on delivering anything, and I have absolutely no clue whether
this will get us anywhere. This said, upstreaming a lightweight dual
kernel technology to the greater community so we can address specific
but critical use cases at a small cost is a goal of this work.

Jorge Ramirez already joined me for working on the ARM64 implementation,
we would welcome the help of those interested in building on this idea.
More details can be read at [1].

Thanks,

[1] https://xenomai.org/looking-ahead/

-- 
Philippe.


