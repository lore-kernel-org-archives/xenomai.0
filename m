MIME-Version: 1.0
From: Cris Almaraz <cristina.almaraz@gmail.com>
Date: Thu, 13 Nov 2014 14:01:58 +0100
Message-ID: <CALTC7XJqCSDfPR8bx4VKLdUQtNgKG5yuWW4CNJSnc_hjJ9Aqyw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Xenomai] Call to clock_gettime from xenomai blocking for more than
	2 seconds
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai <xenomai@xenomai.org>

Hi all,



Xenomai version 2.6.3 . Native skin.

CentOS 6.4



I am having some problems with a Xenomai task and the clock_gettime
function. My application is launching several Xenomai tasks in parallel and
some of them need to access the current time. For that, I=E2=80=99ve been u=
sing the
clock_gettime(CLOCK_REALTIME,..) function, but I noticed that if the
application is running during several minutes, sometimes the Xenomai
watchdog is triggered from the clock_gettime call, as it is taking more
than 2 seconds to be executed. The behavior is not always the same,
sometimes the watchdog is triggered after 5 mins, 10 mins=E2=80=A6 and even=
 when
the delay is not long enough to trigger the 2 seconds watchdog, I=E2=80=99v=
e seen
in the logs that there are some unexpected delays in the application.



I=E2=80=99ve read about a similar issue in the Xenomai mailing list, but it=
 was
reported as fixed with Xenomai 2.6. Is there any chance that it is still
happening or is the problem somewhere else? Any ideas and workarounds are
welcome.



Thanks,

Cristina.
