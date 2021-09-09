Subject: Re: (rt_)printf and virtual memory
References: <cf751850-8771-6120-e615-1fb80566a9a5@tin.it>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <44a8a3ac-edf9-9169-ed3d-2a299a3e4ce5@siemens.com>
Date: Thu, 9 Sep 2021 20:44:16 +0200
MIME-Version: 1.0
In-Reply-To: <cf751850-8771-6120-e615-1fb80566a9a5@tin.it>
Content-Type: text/plain; charset="iso-8859-15"
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "Mauro S." <mau.salvi@tin.it>, xenomai@xenomai.org

On 07.09.21 11:21, Mauro S. via Xenomai wrote:
> Hi all,
>=20
> consider the simple code attached.
>=20
> I'm using Xenomai 3.1 on a x86_64 CPU, 2GB RAM.
>=20
> I compile and link the code using "xeno-config --skin=3Dalchemy --cflags"
> and "xeno-config --skin=3Dalchemy --ldflags"
>=20
> * Scenario 1)
> =A0 #define printf rt_printf commented out (use printf for prints)
>=20
> =A0 Changing the NUM_TASKS value, in top command I see these results:
>=20
> =A0 - NUM_TASKS 2
>=20
> =A0=A0=A0 PID=A0 PPID USER=A0=A0=A0=A0 STAT=A0=A0 VSZ %VSZ %CPU COMMAND
> =A0=A0=A0 496=A0=A0 480 root=A0=A0=A0=A0 S=A0=A0=A0 80068=A0=A0 4%=A0=A0 =
0% ./test
>=20
> =A0 - NUM_TASKS 4
>=20
> =A0=A0=A0 PID=A0 PPID USER=A0=A0=A0=A0 STAT=A0=A0 VSZ %VSZ %CPU COMMAND
> =A0=A0=A0 496=A0=A0 480 root=A0=A0=A0=A0 S=A0=A0=A0 80204=A0=A0 4%=A0=A0 =
0% ./test
>=20
> =A0 - NUM_TASKS 5
>=20
> =A0=A0=A0 PID=A0 PPID USER=A0=A0=A0=A0 STAT=A0=A0 VSZ %VSZ %CPU COMMAND
> =A0=A0=A0 496=A0=A0 480 root=A0=A0=A0=A0 S=A0=A0=A0 80272=A0=A0 4%=A0=A0 =
0% ./test
>=20
> =A0 - NUM_TASKS 6
>=20
> =A0=A0=A0 PID=A0 PPID USER=A0=A0=A0=A0 STAT=A0=A0 VSZ %VSZ %CPU COMMAND
> =A0=A0=A0 496=A0=A0 480 root=A0=A0=A0=A0 S=A0=A0=A0 80340=A0=A0 4%=A0=A0 =
0% ./test
>=20
> Virtual memory size increases in a linear way.
>=20
>=20
> * Scenario 2)
> =A0 #define printf rt_printf not commented (use rt_printf for prints)
>=20
> =A0 Changing the NUM_TASKS value, in top command I see these results:
>=20
> =A0 - NUM_TASKS 2
>=20
> =A0=A0=A0 PID=A0 PPID USER=A0=A0=A0=A0 STAT=A0=A0 VSZ %VSZ %CPU COMMAND
> =A0=A0=A0 496=A0=A0 480 root=A0=A0=A0=A0 S=A0=A0=A0 80068=A0=A0 4%=A0=A0 =
0% ./test
>=20
> =A0 - NUM_TASKS 4
>=20
> =A0=A0=A0 PID=A0 PPID USER=A0=A0=A0=A0 STAT=A0=A0 VSZ %VSZ %CPU COMMAND
> =A0=A0=A0 496=A0=A0 480 root=A0=A0=A0=A0 S=A0=A0=A0 80204=A0=A0 4%=A0=A0 =
0% ./test
>=20
> =A0 - NUM_TASKS 5
>=20
> =A0=A0=A0 PID=A0 PPID USER=A0=A0=A0=A0 STAT=A0=A0 VSZ %VSZ %CPU COMMAND
> =A0=A0=A0 496=A0=A0 480 root=A0=A0=A0=A0 S=A0=A0=A0=A0 142M=A0=A0 4%=A0=
=A0 0% ./test
>=20
> =A0 - NUM_TASKS 6
>=20
> =A0=A0=A0 PID=A0 PPID USER=A0=A0=A0=A0 STAT=A0=A0 VSZ %VSZ %CPU COMMAND
> =A0=A0=A0 496=A0=A0 480 root=A0=A0=A0=A0 S=A0=A0=A0=A0 206M=A0=A0 4%=A0=
=A0 0% ./test
>=20
>=20
> Starting from a number of tasks > 4, the VMEM got a jump and then
> increases very rapidly.
>=20
> Is it normal? Or I'm misusing the rt_printf?

No, that's related to glibc's internal memory allocation strategy. I
didn't dig into details, but you can easily trigger enormous virtual
memory reservations (which are not real memory, as we know) by adding a
pre-thread malloc(1) to your program - without using rt_printf.

Jan

--=20
Siemens AG, T RDA IOT
Corporate Competence Center Embedded Linux

