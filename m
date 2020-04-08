Subject: =?utf-8?q?Re=3A_What_function_does_cobalt=5Fthread=5Fprobe=28=29_provides=2E?=
Date: Wed, 08 Apr 2020 11:55:35 +0200
From: =?utf-8?q?Petr_=c4=8cervenka?= <grugh@centrum.cz>
MIME-Version: 1.0
Message-Id: <20200408115535.628C1F0D@centrum.cz>
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Xenomai <xenomai@xenomai.org>, sunshilong369@gmail.com

Kill doesn't mean to "kill" anything, but to send a signal to a thread.
I bet that cobalt_thread_probe() is meant to send a signal 0 with no reaction, only to find out if the thread exists and is xenomai capable.
Petr

