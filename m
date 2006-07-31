Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Subject: RE: [Xenomai-help] two questions about using rtdm
Date: Mon, 31 Jul 2006 16:55:01 +0300
Message-ID: <02AA386EB831044F8537A696BA785C78A668C7@domain.hid>
In-Reply-To: <44CDF156.9090205@domain.hid>
From: "Landau, Bracha" <BLandau@domain.hid>
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Wolfgang Grandegger <wg@domain.hid>, Jan Kiszka <jan.kiszka@domain.hid>
Cc: xenomai@xenomai.org

I downloaded RTNet and tried to compile it for mpc8260 fcc enet.=20
I use linux kernel 2.6.14.
The file drivers/rt_mpc8260_fcc_enet.c did not compile. It's looking for =
files named "immap_8260.h" and "immap_cpm2.h", neither of which exists.


-----Original Message-----
From: Wolfgang Grandegger [mailto:wg@domain.hid]
Sent: Monday, July 31, 2006 3:03 PM
To: Jan Kiszka
Cc: Landau, Bracha; xenomai@xenomai.org
Subject: Re: [Xenomai-help] two questions about using rtdm


Jan Kiszka wrote:
> Landau, Bracha wrote:
>> -----Original Message-----
>> From: xenomai-help-bounces@domain.hid
>> [mailto:xenomai-help-bounces@domain.hid Behalf Of
>> xenomai-help-request@domain.hid
>=20
> <snip>
>=20
> Could you please avoid re-using posted mails for new threads? Thanks.
>=20
>> Two questions regarding rtdm:
>>
>> 1) I would like to use the real-time system calls (bind,socket,send,re=
cv, etc) that are included in the API (i.e., rt_dev_socket, rt_dev_bind..=
=2E).
>> I tried to replace the calls to their rt equivalents (e.g., socket bec=
omes rt_dev_socket). But apparently that is not enough, because when I do=
 a call to rt_dev_socket, I get an error.
>> Are there any examples of how to use the r/t sockets?
>=20
> RTnet for real-time networking over Ethernet, Firewire (eth1394 togethe=
r
> with the RT-FireWire package), or WLAN (experimental rt2x00). Soon to
> come: RT-CAN via socket interface (patch is working, Wolfgang is
> currently cleaning up). Ah, and the special-purpose protocol driver TiM=
S
> (Tiny Messaging Service) that comes with RACK
> (developer.berlios.de/projects/rack).
>=20
> If you are missing something, feel free to write and register your own
> RTDM protocol driver. ;)
>=20
>> 2) I am running on an MPC8247 with two CPM serial ports. Can I use the=
 16650A driver provided by xenomai to "impersonate" the CPM serial driver=
? If not, can you instruct me how to do this?
>=20
> That's one for the PPC experts, but I bet the UART is not compatible
> with the 16550A controller, is it?

It is _not_ compatible and it requires porting to RTDM.

Wolfgang.

*************************************************************************=
**********
This email message and any attachments thereto are intended only for use =
by the addressee(s) named above, and may contain legally privileged and/o=
r confidential information. If the reader of this message is not the inte=
nded recipient, or the employee or agent responsible to deliver it to the=
 intended recipient, you are hereby notified that any dissemination, dist=
ribution or copying of this communication is strictly prohibited. If you =
have received this communication in error, please immediately notify the =
postmaster@domain.hid and destroy the original message.
*************************************************************************=
**********

