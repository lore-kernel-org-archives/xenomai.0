Message-ID: <4A978959.5060604@domain.hid>
Date: Fri, 28 Aug 2009 09:38:01 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <1251273701.4345.9.camel@domain.hid>	<4A94EE84.5040101@domain.hid>
	<1251354286.4321.19.camel@domain.hid>	<4A9642D3.5040304@domain.hid>
	<1251374443.4321.40.camel@domain.hid>
In-Reply-To: <1251374443.4321.40.camel@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigF14416EAC755230BD618E04E"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-help] Segmentation fault in rt_printf print thread
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Christoph Permes <christoph.permes@domain.hid>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigF14416EAC755230BD618E04E
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Christoph Permes wrote:
> Hi,
>=20
> I have examined the print_buffers() function and my core dump:
>=20
> #1  0xb8087f61 in print_buffers () at rt_print.c:380
> 380				fprintf(head->dest, "%s", head->text);
> (gdb) print head->dest
> $1 =3D (FILE *) 0x445b205d
> (gdb) print head->text
> $2 =3D "_"
> (gdb) print (char*)head
> $3 =3D 0x8ea5a02 "] [D] [V_MainClampToteRequest   ] =3D=3D=3D> [1]\n"
> (gdb) print buffer->read_pos
> $4 =3D 3482
> (gdb) print *(char*)buffer->ring@domain.hid
> $5 =3D "... [67046.506] [CONTROL] [1104820] [\000] [D] [V_MainClamp"
>=20
> As the above output shows the head pointer points to a wrong memory
> address, the head->dest FILE pointer results from some text written to
> the buffer.
>=20
> buffer =3D get_next_buffer();
> if (!buffer)
>         break;
>=20
> read_pos =3D buffer->read_pos;
> head =3D buffer->ring + read_pos;
> len =3D strlen(head->text);
>=20
> if (len) {
>         /* Print out non-empty entry and proceed */
>         fprintf(head->dest, "%s", head->text); // =3D=3D> SEGV
>         read_pos +=3D sizeof(*head) + len;
> } else {
>         /* Emptry entries mark the wrap-around */
>         read_pos =3D 0;
> }
>=20
> Obviously the value of buffer->read_pos is not correct or the buffer
> pointer returned by get_next_buffer() points to a wrong address.

Hmm, strange. Code meditation didn't help, so I need to keep you busy
with testing. Could you try this instrumentation? It should choke if the
rt_vfprintf actually overwrites already written data.

Thanks,
Jan

diff --git a/src/rtdk/rt_print.c b/src/rtdk/rt_print.c
index 0615247..bcd8c88 100644
--- a/src/rtdk/rt_print.c
+++ b/src/rtdk/rt_print.c
@@ -16,6 +16,7 @@
  * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307 =
 USA.
  */
=20
+#include <assert.h>
 #include <errno.h>
 #include <inttypes.h>
 #include <limits.h>
@@ -37,7 +38,10 @@
=20
 #define RT_PRINT_LINE_BREAK		256
=20
+#define RT_PRINT_HEAD_MAGIC		0xDEADBEAF
+
 struct entry_head {
+	uint32_t magic;
 	FILE *dest;
 	uint32_t seq_no;
 	char text[1];
@@ -103,6 +107,10 @@ int rt_vfprintf(FILE *stream, const char *format, va=
_list args)
 	read_pos =3D buffer->read_pos;
 	xnarch_read_memory_barrier();
=20
+	assert(write_pos =3D=3D read_pos ||
+	       ((struct entry_head *)buffer->read_pos)->magic =3D=3D
+	       RT_PRINT_HEAD_MAGIC);
+
 	/* Is our write limit the end of the ring buffer? */
 	if (write_pos >=3D read_pos) {
 		/* Keep a savety margin to the end for at least an empty entry */
@@ -114,6 +122,7 @@ int rt_vfprintf(FILE *stream, const char *format, va_=
list args)
 		if (len =3D=3D 0 && read_pos > sizeof(struct entry_head)) {
 			/* Write out empty entry */
 			head =3D buffer->ring + write_pos;
+			head->magic =3D RT_PRINT_HEAD_MAGIC;
 			head->seq_no =3D seq_no;
 			head->text[0] =3D 0;
=20
@@ -136,6 +145,10 @@ int rt_vfprintf(FILE *stream, const char *format, va=
_list args)
=20
 	res =3D vsnprintf(head->text, len, format, args);
=20
+	assert(write_pos =3D=3D read_pos ||
+	       ((struct entry_head *)buffer->read_pos)->magic =3D=3D
+	       RT_PRINT_HEAD_MAGIC);
+
 	if (res < len) {
 		/* Text was written completely, res contains its length */
 		len =3D res;
@@ -147,6 +160,7 @@ int rt_vfprintf(FILE *stream, const char *format, va_=
list args)
=20
 	/* If we were able to write some text, finalise the entry */
 	if (len > 0) {
+		head->magic =3D RT_PRINT_HEAD_MAGIC;
 		head->seq_no =3D ++seq_no;
 		head->dest =3D stream;
=20
@@ -159,6 +173,7 @@ int rt_vfprintf(FILE *stream, const char *format, va_=
list args)
 	    read_pos <=3D write_pos && read_pos > buffer->size - write_pos) {
 		/* An empty entry marks the wrap-around */
 		head =3D buffer->ring + write_pos;
+		head->magic =3D RT_PRINT_HEAD_MAGIC;
 		head->seq_no =3D seq_no;
 		head->text[0] =3D 0;
=20
@@ -382,6 +397,8 @@ static void print_buffers(void)
 		head =3D buffer->ring + read_pos;
 		len =3D strlen(head->text);
=20
+		assert(head->magic =3D=3D RT_PRINT_HEAD_MAGIC);
+
 		if (len) {
 			/* Print out non-empty entry and proceed */
 			fprintf(head->dest, "%s", head->text);


--------------enigF14416EAC755230BD618E04E
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iEYEARECAAYFAkqXiVwACgkQniDOoMHTA+lTnwCffXRE1RoFzFRm8lKRYiCG1aFf
zKAAn3L1mhxZfwq+tvwEWpsP/R6HiRGN
=cl+A
-----END PGP SIGNATURE-----

--------------enigF14416EAC755230BD618E04E--

