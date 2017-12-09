Message-ID: <477CBDCD49BA4AC1BE6D820DA1BE30EE@itd206>
From: "Sureshvs" <sureshvs@datapatterns.co.in>
Date: Sat, 9 Dec 2017 16:39:29 +0530
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: [Xenomai] Reg:synchronization between Qthread and posix pthread
	with semaphore
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org
Cc: bhargavram.chowdary@industeqsite.com

Hi

ARCH:x86
Kernel : 4.4.43
ipipe: ipipe-4-4.43-x86-8.patch
xenomai: 3.0.5

We are using cobalt posix semaphore(sem_post) for synchronize between =
posix thread and Thread(sem_wait).
The problem is semaphore not blocking in QT thread.Kindly helps to solve =
the problem.It return value -1 (EPERM)

Suggest how to use synchronization service between Qt thread and xenomai =
userspace.

Regards
Suresh V.S



