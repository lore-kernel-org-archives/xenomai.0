MIME-Version: 1.0
From: Ronny Meeus <ronny.meeus@gmail.com>
Date: Mon, 22 Jul 2013 10:07:17 +0200
Message-ID: <CAMJ=MEc70e-1C+ZFVHzZ1ECDgomXThLR3FypCqPcJdP1kbwxQQ@mail.gmail.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: [Xenomai] [xenomai-forge] psos/sm_p: error handling not correct.
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

If the sm_p service is called with the SM_NOWAIT flag and the semaphore is
not available the EWOULDBLOCK error code is returned to the application.
This is not correct since the application expects to see only pSOS
errorcodes.

The attached patch solves the issue.

I have also included a small test application that can be used to verify
the code.

Best regards,
Ronny
-------------- next part --------------
A non-text attachment was scrubbed...
Name: semaphore-nowait-return-code.patch
Type: application/octet-stream
Size: 855 bytes
Desc: not available
URL: <http://www.xenomai.org/pipermail/xenomai/attachments/20130722/f191924=
c/attachment.obj>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: simple_sm_p.c
Type: text/x-csrc
Size: 715 bytes
Desc: not available
URL: <http://www.xenomai.org/pipermail/xenomai/attachments/20130722/f191924=
c/attachment.c>
