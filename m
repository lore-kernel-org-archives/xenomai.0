Message-ID: <5140F24B.7080900@xenomai.org>
Date: Wed, 13 Mar 2013 22:40:27 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <CAPRPZsBh=5TkR93kiQR8yg0ABfJZtwJ_piBQKAOznEWMppgCyw@mail.gmail.com>
In-Reply-To: <CAPRPZsBh=5TkR93kiQR8yg0ABfJZtwJ_piBQKAOznEWMppgCyw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai] SMI handling on x86
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jeroen Van den Keybus <jeroen.vandenkeybus@gmail.com>
Cc: xenomai@xenomai.org

On 03/13/2013 08:43 PM, Jeroen Van den Keybus wrote:

> Hi,


Hi,

>=20
>=20
> We have configured Linux 3.5.7 / Xenomai 2.6.2.1 on an MSI-7514 mainboa=
rd
> with a Core 2 Duo CPU.
>=20
> This configuration suffers from excessive worst-case latencies during t=
he
> 'latency' test (on average: 2.6 =C2=B5s, worst-case around 1900 =C2=B5s=
, around 10
> overruns per second). I believe these overruns are due to the CPUs ente=
ring
> SM mode (SMI). As soon as the ACPI BIOS SMI


Do you have ACPI enabled in the kernel configuration?

--=20
                                                                Gilles.


