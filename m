Date: Fri, 08 Mar 2019 01:19:02 +0000
From: Jeff Webb <w1@codecraftsmen.org>
Reply-To: Jeff Webb <w1@codecraftsmen.org>
Subject: Re: PCI UDD Questions
Message-ID: <zKKqLqu1qla7_010-_LHS-O4UnR4Q6l8v9-LWheCyvIkwigfLQ98AHBXoE_M2sUDmbOTkUxKgzyRM-7Qgs0a-Akkab83rNltWE_K_xZ8dDo=@codecraftsmen.org>
In-Reply-To: <827166fb-a317-e42c-dda3-dd83fcfdbbf5@siemens.com>
References: <MQAHYHsv-KztU7kmKMe1zEyj1YMioxUAHWXO8cjixmGgcY0FuEcPL73Bj0NZxsH9mlyrmGJ1rhAWMr7ii-ErIRz9qSqRXvnyBibYa3AZSAE=@codecraftsmen.org>
 <ecf0bf08-f93e-3c67-a71e-fb25d683930c@xenomai.org>
 <827166fb-a317-e42c-dda3-dd83fcfdbbf5@siemens.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "xenomai@xenomai.org" <xenomai@xenomai.org>

On Wednesday, March 6, 2019 11:38 AM, Jan Kiszka <jan.kiszka@siemens.com> w=
rote:

> On 06.03.19 12:24, Philippe Gerum via Xenomai wrote:
>
> > On 3/2/19 1:25 PM, Jeff Webb via Xenomai wrote:
> >
> > > I could also avoid using the PCI command register entirely and just w=
rite to a device-specific mask bit in my peripheral, but I would rather imp=
lement a generic solution if there is not a performance penalty for using t=
he PCI command register.
> >
> > I don't think that using the PCI layer would be cheaper than tweaking
> > some bit in your device. The former involves a serialization on
> > pci_lock, then a read-update-write sequence to send the
> > masking/unmasking command to the bus layer. Sending the acknowledge to
> > the device in order to stop it from interrupting is the usual way for r=
t
> > sources.
>
> Plus PCI config accesses (which are needed for generic INTx masking) are
> generally more expensive than device register accesses. So don't use them=
 for
> masking, whenever possible.

Philippe and Jan, thanks for the explanations.  That all makes sense.

-Jeff


