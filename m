From: Michael Haberler <mail17@mah.priv.at>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Date: Tue, 17 Dec 2013 12:19:37 +0100
Message-Id: <3A58CFC9-23B9-4B72-A071-3790BEB0912A@mah.priv.at>
Mime-Version: 1.0 (Mac OS X Mail 6.6 \(1510\))
Subject: [Xenomai] debian xenomai package
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "xenomai@xenomai.org" <xenomai@xenomai.org>

we're considering how to package LinuxCNC such that it can eventually be =
included in debian

the core package will support RT-PREEMPT because an RT-PREEMPT kernel is =
available stock in debian; the other RT kernels will be covered by =
separate packages (Xenomai, RTAI).

so far we've used the xenomai userland support straight off the git =
repo, but it might make sense to switch to =
http://packages.debian.org/jessie/xenomai-runtime for one less external =
raw repo dependency

question - is this a recommendable route?

(depends a bit on how well the debian package tracks the repo - does =
this happen 'occasionally', or per-release?; so far we havent had major =
issues with userland support but better ask before relying on something =
only loosely maintained)

thanks!

- Michael=20=

