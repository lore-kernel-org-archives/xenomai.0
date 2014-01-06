Message-ID: <52CB0DA1.9080302@zultron.com>
Date: Mon, 06 Jan 2014 14:10:09 -0600
From: John Morris <john@zultron.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: [Xenomai] Xenomai Red Hat packaging
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Here are the packaging materials I've been using on Red Hat Enterprise
Linux clones for some time now, also recently updated for Fedora.

https://github.com/zultron/xenomai-rpm

The packaging is pretty straightforward, and follows the Debian
packaging for the xenomai-devel subpackage.

A significant addition is the 'xenomai-gid-ctl' script for configuring
non-root access to Xenomai services, plus sysv and systemd boot init
scripts.  I'd appreciate comments on the control script's correctness
and the init scripts' utility.

Thanks-

	John

