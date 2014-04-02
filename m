MIME-Version: 1.0
Date: Wed, 2 Apr 2014 18:37:11 +0100
Message-ID: <CAEbDrgnR1aU-A6KDq7uRCKqV0=sj8yoQE_zUeiVdxmemdfnyMQ@mail.gmail.com>
From: Gregory Dymarek <gregd72002@gmail.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: [Xenomai]  [patch] prepare_kernel.sh --board argument
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

>From ealier discussion - given the evolution pace of ARM platforms, it
seems we will always have -pre and -post patches, so it would make
sense to add this support to prepare-kernel.sh.

Included patch that adds support for --board parameter to the
prepare_kernel.sh script. This will cause prepare_kernel.sh to apply
automatically pre and post patches if available.

When --board is provided the script will look for optional board
patches in the folder that ipipe patch is and in $board subfolder if
exsists.
It expects the patch name to be: {ipipe_base_name}-{board_name}-{pre,post}-*
Where {ipipe_base_name} is the ipipe name before the last '-'.

Example:
For ipipe-core-3.10.18-arm-1.patch and --board=3Draspberry it will look for:
- ipipe-core-3.10.18-arm-raspberry-{pre,post}-*.patch


Regards,
Gregory
-------------- next part --------------
A non-text attachment was scrubbed...
Name: prepare_kernel_board.patch
Type: text/x-patch
Size: 3051 bytes
Desc: not available
URL: <http://www.xenomai.org/pipermail/xenomai/attachments/20140402/e2e648f=
1/attachment.bin>
