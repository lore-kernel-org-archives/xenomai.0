From: Michael Haberler <mail17@mah.priv.at>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Message-Id: <CE260BFE-CB8F-45DC-A46D-8CFE585069EC@mah.priv.at>
Date: Mon, 8 Jul 2013 15:23:43 +0200
Mime-Version: 1.0 (Mac OS X Mail 6.5 \(1508\))
Subject: [Xenomai] q on rt_task_self() and mode switching
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "xenomai@xenomai.org" <xenomai@xenomai.org>

if a userland RT thread gets modeswitched, the SIGXCPU handler obviously =
still executes in the RT domain, at least rt_task_self() returns a valid =
task descriptor - fine.

If a kernel RT thread misses the release point, it seems the thread is =
immediately switched to linux scheduling - or at least rt_task_self() =
returns NULL in this scenario:

int result =3D  rt_task_wait_period(&overruns);
    switch (result) {

    case -ETIMEDOUT: // release point was missed
	task =3D rt_task_self(); // this returns NULL


not a big thing - I just would like to get at the thread name for error =
message purposes; any way to do this?

- Michael





