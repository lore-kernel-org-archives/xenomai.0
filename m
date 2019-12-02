From: Philippe Gerum <rpm@xenomai.org>
Subject: Moving on
Message-ID: <7ef777be-f422-bd61-e19b-2b02772487f4@xenomai.org>
Date: Mon, 2 Dec 2019 17:05:06 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "Xenomai@xenomai.org" <Xenomai@xenomai.org>


It has been two years since I stepped down as Xenomai's lead maintainer.
In the meantime, Jan took over and did a very good job in this role as
expected.

Since this transition period is now taking an end, I'm switching focus
to the EVL project [1] I have been nurturing for some time, with the
goal to make it production-grade next year. In a nutshell, EVL is about
laying the groundwork for dual kernel systems to become first-class
citizens of Linux. This work includes a SMP scalable real-time core
which can be maintained with common kernel knowledge over the latest
mainline kernel series, a standard driver model, and a single, compact API.

I will still review patches coming my way for the I-pipe ARM and arm64
trees for a few weeks, until the next maintainer is appointed for these
architectures. I'll be around to help with Xenomai core issues if needed.

Thanks,

[1] https://evlproject.org/

-- 
Philippe.

