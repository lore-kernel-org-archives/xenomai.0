Message-ID: <366554.1510.qm@domain.hid>
Date: Sat, 26 Dec 2009 12:18:13 +0000 (GMT)
From: A C <adrien_chiron@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="0-1082778567-1261829893=:1510"
Subject: [Adeos-main] Re :  Porting Adeos-Ipipe on AVR32 (NGW 100).
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: adeos <adeos-main@gna.org>

--0-1082778567-1261829893=:1510
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Thu, 2009-12-10 at 16:48 +0000, A C wrote:=0A>> Hello,=0A>> =0A>> We sta=
rted to port Adeos for the IRQs part. =0A>> =0A>> Simple question: Why the =
function raw_irqs_disabled_flags(flags) is=0A>> the same with or without ip=
ipe ? (as we saw in some arch).=0A>> =0A=0A>Because the pipeline code must =
guarantee that, for all standard linux=0A>IRQ state accessors/modifiers (e.=
g. local_irq_save/restore(),=0A>raw_irqs_disabled_flags()) the same values =
are used to assert/test the=0A>interrupt on/off states (e.g. MSR_EE, X86_EF=
LAGS_IF and so on), in the=0A>virtualized IRQ flags, than the real IRQ flag=
s linux uses when the=0A>pipeline is disabled, for any given arch.=0A=0A>e.=
g. on x86, albeit ugly, it must be allowed to open-code:=0A=0A>raw_local_sa=
ve_flags(flags);=0A>if (flags & X86_EFLAGS_IF)=0A>interrupts_are_enabled();=
=0A=0A>even if the pipeline is enabled.=0A=0A>> (in the case with ipipe) =
=0A>> Why not use __ipipe_test_root() -in the same way as the function=0A>>=
 __raw_local_save_flags()- to write the new function=0A>> raw_irqs_disabled=
_flags(flags)?=0A=0A>Because this would break the above rule, since __ipipe=
_test_root()=0A>returns 0/1.=0A=0AHello,=0ASorry but we do not still unders=
tand what is the exception with the functionraw_irqs_disabled_flags(flags).=
 In fact, we understand well all others functions (raw_local_irq_disable(),=
 raw_local_irq_enable()...) in the two differents levels (virtualized IRQ f=
lags and real IRQ flags). But with raw_irqs_disabled_flags(flags) we do not=
 see the rule that we will break if it wasn't  the same with the virtualize=
d IRQ flags and with the real IRQ flags. =0A=0ARegards=0AAdrien Chiron and =
Vincent Vanbesien=0A=0A=0A      
--0-1082778567-1261829893=:1510
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: quoted-printable

<html><head><style type=3D"text/css"><!-- DIV {margin:0px;} --></style></he=
ad><body><div style=3D"font-family:times new roman,new york,times,serif;fon=
t-size:12pt"><div>On Thu, 2009-12-10 at 16:48 +0000, A C wrote:<br>&gt;&gt;=
 Hello,<br>&gt;&gt; <br>&gt;&gt; We started to port Adeos for the IRQs part=
. <br>&gt;&gt; <br>&gt;&gt; Simple question: Why the function raw_irqs_disa=
bled_flags(flags) is<br>&gt;&gt; the same with or without ipipe ? (as we sa=
w in some arch).<br>&gt;&gt; <br><br>&gt;Because the pipeline code must gua=
rantee that, for all standard linux<br>&gt;IRQ state accessors/modifiers (e=
.g. local_irq_save/restore(),<br>&gt;raw_irqs_disabled_flags()) the same va=
lues are used to assert/test the<br>&gt;interrupt on/off states (e.g. MSR_E=
E, X86_EFLAGS_IF and so on), in the<br>&gt;virtualized IRQ flags, than the =
real IRQ flags linux uses when the<br>&gt;pipeline is disabled, for any giv=
en arch.<br><br>&gt;e.g. on x86, albeit ugly, it must be allowed to
 open-code:<br><br>&gt;raw_local_save_flags(flags);<br>&gt;if (flags &amp; =
X86_EFLAGS_IF)<br>&gt;interrupts_are_enabled();<br><br>&gt;even if the pipe=
line is enabled.<br><br>&gt;&gt; (in the case with ipipe) <br>&gt;&gt; Why =
not use __ipipe_test_root() -in the same way as the function<br>&gt;&gt; __=
raw_local_save_flags()- to write the new function<br>&gt;&gt; raw_irqs_disa=
bled_flags(flags)?<br><br>&gt;Because this would break the above rule, sinc=
e __ipipe_test_root()<br>&gt;returns 0/1.<br><br>Hello,<br>Sorry but we do =
not still understand what is the exception with the function<span style=3D"=
font-weight: bold;"> raw_irqs_disabled_flags(flags)</span>. In fact, we und=
erstand well all others functions (<meta http-equiv=3D"Content-Type" conten=
t=3D"text/html; charset=3Dutf-8"><meta name=3D"ProgId" content=3D"Word.Docu=
ment"><meta name=3D"Generator" content=3D"Microsoft Word 11"><meta name=3D"=
Originator" content=3D"Microsoft Word 11"><link rel=3D"File-List"
 href=3D"file:///C:%5CDOCUME%7E1%5CChiron%5CLOCALS%7E1%5CTemp%5Cmsohtml1%5C=
01%5Cclip_filelist.xml"><!--[if gte mso 9]><xml>=0A <w:WordDocument>=0A  <w=
:View>Normal</w:View>=0A  <w:Zoom>0</w:Zoom>=0A  <w:HyphenationZone>21</w:H=
yphenationZone>=0A  <w:PunctuationKerning/>=0A  <w:ValidateAgainstSchemas/>=
=0A  <w:SaveIfXMLInvalid>false</w:SaveIfXMLInvalid>=0A  <w:IgnoreMixedConte=
nt>false</w:IgnoreMixedContent>=0A  <w:AlwaysShowPlaceholderText>false</w:A=
lwaysShowPlaceholderText>=0A  <w:Compatibility>=0A   <w:BreakWrappedTables/=
>=0A   <w:SnapToGridInCell/>=0A   <w:WrapTextWithPunct/>=0A   <w:UseAsianBr=
eakRules/>=0A   <w:DontGrowAutofit/>=0A  </w:Compatibility>=0A  <w:BrowserL=
evel>MicrosoftInternetExplorer4</w:BrowserLevel>=0A </w:WordDocument>=0A</x=
ml><![endif]--><!--[if gte mso 9]><xml>=0A <w:LatentStyles DefLockedState=
=3D"false" LatentStyleCount=3D"156">=0A </w:LatentStyles>=0A</xml><![endif]=
--><style>=0A<!--=0A /* Font Definitions */=0A @font-face=0A=09{font-family=
:Cambria;=0A=09panose-1:2 4 5 3 5 4 6 3 2 4;=0A=09mso-font-charset:0;=0A=09=
mso-generic-font-family:roman;=0A=09mso-font-pitch:variable;=0A=09mso-font-=
signature:-1610611985 1073741899 0 0 159 0;}=0A /* Style Definitions */=0A =
p.MsoNormal, li.MsoNormal, div.MsoNormal=0A=09{mso-style-parent:"";=0A=09ma=
rgin:0cm;=0A=09margin-bottom:.0001pt;=0A=09mso-pagination:widow-orphan;=0A=
=09mso-hyphenate:none;=0A=09font-size:12.0pt;=0A=09font-family:"Times New R=
oman";=0A=09mso-fareast-font-family:Cambria;=0A=09mso-fareast-language:AR-S=
A;}=0A@page Section1=0A=09{size:612.0pt 792.0pt;=0A=09margin:70.85pt 70.85p=
t 70.85pt 70.85pt;=0A=09mso-header-margin:36.0pt;=0A=09mso-footer-margin:36=
.0pt;=0A=09mso-paper-source:0;}=0Adiv.Section1=0A=09{page:Section1;}=0A-->=
=0A</style><!--[if gte mso 10]>=0A<style>=0A /* Style Definitions */=0A tab=
le.MsoNormalTable=0A=09{mso-style-name:"Tableau Normal";=0A=09mso-tstyle-ro=
wband-size:0;=0A=09mso-tstyle-colband-size:0;=0A=09mso-style-noshow:yes;=0A=
=09mso-style-parent:"";=0A=09mso-padding-alt:0cm 5.4pt 0cm 5.4pt;=0A=09mso-=
para-margin:0cm;=0A=09mso-para-margin-bottom:.0001pt;=0A=09mso-pagination:w=
idow-orphan;=0A=09font-size:10.0pt;=0A=09font-family:"Times New Roman";=0A=
=09mso-fareast-font-family:"Times New Roman";=0A=09mso-ansi-language:#0400;=
=0A=09mso-fareast-language:#0400;=0A=09mso-bidi-language:#0400;}=0A</style>=
=0A<![endif]--><span style=3D"font-size: 12pt; font-family: &quot;Times New=
 Roman&quot;;">raw_local_irq_disable()</span>, <meta http-equiv=3D"Content-=
Type" content=3D"text/html; charset=3Dutf-8"><meta name=3D"ProgId" content=
=3D"Word.Document"><meta name=3D"Generator" content=3D"Microsoft Word 11"><=
meta name=3D"Originator" content=3D"Microsoft Word 11"><link rel=3D"File-Li=
st" href=3D"file:///C:%5CDOCUME%7E1%5CChiron%5CLOCALS%7E1%5CTemp%5Cmsohtml1=
%5C01%5Cclip_filelist.xml"><!--[if gte mso 9]><xml>=0A <w:WordDocument>=0A =
 <w:View>Normal</w:View>=0A  <w:Zoom>0</w:Zoom>=0A  <w:HyphenationZone>21</=
w:HyphenationZone>=0A  <w:PunctuationKerning/>=0A  <w:ValidateAgainstSchema=
s/>=0A  <w:SaveIfXMLInvalid>false</w:SaveIfXMLInvalid>=0A  <w:IgnoreMixedCo=
ntent>false</w:IgnoreMixedContent>=0A  <w:AlwaysShowPlaceholderText>false</=
w:AlwaysShowPlaceholderText>=0A  <w:Compatibility>=0A   <w:BreakWrappedTabl=
es/>=0A   <w:SnapToGridInCell/>=0A   <w:WrapTextWithPunct/>=0A   <w:UseAsia=
nBreakRules/>=0A   <w:DontGrowAutofit/>=0A  </w:Compatibility>=0A  <w:Brows=
erLevel>MicrosoftInternetExplorer4</w:BrowserLevel>=0A </w:WordDocument>=0A=
</xml><![endif]--><!--[if gte mso 9]><xml>=0A <w:LatentStyles DefLockedStat=
e=3D"false" LatentStyleCount=3D"156">=0A </w:LatentStyles>=0A</xml><![endif=
]--><style>=0A<!--=0A /* Font Definitions */=0A @font-face=0A=09{font-famil=
y:Cambria;=0A=09panose-1:2 4 5 3 5 4 6 3 2 4;=0A=09mso-font-charset:0;=0A=
=09mso-generic-font-family:roman;=0A=09mso-font-pitch:variable;=0A=09mso-fo=
nt-signature:-1610611985 1073741899 0 0 159 0;}=0A /* Style Definitions */=
=0A p.MsoNormal, li.MsoNormal, div.MsoNormal=0A=09{mso-style-parent:"";=0A=
=09margin:0cm;=0A=09margin-bottom:.0001pt;=0A=09mso-pagination:widow-orphan=
;=0A=09mso-hyphenate:none;=0A=09font-size:12.0pt;=0A=09font-family:"Times N=
ew Roman";=0A=09mso-fareast-font-family:Cambria;=0A=09mso-fareast-language:=
AR-SA;}=0A@page Section1=0A=09{size:612.0pt 792.0pt;=0A=09margin:70.85pt 70=
.85pt 70.85pt 70.85pt;=0A=09mso-header-margin:36.0pt;=0A=09mso-footer-margi=
n:36.0pt;=0A=09mso-paper-source:0;}=0Adiv.Section1=0A=09{page:Section1;}=0A=
-->=0A</style><!--[if gte mso 10]>=0A<style>=0A /* Style Definitions */=0A =
table.MsoNormalTable=0A=09{mso-style-name:"Tableau Normal";=0A=09mso-tstyle=
-rowband-size:0;=0A=09mso-tstyle-colband-size:0;=0A=09mso-style-noshow:yes;=
=0A=09mso-style-parent:"";=0A=09mso-padding-alt:0cm 5.4pt 0cm 5.4pt;=0A=09m=
so-para-margin:0cm;=0A=09mso-para-margin-bottom:.0001pt;=0A=09mso-paginatio=
n:widow-orphan;=0A=09font-size:10.0pt;=0A=09font-family:"Times New Roman";=
=0A=09mso-fareast-font-family:"Times New Roman";=0A=09mso-ansi-language:#04=
00;=0A=09mso-fareast-language:#0400;=0A=09mso-bidi-language:#0400;}=0A</sty=
le>=0A<![endif]--><span style=3D"font-size: 12pt; font-family: &quot;Times =
New Roman&quot;;">raw_local_irq_enable()...)</span> in the two differents l=
evels (virtualized IRQ flags and real IRQ flags). But with raw_irqs_disable=
d_flags(flags) we do not see the rule that we will break if it wasn't&nbsp;=
 the same with the virtualized IRQ flags and with the real IRQ flags. <br><=
br>Regards<br>Adrien Chiron and Vincent Vanbesien<br><br><br></div>=0A<!-- =
cg21.c41.mail.ird.yahoo.com compressed/chunked Sat Dec 26 03:54:58 PST 2009=
 -->=0A</div><br>=0A=0A=0A=0A=0A      </body></html>
--0-1082778567-1261829893=:1510--

