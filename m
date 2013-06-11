MIME-Version: 1.0
From: Ronny Meeus <ronny.meeus@gmail.com>
Date: Tue, 11 Jun 2013 12:22:52 +0200
Message-ID: <CAMJ=MEd730W6nxpnPPD4upj_8uk41=kJ-yXcz1qCWfsNBa=Qeg@mail.gmail.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: [Xenomai] [xenomai-forge] psos interface: sm_p call ignores flags
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Hello

We have observed that the SM_NOWAIT flag is not taken into account for the
sm_p service call.
If the sm_p is called with the SM_NOWAIT flag and a timeout of 0, the call
never returns while it is expected that the timeout value is not taken into
account at all.

This is solved with the attached patch.

---
Ronny
-------------- next part --------------
A non-text attachment was scrubbed...
Name: semaphore-apply-nowait-flag.patch
Type: application/octet-stream
Size: 647 bytes
Desc: not available
URL: <http://www.xenomai.org/pipermail/xenomai/attachments/20130611/df8620c=
b/attachment.obj>
