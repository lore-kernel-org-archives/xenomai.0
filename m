MIME-Version: 1.0
Sender: patrickdepinguin@domain.hid
In-Reply-To: <4EA7DEC3.9010706@domain.hid>
References: <patchbomb.1318861189@domain.hid>
	<0db9974c036abae53f74.1318861190@domain.hid>
	<4EA7DEC3.9010706@domain.hid>
Date: Wed, 26 Oct 2011 12:26:10 +0200
Message-ID: <CAAXf6LUWHAPj7maEVW52_7P=Jgi+w0oPG1Bqv-+TRG10P51vkw@domain.hid>
From: Thomas De Schampheleire <patrickdepinguin+xenomai@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai-help] [PATCH 1 of 4] psos.h: add definition of
	ERR_OBJTFULL
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai@xenomai.org

Hi,

On Wed, Oct 26, 2011 at 12:19 PM, Philippe Gerum <rpm@xenomai.org> wrote:
> On 10/19/2011 09:35 AM, Thomas De Schampheleire wrote:
>>
>> Signed-off-by: Thomas De Schampheleire<thomas.de.schampheleire@domain.hid=
>
>> Signed-off-by: Ronny Meeus<ronny.meeus@domain.hid>
>>
>> ---
>> =A0include/psos/psos.h | =A01 +
>> =A01 files changed, 1 insertions(+), 0 deletions(-)
>>
>> diff --git a/include/psos/psos.h b/include/psos/psos.h
>> --- a/include/psos/psos.h
>> +++ b/include/psos/psos.h
>> @@ -97,6 +97,7 @@
>> =A0#define ERR_OBJDEL =A0 0x05
>> =A0#define ERR_OBJID =A0 =A00x06
>> =A0#define ERR_OBJTYPE =A00x07
>> +#define ERR_OBJTFULL 0x08
>> =A0#define ERR_OBJNF =A0 =A00x09
>>
>> =A0#define ERR_NOTCB =A0 =A00x0E
>
> Where is this error code used in the Xenomai tree? Can't find it right no=
w.

It's not used in the Xenomai code itself, but it may be used by application=
s.
The definition is absent both in Xenomai as Xenomai-forge.

~Thomas

