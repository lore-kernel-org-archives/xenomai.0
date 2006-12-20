Message-ID: <1a8b03710612191717k32dc37e1k9ef4d27ca1ec48aa@domain.hid>
Date: Wed, 20 Dec 2006 09:17:00 +0800
From: "fengli zhang" <zflandwjj@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_18475_17390427.1166577420370"
Subject: [Adeos-main] installing problems with adeos-based rtai
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: adeos-main@gna.org

------=_Part_18475_17390427.1166577420370
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi,

 I have been trying to insatall adios-based rtai. But there always serval
problems I coud't understand complete, which as ollows:Take linux-2.6.10 and
rtai-3.4 for example.

1.    I don't know the difference between adeos-based rtai and rthal-based
rtai. In my opinion, they both act as a interrupt dispatcher which receive
interruptions from the hardware layer and control them .

 2.   I still don't know how to install adeos-based rtai after reading many
articles about installing rtai. There are two ideas about it :

(1). After downloading rtai-3.4 ,do I still need to download an adeos patch
for linux , e.g.adeos-linux-2.6.10-i386-r13, and patch the kernel?
(2). The  rtai-3.4 itself contains the adeos patch for linux already,and
what I need to do is just patch the linux using which is located in
rtaidir/rtai-3.4/base/arch/i386/patches/hal-linux-
2.6.10-i386-r13.patchafter I unzip the
rtai-3.4.tar.bz2.

 I don't know which one is all right. Please let me know if you have some
ideas about it.
Thanks in advance
Regards
Fengli Zhang

------=_Part_18475_17390427.1166577420370
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<div>Hi,<br><br>&nbsp;I have been trying to insatall adios-based rtai. But there always serval problems I coud&#39;t understand complete, which as ollows:Take linux-2.6.10 and rtai-3.4 for example.<br><br>1. &nbsp; &nbsp;I don&#39;t know the difference between adeos-based rtai and rthal-based rtai. In my opinion, they both act as a interrupt dispatcher which receive interruptions from the hardware layer&nbsp;and control them .
<br><br>&nbsp;2.&nbsp;&nbsp;&nbsp;I still don&#39;t know how to install adeos-based rtai after reading many articles about installing rtai. There are two ideas about it :<br><br>(1).&nbsp;After downloading rtai-3.4 ,do I still need to download an adeos patch for linux , 
e.g.adeos-linux-2.6.10-i386-r13, and patch the kernel?<br>(2). The &nbsp;rtai-3.4 itself contains the adeos patch for linux already,and what I need to do is just patch the linux using which is located in rtaidir/rtai-3.4/base/arch/i386/patches/hal-linux- 
2.6.10-i386-r13.patch after I unzip the rtai-3.4.tar.bz2.<br><br>&nbsp;I don&#39;t know which one is all right. Please let me know if you have some ideas about it.</div>
<div>Thanks in advance</div>
<div>Regards</div>
<div>Fengli Zhang<br>&nbsp;</div>

------=_Part_18475_17390427.1166577420370--

