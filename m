From: Steve Hartmann <shartmann@cnt.canon.com>
Date: Tue, 21 Oct 2014 20:11:51 +0000
Message-ID: <D06C2835.195D7%shartmann@cnt.canon.com>
Content-Language: en-US
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Subject: [Xenomai] /proc/xenomai/sched
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Xenomai <xenomai@xenomai.org>

Can someone please point me in the direction of a writeup of how to interpr=
et /proc/xenomai/sched?  I have searched around, but cannot find what I am =
looking for.  Specifically, I want to know what it means when I see a "D" i=
n the "STAT" column, and what the number in the "TIMEOUT" column means.

I did find one post that said the "D" means "Delayed (without any other wai=
t condition).". Maybe I'm just dense, but I'm not positive on what that mea=
ns.  I think it might mean that the task should be running, but it is delay=
ed because it could not be scheduled because of some reason perhaps another=
 higher priority task is bumping it?  Or am I way off base?

Also, in xenomai 2.4.7, the TIMEOUT column is expressed in a number with no=
 units; what is the unit?

Thanks,

Steven
