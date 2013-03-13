MIME-Version: 1.0
Date: Wed, 13 Mar 2013 20:43:11 +0100
Message-ID: <CAPRPZsBh=5TkR93kiQR8yg0ABfJZtwJ_piBQKAOznEWMppgCyw@mail.gmail.com>
From: Jeroen Van den Keybus <jeroen.vandenkeybus@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Subject: [Xenomai] SMI handling on x86
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Hi,


We have configured Linux 3.5.7 / Xenomai 2.6.2.1 on an MSI-7514 mainboard
with a Core 2 Duo CPU.

This configuration suffers from excessive worst-case latencies during the
'latency' test (on average: 2.6 =B5s, worst-case around 1900 =B5s, around 1=
0
overruns per second). I believe these overruns are due to the CPUs entering
SM mode (SMI). As soon as the ACPI BIOS SMI is disabled (when
xeno_nucleus/native are loaded as a module), the computer shuts down in 5
secs. or so. Presumably some power supply watchdog on the mainboard isn't
triggered.

- Has someone also observed this behaviour and maybe solved it in some way =
?
- I looked around in the Intel manuals and I don't think it's possible to
have only 1 CPU handle these SMIs. Is that correct ? If it were possible,
we could run RT tasks on the other one, obviously, but currently latency
shows overruns on both CPUs.
- Would it somehow be possible/sensible to leave the SMI disabled and
generically call the SMI handler directly from within (a task in) the OS ?
There's probably going to be issues, the least of which would be proper
handling of the RSM instruction outside SM mode. But still...


Jeroen.
