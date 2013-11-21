Message-ID: <1385063104.21818.YahooMailNeo@web193606.mail.sg3.yahoo.com>
Date: Fri, 22 Nov 2013 03:45:04 +0800 (SGT)
From: Alex Martin <alex.martin92@ymail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: [Xenomai] rt_task_set_periodic
Reply-To: Alex Martin <alex.martin92@ymail.com>
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "xenomai@xenomai.org" <xenomai@xenomai.org>

Hi,=0A=0AI want to adjust the period set for rt_task_set_periodic. =0A=0AIt=
 is required to adjust the period value at run time when task is running.=
=0AI want to adjust the task period to external clock.=0A=0Aperiod will abo=
ut 5 milli seconds.( I set it to 5e6 ). There will be always difference bet=
ween two clocks. I want to adjust dynamically during run time period of the=
 xenomai task to match external clock.=0A=0AWhich function can be used.=0A=
=0ABest regards,=0A=0AAlex.

