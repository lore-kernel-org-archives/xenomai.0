MIME-Version: 1.0
Date: Mon, 2 Mar 2015 18:16:42 -0600
Message-ID: <CA+C+_XRjP-YeDZgOmumU+AMbuUOJEtiuJ7v5U-ijRrTQWv-qrw@mail.gmail.com>
From: Mathew Benson <mathew.benson@gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: [Xenomai] gdbserver hangs on rt_task_create()
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "xenomai@xenomai.org" <xenomai@xenomai.org>

When I step through my code, gdbserver hangs on rt_task_create() and never
comes back.  I'm using Xenomai 2.6.4.  I noticed in the archives several
other people ran into similar or identical problems in previous versions,
but I don't see a fix or workaround.
