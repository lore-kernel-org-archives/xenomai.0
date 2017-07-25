From: mathew.benson@gmail.com
Content-Type: text/plain;
	charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0 (1.0)
Date: Tue, 25 Jul 2017 07:48:46 -0500
Message-Id: <DEB5F512-B818-454D-A423-7CB391071BBD@gmail.com>
Subject: [Xenomai] rt_task_create fails
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

I ported Xenomai 3.0.5 to Petalinux 2017.1.  The supported tests run fine, b=
ut my code is failing.  rt_task_create always fails with errno set to 17 (EE=
XIST).  Doesn't matter what arguments I give it.  Before I dissect this furt=
her, does anybody have any insight?

Sent from my iPhone=

