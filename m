Message-ID: <49CC07F6.7000100@domain.hid>
Date: Thu, 26 Mar 2009 23:55:50 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <49CBB6C5.5000407@domain.hid> <49CBBD4B.7070800@domain.hid>
	<49CBEDE2.5040106@domain.hid> <49CBF29D.5020500@domain.hid>
	<49CBF91A.1070201@domain.hid> <49CBFA89.8020500@domain.hid>
	<49CC0687.2070509@domain.hid>
In-Reply-To: <49CC0687.2070509@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai-help] Keyboard IRQ
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Antoine Nourry <nourry@domain.hid>
Cc: xenomai@xenomai.org

Antoine Nourry wrote:
> Gilles Chanteperdrix a =E9crit :
>> Antoine Nourry wrote:
>>
>>  =20
>>> I neither understand, is there a way to measure precisely the absolut=
e=20
>>> time of a keypress event on our computers ?
>>>    =20
>> Well, you can wait for the event in a user-space program, and use Linu=
x
>> plain gettimeofday. It will probably give you more than enough precisi=
on.
>>
>>  =20
> Ok, i already made such programs but i thought that my polling method t=
o=20
> detect key event was bad and may consume too much time.

Well, you have to set the terminal to raw mode, and wait for a one
character read to return, then call gettimeofday. But you will have to
check in books or other lists for the shortest way to wait for a
character, I will not pretend to know this.

> Moreover aren't there any risks of being preempted or slowed by other
tasks ?

Not if you give your task a real-time priority. Which you were going to
do by using xenomai anyway.

--=20
					    Gilles.


