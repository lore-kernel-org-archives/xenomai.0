MIME-Version: 1.0
Date: Sat, 9 Jun 2012 13:35:44 +0430
Message-ID: <CAKKWdteQhq4HKEj0JAsfwsjE3aYAiYdqxG_QQ1Kh3o+jjHUUWw@mail.gmail.com>
From: ali hagigat <hagigatali@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Subject: [Xenomai] How much the user space code can effect the real time
	functionality?
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

I was heard that for making a real time Linux system based on Xenomai,
 the unnecessary services should be stopped. How those services can
effect the real time functionality? They are pre-empted by the timer
and the Xenomai real time scheduler.
Why not stopping them make a system non-real time?

