MIME-Version: 1.0
Date: Mon, 28 Oct 2013 16:37:24 +0330
Message-ID: <CAKKWdtfD3ZQOR9pVK1fG_z2fdxZziknh6p99OxCTWwLtZN45pw@mail.gmail.com>
From: ali hagigat <hagigatali@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Subject: [Xenomai] questions about scheduling
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai <xenomai@xenomai.org>, Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>

when rt_alarm_wait() is called the priority rises. so what is that
priority? is it between 1 to 99?
that priority is boosted only once and temporarily when the waiting
process is executed right after wait()?
or the base priority of that process changes afterwards?

