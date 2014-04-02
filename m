MIME-Version: 1.0
Date: Wed, 2 Apr 2014 18:19:16 +0100
Message-ID: <CAEbDrgmdy_u5O-1VW+sE6bF4xbM9QaQTtGZh7Ljf8TnDiCpT6w@mail.gmail.com>
From: Gregory Dymarek <gregd72002@gmail.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: [Xenomai]  [patch] Raspberry Pi - 3.10.34
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "xenomai@xenomai.org" <xenomai@xenomai.org>

Hi,

Enclosed patches needed to get Xenomai compiled on Raspbery Pi kernel
3.10.34 (github sha: 7cf0cf0d3e53b4c62f4931bb2d7cb60a1a07b132)

This is based on ipipe-core-3.10.18-arm-1.patch.

Steps:
1) get ipipe-core-3.10.18-arm-1.patch
2) patch it using rpi-ipipe-core-3.10.34-arm-1.patch
3) do prepare_kernel.sh or patch the kernel using the above patch
4) patch kernel using ipipe-core-3.10.34-arm-raspberry-post-1.patch
5) done

I've tested it multiple times including buildroot and works great.

Regards,
Gregory
-------------- next part --------------
A non-text attachment was scrubbed...
Name: rpi-ipipe-core-3.10.34-arm-1.patch
Type: text/x-patch
Size: 1509 bytes
Desc: not available
URL: <http://www.xenomai.org/pipermail/xenomai/attachments/20140402/e58c2d3=
c/attachment.bin>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: ipipe-core-3.10.34-arm-raspberry-post-1.patch
Type: text/x-patch
Size: 6899 bytes
Desc: not available
URL: <http://www.xenomai.org/pipermail/xenomai/attachments/20140402/e58c2d3=
c/attachment-0001.bin>
