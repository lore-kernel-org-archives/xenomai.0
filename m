From: Umair Ali <ali.umair@tut.fi>
Date: Mon, 2 May 2016 10:01:16 +0000
Message-ID: <2396B4D2166B62479FBBE370D4A7C1F30A732092@mb2010-3.intra.tut.fi>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Xenomai] rtdm_socket() error -97 for sending UDP or RAW packets
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "xenomai@xenomai.org" <xenomai@xenomai.org>



Hello Gilles,

Thanks for the reply.


** may work from the init module, but not from a real-time thread or vice v=
ersa I am calling rtdm_socket() in init module of the kernel app.

Can you tell me what kind of portocls are supported by rtdm_socket()


Thanks & Regards
Ali
-----Original Message-----
From: Gilles Chanteperdrix [mailto:gilles.chanteperdrix@xenomai.org]
Sent: April-29-16 11:06 PM
To: Umair Ali
Cc: xenomai@xenomai.org
Subject: Re: [Xenomai] rtdm_socket() error -97 for sending UDP or RAW packe=
ts

On Fri, Apr 29, 2016 at 01:45:53PM +0000, Umair Ali wrote:
> Hello there,
>=20
> I am working to make a module which will uses the Rtnet module to send=20
> the UDP or RAW pakets. My aim is to use the interface 'rteth0' in=20
> kernel space same like in userspace. Therefore I think I should create=20
> the socket and then using the created socket link the interface rteth0=20
> with it. But when I use the function 'rtdm_socket(PF_INET,=20
> SOCK_RAW,0)' or 'rtdm_socket(PF_PACKET, SOCK_RAW,0)' or=20
> 'rtdm_socket(PF_INET, SOCK_DGRAM,0)' or anything with available=20
> options i.e also with sock_stream. I got the error -97. Which I have=20
> looked in google means the family of protocol is not supported. Please=20
> tell me if it is possible to send the UDP packets from the kernel=20
> space using interface rteth0 and socket or not. Can u guide me how I=20
> can solve the error -97. Thanks in advance

Sorry, no, I never used RTnet interface in kernel-space. I seem to recall n=
ot all functions may be called from all contexts (for instance, calling soc=
ket may work from the init module, but not from a real-time thread or vice =
versa), but apart from that, I have no clue. The best answer at this point =
would be "use the source, Luke".

Regards.

--=20
					    Gilles.
https://click-hack.org

