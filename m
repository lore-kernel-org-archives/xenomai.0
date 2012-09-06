MIME-Version: 1.0
In-Reply-To: <CAHue_TX6R8i_8HSNNeBi-JLBv4MGMjtQH6JxGvgj5xqWzU3kkQ@mail.gmail.com>
References: <CAHue_TVRdTsre3E7NxHtb=6XfxkL7_36nsLLxSkiF3kUJAJ5Vw@mail.gmail.com>
	<5022B5E4.7040101@xenomai.org>
	<CAHue_TWodrVNxhsxXZ6_xcOGWHDqVGe41qbY0=R3RhFjBedG+g@mail.gmail.com>
	<50339840.1070202@xenomai.org>
	<CAHue_TVSGuatTqL4fRFoOABo4KTm8dFPmRFp7QJNmpk=ZU7NtQ@mail.gmail.com>
	<CAHue_TUKTiusLqfXK59O+PVoxONKAE2xQyBYOgjDh=dZZ2-b3w@mail.gmail.com>
	<504503DC.4040908@xenomai.org>
	<CAHue_TX3+pr39Mso1SXA83NWVRNoeocD-zDcLPk5mKn-XCkQKQ@mail.gmail.com>
	<50453DCE.5020601@xenomai.org>
	<CAHue_TUfY4f4CdCXyEYQ5mPFNiCazwZLgv9yy29W5r78tfftYA@mail.gmail.com>
	<50485E80.6050800@xenomai.org>
	<CAHue_TX6R8i_8HSNNeBi-JLBv4MGMjtQH6JxGvgj5xqWzU3kkQ@mail.gmail.com>
Date: Thu, 6 Sep 2012 15:44:04 +0200
Message-ID: <CAHue_TWY9enhqqG4N7nDmHi_iVesqU1o3EYopEJigOVMeB1hnw@mail.gmail.com>
From: =?ISO-8859-2?Q?Marcin_Ku=B6ka?= <marckuska@gmail.com>
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai] Cortex-a9 - please fix xenomai-fix-lfs-issue.patch
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

About that SLAB warning, there have been a small fix about this:

Signed-off-by: Michael Grzeschik <m.grzeschik@...>
---
 drivers/usb/host/isp1760-hcd.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/host/isp1760-hcd.c b/drivers/usb/host/isp1760-hcd.=
c
index eb99bf9..6599616 100644
--- a/drivers/usb/host/isp1760-hcd.c
+++ b/drivers/usb/host/isp1760-hcd.c
@@ -2173,7 +2173,7 @@ static const struct hc_driver isp1760_hc_driver =3D {

 int __init init_kmem_once(void)
 {
- urb_listitem_cachep =3D kmem_cache_create("isp1760 urb_listitem",
+ urb_listitem_cachep =3D kmem_cache_create("isp1760_urb_listitem",
  sizeof(struct urb_listitem), 0, SLAB_TEMPORARY |
  SLAB_MEM_SPREAD, NULL);

Done and never appeared again.

A twd_timer_setup message "no clock found" doesn't appear either. I put


static struct clk smp_twd =3D {
    .rate   =3D 200000000,
};


{    /* SMP timers */
        .dev_id        =3D NULL,
        .con_id        =3D "smp_twd",
        .clk        =3D &smp_twd,
    },


into mach-vexpress/v2m.c file. And the I-pipe works with 200.000 MHz timer.

regards
--
Marcin Ku=B6ka
