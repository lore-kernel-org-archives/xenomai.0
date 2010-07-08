Date: 8 Jul 2010 08:01:05 -0000
Message-ID: <20100708080105.27906.qmail@domain.hid>
MIME-Version: 1.0
From: "prakash srinivasan" <asprakash_83@domain.hid>
Content-Type: multipart/alternative;
	boundary="=_c1f86c47e8933342795141c424afbc64"
Subject: [Xenomai-help] =?utf-8?q?Testing_RTNet_in_Xenomai?=
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org

--=_c1f86c47e8933342795141c424afbc64
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="UTF-8"

Dear All,

     I am new to Xenomai. But I am already using RTAI. I referred this page, http://www.xenomai.org/index.php/RTnet:Installation_%26_Testing and tested RTNet in RTAI. Its working fine. However now I would like to test the same RTNet in Xenomai. According to the wiki page, i could not able to start the rtnet successfully. When I tried to start the rtnet, I am getting the segmentation fault error. The errors clearly shows that the dependent modules are not loaded. 



Like RTAI dependent modules rtai_hal, rtai_lxrt, rtai_sem and rtai_rtdm, I did not loaded any modules in Xenomai. Even I never found any "modules" folder in my xenomai installation directory, /usr/xenomai/. I would like to know whether my xenomai is not properly installed or what are the other reasons rtnet is not started?. Kindly give me more about about from this wiki page, "If you have built the RTDM support of Xenomai into the kernel, nothing has to be done.". Do I no need to insert any modules?. Help me to resolve the above issues.



-Prakash   
--=_c1f86c47e8933342795141c424afbc64
Content-Transfer-Encoding: quoted-printable
Content-Type: text/html; charset="UTF-8"

Dear All,<br />
     I am new to Xenomai. But I am already using RTAI. I referred this page=
, http://www.xenomai.org/index.php/RTnet:Installation_%26_Testing and teste=
d RTNet in RTAI. Its working fine. However now I would like to test the sam=
e RTNet in Xenomai. According to the wiki page, i could not able to start t=
he rtnet successfully. When I tried to start the rtnet, I am getting the se=
gmentation fault error. The errors clearly shows that the dependent modules=
 are not loaded. <br />
<br />
Like RTAI dependent modules rtai_hal, rtai_lxrt, rtai_sem and rtai_rtdm, I =
did not loaded any modules in Xenomai. Even I never found any "modules" fol=
der in my xenomai installation directory, /usr/xenomai/. I would like to kn=
ow whether my xenomai is not properly installed or what are the other reaso=
ns rtnet is not started?. Kindly give me more about about from this wiki pa=
ge, "If you have built the RTDM support of Xenomai into the kernel, nothing=
 has to be done.". Do I no need to insert any modules?. Help me to resolve =
the above issues.<br />
<br />
-Prakash   <br><Table border=3D0 Width=3D644 Height=3D57 cellspacing=3D0 ce=
llpadding=3D0 style=3D"font-family:Verdana;font-size:11px;line-height:15px;=
"><TR><td><A HREF=3D"http://sigads.rediff.com/RealMedia/ads/click_nx.ads/ww=
w.rediffmail.com/signatureline.htm@domain.hid?" target=3D"_blank"><IMG SRC=3D"h=
ttp://sigads.rediff.com/RealMedia/ads/adstream_nx.ads/www.rediffmail.com/si=
gnatureline.htm@domain.hid"></A></td></TR></Table>
--=_c1f86c47e8933342795141c424afbc64--

