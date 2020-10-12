Date: Mon, 12 Oct 2020 18:16:53 +0200 (CEST)
From: g.strobbe@telenet.be
Message-ID: <1555122598.71587057.1602519413581.JavaMail.zimbra@telenet.be>
In-Reply-To: <1174-5f847700-53-37e14c00@74917922>
References: <1174-5f847700-53-37e14c00@74917922>
Subject: Re: SOEM for Xenomai 3
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
To: John Ho <johnho26@gmail.com>
Cc: xenomai <xenomai@xenomai.org>


----- On Oct 12, 2020, at 5:31 PM, xenomai xenomai@xenomai.org wrote:

> Le Lundi, Octobre 12, 2020 17:04 CEST, John Ho via Xenomai <xenomai@xenom=
ai.org>
> a =C3=A9crit:
>=20
>> Hi there, I am writing here to ask if anyone can help me with SOEM
>> compilation for Xenomai 3. I am currently trying to use RTNet to
>> communicate with my Universities Robot and run experiments, however the
>> SOEM's xenomai cmake is requesting for some libraries:
>> Xenomai_Native_Libraries,posix ,pthread, rtdm.it is looking for files fr=
om
>> rtnet for example rtnet.h. Will appreciate the help i can get with regar=
ds
>> to this matter!
>=20
> Hello.
>=20
> I made it some time ago.
> Here are the makefile/setup.sh for my platform (Xilinx Zynq7000) that you=
 can
> adapt for yours.
> Also, I made a slight modification in nicdrv.c to use the proper RTNET io=
ctl for
> receive timeout (RTNET_RTIOC_TIMEOUT).
>=20
> Fran=C3=A7ois
> -------------- next part --------------
> A non-text attachment was scrubbed...
> Name: setup.sh
> Type: text/x-sh
> Size: 2321 bytes
> Desc: not available
> URL:
> <http://xenomai.org/pipermail/xenomai/attachments/20201012/01af9530/attac=
hment.sh>
> -------------- next part --------------
> A non-text attachment was scrubbed...
> Name: arm-zynqrt-gcc.mk
> Type: application/octet-stream
> Size: 1574 bytes
> Desc: not available
> URL:
> <http://xenomai.org/pipermail/xenomai/attachments/20201012/01af9530/attac=
hment.obj>

Hi John,

I have ROS 1/2 - Orocos RTT - SOEM running on Xenomai 3.
If you still need them I can forward my patches as well.

Best regards,

Gino

