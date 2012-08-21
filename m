MIME-Version: 1.0
Date: Tue, 21 Aug 2012 10:16:35 +0430
Message-ID: <CAKKWdtfEMAJcH=UxGX7t0dhSwHGBs5XcfqbV+ioupxOVsXxCvw@mail.gmail.com>
From: ali hagigat <hagigatali@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Subject: [Xenomai] question: scheduling5
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Xenomai@xenomai.org

Suppose one Xenomai thread migrates to the secondary mode and keeps
its real time priority(it is 80 for example). How it can compete with
Linux threads as their priorities are in the range of 100 to 139. So
all Linux threads are scheduled first till some time passes and that
Xenomai thread gets higher effective priority. Is that right?

