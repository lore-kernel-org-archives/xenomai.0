Date: Thu, 3 Nov 2016 09:36:05 +0100
From: Henning Schild <henning.schild@siemens.com>
Message-ID: <20161103093605.2228191c@md1em3qc>
In-Reply-To: <581A1E18.7040405@numalliance.com>
References: <581A1E18.7040405@numalliance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai] ipipe tracer question
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: =?UTF-8?B?U3TDqXBoYW5l?= ancelot <sancelot@numalliance.com>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

Am Wed, 2 Nov 2016 18:10:48 +0100
schrieb St=C3=A9phane ancelot <sancelot@numalliance.com>:

> Hi,
> I have got an RT task that seems being disturbed by some system
> driver.
>=20
> So, I have setted up ipipe tracer in kernel.

The tracing uses the kernel tracing infrastructure. Use the
sysfs-Interface or a tool like trace-cmd or perf to collect traces.
https://www.kernel.org/doc/Documentation/trace/ftrace.txt

> But I do not know where to  go  now ?
> I suppose being on the right way, but what to do next ?
>=20
> Regards,
> S.Ancelot
>=20
>=20
> _______________________________________________
> Xenomai mailing list
> Xenomai@xenomai.org
> https://xenomai.org/mailman/listinfo/xenomai


