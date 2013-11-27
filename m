Message-ID: <52962CC0.20505@geral.com>
Date: Wed, 27 Nov 2013 18:32:48 +0100
From: Alexandre COFFIGNAL <acoffignal@geral.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"; Format="flowed"
Subject: [Xenomai] rtcan_flexcan on a i.MX28 board
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Hi all.

I'm trying to use rtcan_flexcan on a i.MX28 board with Xenomai 2.6.3 =

under Linux v3.8.13.
I use a dtb file and it seem to be a mistake in flexcan_probe function.

If flexcan device id is found in dtb, devtype_data points to the =

flexcan_id_table driver_data structure. In this case, the condition in =

flexcan_probe function (!devtype_data && pdev->id_entry->driver_data) =

will always fail and it will always return ENODEV, whereas devtype_data =

points to a valid value.

I submit this patch which fixes this issue

Best regards,
Alex.
-- =

-------------- next part --------------
A non-text attachment was scrubbed...
Name: xenomai-rtcan_flexcan-fix-devtype_data-initialization.patch
Type: text/x-patch
Size: 857 bytes
Desc: not available
URL: <http://www.xenomai.org/pipermail/xenomai/attachments/20131127/cade88f=
3/attachment.bin>
