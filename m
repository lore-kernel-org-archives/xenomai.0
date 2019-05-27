Date: Mon, 27 May 2019 11:13:45 -0500 (CDT)
From: Per Oberg <pero@wolfram.com>
Message-ID: <661761898.734873.1558973625401.JavaMail.zimbra@wolfram.com>
In-Reply-To: <c3d7d4a5-6446-1109-1100-39dd83cf862e@siemens.com>
References: <1472936151.691343.1558942077593.JavaMail.zimbra@wolfram.com>
 <c3d7d4a5-6446-1109-1100-39dd83cf862e@siemens.com>
Subject: Re: RTUdp incoming msg are ok but unable to send UDP
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: xenomai <xenomai@xenomai.org>





----- Den 27 maj 2019, p=C3=A5 kl 10:22, Jan Kiszka jan.kiszka@siemens.com =
skrev:

> On 27.05.19 09:27, Per Oberg via Xenomai wrote:
> > Hi folks

>> I am having some troubles with UDP and rtnet. I think it used to work, b=
ut I'm
>> not sure in what configuration. I had to update to meet some driver dema=
nds and
> > now i am using the following versions:

> > Xenomai 3.0.7
> > ipipe-core-4.9.90-x86-6
> > Kernel 4.9.90


>> When trying to send a UDP message I got a kernel paging request error so=
 I tried
>> adding nosmap to the boot parameters. This solved the kernel paging bug =
but no
> > messages are coming out.


>> Does anyone know if there went in some patches to rtudp lately that woul=
d fix
> > this?

> > Any other tips out there ?


> Can you try if the issue is also present in stable/v3.0.x or master?

At a first glance it looks like the bug is fixed. However, I couldn't make =
it work in 3.0.8 because of compilation issues with the kernel. In current =
master it works however.



> Jan

> PS: 4.9 is EOL by now.

Yes, I've been meaning to upgrade to 4.14, but I got the feeling there was =
something iffy going on for quite a while?

> --
> Siemens AG, Corporate Technology, CT RDA IOT SES-DE
> Corporate Competence Center Embedded Linux


Thanks

Per =C3=96berg=20

