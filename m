MIME-Version: 1.0
Date: Sat, 9 Aug 2014 19:15:21 +0430
Message-ID: <CAKKWdteuWLz2YAhnsQZo9wH7T6o5F62du7MdZ+fZg6+A+JqBZQ@mail.gmail.com>
From: ali hagigat <hagigatali@gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: [Xenomai] a question about domains
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai <xenomai@xenomai.org>

I wonder if anybody can answer this and i apprecite in advance.
Nothing can change the current domain! as far as i looked in the code.
How is that possible?
does xnpod_schedule() can set a new current domain for a CPU?
It seems that current domian is set to "root" and keeps that forever.
Only some functions temporarily change "current domain" to "head" but
immediately it returns to "root" or "current domain".

