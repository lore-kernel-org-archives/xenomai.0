Content-Class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 4 May 2011 16:34:43 +0200
Message-ID: <1183078C0D064042B3AD2D03E3859EF174EA21@domain.hid>
In-Reply-To: <4DC0F4E0.2070707@domain.hid>
References: <1183078C0D064042B3AD2D03E3859EF174E31A@AREXCH02.mra.roland-man.biz><1303849652.1961.7.camel@domain.hid><1183078C0D064042B3AD2D03E3859EF174E3E4@domain.hid><1183078C0D064042B3AD2D03E3859EF174E43D@AREXCH02.mra.roland-man.biz><1303940558.1932.33.camel@domain.hid>	<1183078C0D064042B3AD2D03E3859EF174E5BC@AREXCH02.mra.roland-man.biz><1183078C0D064042B3AD2D03E3859EF174E826@domain.hid>	<4DBFE062.3020902@domain.hid>	<1183078C0D064042B3AD2D03E3859EF174E87B@AREXCH02.mra.roland-man.biz>	<4DC03CE8.4050608@domain.hid>
	<1183078C0D064042B3AD2D03E3859EF174E92F@AREXCH02.mra.roland-man.biz>
	<4DC0F4E0.2070707@domain.hid>
From: <dietmar.schindler@domain.hid>
Subject: Re: [Xenomai-help] message pipe message boundaries
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
Cc: xenomai@xenomai.org

> From: Gilles Chanteperdrix [mailto:gilles.chanteperdrix@xenomai.org]
> Sent: Wednesday, May 04, 2011 8:41 AM
>=20
> What I suggest, is that you make a patch which removes the read
> implementation and adds the readv implementation. In this case, the
> kernel will use readv to implement read anyway, and there will be no
> code duplication.

Thank you for the clarification. However, in the (still used by us) =
Linux 2.4.25 kernel's function

asmlinkage ssize_t sys_read(unsigned int fd, char * buf, size_t count)
{
    ssize_t ret;
    struct file * file;

    ret =3D -EBADF;
    file =3D fget(fd);
    if (file) {
        if (file->f_mode & FMODE_READ) {
            ret =3D locks_verify_area(FLOCK_VERIFY_READ, =
file->f_dentry->d_inode,
                        file, file->f_pos, count);
            if (!ret) {
                ssize_t (*read)(struct file *, char *, size_t, loff_t =
*);
                ret =3D -EINVAL;
                if (file->f_op && (read =3D file->f_op->read) !=3D NULL)
                    ret =3D read(file, buf, count, &file->f_pos);
            }
        }
        if (ret > 0)
            dnotify_parent(file->f_dentry, DN_ACCESS);
        fput(file);
    }
    return ret;
}

it doesn=E2=80=99t look like it would use readv to implement read, so =
I'm afraid that your otherwise good suggestion would not work with such =
old kernel versions.

--=20
Dietmar

--------------------------------------------------------
manroland AG
Vorsitzender des Aufsichtsrates: Hanno C. Fiedler
Vorstand: Gerd Finkbeiner (Vorsitzender), Dr. Ingo Koch, Dr. Markus =
Rall, Paul Steidle  =20
Sitz der Gesellschaft: Offenbach am Main, Registergericht: Amtsgericht =
Offenbach HRB-Nr. 42592
USt-Ident-Nr. DE 250200933


