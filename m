Message-ID: <BLU177-W291D54AEABEF93CCC47D2AA03A0@phx.gbl>
From: Rosali Pyun <whimt@hotmail.com>
Date: Tue, 27 May 2014 12:56:28 +0000
In-Reply-To: <oq38fytytt.fsf@merlin.sez.to>
References: <CAJX3k=V+ns3H49G+5HuoMjv6+16yeRLXzr=D6dryyQiuVoQ_dA@mail.gmail.com>,
 <oq8uprt339.fsf@merlin.sez.to>,
 <CAJX3k=X=SOD3P503WM226Qf9VLzMLrRC_3R91DYsBtkwLY5wVA@mail.gmail.com>,
 <oq38fytytt.fsf@merlin.sez.to>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai] Troubleshooting Analogy DIO
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Paul Janzen <pcj@xenomai.sez.to>, Manu S Madhav <manusmad@gmail.com>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>



> To: manusmad@gmail.com
> From: pcj@xenomai.sez.to
> Date: Sat=2C 24 May 2014 18:46:22 -0700
> CC: xenomai@xenomai.org
> Subject: Re: [Xenomai] Troubleshooting Analogy DIO
>=20
> Manu S Madhav <manusmad@gmail.com> writes:
>=20
> > One more question: Is anyone aware of an analogy implementation for
> > using the DAQ counter for quadrature encoding? E.g. by using the
> > A4L_INSN_CONFIG_GPCT_QUADRATURE_ENCODER instruction.
>=20
> I know it works in Comedi=2C but have not tried it in Analogy.  You may
> have to snarf some bit definitions from comedi.
>=20
> Try INSN_CONFIG=2C with two data
> { A4L_INSN_CONFIG_SET_COUNTER_MODE=2C=20
>   NI_GPCT_COUNTING_MODE_QUADRATURE_X4_BITS |
>     NI_GPCT_COUNTING_DIRECTION_HW_UP_DOWN_BITS
> }
>=20
> and then again to arm the counter:
> { A4L_INSN_CONFIG_ARM=2C NI_GPCT_ARM_IMMEDIATE }
>=20
> Then you should be able to get the counter value back with
> a4l_sync_read.=20
>=20
> A4L_INSN_CONFIG_GPCT_QUADRATURE_ENCODER appears to be a half-baked
> sensoray only thing.=20
>=20
> -- Paul
>=20


I was not able to use the counter for quadrature encoder with NI m-series D=
AQ card.I ended up using "quadrature clock converter" chip along with the e=
ncoder and implemented simple counting functionality.
INSN_CONFIG with {A4L_INSN_CONFIG_SET_COUNTER_MODE=2C NI_GPCT_COUNTING_MODE=
_NORMAL_BITS | NI_GPCT_COUNTING_DIRECTION_HW_UP_DOWN_BITS}
Let me know if you have any luck with quadrature encoder mode.=20
-Rosali 		 	   		  =
