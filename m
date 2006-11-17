Message-ID: <9656043.1163758677000.JavaMail.ngmail@domain.hid>
Date: Fri, 17 Nov 2006 11:17:56 +0100 (CET)
From: "M. Koehrer" <mathias_koehrer@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_17490_22552330.1163758676999"
Subject: [Xenomai-help] What happens if task entry function returns?
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org

------=_Part_17490_22552330.1163758676999
Content-Type: multipart/alternative; 
	boundary="----=_Part_17489_9610283.1163758676999"

------=_Part_17489_9610283.1163758676999
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi!

I am just playing around with Xenomai to understand it.
And I have one question concerning the entry function that will be called f=
rom
rt_task_start (Native API).
What happens if this entry function reaches its end or a return within the =
function is
called?

I have made a simple example that lead to strange effects.
In my example (see complete C Code in attachement) I create to tasks
that do the same.
The entry functions look like:

void taska(void *cookie)
{
    RTIME delay;
    int i;
    printf("Hi, I am task A %s\n", (char*)cookie);
    delay =3D 100000;

    for (i=3D0; i<200; i++)
    {
        rt_task_sleep(delay);
    }

    printf("This is the end of A\n");
    // rt_task_delete(0);
}
When I do not place the rt_task_delete(0) at the end of the function
my second task will never reach the end with the second printf.
Whenever I use rt_task_delete(0) at the end of the function it works perfec=
tly.

My question is now: What happens if the task's entry function returns?

Thanks for any feedback on that question.

Regards

Mathias


--=20
Mathias Koehrer
mathias_koehrer@domain.hid


Viel oder wenig? Schnell oder langsam? Unbegrenzt surfen + telefonieren
ohne Zeit- und Volumenbegrenzung? DAS TOP ANGEBOT JETZT bei Arcor: g=FCnsti=
g
und schnell mit DSL - das All-Inclusive-Paket f=FCr clevere Doppel-Sparer,
nur  44,85 =80  inkl. DSL- und ISDN-Grundgeb=FChr!
http://www.arcor.de/rd/emf-dsl-2
------=_Part_17489_9610283.1163758676999--

------=_Part_17490_22552330.1163758676999
Content-Type: application/postscript
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename=multitasks.c.gz

H4sICO2LXUUAA211bHRpdGFza3MuYwCtU2Fr2zAQ/a5fcWSs2G1Ykn0apB0kwaXZmra4DoMxMLIt
Ey22FCSlI1v733eS7dTOh4SyicRIT3dP795J5B0XabHNGFxqk3H5YfWZtKB0xbIDaKcHZUmFRVuw
oIY/sYGhet2NbzZ4yZTLIWEUR5PHr2BjaZwxnY67YNKA5EnyrIrz3PQ8lXLNmU/+EMARRvNFABkr
6G7sAC4M8Gq6UbjIvd4N78McaOloYALv9Q/R64OXrqg692u+KsURwRWMhnaMgTg0lwo8foVrfvnR
wvziwnc7lQg7lIktfawLxjae46k5X0hHTbTiGvBnVgyYyEDmMEE9dfBgsGdCDmaYN8Qd8tJ2InmT
E0esmL7Biv/jxAkjpqeMsD4QW1hJuXA2NOVbkClVJZeFTNe0KLzF7DaeLcMwuIue7fx6GS3DwK+r
edWMp4Vb4VhBCpg9LGG430w321gzFAP4He9hDIq/B+G9d4aw38Ufg8gb9uFgx70lS0XznAtudjZG
899M5p6N7CTYUlvSFKMF2CfkWqcblSMXg4Vjpxq/UoxFv85eX1cfem6BrcYTP+E/ir/cz+8m09vg
OYqvH5b4RTpv5Nen75toqDJdqmqBlDesKKTtFzkhImmLSP5JRNIWkSDlN6mKrOcf3POFbeQvyo12
V7b1wBrOnxIvUKsuf3yMYHqMIGkIuhqC6k7bO1VlV+nMbJWAYf2oyV8EET9ufgUAAA==
------=_Part_17490_22552330.1163758676999--


