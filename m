MIME-Version: 1.0
Date: Mon, 23 Aug 2010 20:59:40 +0200
Message-ID: <AANLkTik6qbZkrFyWYC4HQten+EcfHLboiSN2eRtTTqnQ@mail.gmail.com>
From: ramon costa <ramoncostacastello@domain.hid>
Content-Type: multipart/mixed; boundary=00c09f83a2c627cafe048e8240e2
Subject: [Xenomai-help] periodical task in posix skin
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Xenomai help <xenomai@xenomai.org>

--00c09f83a2c627cafe048e8240e2
Content-Type: multipart/alternative; boundary=00c09f83a2c627caf4048e8240e0

--00c09f83a2c627caf4048e8240e0
Content-Type: text/plain; charset=ISO-8859-1

Hi,

I have developed a very simple task in native code and it works fine
(included in native.tar.gz). This
simple task generates a square waveform through the parallel port ( and also
the speaker).

Currently I'm trying to transform this code into the POSIX skin (Makefile
and .c included in posix,tar.gz).
Unfortunatelly It does not work, although the parallel port shows a square
waveform its period is not the desired
one (0.1ms), its period is very small. This makes the system to freeze.

It seems that pthread_wait_np is not working properly, or may be I'm not
using pthread_make_periodic_np
properly. I used it in the following way :

        #define PERIOD 100000

        clock_gettime      ( CLOCK_REALTIME, &now);
        pthread_make_periodic_np (pthread_self(), &now, (struct timespec
*)PERIOD);

I also have tried

       struct timespec period;
       period.tv_sec=0;
       period.tv_nsec=PERIOD;

        clock_gettime      ( CLOCK_REALTIME, &now);
        pthread_make_periodic_np (pthread_self(), &now,&period);

Although both compile and execute, non of them works fine to me. Any clue ?


Best wishes,
Ramon

--00c09f83a2c627caf4048e8240e0
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi,<br><br>I have developed a very simple task in native code and it works =
fine (included in native.tar.gz). This<br>simple task generates a square wa=
veform through the parallel port ( and also the speaker).<br><br>Currently =
I&#39;m trying to transform this code into the POSIX skin (Makefile and .c =
included in posix,tar.gz). <br>


Unfortunatelly It does not work, although the parallel port shows a square =
waveform its period is not the desired <br>one (0.1ms), its period is very =
small. This makes the system to freeze.<br><br>It seems that pthread_wait_n=
p is not working properly, or may be I&#39;m not using pthread_make_periodi=
c_np<br>

properly. I used it in the following way :<br>
<br>=A0=A0=A0=A0=A0=A0=A0 #define PERIOD 100000<br><br>=A0=A0=A0=A0=A0=A0=
=A0 clock_gettime=A0 =A0=A0=A0 ( CLOCK_REALTIME, &amp;now);<br>=A0=A0=A0=A0=
=A0=A0=A0 pthread_make_periodic_np (pthread_self(), &amp;now, (struct times=
pec *)PERIOD);<br><br>I also have tried <br><br>

=A0=A0=A0=A0=A0=A0 struct timespec period;<br>=A0=A0=A0=A0=A0=A0 period.tv_=
sec=3D0;
<br>=A0=A0=A0=A0=A0=A0 period.tv_nsec=3DPERIOD;<br><br>=A0=A0=A0=A0=A0=A0=
=A0 clock_gettime=A0 =A0=A0=A0 ( CLOCK_REALTIME, &amp;now);<br>=A0=A0=A0=A0=
=A0=A0=A0 pthread_make_periodic_np (pthread_self(), &amp;now,&amp;period);<=
br><br>Although both compile and execute, non of them works fine to me. Any=
 clue ?<br>


<br><br>Best wishes,<br>Ramon<br>

--00c09f83a2c627caf4048e8240e0--

--00c09f83a2c627cafe048e8240e2
Content-Type: application/x-gzip; name="native.tar.gz"
Content-Disposition: attachment; filename="native.tar.gz"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_gd7npnf40

H4sICNq8ckwAA3VzZXJfc3BhY2UudGFyAO1X727bNhDPV+spDm3RSJ4iW7HTruncwXOcLqhjB/6D
dRgGg5FomwhFqqTkxO3yMHuWvdiOku3acZquwLpigH5fTPF4x+Pd8cdz7I9vxDgminBOuRfsfQVU
Ec/qdfPrPz+qbv4a1I7qR3u+X6/Vj2p138d5v+bXDveg+jWcuYtUJ0QB7AUSBw+s+5z8f4rHTAQ8
DSn8oJOQSW/2ytqYYlNB+PZcKhiuvLNuoStRRMTubG5xY1KQhM1pJSH6anv1SsAiqjKd/nA8bA7e
QEgjOTbrX6KdkE6YoHDRQ+lFs9/sdNodqN7Unn+/lg0u2s037f74pDlsouiZbyEqZej2hu1joEpJ
BTMiQs7EFGTEkoSGHpQrljWXLMy2s7NRmaipY32wghkWyJxwqdCDUn94dt4GIa9diBWdM5lqM10p
WyUoQ1NN04iKRB/DU+Mz2N1Rp9PQlE8cN1uxAVN5CZgT74hiqpgMwUxXrJJKsgCMNU3GuYQFmWEX
hufjbu8XF/zsKjkvrdLKK2iA0TPxHCtKQtsxfl7PGKdg+w58sEprw9eErSxndo2dEp7xfhvZYY3D
eUhjxUQygYgsMK5zCqmgNzENMKzAopgECUgByYyak2Yxn+TaORYyVWhCThWJPDhLgGlINerOqKLA
cs1AsYQFhAOXMt7UloIvYIIZNWkTOlFYRbhbnKpYaqq9bC2mFgOZg03AznLZaFRNDOAe5PLqzWTy
8l65TJNLG8WBu1lrzu7i2/W2GSjXdHfH1W7V6q6B1U70oZ1uLeuORmbS3bokWeJurVtzGTBdmC0m
bDPAIg9cMDVeNuP5b7+bmi+ZioamuQcaIoytWoC+JnFsEmjincwwT8u0ZTUacRlc4SNin7c649ao
3293h3+Y8eloOOq3zf65h1g8K2cH+0xgKRPAzA68ngfvUgp6P00YZ8l7ov76E2OWXXZYnePjWYeU
c51VR88beNlg5c8149wUUTa5pgljZ62NLq+GTGLlR/ZWuFzf9TfCvB58sfPLvH252yvFjw6vvVg6
vFkSS38/TUQ7DCPIPbSDjBRcgWbvkSKqDSRUkvJkl7jwxku8kYsdQSSRyu3Ti5G7JDed6piKkIYu
eJ7n3OGzADklofbTNcW78ChRbM4If+RC1YUXL/DHeYBfdzzISHeSisDwwI50JTCVntm5S7DG6S1/
srELS1JEdiWYoJwGV0oh5XTrFIY9FU1SJWzj/K31rR/5B3BOrvDZ5PRr7vGZ/s+vV+ur/q92eHiE
/Z9/dFgr+r//Ao8zQKvXPT17Peo3h2e9LuST2G6hpIPtHj7ZgNzPke3M7UH6knBJ4TJlPLSaFxed
s1amOMB+Id76Q2FlRoyd0aDdR1Jrttrw0+iscwK2kObZEVMKir5LmcI3X0gVod7C2XLhJOcheEuF
xHcLmwJMBefLp54kM+ttu9uDHxtQSbWq3OTLcGsznZ+s8cTWM2RefA2GP+OHkTjHy9/KJRM4NiIH
sEEKZmBsHARSTNgUDl9VQjqviJRzx7JarbWtXD3fwIGDA33FRCPvY/ErCMzq007z9eCfakw4mWoH
V53/Os410UTn5Ets8HDTyFLXAQwkDM2Tvey38xeIs0tF8GU3MTQ5nqINsRFmTLNZhuExq/ArQrZA
rTlFc5RoRlXWDFzSKROCKm3aq6X6vjbmNTItxbQmppMjYgHLNwU0JQrjbHb2Vkf8rnHwFrvyK7R6
oDKf1t+fOjxuETKFUcJ6OD5G8WY14nTAKRHHx1bpid0/d+7KoexJLJNvfQcLFChQoECBAgUKFChQ
oECBAgUKFChQoECBAgX+TfwNF9iPUwAoAAA=
--00c09f83a2c627cafe048e8240e2
Content-Type: application/x-gzip; name="posix.tar.gz"
Content-Disposition: attachment; filename="posix.tar.gz"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_gd7ostbt1

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
--00c09f83a2c627cafe048e8240e2--

