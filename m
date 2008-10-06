Message-ID: <b054e88e0810060529u7c5189qd2853385e7ac64ce@domain.hid>
Date: Mon, 6 Oct 2008 14:29:04 +0200
From: "Giammarco Zacheo" <g.zacheo@domain.hid>
In-Reply-To: <b054e88e0810031129o1638c19cr1a1d096da5169aee@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_72358_8601001.1223296144768"
References: <b054e88e0809290735x19e1618eh6facc56ee6baef18@domain.hid>
	<48E3541E.8090808@domain.hid>
	<b054e88e0810030957l3e25a1beo8866a3e8f79d9e9b@domain.hid>
	<48E66224.7060709@domain.hid>
	<b054e88e0810031129o1638c19cr1a1d096da5169aee@domain.hid>
Subject: Re: [Xenomai-help] Error while building Xenomai on Powerpc with
	instrument function entries enabled
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai-help <xenomai@xenomai.org>

------=_Part_72358_8601001.1223296144768
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

I can confirm that with vmalloc'ed buffers it hangs anyhow.

Giammarco

On Fri, Oct 3, 2008 at 8:29 PM, Giammarco Zacheo <g.zacheo@domain.hid> wrote:

> I'm quite sure it was enabled. I will confirm it on Monday.
>
> Giammarco
>
>
> On Fri, Oct 3, 2008 at 8:19 PM, Gilles Chanteperdrix <
> gilles.chanteperdrix@xenomai.org> wrote:
>
>> Giammarco Zacheo wrote:
>> > I was wrong. I am able to compile the kernel, but it hangs very early,
>> > giving this output:
>> >
>> > zImage starting: loaded at 0x00400000 (sp: 0x017ffe50)
>> > Allocating 0x590acc bytes for kernel ...
>> > OF version = 'EFIKA5K2,1.3'
>> > gunzipping (0x01800000 <- 0x00407000:0x00619b3b)...done 0x4cd39c bytes
>> >
>> > Linux/PowerPC load: root=/dev/nfs rw nfsroot=192.168.10.122:
>> /opt/eldk/ppc_6xx
>> > ip=dhcp console=ttyPSC0
>> > Finalizing device tree... using OF tree (promptr=01003ed8)
>> > cpu_exception:
>> > SRR0 0x0180B338 SRR1  0x00043030 MSR  0x00003030
>> > LR   0x01C704B4 CTR   0x01800000 CR   0x42002042   XER 0x0
>> > DAR  0x00000000 DSISR 0x00000000 Type 2
>> > GPR[] 0x40000000 0x017FFE20 0x00000000 0x41820014 0x01C704B4 0x42002042
>> > 0xC04D0000 0x017FFD90
>> > GPR[] 0x00000001 0x00625C04 0x07C00008 0x07C00008 0x42002044 0x1004A33C
>> > 0x01C647A0 0x017FFC2C
>> > GPR[] 0x01BDCA4C 0x01BDCA6C 0x01BF66C4 0x01BDCA78 0x08000000 0x01BDCA10
>> > 0xFFFFFFFF 0x07C53FC8
>> > GPR[] 0x01800000 0x00590ACC 0x07C548A8 0x00000000 0x00000000 0x004062C8
>> > 0x0040E134 0x00000000
>> > ibat0U 0x00001FFF ibat0L 0x00000012
>> > ibat1U 0xF0001FFF ibat1L 0xF0000012
>> > ibat2U 0x00000000 ibat2L 0x00000000
>> > ibat3U 0x00000000 ibat3L 0x00000000
>> > dbat0U 0xF0001FFF dbat0L 0xF000002A
>> > dbat1U 0x80001FFF dbat1L 0x8000002A
>> > dbat2U 0x00001FFF dbat2L 0x00000012
>> > dbat3U 0xC0001FFF dbat3L 0xC000002A
>> > HID0 0x0000C000
>> > deadend:
>> >
>> > Any hint about?
>>
>> Did you try using vmalloc for the tracer logs ?
>>
>>
>> --
>>                                             Gilles.
>>
>
>

------=_Part_72358_8601001.1223296144768
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<div dir="ltr">I can confirm that with vmalloc&#39;ed buffers it hangs anyhow.<br><br>Giammarco<br><br><div class="gmail_quote">On Fri, Oct 3, 2008 at 8:29 PM, Giammarco Zacheo <span dir="ltr">&lt;<a href="mailto:g.zacheo@domain.hid">g.zacheo@domain.hid</a>&gt;</span> wrote:<br>
<blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;"><div dir="ltr">I&#39;m quite sure it was enabled. I will confirm it on Monday.<br><font color="#888888"><br>
Giammarco</font><div><div></div><div class="Wj3C7c"><br><br><div class="gmail_quote">On Fri, Oct 3, 2008 at 8:19 PM, Gilles Chanteperdrix <span dir="ltr">&lt;<a href="mailto:gilles.chanteperdrix@xenomai.org" target="_blank">gilles.chanteperdrix@xenomai.org</a>&gt;</span> wrote:<br>

<blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;"><div><div></div><div>Giammarco Zacheo wrote:<br>
&gt; I was wrong. I am able to compile the kernel, but it hangs very early,<br>
&gt; giving this output:<br>
&gt;<br>
&gt; zImage starting: loaded at 0x00400000 (sp: 0x017ffe50)<br>
&gt; Allocating 0x590acc bytes for kernel ...<br>
&gt; OF version = &#39;EFIKA5K2,1.3&#39;<br>
&gt; gunzipping (0x01800000 &lt;- 0x00407000:0x00619b3b)...done 0x4cd39c bytes<br>
&gt;<br>
&gt; Linux/PowerPC load: root=/dev/nfs rw nfsroot=192.168.10.122:/opt/eldk/ppc_6xx<br>
&gt; ip=dhcp console=ttyPSC0<br>
&gt; Finalizing device tree... using OF tree (promptr=01003ed8)<br>
&gt; cpu_exception:<br>
&gt; SRR0 0x0180B338 SRR1 &nbsp;0x00043030 MSR &nbsp;0x00003030<br>
&gt; LR &nbsp; 0x01C704B4 CTR &nbsp; 0x01800000 CR &nbsp; 0x42002042 &nbsp; XER 0x0<br>
&gt; DAR &nbsp;0x00000000 DSISR 0x00000000 Type 2<br>
&gt; GPR[] 0x40000000 0x017FFE20 0x00000000 0x41820014 0x01C704B4 0x42002042<br>
&gt; 0xC04D0000 0x017FFD90<br>
&gt; GPR[] 0x00000001 0x00625C04 0x07C00008 0x07C00008 0x42002044 0x1004A33C<br>
&gt; 0x01C647A0 0x017FFC2C<br>
&gt; GPR[] 0x01BDCA4C 0x01BDCA6C 0x01BF66C4 0x01BDCA78 0x08000000 0x01BDCA10<br>
&gt; 0xFFFFFFFF 0x07C53FC8<br>
&gt; GPR[] 0x01800000 0x00590ACC 0x07C548A8 0x00000000 0x00000000 0x004062C8<br>
&gt; 0x0040E134 0x00000000<br>
&gt; ibat0U 0x00001FFF ibat0L 0x00000012<br>
&gt; ibat1U 0xF0001FFF ibat1L 0xF0000012<br>
&gt; ibat2U 0x00000000 ibat2L 0x00000000<br>
&gt; ibat3U 0x00000000 ibat3L 0x00000000<br>
&gt; dbat0U 0xF0001FFF dbat0L 0xF000002A<br>
&gt; dbat1U 0x80001FFF dbat1L 0x8000002A<br>
&gt; dbat2U 0x00001FFF dbat2L 0x00000012<br>
&gt; dbat3U 0xC0001FFF dbat3L 0xC000002A<br>
&gt; HID0 0x0000C000<br>
&gt; deadend:<br>
&gt;<br>
&gt; Any hint about?<br>
<br>
</div></div>Did you try using vmalloc for the tracer logs ?<br>
<br>
<br>
--<br>
<font color="#888888"> &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;Gilles.<br>
</font></blockquote></div><br></div></div></div>
</blockquote></div><br></div>

------=_Part_72358_8601001.1223296144768--

