From: "Mnatsakanyan, M." <m.mnatsakanyan@tue.nl>
Date: Tue, 25 Mar 2014 16:03:26 +0000
Message-ID: <6781B7C7F03D8A4BAF673DC4478144C406908D51@XSERVER21A.campus.tue.nl>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: [Xenomai] Switch to secondary mode due to pop/push into TBB queue
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "xenomai@xenomai.org" <xenomai@xenomai.org>

Hello,

I am trying to build a real-time application, but still do not understand a=
ll Xenomai concepts clearly, so I'm having difficulty to explain why my rt =
task switches to secondary mode.

My tasks communicate using TBB concurrent_bounded_queue. Whenever the tasks=
 push or pop into the queue they switch to secondary mode.

I am aware of RT_QUEUE provided by Xenomai, but I would like to avoid makin=
g this change.
My question is: is it possible to prevent mode switch while still using TBB=
 queue? And how this mode switch can be explained? I read that system calls=
 cause mode switch, but here I cannot recognize a system call.

Thank you,
Mari

