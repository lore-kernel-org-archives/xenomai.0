MIME-Version: 1.0
Date: Tue, 4 Dec 2012 17:53:04 +0100
Message-ID: <CANKLDmvSr6j-=6T-YGCG8byGsZ6oy_7sTmcknL7YC8uk9ymTrQ@mail.gmail.com>
From: Henri Roosen <henriroosen@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Subject: [Xenomai] Strange behavior calling certain libraries from
	non-realtime shadow task
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

I have a task that is using the libvlc (v2.0.4) library to play some media
streams. This all works when it is a normal posix task. When the task is a
non-realtime shadow task (prio 0, autorelax), then the shared libraries
that libvlc loads (its plugins, codecs etc) get corrupted on disk. A second
run of the program is not working.

Does anyone know what can be causing this? I was under the impression an
autorelaxed shadow task was allowed to make all Linux calls. Are there
known limitations or is this a bug?

Platform: x86
Xenomai 2.5.6
Linux 2.6.38.8

Thanks,
Henri
