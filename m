Message-ID: <507C82E0.2030409@nta-inc.net>
Date: Mon, 15 Oct 2012 16:40:48 -0500
From: Jeff Webb <jeff.webb@nta-inc.net>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"; Format="flowed"
Subject: [Xenomai] Building deb packages under Ubuntu 12.04
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

In order to build a set of xenomai deb packages from the xenomai-2.6.git re=
po under ubuntu 12.04, I had to make the following change.  Otherwise, the =
build process aborts because it can't copy files into a non-existent direct=
ory.

-Jeff

-------------- next part --------------
A non-text attachment was scrubbed...
Name: xeno-deb.patch
Type: text/x-patch
Size: 552 bytes
Desc: not available
URL: <http://www.xenomai.org/pipermail/xenomai/attachments/20121015/97032be=
5/attachment.bin>
