Message-ID: <43E49D07.2070705@domain.hid>
Date: Sat, 04 Feb 2006 13:24:39 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] broken docs
References: <FDBBB5CC70676540B3EF7CFE83FD94E0210CE1@domain.hid>	<43DE03CF.3070603@domain.hid>	<17374.2360.273205.998312@domain.hid>
	<43DE0DA0.2050307@domain.hid>
In-Reply-To: <43DE0DA0.2050307@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig38F794CCBAF7683E5F329B89"
Sender: jan.kiszka@domain.hid
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai-core <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig38F794CCBAF7683E5F329B89
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Jan Kiszka wrote:
> Gilles Chanteperdrix wrote:
>> Jan Kiszka wrote:
>>  > ROSSIER Daniel wrote:
>>  > > Dear Xenomai workers,
>>  > >=20
>>  > > Would it be possible to have an updated API documentation for Xen=
omai
>>  > > 2.0.x ? (I mean with formal parameters in function prototypes)
>>  > >=20
>>  > > I tried to regenerate it with make generate-doc, but it seems tha=
t a
>>  > > SVN working dir is required.
>>
>> make generate-doc is needed for maintenance only. If you want to
>> generate doxygen documentation, simply add --enable-dox-doc to Xenomai=

>> configure command line.
>>
>>  > >=20
>>  > > It would be great.
>>  >=20
>>  > I just had a "quick" look at the status of the documentation in
>>  > SVN-trunk (2.1). Unfortunately, doxygen is a terrible tool (to expr=
ess
>>  > it politely) when it comes to tracking down bugs in your formatting=
=2E
>>  > Something is broken in all modules except RTDM, and although I spen=
t *a
>>  > lot* of time in getting RTDM correctly formatted, I cannot tell wha=
t's
>>  > wrong with the rest. This will require some looooong evenings of
>>  > continuous patching the docs, recompiling, and checking the result.=
 Any
>>  > volunteers - I'm lacking the time? :-/
>>
>> Looking at the difference between RTDM documentation blocks and the
>> other modules is that the other modules use the "fn" tag. Removing the=

>> "fn" tag from other modules documentation blocks seems to solve the
>> issue.
>>
>=20
> Indeed, works. Amazingly blind I was.
>=20
> Anyway, it still needs some work to remove that stuff (I wonder what th=
e
> "correct" usage of @fn is...) and to wrap functions without bodies via
> "#ifdef DOXYGEN_CPP" like RTDM does. At this chance, I would also
> suggest to replace all \tag by @tag for the sake of a unified style (an=
d
> who knows what side effects mixing up both may have).
>=20

Here is a shell script aiming at an automated fix for parts of the
mentioned issues. Anyone with better shell hacking skills may improve it
(I'm always willing to learn!).

for file in `find -name "*.[c|h]"`; do
    mv $file $file.tmp
    cat $file.tmp | (
        echo $file
        while read -r; do
            # delete " * @fn ..." lines
            new_line=3D"`echo "$REPLY" | sed 's/\ \*\ @fn[^$]*$//' | \
                tr -d "\n"`"
            if echo "$REPLY" | grep -q '\ \*\ @fn[^$]*$'; then
                # delete empty comment lines succeeding " * @fn ..."
                read -r
                if [ "$REPLY" !=3D " *" ]; then
                    echo "$REPLY" >> $file
                fi
            else
                # convert " * \<tag>" to " * @<tag>"
                echo "$new_line" | sed 's/\ \*\ \\\([a-z]\)/ * @\1/' \
                    >> $file
            fi
        done
    )
    rm $file.tmp
done


I only tested it on ksrs/skins/native, but it seems to work - for those
functions with a body :-/. We still need to manually wrap body-less
function docs as it is done in the rtdm skin. But I think this is a start=
=2E

Jan


--------------enig38F794CCBAF7683E5F329B89
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFD5J0HniDOoMHTA+kRAlgEAJ0XoF3irh9XSiCfxzcwuG6l+KSwwgCfTPWs
7ujxjdtIDrz/XszkOvnYv14=
=A/xg
-----END PGP SIGNATURE-----

--------------enig38F794CCBAF7683E5F329B89--

