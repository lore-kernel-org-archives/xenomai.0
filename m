Message-ID: <19756477.1179132019857.JavaMail.ngmail@domain.hid>
Date: Mon, 14 May 2007 10:40:19 +0200 (CEST)
From: "M. Koehrer" <mathias_koehrer@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_2803_5628490.1179132019856"
Subject: [Xenomai-help] Scheduler: Strange priority handling with multiple
 tasks waiting for one semaphore
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

------=_Part_2803_5628490.1179132019856
Content-Type: multipart/alternative; 
	boundary="----=_Part_2802_24622623.1179132019856"

------=_Part_2802_24622623.1179132019856
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi everybody,

I see strange effect that I do not understand.
What happens when multiple tasks (with different priority) are waiting for =
a single semaphore?
Assume the following situation:
Task H (High prio) and Task L (low prio) are waiting both for the same sema=
phore.
A third task does the rt_sem_v() to grant access.
Now H passes its rt_sem_p() and runs.=20
A few statements later H calls rt_sem_v() to grant access to the semaphore =
protected part.
What happens now? As H is high priority there should be no reschedule, i.e.=
 H continues to run.
What happens now if H wants to enter again via rt_sem_p() (on the same sema=
phore)?
I expect to allow H again the access as it has a higher priority than L.
However, a small demo application for this use case shows me that this not =
the case.
The heart of my demo application is the following task code fragment:

void mytask(void *cookie)
{
    int id =3D (int)cookie;
    int cnt =3D 0;

    while (!end)
    {
        rt_sem_p(&sem, TM_INFINITE);
        (....)
        rt_sem_v(&sem);
    }

    printf("task %i: cnt %i\n", id, cnt);
}
There are two tasks with different priorities that execute this code.
I expected to have only the higher priority task to be run, however they ru=
n alternately.
What is happening here? It looks as if the Xenomai scheduler does not handl=
e the priority=20
correctly in this case.
I have enclosed the C code of this application to this mail.

Thanks for any feedback on this.

Regards

Mathias



--=20
Mathias Koehrer
mathias_koehrer@domain.hid


Viel oder wenig? Schnell oder langsam? Unbegrenzt surfen + telefonieren
ohne Zeit- und Volumenbegrenzung? DAS TOP ANGEBOT JETZT bei Arcor: g=FCnsti=
g
und schnell mit DSL - das All-Inclusive-Paket f=FCr clevere Doppel-Sparer,
nur  39,85 =80  inkl. DSL- und ISDN-Grundgeb=FChr!
http://www.arcor.de/rd/emf-dsl-2
------=_Part_2802_24622623.1179132019856--

------=_Part_2803_5628490.1179132019856
Content-Type: application/octetstream
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename=sematest.c.gz

H4sICBYgSEYAA3NlbWF0ZXN0LmMAnVRtb5swEP7Or3BTJYLCFsikaRrtpDSiUtqEVAmZJnURYuA0
XniJgGaq2vz3nV/AEPVFKpLB+O55/PjufKckDeOHCKPzooxI9nnzQzmVS49FP0mClK42ltOgJHvc
L4Ni2/YXhgInHBHhNUkxcmfecHGzQF+UuefTKaJQP8JFeCdsK5vaFs4UAdhWlH0WA1eMEUlLhNMI
XSDTlozT4S/f+em43gJZpqmEmyBHeI/TsriTJuBs01AHn1Rc+wymySOVorL5WZhlW4I15UlB8FAI
c1ZhpnGbXVtCGJyHrvzb0E3UE1CqsQVOQZ+89OFI/k7twcdA3tQfu1djd+w5ml07Ce2VQl1f0X3p
sTQS2U0uFrkixninwsn5o9kI9fs0EklR+4JAXbePZeyZDLHzgYvf5XCgtdqh1KhLvrOzdcnvtGNA
AAz6C4CDiFiZk/t7nL8aNqFNbFFzSxQqyiAvgV24HCtrsAzeYIFQn3AS5sJrxGI6aX6SgKRMXzOd
ecj5kjgLt0Ecq9PRxB8t53Mol2c6v1p6y7lTceYhUAp5f0gaiRR24B10WCrdmXs5mY1uhE6yRioF
QWG8UgYRjnGJX0iCsIc5DoRdbmQaaOHfzsezWpiog8pbXidzBTBe1CZHfoXh+dezsTu8nDjoGX5G
t0vV1GT4eU3RrBxT9TiVgVgozzTrfQWWVGAJBdYHFVgvKBi8r2AgFQy4gm8fVUCpeo2qk4Fg166t
5G8GJdcCtyu8nfs3oebqSNmxg7WqKGSJsYYlb/w6y6F1XZg2vM8bHVNDvR5SRcchwIOIrms17AlG
/dO8fF3yqWoKBu+JDY4acWgVNS4f8pR2SVhQlP97idWobAYAAA==
------=_Part_2803_5628490.1179132019856--


