References: <CAKSrRNzt7tRjShU79EFYv71SbYwhjmagP11KCAk7-LUCTqXdzA@mail.gmail.com>
	<4FFBEA93.5070202@xenomai.org>
	<CAKSrRNxNEU5f3eY93tgL1WQjtPP5500z1pbYFjLnYOf2P4T2Zg@mail.gmail.com>
	<4FFBF197.4050203@xenomai.org>
	<CAKSrRNwnjG1GRogzx5_QaXu_Jwe+HuQWoQVjqe8N_YQO9GT9Sg@mail.gmail.com>
	<4FFBF7A0.7070601@xenomai.org>
	<CAKSrRNxBZ+GYVRwZhjOxX+tb_LvXhJgjF8ydckmtUNU3PoQdzg@mail.gmail.com>
	<4FFC43B8.2030203@xenomai.org>
	<CAKSrRNzwfnznNPFY+fkEY2q28NEa+Y-7g=g9D8ch5oP0U10BgQ@mail.gmail.com>
	<4FFC50FD.7090008@xenomai.org>
	<CAKSrRNz=88H6A_42fM0_vSSA2hpQekj_k25ZAmOH_Sja4m0TiQ@mail.gmail.com>
	<4FFC61B6.4020900@xenomai.org>
In-Reply-To: <4FFC61B6.4020900@xenomai.org>
Mime-Version: 1.0 (1.0)
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8
Message-Id: <451C7C32-97C8-40B9-9E85-C216A8CD828D@gmail.com>
From: Snmgmt <snmgmt19@gmail.com>
Date: Tue, 10 Jul 2012 13:20:50 -0400
Subject: Re: [Xenomai] XDDP and inter-driver API.
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>




On Jul 10, 2012, at 1:09 PM, Philippe Gerum <rpm@xenomai.org> wrote:

> On 07/10/2012 06:15 PM, Sunetra Sashi wrote:
>>=20
>> Thanks for clarifying. I should have said =C2=A8not possible using Xenoma=
i
>> IPCs=C2=A8. Sorry about that.
>>=20
>> I am not trying to port legacy code. I am instead trying to establish a
>> communication pathway from voice applications in user land to some real
>> time xenomai code running within the kernel via a linux driver KM
>> running native linux. In our instance, it is necessary that the code
>> executes in the kernel space.
>=20
> I have a very simple question: would the real-time code implement a driver=
?
>=20
No, it is a simple xenomai task doing some preliminary things before data hi=
ts the h/w.
>>=20
>> On a related note, if I create a simple xenomai kernel module running
>> real time code and signal events to it from linux kernel space (via the
>> rt_event API) and communicate information back via interrupts (assuming
>> we manage memory via shared buffers), would that considered to be a true
>> Linux-Xenomai switch?
>>=20
>>=20
>>=20
>>=20
>>=20
>>=20
>> On Tue, Jul 10, 2012 at 11:57 AM, Philippe Gerum <rpm@xenomai.org
>> <mailto:rpm@xenomai.org>> wrote:
>>=20
>>    On 07/10/2012 05:43 PM, Sunetra Sashi wrote:
>>=20
>>=20
>>=20
>>        On Tue, Jul 10, 2012 at 11:01 AM, Philippe Gerum
>>        <rpm@xenomai.org <mailto:rpm@xenomai.org>
>>        <mailto:rpm@xenomai.org <mailto:rpm@xenomai.org>>> wrote:
>>=20
>>             On 07/10/2012 01:23 PM, Sunetra Sashi wrote:
>>=20
>>=20
>>                 What is the recommended methodology for kernel space
>>        modules to
>>                 communicate with each other across the Linux-Xenomai spac=
e?
>>=20
>>=20
>>             There is no recommended methodology for this: kernel space
>>        should
>>             run within the linux domain only, or within the Xenomai
>>        domain only
>>             via the inter-driver RTDM interface, or should communicate wi=
th
>>             user-space only via a driver interface. rt <-> nrt within
>>        kernel
>>             space can be done using a low level mechanism, but there is
>>        no high
>>             level IPC for this.
>>=20
>>             Again, if your kernel space code is actually an
>>        application, spare
>>             yourself a lot of pain, and move it to userland.
>>=20
>>=20
>>        That is interesting. So if I have a linux kernel module, say a
>>        network
>>        device driver. And another Xenomai kernel module that needs to
>>        run real
>>        time. Since we want to deal with IP packets, we need our linux
>>        module to
>>        run in the kernel space. Is it safe to assume that communication
>>        between
>>        2 such drivers is not possible in the kernel?
>>=20
>>=20
>>=20
>>    Where did you read the word "impossible" in any of my mails? I've
>>    been telling you two things:
>>=20
>>    - the kind of interface you mention cannot be done using
>>    off-the-shelf Xenomai IPCs. It could be done with a low level
>>    interface though, hint: linux netdev interfacing to Xenomai APCs.
>>=20
>>    - if your linux module actually runs an application, then you may
>>    want to consider moving it to userland, where it belongs. We
>>    strongly discourage implementing application code in kernel space.
>>=20
>>    I don't know what you actually want to do, but it looks like some
>>    port of legacy code from say, VxWorks/pSOS/whatever to linux. If so,
>>    then you should reconsider your target software design, it looks
>>    wrong. There are better ways to do this, less error prone, more
>>    efficient and maintainable, provided you stop insisting on running
>>    application bits in kernel space.
>>=20
>>=20
>>=20
>>                 I corrected the rtipc rtdm device as a protocol device
>>        (I must have
>>                 changed it in error) and I am able to load the
>>        xeno_rtipc.ko now.
>>                 However, the socket open still fails with the same
>>        error code.
>>=20
>>                 Thanks
>>=20
>>=20
>>                                   I am making these calls from within the=

>>                 kernel, not
>>                          from user space.
>>                                   Hence I ended up using rtdm calls inste=
ad
>>=20
>>=20
>>=20
>>                               /dev/rtp0 is a non-real-time user-space
>>        endpoint
>>                 for the
>>                               communication, between a regular linux
>>        application
>>                 and a
>>                          real-time
>>                               component. It does not make sense to open
>>        it from
>>                 kernel space.
>>=20
>>=20
>>                          My intent here is to set up something similar to=

>>                 xddp-echo.c
>>                            (RT - Non
>>                          RT communication) but in kernel space instead. H=
ow
>>                 should I go about
>>                          creating the Linux endpoint for XDDP in the
>>        kernel?
>>=20
>>=20
>>                      There is no direct way for that, this
>>        device/protocol is not
>>                      intended for this purpose. This is a regular linux
>>                 application to
>>                      Xenomai real-time communication path, nothing
>>        else. Regular
>>                 linux
>>                      applications live in userland, only.
>>=20
>>                      We don't recommend building applications in kernel
>>        space.
>>=20
>>=20
>>=20
>>=20
>>=20
>>=20
>>=20
>>                                            Do I need to install any
>>        specific xenomai
>>                          modules for
>>                                   this to work?
>>=20
>>=20
>>                                        Obviously, yes. Check IPC
>>        drivers in the
>>                 "Drivers"
>>                          sub-menu
>>                                   of the
>>                                        Xenomai configuration. You need
>>        to have
>>                                        CONFIG_XENO_DRIVERS_RTIPC_XDDP
>>        enabled.
>>=20
>>=20
>>                                   I already checked this in the
>>        configuration,
>>                 It is enabled.
>>                                   Should this
>>                                   also be set to y?
>>        CONFIG_XENO_DRIVERS_RTIPC. In my
>>                          configuration
>>                                   it is
>>                                   set to m.
>>=20
>>=20
>>                               Did you load the xeno_rtipc module then?
>>=20
>>=20
>>                          It is not loaded. But I got an error when I
>>        did that.
>>                          Xenomai: assertion failed at
>>        /.../kernel/xenomai/skins/)
>>                          Xenomai: RTDM: missing open handler
>>=20
>>=20
>>                      It does not make any sense. This assertion can
>>        only trigger
>>                 for a
>>                      named device, not a protocol device. RTIPC is a
>>        protocol
>>                 device.
>>=20
>>                      - did you change any of the driver code?
>>                      - what command did you use to load the module,
>>        verbatim?
>>=20
>>                          insmod: error inserting 'xeno_rtipc.ko': -1
>>        Invalid
>>                 parameters
>>=20
>>=20
>>=20
>>                                   Should I see any modules loaded in
>>=20
>>        /proc/xenomai/rtdm/protocol_________devices?
>>=20
>>=20
>>                               Yes.
>>=20
>>=20
>>=20
>>=20
>>                                            Thanks
>>                                            Shweta
>>=20
>>=20
>>          _________________________________________________________
>>=20
>>=20
>>=20
>>                                            Xenomai mailing list
>>        Xenomai@xenomai.org <mailto:Xenomai@xenomai.org>
>>        <mailto:Xenomai@xenomai.org <mailto:Xenomai@xenomai.org>>
>>                 <mailto:Xenomai@xenomai.org
>>        <mailto:Xenomai@xenomai.org> <mailto:Xenomai@xenomai.org
>>        <mailto:Xenomai@xenomai.org>>>
>>                          <mailto:Xenomai@xenomai.org
>>        <mailto:Xenomai@xenomai.org>
>>                 <mailto:Xenomai@xenomai.org
>>        <mailto:Xenomai@xenomai.org>> <mailto:Xenomai@xenomai.org
>>        <mailto:Xenomai@xenomai.org>
>>                 <mailto:Xenomai@xenomai.org <mailto:Xenomai@xenomai.org>>=
>>
>>                                   <mailto:Xenomai@xenomai.org
>>        <mailto:Xenomai@xenomai.org>
>>                 <mailto:Xenomai@xenomai.org <mailto:Xenomai@xenomai.org>>=

>>                          <mailto:Xenomai@xenomai.org
>>        <mailto:Xenomai@xenomai.org>
>>                 <mailto:Xenomai@xenomai.org
>>        <mailto:Xenomai@xenomai.org>>> <mailto:Xenomai@xenomai.org
>>        <mailto:Xenomai@xenomai.org>
>>                 <mailto:Xenomai@xenomai.org <mailto:Xenomai@xenomai.org>>=

>>                          <mailto:Xenomai@xenomai.org
>>        <mailto:Xenomai@xenomai.org> <mailto:Xenomai@xenomai.org
>>        <mailto:Xenomai@xenomai.org>>>>__>
>>        http://www.xenomai.org/__________mailman/listinfo/xenomai
>>        <http://www.xenomai.org/________mailman/listinfo/xenomai>
>>=20
>>        <http://www.xenomai.org/________mailman/listinfo/xenomai
>>        <http://www.xenomai.org/______mailman/listinfo/xenomai>>
>>=20
>>=20
>>          <http://www.xenomai.org/________mailman/listinfo/xenomai
>>        <http://www.xenomai.org/______mailman/listinfo/xenomai>
>>                 <http://www.xenomai.org/______mailman/listinfo/xenomai
>>        <http://www.xenomai.org/____mailman/listinfo/xenomai>>>
>>=20
>>=20
>>=20
>>        <http://www.xenomai.org/________mailman/listinfo/xenomai
>>        <http://www.xenomai.org/______mailman/listinfo/xenomai>
>>                 <http://www.xenomai.org/______mailman/listinfo/xenomai
>>        <http://www.xenomai.org/____mailman/listinfo/xenomai>>
>>=20
>>          <http://www.xenomai.org/______mailman/listinfo/xenomai
>>        <http://www.xenomai.org/____mailman/listinfo/xenomai>
>>                 <http://www.xenomai.org/____mailman/listinfo/xenomai
>>        <http://www.xenomai.org/__mailman/listinfo/xenomai>>>>
>>=20
>>=20
>>=20
>>=20
>>        <http://www.xenomai.org/________mailman/listinfo/xenomai
>>        <http://www.xenomai.org/______mailman/listinfo/xenomai>
>>                 <http://www.xenomai.org/______mailman/listinfo/xenomai
>>        <http://www.xenomai.org/____mailman/listinfo/xenomai>>
>>=20
>>          <http://www.xenomai.org/______mailman/listinfo/xenomai
>>        <http://www.xenomai.org/____mailman/listinfo/xenomai>
>>                 <http://www.xenomai.org/____mailman/listinfo/xenomai
>>        <http://www.xenomai.org/__mailman/listinfo/xenomai>>>
>>=20
>>=20
>>        <http://www.xenomai.org/______mailman/listinfo/xenomai
>>        <http://www.xenomai.org/____mailman/listinfo/xenomai>
>>                 <http://www.xenomai.org/____mailman/listinfo/xenomai
>>        <http://www.xenomai.org/__mailman/listinfo/xenomai>>
>>=20
>>          <http://www.xenomai.org/____mailman/listinfo/xenomai
>>        <http://www.xenomai.org/__mailman/listinfo/xenomai>
>>                 <http://www.xenomai.org/__mailman/listinfo/xenomai
>>        <http://www.xenomai.org/mailman/listinfo/xenomai>>>>>
>>=20
>>=20
>>=20
>>                                        --
>>                                        Philippe.
>>=20
>>=20
>>=20
>>=20
>>=20
>>                               --
>>                               Philippe.
>>=20
>>=20
>>=20
>>=20
>>=20
>>                      --
>>                      Philippe.
>>=20
>>=20
>>=20
>>=20
>>=20
>>             --
>>             Philippe.
>>=20
>>=20
>>=20
>>=20
>>=20
>>    --
>>    Philippe.
>>=20
>>=20
>>=20
>=20
>=20
> --=20
> Philippe.
>=20
>=20

