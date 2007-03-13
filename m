Message-ID: <11906791.1173797505269.JavaMail.ngmail@domain.hid>
Date: Tue, 13 Mar 2007 15:51:45 +0100 (CET)
From: "M. Koehrer" <mathias_koehrer@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_40701_20176183.1173797505267"
Subject: [Xenomai-help] Howto catch SEGV signals in Xenomai
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

------=_Part_40701_20176183.1173797505267
Content-Type: multipart/alternative; 
	boundary="----=_Part_40700_10464625.1173797505267"

------=_Part_40700_10464625.1173797505267
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi all,

I have a problem to catch segment violations with Xenomai:
For demonstration I use the following program:
------------------------------------------
#include <stdio.h>
#include <sys/mman.h>

#include <native/task.h>
#include <native/sem.h>
RT_TASK taska_desc;
volatile int *pointer =3D 0;

void mytaska(void *cookie)
{
    int i;
    for (i=3D0; i < 50; i++)
    {
        rt_task_sleep(50000000);
        if (i > 20)
        {
            *pointer =3D 123;
        }
        printf("Hello %i\n", i);
    }
    printf("Hi, this is task A\n");
}

int main(void)
{
    mlockall(MCL_CURRENT|MCL_FUTURE);

    rt_task_create(&taska_desc, "mytaska", 0, 81, T_JOINABLE);
    rt_task_start(&taska_desc, &mytaska, NULL);

    rt_task_join(&taska_desc);
    printf("Main: A joined\n");

    return 0;
}
---------------------------------------
Whenever i is greater than 20 a segment violation occurs, as I must not wri=
te
to address 0 (the pointer is always NULL).
However, what happens is, that my system freezes after printing out 18 or 1=
9.
I have to reset the PC to continue.
When I write a printf() directly before the invalid assignment I get the us=
ual linux
"segmentation fault" error message.

How can I catch a signal in a Xenomai real time task?

I am running Xenomai 2.3.0 + NOCOW patch.

I have enclosed the .c file and a Makefile in a .tgz file.

Thanks for any feedback on that issue

Regards

Mathias
~
~



--=20
Mathias Koehrer
mathias_koehrer@domain.hid


Viel oder wenig? Schnell oder langsam? Unbegrenzt surfen + telefonieren
ohne Zeit- und Volumenbegrenzung? DAS TOP ANGEBOT JETZT bei Arcor: g=FCnsti=
g
und schnell mit DSL - das All-Inclusive-Paket f=FCr clevere Doppel-Sparer,
nur  39,85 =80  inkl. DSL- und ISDN-Grundgeb=FChr!
http://www.arcor.de/rd/emf-dsl-2
------=_Part_40700_10464625.1173797505267--

------=_Part_40701_20176183.1173797505267
Content-Type: application/octet-stream
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename=signal.tgz

H4sIAP239kUAA+2U30/bMBDH+4r/ihMrKIGmTVrSTi1FK13ZxgpIpdX2MKkKqVO8OkmVpAi08b/v
nB+l8ABPgCbdR5Fsn7939tk5nzkL7gnJS6+IiTQPDlRrtWwzHVvZOKVpNkuWabdsu2E2zFbJtKxm
yyyB+ZqbKljFiRMBlKRz5TrRczoexW+xobeFsVsehIYbBp6YQ7sLtVUc1ZTNd0TtSgS1jXk2+Dno
QizmgSMZuxz1u1DW0KZXXXZxfKpGaGxX3W411BlbRvhr3aqgZS2+5lJiuxFNB8PIJKjtnwx7Xy6f
0aI4G3vSmcfoOwfjh4M6MC7qbPh57W/IwEnEDX8pkJw9jcQYw6ad54QjlvWUBdPT2dbcdcEIofwJ
yodozFdF6U41bO/gKWQKF+eyhHQlVIFdyZ2gzbaMyAfDy5co4rL3u//sMqvua67xQv1bdatV1H/D
Psjqv2lR/b8F7IMIXLmacTiMk5kIq9dHm6a7uOb7TqCsG+aswGqJEy8e6/OJmPupBxuNp+Pe5XdQ
Smc647HbUWV1E0oUSg4iSGBvGWLDI+iC2VFzYgb+XeqhpYM9NwwXguvsDwNE+QgUqr4XRqCJrtkB
AYdgq3Z/X0+nMrEiSqYq2jSWnC81O//r9DxEGtLDKHAEdVNf2x78FRubtOqNznruft1bRijwtO2v
+OSEsCN+BdsVEMUq91mzFokKJNciBvzU3qCHctTeq9NRCeLjG6TZF1n7MnQX+DppZ/3htD8ZjQbn
47+qfzIZT0aDYp0iVzfiTsK13YeDr8B2fqq4L7MCH60KjKenF9/Oe8dD5f/oqLAmksfeu7l3Bc4n
w+HT9X7j8Wzq83hFvmeYTht6oGR8luWaB+DJKgrUzae5v3c5EARBEARBEARBEARBEARBEARBEARB
EMR/yT/hNhnQACgAAA==
------=_Part_40701_20176183.1173797505267--


