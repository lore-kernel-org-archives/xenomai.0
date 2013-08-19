MIME-Version: 1.0
Date: Mon, 19 Aug 2013 09:06:20 -0400
Message-ID: <CAGQdp5zSpTPymv=J69LKaKSV0GxY-6TtKYVPVrvrOWG9fOURDw@mail.gmail.com>
From: Robert McCullough <robmccullough13@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Subject: [Xenomai] How to synchronize a non-realtime Linux thread with a
	Xenomai task?
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Hi,

I tried using a semaphore to synchronize the two, but when I call
rt_sem_p(...) in the  non-realtime Linux thread* *I
get the -EPERM error.

Is there a way to synchronize a non-realtime Linux thread with a Xenomai
task?

Rob McCullough
