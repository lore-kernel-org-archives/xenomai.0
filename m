References: <4ac5d8524f864db989a3332282818783@dettmbx02.intra.ifm>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <55D757E3.5000607@xenomai.org>
Date: Fri, 21 Aug 2015 18:54:59 +0200
MIME-Version: 1.0
In-Reply-To: <4ac5d8524f864db989a3332282818783@dettmbx02.intra.ifm>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai] timer "host-timer" gets stopped
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: =?UTF-8?Q?See=c3=9flen=2c_Maximilian?= <maximilian.seesslen@ifm.com>, "xenomai@xenomai.org" <xenomai@xenomai.org>

On 08/21/2015 11:44 AM, See=DFlen, Maximilian wrote:
> Hi all,
>=20
> we are using kernel 3.5.7 with xenomai 2.6.2.1 on an MPC5121 PPC architec=
ture.

Which I-pipe patch release number for 3.5.7?

You may want to adapt this fix from 3.10 to 3.5.7, in case the issue is
with a timer IRQ being lost:

commit dad0edc5c84722b16abb24a1f669361522e7277d
Author: Philippe Gerum <rpm@xenomai.org>
Date:   Wed Mar 19 15:02:58 2014 +0100

    powerpc/ipipe: safe transition to cpu-idle mode

--
Philippe.

