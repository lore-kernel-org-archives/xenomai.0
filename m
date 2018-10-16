From: Lange Norbert <norbert.lange@andritz.com>
Date: Tue, 16 Oct 2018 09:23:31 +0000
Message-ID: <aa8ff35f59804fe08c8ed79d2861eebd@andritz.com>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: [Xenomai] Fun with cobalt interposing fcntl
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "Xenomai (xenomai@xenomai.org)" <xenomai@xenomai.org>

Hello,

I ran into an annoying problem with cobalt, namely that it interposes funct=
ions with varargs like fcntl,
The issue is that it won't ever be able to correctly forward the varags.
In the example, fcntl will be interpreted as having an additional int param=
eter, while some functionality has a pointer instead,
This yields to truncation and errors.

Unfortunatly I don't see any way of fixing this easily, but I consider this=
 harmful (silently breaking code).
IMHO  Would be better to remove the wrapping for fcntl and use an explicit =
cobalt function where necessary.

King regards,  Norbert

----- offending code

bool lockfile(const char *fname)
{
    int fd =3D open(fname, O_WRONLY | O_CREAT, S_IRUSR | S_IWUSR | S_IRGRP =
| S_IROTH);
    if (fd < 0)
    {
        perror("Opening Component Lock");
        return false;
    }
    struct flock fl =3D {F_WRLCK, SEEK_SET};

    int ret =3D fcntl(fd, F_SETLK, &fl);
    if (ret !=3D 0)
    {
        perror("Acquiring Component Lock");
        return false;
    }
    return true;
}

----- wrapping in rtdm.c

COBALT_IMPL(int, fcntl, (int fd, int cmd, ...))
{
        va_list ap;
        int arg;
        int ret;

        va_start(ap, cmd);
        arg =3D va_arg(ap, int);
        va_end(ap);

        ret =3D XENOMAI_SYSCALL3(sc_cobalt_fcntl, fd, cmd, arg);

        if (ret !=3D -EBADF && ret !=3D -ENOSYS)
                return set_errno(ret);

        return __STD(fcntl(fd, cmd, arg));
}
________________________________

This message and any attachments are solely for the use of the intended rec=
ipients. They may contain privileged and/or confidential information or oth=
er information protected from disclosure. If you are not an intended recipi=
ent, you are hereby notified that you received this email in error and that=
 any review, dissemination, distribution or copying of this email and any a=
ttachment is strictly prohibited. If you have received this email in error,=
 please contact the sender and delete the message and any attachment from y=
our system.

ANDRITZ HYDRO GmbH


Rechtsform/ Legal form: Gesellschaft mit beschr=C3=A4nkter Haftung / Corpor=
ation

Firmensitz/ Registered seat: Wien

Firmenbuchgericht/ Court of registry: Handelsgericht Wien

Firmenbuchnummer/ Company registration: FN 61833 g

DVR: 0605077

UID-Nr.: ATU14756806


Thank You
________________________________

