Date: Mon, 15 Dec 2014 13:51:36 +0100
From: "Mariusz Janiak" <mariuszjaniak@wp.pl>
Message-ID: <548ed95828a095.41388325@wp.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
Subject: [Xenomai] RTnet compilation issues with kernel above 3.10
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Xenomai <xenomai@xenomai.org>

Hi,

I have prepared a patch that should fix the RTnet compilation issues on a k=
ernel 3.10 and higher, especially the latest supported 3.14.17 by the Xenom=
ai 2.6.4. It is based on the Anders Blomdell patch

http://sourceforge.net/p/rtnet/mailman/message/32034653/

supplemented with missing parts. Patch should be applied to original RTnet =
git repository. =


Best regards,
Mariusz Janiak =

-------------- next part --------------
A non-text attachment was scrubbed...
Name: 0001-Fix-compilatin-issues-on-kernel-above-3.10.patch
Type: text/x-patch
Size: 46037 bytes
Desc: not available
URL: <http://www.xenomai.org/pipermail/xenomai/attachments/20141215/5e590e5=
6/attachment.bin>
