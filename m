MIME-Version: 1.0
Sender: patrickdepinguin@domain.hid
In-Reply-To: <4EA7DF4E.7030403@domain.hid>
References: <patchbomb.1318861189@domain.hid>
	<8493adf46f985831fad1.1318861192@domain.hid>
	<4EA7DF4E.7030403@domain.hid>
Date: Wed, 26 Oct 2011 12:42:24 +0200
Message-ID: <CAAXf6LV=LM0h2EVZse=oV0GE_3DJHb15SOSCBPNJwiBi4gH8=Q@mail.gmail.com>
From: Thomas De Schampheleire <patrickdepinguin+xenomai@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai-help] [PATCH 3 of 4] psos: add tm_getm function
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

On Wed, Oct 26, 2011 at 12:22 PM, Philippe Gerum <rpm@xenomai.org> wrote:
> On 10/19/2011 09:35 AM, Thomas De Schampheleire wrote:
>>
>> Signed-off-by: Thomas De Schampheleire<thomas.de.schampheleire@domain.hid=
>
>> Signed-off-by: Ronny Meeus<ronny.meeus@domain.hid>
>>
>> ---
>> =A0include/psos/psos.h | =A02 ++
>> =A0lib/psos/tm.c =A0 =A0 =A0 | =A07 +++++++
>> =A02 files changed, 9 insertions(+), 0 deletions(-)
>>
>> diff --git a/include/psos/psos.h b/include/psos/psos.h
>> --- a/include/psos/psos.h
>> +++ b/include/psos/psos.h
>> @@ -363,6 +363,8 @@ u_long tm_set(u_long date,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0u_long time,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0u_long ticks);
>>
>> +u_long tm_getm(unsigned long long *ns);
>> +
>> =A0u_long tm_wkafter(u_long ticks);
>>
>> =A0u_long tm_wkwhen(u_long date,
>> diff --git a/lib/psos/tm.c b/lib/psos/tm.c
>> --- a/lib/psos/tm.c
>> +++ b/lib/psos/tm.c
>> @@ -309,3 +309,10 @@ u_long tm_get(u_long *date_r, u_long *ti
>>
>> =A0 =A0 =A0 =A0return SUCCESS;
>> =A0}
>> +
>> +u_long tm_getm(unsigned long long *ns_r)
>> +{
>> + =A0 =A0 =A0 *ns_r =3D clockobj_get_tsc();
>> + =A0 =A0 =A0 return SUCCESS;
>> +}
>
> - =A0 =A0 =A0 *ns_r =3D clockobj_get_tsc();
> + =A0 =A0 =A0 *ns_r =3D clockobj_tsc_to_ns(clockobj_get_tsc());
>

Ok, thanks.

