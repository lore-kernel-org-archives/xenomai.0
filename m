MIME-Version: 1.0
Date: Tue, 26 Jun 2012 13:51:12 +0530
Message-ID: <CAM1yFZ-CZ8qkTS1MqFMiQJtg85UVM5QiDUcPKSGBWDMDj4LdLQ@mail.gmail.com>
From: Anisha Kaul <born.rebel.83@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Subject: [Xenomai] RT_TASK isn't needed for every program, is it?
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Xenomai <xenomai@xenomai.org>

>From what I've read here:
http://www.cs.ru.nl/lab/xenomai/exercises/ex01/Exercise-1.html
I could figure out that `RT_TASK`  is a kind of real time "thread" concept.

But in the cases where I don't need threads, can I simply write the
program in main() using Xenomai/RTnet API? Creating RT_TASK isn't
necessary for every program, is it?

-- 
Anisha Kaul

