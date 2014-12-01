From: Mathew Benson <mathew.benson@gmail.com>
Content-Type: text/plain;
	charset=us-ascii
Message-Id: <5389961F-2DC1-43AA-8FEA-2BD0D3A61B7E@gmail.com>
Date: Sun, 30 Nov 2014 22:39:56 -0600
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0 (1.0)
Subject: [Xenomai] Performance monitoring question
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

I'm using the native skin.  I understand there are things you can do to caus=
e a user space task to fall back to the normal Linux scheduler.  How do I kn=
ow if this has happened?  Will RT functions like semaphores fail with an inc=
orrect mode failure?  Can I register a callback to be notified?

I'm asking because I added code to my project fully expecting it to kick it b=
ack to normal scheduler or cause timers to fail, but nothing.  Everything st=
ill seems to be working just fine.  Specifically, I'm making ioctl calls to a=
ccess a webcam.  So what can I do to verify that my tasks really are running=
 on the rt scheduler?

Sent from my Packard Bell 386=

