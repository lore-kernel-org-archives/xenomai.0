Message-ID: <49CC0687.2070509@domain.hid>
Date: Thu, 26 Mar 2009 23:49:43 +0100
From: Antoine Nourry <nourry@domain.hid>
MIME-Version: 1.0
References: <49CBB6C5.5000407@domain.hid> <49CBBD4B.7070800@domain.hid>
	<49CBEDE2.5040106@domain.hid> <49CBF29D.5020500@domain.hid>
	<49CBF91A.1070201@domain.hid> <49CBFA89.8020500@domain.hid>
In-Reply-To: <49CBFA89.8020500@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
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
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

Gilles Chanteperdrix a =E9crit :
> Antoine Nourry wrote:
>
>  =20
>> I neither understand, is there a way to measure precisely the absolute=
=20
>> time of a keypress event on our computers ?
>>    =20
>
> Well, you can wait for the event in a user-space program, and use Linux
> plain gettimeofday. It will probably give you more than enough precisio=
n.
>
>  =20
Ok, i already made such programs but i thought that my polling method to=20
detect key event was bad and may consume too much time. Moreover aren't=20
there any risks of being preempted or slowed by other tasks ?


