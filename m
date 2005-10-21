Message-ID: <4358FF63.5070600@domain.hid>
Date: Fri, 21 Oct 2005 16:46:59 +0200
From: =?ISO-8859-15?Q?Ignacio_Garc=EDa_P=E9rez?= <iggarpe@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] timeout in native API calls          (cond, sem,
	mutex, etc).
References: <4357C3E1.1040701@domain.hid>
	<4357C9F7.2060808@domain.hid>	<4357CF67.8080601@domain.hid>
	<4357DF0F.3060806@domain.hid> <435896AA.1060103@domain.hid>
	<4358C829.5050304@domain.hid> <4358DDAE.2090703@domain.hid>
In-Reply-To: <4358DDAE.2090703@domain.hid>
Content-Type: text/plain; charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Jan Kiszka <kiszka@domain.hid>
Cc: xenomai@xenomai.org

Jan Kiszka wrote:

>Ignacio Garc=EDa P=E9rez wrote:
> =20
>
>>...
>>P.S: As a side note, wouldn't be a good practice to expand tabs to
>>spaces in all the code?
>>   =20
>>
>
>My opinion is yes - but it's a nasty work. Would you provide such
>patches...?
>
>Jan
>
> =20
>
Assuming everybody is using the 8 space tab (I saw it in all the files I
examined today), something like this would do:

texp () {
    TMPFILE=3D$(mktemp tmp.XXXXXX)
    expand -t 8 $1 > $TMPFILE
    mv -f $TMPFILE $1
}

for i in $(find -name "*.c"); do texp $i; done
for i in $(find -name "*.h"); do texp $i; done



However, this is of no help if developers don't configure their editors
to expand spaces by default, which I think is quite difiicult to achieve.

Would be a good idea too to enforce this tab expansion policy with a SVN
submit filter, but that's beyond by knowledge.

Nacho.

