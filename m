Date: Mon, 23 Aug 2021 15:56:23 +0800
Subject: Re: Big jitter issues every 5 seconds
From: Ivan Jiang <jcgeforce@aliyun.com>
Message-ID: <EE5664AB-92AF-4393-8959-557BA933D671@aliyun.com>
References: <FE2C94EF-3136-482C-9A4A-CF252AD452F0@aliyun.com>
 <8cf26766-7cc1-4bf5-d92f-75f9a247da78@numalliance.com>
In-Reply-To: <8cf26766-7cc1-4bf5-d92f-75f9a247da78@numalliance.com>
Mime-version: 1.0
Content-type: text/plain;
	charset="UTF-8"
Content-transfer-encoding: quoted-printable
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: =?UTF-8?B?U3TDqXBoYW5l?= Ancelot <sancelot@numalliance.com>, xenomai@xenomai.org

Hi, S.Ancelot:

	That's true 55us or even more jitter will not influent with EtherCAT Maste=
r especially with DC, and we've already done with the robot control or motio=
n control.
	But for some enhanced implementations the control period must set to 125uS=
 or 250uS, and this big jitter must be a big problem.
	Therefore, we are starting to use ftrace to analysis if any unrealized app=
s in kernel.
	Will you be pleased to give me more suggestion?
	Thank you.

	BR.,
	Ivan.

=EF=BB=BF=E5=9C=A8 2021/8/23 15:25=EF=BC=8C=E2=80=9CXenomai =E4=BB=A3=E8=A1=A8 St=C3=A9phane Ancelot via Xenomai=E2=80=9D=
<xenomai-bounces@xenomai.org =E4=BB=A3=E8=A1=A8 xenomai@xenomai.org> =E5=86=99=E5=85=A5:

    Hi,

    I understand that you must check max jitters in your system.

    However, I have already designed ethercat master stacks.

    By design, having 55us or more jitter when sending the sync frame  is=20
    not a problem for an Ethercat master system,  since the implementation=20
    of this bus permits it.

    Regards,

    S.Ancelot

    Le 20/08/2021 =C3=A0 19:14, Ivan Jiang via Xenomai a =C3=A9crit :
    > Dear xenomai Oners:
    >
    >  =20
    >
    >         My name is Ivan and our company use xenomai 3.10 patched on L=
inux 4.19.94 worked on Daul core Cortex A7 800MHz CPU.
    >
    >         We used this solution to build an EtherCAT Master controller.
    >
    >         With the isolcpus=3D1 nohz=3Don nohz_full=3D1  rcu_nocbs=3D1 the user=
 space latency waveforms is like below:
    >
    >  =20
    >
    >         Normally jitter is from -10~10uS every 1mS period,
    >
    >         With a -30~30uS worst jitter every 200mS which made by our wi=
fi AP enabled on our A7 Core board, this one could be disappeared if we turn=
ed off the WIFI.
    >
    >         But the most unimaginable jitter is up to -55~55uS every 5S, =
which could not find any reason,  that we closed all the peripherals on the =
board except the EtherCAT.
    >
    >         Whatever we turn on/off the L2 Cache or change the size of re=
gistry slots and size of system heap / private heap / shared heap.
    >
    >         Our biggest problems are why WIFI could influent the Jitters =
and the biggest jitter every 5S is forbidden, we must get rid of them.
    >
    >         Could you help us to analysis these questions.
    >
    >         Sincerely we need your help.
    >
    >  =20
    >
    >         Thank you,
    >
    >         BR.,
    >
    >         Ivan
    >
    >  =20
    >
    >  =20
    >
    > -------------- next part --------------
    > A non-text attachment was scrubbed...
    > Name: image001.png
    > Type: image/png
    > Size: 319147 bytes
    > Desc: not available
    > URL: <http://xenomai.org/pipermail/xenomai/attachments/20210821/03a14=
63a/attachment.png>



