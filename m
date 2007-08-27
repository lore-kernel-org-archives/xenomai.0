Message-ID: <10837d740708262338w2def2f9er8fd2ca589e681992@domain.hid>
Date: Mon, 27 Aug 2007 14:38:43 +0800
From: "=?GB2312?B?1cW+pw==?=" <2hang.j1ng.home@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_30914_12240970.1188196723637"
Subject: [Adeos-main] RT ISR re-entrance
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: adeos-main@gna.org

------=_Part_30914_12240970.1188196723637
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

hi all,

In SMP system, an edge triggerred interrupt may be dispatched to multiple
cpus, so the RT ISR of this interrupt may be involved on multiple cpus at
the same time. The question comes: is RT ISR need to be reentrant as
designed or do I miss something?

best regards,

zhangjing

------=_Part_30914_12240970.1188196723637
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

hi all,
<br>
<br>
In SMP system, an edge triggerred interrupt may be dispatched to
multiple cpus, so the RT ISR of this interrupt may be involved on
multiple cpus at the same time. The question comes: is RT ISR need to
be reentrant as designed or do I miss something? <br>
<br>
best regards,
<br>
<br>
zhangjing

------=_Part_30914_12240970.1188196723637--

