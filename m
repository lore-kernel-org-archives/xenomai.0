Message-ID: <4A979E68.1040805@domain.hid>
Date: Fri, 28 Aug 2009 11:07:52 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <1251273701.4345.9.camel@domain.hid>	 <4A94EE84.5040101@domain.hid>
	<1251354286.4321.19.camel@domain.hid>	 <4A9642D3.5040304@domain.hid>
	<1251374443.4321.40.camel@domain.hid>	 <4A978959.5060604@domain.hid>
	<1251448708.4365.11.camel@domain.hid>
In-Reply-To: <1251448708.4365.11.camel@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig583739A1CC0501217AA920F0"
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
--------------enig583739A1CC0501217AA920F0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Christoph Permes wrote:
> Am Freitag, den 28.08.2009, 09:38 +0200 schrieb Jan Kiszka:
>> Hmm, strange. Code meditation didn't help, so I need to keep you busy
>> with testing. Could you try this instrumentation? It should choke if t=
he
>> rt_vfprintf actually overwrites already written data.
>>
>> Thanks,
>> Jan
>>
>> diff --git a/src/rtdk/rt_print.c b/src/rtdk/rt_print.c
>> index 0615247..bcd8c88 100644
>> --- a/src/rtdk/rt_print.c
>> +++ b/src/rtdk/rt_print.c
>> @@ -16,6 +16,7 @@
>>   * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-13=
07  USA.
>>   */
>> =20
>> +#include <assert.h>
>>  #include <errno.h>
>>  #include <inttypes.h>
>>  #include <limits.h>
>> @@ -37,7 +38,10 @@
>> =20
>>  #define RT_PRINT_LINE_BREAK		256
>> =20
>> +#define RT_PRINT_HEAD_MAGIC		0xDEADBEAF
>> +
>>  struct entry_head {
>> +	uint32_t magic;
>>  	FILE *dest;
>>  	uint32_t seq_no;
>>  	char text[1];
>> @@ -103,6 +107,10 @@ int rt_vfprintf(FILE *stream, const char *format,=
 va_list args)
>>  	read_pos =3D buffer->read_pos;
>>  	xnarch_read_memory_barrier();
>> =20
>> +	assert(write_pos =3D=3D read_pos ||
>> +	       ((struct entry_head *)buffer->read_pos)->magic =3D=3D
>> +	       RT_PRINT_HEAD_MAGIC);
>> +
>>  	/* Is our write limit the end of the ring buffer? */
>>  	if (write_pos >=3D read_pos) {
>>  		/* Keep a savety margin to the end for at least an empty entry */
>> @@ -114,6 +122,7 @@ int rt_vfprintf(FILE *stream, const char *format, =
va_list args)
>>  		if (len =3D=3D 0 && read_pos > sizeof(struct entry_head)) {
>>  			/* Write out empty entry */
>>  			head =3D buffer->ring + write_pos;
>> +			head->magic =3D RT_PRINT_HEAD_MAGIC;
>>  			head->seq_no =3D seq_no;
>>  			head->text[0] =3D 0;
>> =20
>> @@ -136,6 +145,10 @@ int rt_vfprintf(FILE *stream, const char *format,=
 va_list args)
>> =20
>>  	res =3D vsnprintf(head->text, len, format, args);
>> =20
>> +	assert(write_pos =3D=3D read_pos ||
>> +	       ((struct entry_head *)buffer->read_pos)->magic =3D=3D
>> +	       RT_PRINT_HEAD_MAGIC);
>> +
>>  	if (res < len) {
>>  		/* Text was written completely, res contains its length */
>>  		len =3D res;
>> @@ -147,6 +160,7 @@ int rt_vfprintf(FILE *stream, const char *format, =
va_list args)
>> =20
>>  	/* If we were able to write some text, finalise the entry */
>>  	if (len > 0) {
>> +		head->magic =3D RT_PRINT_HEAD_MAGIC;
>>  		head->seq_no =3D ++seq_no;
>>  		head->dest =3D stream;
>> =20
>> @@ -159,6 +173,7 @@ int rt_vfprintf(FILE *stream, const char *format, =
va_list args)
>>  	    read_pos <=3D write_pos && read_pos > buffer->size - write_pos) =
{
>>  		/* An empty entry marks the wrap-around */
>>  		head =3D buffer->ring + write_pos;
>> +		head->magic =3D RT_PRINT_HEAD_MAGIC;
>>  		head->seq_no =3D seq_no;
>>  		head->text[0] =3D 0;
>> =20
>> @@ -382,6 +397,8 @@ static void print_buffers(void)
>>  		head =3D buffer->ring + read_pos;
>>  		len =3D strlen(head->text);
>> =20
>> +		assert(head->magic =3D=3D RT_PRINT_HEAD_MAGIC);
>> +
>>  		if (len) {
>>  			/* Print out non-empty entry and proceed */
>>  			fprintf(head->dest, "%s", head->text);
>>
>=20
> Now I get a SEGV at the first line of the first assert statement
> (assert(write_pos =3D=3D read_pos || ) in rt_vfprintf.
> This happens at the first rt_printf call, also with the rtprint example=

> program.

Untested stuff as I should already be on the road. Here is another try,
but please don't expect replies from me over this weekend.

Jan

diff --git a/src/rtdk/rt_print.c b/src/rtdk/rt_print.c
index 0615247..06dabc1 100644
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
+	       ((struct entry_head *)buffer->ring + buffer->read_pos)->magic =3D=
=3D
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
+	       ((struct entry_head *)buffer->ring + buffer->read_pos)->magic =3D=
=3D
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


--------------enig583739A1CC0501217AA920F0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iEYEARECAAYFAkqXnmwACgkQniDOoMHTA+kOdQCfT0F5UqH78CK7UBB4PWpV/e/h
9BsAnRWUXJxCOQxy/LF5qyLsZ7JNh04M
=4NjH
-----END PGP SIGNATURE-----

--------------enig583739A1CC0501217AA920F0--

