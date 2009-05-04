From: Wolfgang Denk <wd@domain.hid>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: <49FDFCC7.6000009@domain.hid>
References: <5D63919D95F87E4D9D34FF7748CE2C2A018D48CC@ARVMAIL1.mra.roland-man.biz>
	<49FDFCC7.6000009@domain.hid>
Date: Mon, 04 May 2009 09:23:04 +0200
Message-Id: <20090504072304.A7E2483420E8@domain.hid>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai-help] Some problems with shared memory
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

Dear Gilles,

in message <49FDFCC7.6000009@domain.hid> you wrote:
>
> > 1.) If I don=B4t page align the size of shared memory (multiple of 40=
96)
> I get the following error message :
> > "createshm mmap: No such device or address"
...
> Are you sure this issue is specific to xenomai, do not you have the sam=
e
> effect with plain Linux shared memories ?

To avoid misunderstandings, we should first point  out  that  we  are
here  in  fact *not* discussing classic shared memory in the sense of
the SysV SHM code, but the creation of shared memory regions by using
the mmap() system call.


For completeness: shmget(2) *does* allow to allocate sizes which are
not a multiple of pages sizes; but it then rounds up internally:

SHMGET(2) ... DESCRIPTION:

        ... A new shared memory segment, with size equal to the value
        of size rounded up to a multiple of PAGE_SIZE, is created ...

As far as mmap()  is  concerned,  there  is  no  restriction  on  the
"length"  parameter  (though  it  is  clear  that  internally this is
rounded up to a multiple of pages, too, but only "length"  bytes  are
visible to the user).

The restrictions for page allignments affect the addr and offset
paraemters only.


To me it seems clear that mmap() in plain Linux and Xenomai behave
differently.


Best regards,

Wolfgang Denk

--=20
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@domain.hid
Let's say the docs present a simplified view of reality...    :-)
                      - Larry Wall in  <6940@domain.hid>

