MIME-Version: 1.0
Date: Tue, 11 Dec 2012 15:07:07 +0100
Message-ID: <CAPpP=rOpsiFBEZLFUrc_Sjf88J66Q0zDgmrNkaQ5O4xoz=iwYQ@mail.gmail.com>
From: alex alex <duch.alexandre@gmail.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable
Subject: [Xenomai] RTDM/POSIX - Select mask return value missing in case of
	timeout
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


The problem is the following:


When the timeout interval expires of the =93select=94 function the return v=
alue
of FD_ISSET(fdr,&readfds) is 1 whereas it should be 0.

In ksrc/skins/posix/syscall.c we can see that they are not copy to
userspace of select return value in case of timeout.



The attached code shows this bug with the use of a rtdm driver.



Alex.
