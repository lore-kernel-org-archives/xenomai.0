Message-ID: <1434988133.67288.YahooMailBasic@web173201.mail.ir2.yahoo.com>
Date: Mon, 22 Jun 2015 16:48:53 +0100
From: Frederik Bayart <frederik_bayart@yahoo.co.uk>
In-Reply-To: <55881E09.20803@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai] include guard trank/posix/pthread.h
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

>
>--------------------------------------------
>On Mon, 22/6/15, Philippe Gerum <rpm@xenomai.org> wrote:
>
> Subject: Re: [Xenomai] include guard trank/posix/pthread.h
> To: "Frederik Bayart" <frederik_bayart@yahoo.co.uk>, xenomai@xenomai.org
> Date: Monday, 22 June, 2015, 16:39
>=20
> On 06/22/2015 03:41 PM,
> Frederik Bayart wrote:
>=20
> >
> With this patch, xeno-config works with --native and
> --posix.
> >=20
> > Thank
> you for the quick fix.
> >=20
> > I noticed also that xeno-config is in 2
> debian packages so that you yet an install error.
>=20
> Ok, it has to belong to the
> runtime one, not the development one.
>=20
> > I'm busy to write a mail to report
> this, and to fix this, but maybe this is not urgent for
> rc5
> >=20
>=20
> I
> agree, this is not critical for -rc5.
>=20
> --=20
> Philippe.
>=20

In 2.6, xeno-config was in libxenomai-dev

If it should be now in xenomai-runtime, the patch below should fix it.

Frederik

--- rules.old=092015-06-22 17:41:21.192669068 +0200
+++ rules.new=092015-06-22 17:45:31.916677507 +0200
@@ -64,6 +64,9 @@
 =09for f in $(CURDIR)/kernel/cobalt/udev/*.rules ; do \
 =09    cat $$f >> $(CURDIR)/debian/libxenomai1/etc/udev/xenomai.rules ; \
 =09done
+=09# xeno-config should be only in xenomai-runtime
+=09rm -f $(CURDIR)/debian/libxenomai-dev/usr/bin/xeno-config
+=09rm -f $(CURDIR)/debian/libxenomai-dev/usr/share/man/man1/xeno-config.1
 =09install -m 644 debian/libxenomai1.modprobe $(CURDIR)/debian/libxenomai1=
/etc/modprobe.d/xenomai.conf
 =09# remove empty directory
 =09rm -rf $(CURDIR)/debian/xenomai-doc/usr/share/doc/xenomai-doc/ps





