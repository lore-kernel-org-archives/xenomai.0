MIME-Version: 1.0
Date: Tue, 31 Jan 2012 18:04:52 +0200
Message-ID: <CAJp2OCNsfC96pT9T3Ya6=z_5bydrt84=4hLy6AySuh4Ec7cVTA@mail.gmail.com>
From: Alex Nikitenko <alexzoidbergnikitenko@domain.hid>
Content-Type: multipart/alternative; boundary=f46d042f92109b5e3b04b7d51f23
Subject: [Xenomai-help] "How to Adapt ARM I-pipe patch to S3C6410" - still
	not solved
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org

--f46d042f92109b5e3b04b7d51f23
Content-Type: text/plain; charset=ISO-8859-1

Hi all.
I'm facing the same problem that has been already discussed some time ago.
Here is the subj.

 On 12/19/2011 02:38 AM, ?? wrote:
>> I want to get the  ARM I-pipe patch  Adapt to S3C6410,but when I start up
>> the board,it stopped at the head.s,with no warning and notice.I find It
>> even not go to the start_kernel() function.what can I do??
>>

>What kernel version? What I-pipe version? What kernel configuration?
>Have you tried the howto?

>http://www.xenomai.org/index.php/I-pipe:ArmPorting

On 12/22/2011 03:37 AM, ?? wrote:
> The kernel version is 2.6.37.6 I-pipe patch is 2.6.0-rc4,

2.6.0-rc4 is a xenomai version, not an I-pipe version. And xenomai
2.6.0-rc4 is obsolete and superseeded by xenomai 2.6.0.

I tried the
> howto ,but I couldn't find the variables and functions in irq.c ,but
> some of  the  functions and variables in time.c were here because of
> the patch.  I want to know whether all the function need to be add by
> myself ? because some of it exist when I patch the ipipe-patch.
> And the tip "Implementing a high-resolution counter.",I modified the
> CONFIG file and use the second way "Decrementer  See s3c24xx
> implementation."
> The complie work was finished with no error. Is there any patch t
> adpat  to the board?
> Thank you !

As indicated by the howto: "In the rest of this document we will call
these files time.c and irq.c, even though they may have another name for
your board. "

Anyway, irq demuxing is done differently with current versions of the
I-pipe, the howto is out of date. For each irq demux (the callbacks
registered with set_irq_chained_handler), the demux function should call
ipipe_handle_chained_irq instead of generic_handle_irq.

However, if the bug happens before start_kernel, the bug has probably
nothing to do with the modifications you made for the I-pipe. But are
you sure that the bug happens before start_kernel? Have you noted that
printk does not work as early as in start_kernel, you have to enable
early printk or use the printascii trick mentioned in the "tips and
tricks" section of the howto.

Please no private mails.

--
                                            Gilles.

On 12/24/2011 03:10 AM, ?? wrote:
> sorry for the mistake,my ipipe-patch is
> adeos-ipipe-2.6.37.6-arm-1.18-03   ,and where can I get the new
> "HowTo" as it maybe out of date.
> As I said,I add the printascii function in the begin of
> start_kernel(),but it didn't print out ,so I believe it didn't go to
> the start_kernel. I also add the printascii function to the
> arch/arm/kernel/head.S,I found when it run to "enable the mmu" it
> stopped. I believe the .config file works well before I patch the
> xenomai .I also believe the xenomai has nothing to do with the setup
> of hardware before the kernel startup.
>

There is no updated version of the howto. But the only wrong thing is
the part about multiplexed interrupts.

You should try printascii with a non-patched kernel to verify that
printascii works for the board you use.

As for using printascii around the place where the mmu is enabled, have
you read the following comment in the kernel sources:

/*
 * Enable the MMU.  This completely changes the structure of the visible
 * memory space.  You will not be able to trace execution through this.
 * If you have an enquiry about this, *please* check the linux-arm-kernel
 * mailing list archives BEFORE sending another post to the list.

Anyway, as early in the boot process the I-pipe patch does not change
anything, so, your problem does not come from the I-pipe patch. Have you
tried the exact same config you use with the patched kernel with an
unpatched kernel?

--
                                                                Gilles.

The problem is that I cannot enter start_kernel() function only with
CONFIG_IPIPE enabled.
If I disable this config everything boots just fine.

I used printascii at arch/arm/kernel/head.S to trace the execution. It goes
to start_kernel() and after this it hangs. But ONLY with CONFIG_IPIPE
enabled.
I also used printk("some string") at the very begining of start_kernel().
If CONFIG_IPIPE not set - string is printed out and kernel boots.
If CONFIG_IPIPE  - hang after calling start_kernel.
Printascii works well.
I used the howto but it seems to have nothing to deal with this problem.
IRQs and Timers are initialized later as I understood.
Kernel version - 2.6.36. Ipipe patch version -
adeos-ipipe-2.6.35.9-arm-1.18-
03.patch.

Any help would be appreciated.
Regards,
Alex

--f46d042f92109b5e3b04b7d51f23
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi all.<br>
  I&#39;m facing the same problem that has been already discussed some time=
 ago. Here is the subj.<br>
  <br>

  <div style=3D"margin-left:40px">
    On 12/19/2011 02:38 AM, ?? wrote:<br>
    &gt;&gt; I want to get the=A0 ARM I-pipe patch=A0 Adapt to S3C6410,but =
when I start up<br>
    &gt;&gt; the board,it stopped at the head.s,with no warning and notice.=
I find It<br>
    &gt;&gt; even not go to the start_kernel() function.what can I do??<br>
    &gt;&gt;<br>
    <br>
    &gt;What kernel version? What I-pipe version? What kernel configuration=
?<br>
    &gt;Have you tried the howto?<br>
    <br>
    &gt;<a href=3D"http://www.xenomai.org/index.php/I-pipe:ArmPorting" targ=
et=3D"_blank">http://www.xenomai.org/index.php/I-pipe:ArmPorting</a><br>
    <br>
    On 12/22/2011 03:37 AM, ?? wrote:<br>
    &gt; The kernel version is 2.6.37.6 I-pipe patch is 2.6.0-rc4,<br>
    <br>
    2.6.0-rc4 is a xenomai version, not an I-pipe version. And xenomai<br>
    2.6.0-rc4 is obsolete and superseeded by xenomai 2.6.0.<br>
    <br>
    I tried the<br>
    &gt; howto ,but I couldn&#39;t find the variables and functions in irq.=
c ,but<br>
    &gt; some of=A0 the=A0 functions and variables in time.c were here beca=
use of<br>
    &gt; the patch.=A0 I want to know whether all the function need to be a=
dd by<br>
    &gt; myself ? because some of it exist when I patch the ipipe-patch.<br=
>
    &gt; And the tip &quot;Implementing a high-resolution counter.&quot;,I =
modified the<br>
    &gt; CONFIG file and use the second way &quot;Decrementer=A0 See s3c24x=
x<br>
    &gt; implementation.&quot;<br>
    &gt; The complie work was finished with no error. Is there any patch t<=
br>
    &gt; adpat=A0 to the board?<br>
    &gt; Thank you !<br>
    <br>
    As indicated by the howto: &quot;In the rest of this document we will c=
all<br>
    these files time.c and irq.c, even though they may have another name fo=
r<br>
    your board. &quot;<br>
    <br>
    Anyway, irq demuxing is done differently with current versions of the<b=
r>
    I-pipe, the howto is out of date. For each irq demux (the callbacks<br>
    registered with set_irq_chained_handler), the demux function should cal=
l<br>
    ipipe_handle_chained_irq instead of generic_handle_irq.<br>
    <br>
    However, if the bug happens before start_kernel, the bug has probably<b=
r>
    nothing to do with the modifications you made for the I-pipe. But are<b=
r>
    you sure that the bug happens before start_kernel? Have you noted that<=
br>
    printk does not work as early as in start_kernel, you have to enable<br=
>
    early printk or use the printascii trick mentioned in the &quot;tips an=
d<br>
    tricks&quot; section of the howto.<br>
    <br>
    Please no private mails.<br>
    <br>
    --<br>
    =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 Gilles.<br>
    <br>
    On 12/24/2011 03:10 AM, ?? wrote:<br>
    &gt; sorry for the mistake,my ipipe-patch is<br>
    &gt; adeos-ipipe-2.6.37.6-arm-1.18-03=A0=A0 ,and where can I get the ne=
w<br>
    &gt; &quot;HowTo&quot; as it maybe out of date.<br>
    &gt; As I said,I add the printascii function in the begin of<br>
    &gt; start_kernel(),but it didn&#39;t print out ,so I believe it didn&#=
39;t go to<br>
    &gt; the start_kernel. I also add the printascii function to the<br>
    &gt; arch/arm/kernel/head.S,I found when it run to &quot;enable the mmu=
&quot; it<br>
    &gt; stopped. I believe the .config file works well before I patch the<=
br>
    &gt; xenomai .I also believe the xenomai has nothing to do with the set=
up<br>
    &gt; of hardware before the kernel startup.<br>
    &gt;<br>
    <br>
    There is no updated version of the howto. But the only wrong thing is<b=
r>
    the part about multiplexed interrupts.<br>
    <br>
    You should try printascii with a non-patched kernel to verify that<br>
    printascii works for the board you use.<br>
    <br>
    As for using printascii around the place where the mmu is enabled, have=
<br>
    you read the following comment in the kernel sources:<br>
    <br>
    /*<br>
    =A0* Enable the MMU.=A0 This completely changes the structure of the vi=
sible<br>
    =A0* memory space.=A0 You will not be able to trace execution through t=
his.<br>
    =A0* If you have an enquiry about this, *please* check the linux-arm-ke=
rnel<br>
    =A0* mailing list archives BEFORE sending another post to the list.<br>
    <br>
    Anyway, as early in the boot process the I-pipe patch does not change<b=
r>
    anything, so, your problem does not come from the I-pipe patch. Have yo=
u<br>
    tried the exact same config you use with the patched kernel with an<br>
    unpatched kernel?<br>
    <br>
    --<br>
    =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 Gilles.<br>
    <br>
  </div>The problem is that I cannot enter start_kernel() function only wit=
h CONFIG_IPIPE enabled.<br>
  If I disable this config everything boots just fine.<br>
  <br>
  I used printascii at arch/arm/kernel/head.S to trace the execution. It
 goes to start_kernel() and after this it hangs. But ONLY with=20
CONFIG_IPIPE enabled.<br>
  I also used printk(&quot;some string&quot;) at the very begining of start=
_kernel().<br>
  If CONFIG_IPIPE not set - string is printed out and kernel boots.<br>
  If CONFIG_IPIPE=A0 - hang after calling start_kernel.<br>
  Printascii works well.<br>
  I used the howto but it seems to have nothing to deal with this=20
problem. IRQs and Timers are initialized later as I understood.<br>
  Kernel version - 2.6.36. Ipipe patch version - adeos-ipipe-2.6.35.9-arm-1=
.18-<div>03.patch.<br>
  <br>
  Any help would be appreciated.<br>
  Regards,<br>
  Alex
</div>

--f46d042f92109b5e3b04b7d51f23--

