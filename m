Mime-Version: 1.0 (Apple Message framework v753.1)
In-Reply-To: <mailman.45.1289905237.25153.xenomai@xenomai.org>
References: <mailman.45.1289905237.25153.xenomai@xenomai.org>
Content-Type: multipart/alternative; boundary=Apple-Mail-6-215655882
Message-Id: <E1C5E37E-623F-41B8-892C-5101FD132E4A@gmail.com>
From: Andreas Glatz <andi.glatz@domain.hid>
Date: Tue, 16 Nov 2010 11:46:24 +0000
Subject: Re: [Xenomai-help] Debug/trace tools for xenomai applications.
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


--Apple-Mail-6-215655882
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	charset=US-ASCII;
	delsp=yes;
	format=flowed

>
> On Mon, 2010-11-15 at 21:26 +0100, ronny meeus wrote:
>> Hello
>>
>> Thanks for the information.
>> I was testing on QEMU but I have seen that there are issue with the
>> timing anyhow.
>> I'm currently changing to a target environment. Once this is
>> completed, I will re-run my tests and get back with the result.
>>
>> I do not really understand what you mean with the simulator.
>> Where can I find more information about it?
>
> http://git.xenomai.org/?p=xenosim.git;a=blob;f=doc/mvm- 
> manual.txt;h=1c6767ea2890d68e1c1c5cfe1420e189b3cc5328;hb=06919eb3a6b6b 
> af7880ea3ade1ecc5f610c35794
>

So in other words the simulator is a good debugging tool if your  
application doesn't (i) directly access hardware (mmap aso...)
(ii) doesn't used assembly code written for another platform and  
(iii) can be compiled with the gcc 2.95.3.

For the first two restrictions this means in other words that the  
application should follow the golden design standard which
proposes to put all hardware depended code into rtdm drivers and  
everything else into the application.

Could one (partly) work around the first two restrictions by letting  
the simulator run inside of qemu which emulates the
target architecture?

Andreas
--Apple-Mail-6-215655882
Content-Transfer-Encoding: quoted-printable
Content-Type: text/html;
	charset=US-ASCII

<html><body style=3D"word-wrap: break-word; -webkit-nbsp-mode: space; =
-webkit-line-break: after-white-space; "><div><blockquote =
type=3D"cite"><div style=3D"margin-top: 0px; margin-right: 0px; =
margin-bottom: 0px; margin-left: 0px; min-height: 14px; "><br></div><div =
style=3D"margin-top: 0px; margin-right: 0px; margin-bottom: 0px; =
margin-left: 0px; ">On Mon, 2010-11-15 at 21:26 +0100, ronny meeus =
wrote:</div> <blockquote type=3D"cite"><div style=3D"margin-top: 0px; =
margin-right: 0px; margin-bottom: 0px; margin-left: 0px; =
">Hello</div><div style=3D"margin-top: 0px; margin-right: 0px; =
margin-bottom: 0px; margin-left: 0px; min-height: 14px; "><br></div><div =
style=3D"margin-top: 0px; margin-right: 0px; margin-bottom: 0px; =
margin-left: 0px; ">Thanks for the information.</div><div =
style=3D"margin-top: 0px; margin-right: 0px; margin-bottom: 0px; =
margin-left: 0px; ">I was testing on QEMU but I have seen that there are =
issue with the</div><div style=3D"margin-top: 0px; margin-right: 0px; =
margin-bottom: 0px; margin-left: 0px; ">timing anyhow.</div><div =
style=3D"margin-top: 0px; margin-right: 0px; margin-bottom: 0px; =
margin-left: 0px; ">I'm currently changing to a target environment. Once =
this is</div><div style=3D"margin-top: 0px; margin-right: 0px; =
margin-bottom: 0px; margin-left: 0px; ">completed, I will re-run my =
tests and get back with the result.</div><div style=3D"margin-top: 0px; =
margin-right: 0px; margin-bottom: 0px; margin-left: 0px; min-height: =
14px; "><br></div><div style=3D"margin-top: 0px; margin-right: 0px; =
margin-bottom: 0px; margin-left: 0px; ">I do not really understand what =
you mean with the simulator.</div><div style=3D"margin-top: 0px; =
margin-right: 0px; margin-bottom: 0px; margin-left: 0px; ">Where can I =
find more information about it?</div> </blockquote><div =
style=3D"margin-top: 0px; margin-right: 0px; margin-bottom: 0px; =
margin-left: 0px; min-height: 14px; "><br></div><div style=3D"margin-top: =
0px; margin-right: 0px; margin-bottom: 0px; margin-left: 0px; "><a =
href=3D"http://git.xenomai.org/?p=3Dxenosim.git;a=3Dblob;f=3Ddoc/mvm-manua=
l.txt;h=3D1c6767ea2890d68e1c1c5cfe1420e189b3cc5328;hb=3D06919eb3a6b6baf788=
0ea3ade1ecc5f610c35794">http://git.xenomai.org/?p=3Dxenosim.git;a=3Dblob;f=
=3Ddoc/mvm-manual.txt;h=3D1c6767ea2890d68e1c1c5cfe1420e189b3cc5328;hb=3D06=
919eb3a6b6baf7880ea3ade1ecc5f610c35794</a></div><div style=3D"margin-top: =
0px; margin-right: 0px; margin-bottom: 0px; margin-left: 0px; =
min-height: 14px; "><font class=3D"Apple-style-span" =
color=3D"#006312"><br></font></div> </blockquote><br></div><div>So in =
other words the simulator is a good debugging tool if your application =
doesn't (i) directly access hardware (mmap aso...)</div><div>(ii) =
doesn't used assembly code written for another platform and (iii) can be =
compiled with the gcc 2.95.3.&nbsp;</div><div><br></div><div>For the =
first two restrictions this means in other words that =
the&nbsp;application should follow&nbsp;the golden design standard =
which</div><div>proposes to put all&nbsp;hardware depended code into =
rtdm drivers&nbsp;and everything else into&nbsp;the =
application.&nbsp;</div><div><br></div><div>Could one (partly) work =
around the first two restrictions by letting the simulator run inside of =
qemu which emulates the</div><div>target =
architecture?</div><br><div>Andreas</div></body></html>=

--Apple-Mail-6-215655882--

