MIME-Version: 1.0
From: mohamed atef <mohamedatefmohamed95@gmail.com>
Date: Thu, 24 Aug 2017 10:55:55 +0200
Message-ID: <CAAaH=QGRoJJZDiucTdGq33hEATa1j1LZ1fXBWFUWs1-=vDgi-Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: [Xenomai] Work around disabling CONFIG_CPU_FREQ
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

=E2=80=8B
=E2=80=8BHello everyone,

I'm using vendor-originated linux kernel for UDOO IMX6Q board. I could
disable all the configuration variables that Xenomai needs
(CONFIG_CPU_IDLE, ...) except for CONFIG_CPU_FREQ. It always produces
several errors on trying to disable it as many used functions in the
drivers files are defined within cpufreq folder. Is there anything that can
be done to work around disabling it? for example, can I set
cpuinfo_min_freq equal to cpuinfo_max_freq or that won't make a profit?

Thanks in advance.

--=20
=E2=80=8BMohamed Atef=E2=80=8B
=E2=80=8B=E2=80=8B
