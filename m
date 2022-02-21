From: Russell Johnson <russell.johnson@kratosdefense.com>
Subject: RE: [External] - Re: In-band Context Switch on oob_ioctl() call
Date: Mon, 21 Feb 2022 15:25:34 +0000
Message-ID: <PH1P110MB10505DB6F9F0B40F4C9DB93CE23A9@PH1P110MB1050.NAMP110.PROD.OUTLOOK.COM>
References: <PH1P110MB105036E4A7D3954173E4C536E2379@PH1P110MB1050.NAMP110.PROD.OUTLOOK.COM>
 <877d9qho0c.fsf@xenomai.org>
In-Reply-To: <877d9qho0c.fsf@xenomai.org>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

I verified this, and the thread is under the FIFO scheduling policy.

CPU   PID   SCHED   PRIO  ISW     CTXSW     SYS       RWA       STAT     TI=
MEOUT      %CPU   CPUTIME     NAME
  9   12344  fifo    98   14      14        14        0          X         =
 -           0.0  00:000.289  evl_dma_thread:12100

- Russell

-----Original Message-----
From: Philippe Gerum <rpm@xenomai.org>=20
Sent: Saturday, February 19, 2022 8:29 AM
To: Russell Johnson <russell.johnson@kratosdefense.com>
Cc: xenomai@xenomai.org
Subject: [External] - Re: In-band Context Switch on oob_ioctl() call

CAUTION: This email originated from outside of the organization. Do not cli=
ck links or open attachments unless you recognize the sender and know the c=
ontent is safe.


Russell Johnson via Xenomai <xenomai@xenomai.org> writes:

> Hello,
>
> I have added the oob_ioctl file descriptor to my driver, and I have=20
> made sure that I call the necessary evl functions in the open()=20
> function in the driver as well. I have a test app in userspace that is=20
> simply opening the driver and issuing an oob_ioctl every second. What=20
> I am seeing in the output from "evl ps -l" is that the "ISW" and=20
> "CTXSW" fields are incrementing with every oob_ioctl call. I added in=20
> the O_OOB flag to my open call, and I am still seeing the same=20
> behavior. I don't get why it would be switching to in-band every time=20
> the oob_ioctl() is called. Any ideas on what I could be doing wrong?
>
> Thanks,
> Russell

It looks like the calling thread is undergoing the so-called weak schedulin=
g policy, see [1].

[1] https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__evlproject.org_c=
ore_user-2Dapi_scheduling_-23SCHED-5FWEAK&d=3DDwIBAg&c=3DzeCCs5WLaN-HWPHrpX=
wbFoOqeS0G3NH2_2IQ_bzV13g&r=3D-WrlDvHLmZCY7pl-EOIRaJl9uZvKbG-G8KkkUcIDh2F7J=
r6SYxS_pdf-orjkExnI&m=3D0Ytm_g4N1lnCdUHifknw-Mckrpzq2gJlG2oKvQ543DBHhDfXPgb=
p5TWf-00etMCB&s=3DHKJUpkhAExaAqj5CUY7bze1EqRKRy8x6RHRKCl4OWH4&e=3D

--
Philippe.

