Message-ID: <50F904C3.3060906@zultron.com>
Date: Fri, 18 Jan 2013 02:16:03 -0600
From: John Morris <john@zultron.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: [Xenomai] Redhat packaging patch
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Xenomai <xenomai@xenomai.org>

Here's a two-liner patch to Makefile.in that disables /dev entry
creation when 'make NODEVICES=3D1 install'.

RedHat packages are built as normal users, and there is no fakeroot
mechanism like Debian has, so devices must be recreated from a separate
script run after the rest of the package is unpacked.

Incorporating this patch into Xenomai makes it a little cleaner for RH
package maintainers, as we don't have to keep a separate patch in the
RPM sources.  Unfortunately, we still must continue maintaining the
%post script to create the devices.  :P

	John
-------------- next part --------------
A non-text attachment was scrubbed...
Name: xenomai-2.6-nodevices.patch
Type: text/x-patch
Size: 872 bytes
Desc: not available
URL: <http://www.xenomai.org/pipermail/xenomai/attachments/20130118/4a4e357=
1/attachment.bin>
