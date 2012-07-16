MIME-Version: 1.0
Date: Mon, 16 Jul 2012 14:11:37 +0430
Message-ID: <CAKKWdtdjPVbTmUMRgXYuH_9y0Gjrcqa-KvLQWPzo2EA+x0t13Q@mail.gmail.com>
From: ali hagigat <hagigatali@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Subject: [Xenomai] question: periodic system timer
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Xenomai@xenomai.org

When the system clock is set as periodic for a skin, does this mean
that the timer interrupt happens for the period and for any function
of that skin? or only some functions? This interrupt rate happens
after the skin API function is called?
So after returning the function and before executing any other
instruction, the timer mode gets back to one-shot?

