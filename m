MIME-Version: 1.0
From: Peter Soetens <peter@domain.hid>
Date: Tue, 6 Jul 2010 21:25:39 +0200
Message-ID: <AANLkTik-cpk4RfJGxj422mOvU1xQFdQCfB8gno7uzD7N@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: [Xenomai-help] native: A 32k stack is not always a 'reasonable' size
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai-help <xenomai@xenomai.org>

At least, not for Orocos applications. We've had hard to debug
application segfaults that used just a 'little' bit more than 32k. We
had to raise the stack size to 128k to get reliably through our
application startup. I stem from the old 'mlockall ate my RAM'
generation where we typically reduced stack sizes in order to have
some crumbles left for the heap. But 32k wasn't really what we were
aiming for.

Maybe we should explicitly document the 32k limit and its limitations
for certain applications...?

Just my 2ct,
Peter

PS: can anyone allow 'sspr' (=me) to edit/add stuff on the wiki ?

