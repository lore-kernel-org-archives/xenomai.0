From: Lange Norbert <norbert.lange@andritz.com>
Date: Wed, 13 Jun 2018 10:47:23 +0000
Message-ID: <99BAB48E90E86D42AD41F0BCE3225AEB019FC2A4FA@GRZSMS582.andritz.com>
References: <CAEvX6dnegM8CXwc7zGCsvyWNMziEcjdjB0fJRH_NMdTO2vdWgA@mail.gmail.com>
In-Reply-To: <CAEvX6dnegM8CXwc7zGCsvyWNMziEcjdjB0fJRH_NMdTO2vdWgA@mail.gmail.com>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Xenomai] Why get low latency while running stress command?
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Kiwamu Okabe <kiwamu@debian.or.jp>, "xenomai@xenomai.org" <xenomai@xenomai.org>

Hi,

I guess what happens is, that the CPU will be put to sleep and/or lower fre=
quency and voltage between calls,
These transitions are rather slow and will then have to happen on wake-up
Disable any kind of powersaving features in Linux and possibly BIOS (C-Stat=
es).

Kind regards,
Norbert

-----Original Message-----
From: Xenomai <xenomai-bounces@xenomai.org> On Behalf Of Kiwamu Okabe
Sent: Mittwoch, 13. Juni 2018 10:51
To: xenomai@xenomai.org
Subject: [Xenomai] Why get low latency while running stress command?

E-MAIL FROM A NON-ANDRITZ SOURCE: AS A SECURITY MEASURE, PLEASE EXERCISE CA=
UTION WITH E-MAIL CONTENT AND ANY LINKS OR ATTACHMENTS.


Dear all,

I build Xenomai kernel on Debian GNU/Linux Stretch (amd64) with attached co=
nfig.
It runs on Intel(R) Celeron(R) CPU J3355 @ 2.00GHz.

But the latency is not good:

```
$ sudo /usr/lib/xenomai/testsuite/latency
=3D=3D Sampling period: 100 us
=3D=3D Test mode: periodic user-mode task
=3D=3D All results in microseconds
warming up...
RTT|  00:00:01  (periodic user-mode task, 100 us period, priority 99)
RTH|----lat min|----lat avg|----lat max|-overrun|---msw|---lat best|--lat w=
orst
RTD|      0.912|      6.856|    414.649|     104|     0|      0.912|    414=
.649
RTD|      6.065|     10.102|    120.338|     109|     0|      0.912|    414=
.649
RTD|      5.473|     10.465|    124.834|     116|     0|      0.912|    414=
.649
RTD|      6.224|     10.215|    137.833|     125|     0|      0.912|    414=
.649
RTD|      6.058|     10.392|    126.856|     131|     0|      0.912|    414=
.649
RTD|      1.126|      8.278|    239.556|     145|     0|      0.912|    414=
.649
RTD|      4.789|      9.966|    122.924|     149|     0|      0.912|    414=
.649
RTD|      5.228|     10.289|    126.303|     157|     0|      0.912|    414=
.649
RTD|      5.470|     10.273|    126.994|     165|     0|      0.912|    414=
.649
RTD|      5.624|     10.391|    127.353|     171|     0|      0.912|    414=
.649
RTD|      1.128|     10.766|    429.696|     245|     0|      0.912|    429=
.696
RTD|      5.568|     10.557|    123.488|     249|     0|      0.912|    429=
.696
RTD|      2.113|      8.890|    253.340|     282|     0|      0.912|    429=
.696
RTD|      6.056|     10.301|    126.958|     285|     0|      0.912|    429=
.696
RTD|      6.230|     10.411|    127.802|     293|     0|      0.912|    429=
.696
RTD|      5.787|     10.447|    124.719|     299|     0|      0.912|    429=
.696
RTD|      6.143|     10.307|    126.947|     301|     0|      0.912|    429=
.696
RTD|      6.250|     10.391|    124.367|     303|     0|      0.912|    429=
.696
RTD|      5.861|     10.367|    126.357|     309|     0|      0.912|    429=
.696
```

Strangely the result gets better while running stress command:

```
$ stress -v -c 8 -i 10 -d 8 &
$ sudo /usr/lib/xenomai/testsuite/latency
=3D=3D Sampling period: 100 us
=3D=3D Test mode: periodic user-mode task
=3D=3D All results in microseconds
warming up...
RTT|  00:00:01  (periodic user-mode task, 100 us period, priority 99)
RTH|----lat min|----lat avg|----lat max|-overrun|---msw|---lat best|--lat w=
orst
RTD|      2.744|      4.108|      8.634|       0|     0|      2.744|      8=
.634
RTD|      2.872|      4.225|      8.670|       0|     0|      2.744|      8=
.670
RTD|      3.147|      4.250|      8.538|       0|     0|      2.744|      8=
.670
RTD|      2.767|      4.271|     10.512|       0|     0|      2.744|     10=
.512
RTD|      2.867|      4.239|      8.502|       0|     0|      2.744|     10=
.512
RTD|      2.826|      4.262|      9.819|       0|     0|      2.744|     10=
.512
RTD|      2.930|      4.222|      9.128|       0|     0|      2.744|     10=
.512
RTD|      2.840|      4.159|      8.984|       0|     0|      2.744|     10=
.512
RTD|      2.841|      4.112|      8.608|       0|     0|      2.744|     10=
.512
RTD|      2.828|      4.112|      8.557|       0|     0|      2.744|     10=
.512
RTD|      2.875|      4.124|      8.662|       0|     0|      2.744|     10=
.512
RTD|      2.795|      4.109|      9.112|       0|     0|      2.744|     10=
.512
RTD|      2.939|      4.103|      8.677|       0|     0|      2.744|     10=
.512
RTD|      2.867|      4.123|      8.686|       0|     0|      2.744|     10=
.512
RTD|      2.808|      4.106|      8.728|       0|     0|      2.744|     10=
.512
RTD|      2.940|      4.113|      8.488|       0|     0|      2.744|     10=
.512
RTD|      2.873|      4.132|      8.703|       0|     0|      2.744|     10=
.512
RTD|      2.994|      4.107|      8.479|       0|     0|      2.744|     10=
.512
RTD|      2.983|      4.147|      8.642|       0|     0|      2.744|     10=
.512
```

What's wrong? Should I set some kernel settings?

Best regards,
--
Kiwamu Okabe at METASEPI DESIGN
-------------- next part --------------
A non-text attachment was scrubbed...
Name: config-4.9.90-xenomai
Type: application/octet-stream
Size: 187638 bytes
Desc: not available
URL: <http://xenomai.org/pipermail/xenomai/attachments/20180613/ed742ae0/at=
tachment.obj>
_______________________________________________
Xenomai mailing list
Xenomai@xenomai.org
https://xenomai.org/mailman/listinfo/xenomai
________________________________

This message and any attachments are solely for the use of the intended rec=
ipients. They may contain privileged and/or confidential information or oth=
er information protected from disclosure. If you are not an intended recipi=
ent, you are hereby notified that you received this email in error and that=
 any review, dissemination, distribution or copying of this email and any a=
ttachment is strictly prohibited. If you have received this email in error,=
 please contact the sender and delete the message and any attachment from y=
our system.

ANDRITZ HYDRO GmbH


Rechtsform/ Legal form: Gesellschaft mit beschr=C3=A4nkter Haftung / Corpor=
ation

Firmensitz/ Registered seat: Wien

Firmenbuchgericht/ Court of registry: Handelsgericht Wien

Firmenbuchnummer/ Company registration: FN 61833 g

DVR: 0605077

UID-Nr.: ATU14756806


Thank You
________________________________

