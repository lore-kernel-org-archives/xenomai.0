Message-ID: <a18a592b0708060815s4a1d30c0w906ff61d9acb0fab@domain.hid>
Date: Mon, 6 Aug 2007 17:15:21 +0200
From: "rolfetas bambolas" <rolfetas@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_139519_19092849.1186413321333"
Subject: [Xenomai-help] newbie question
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Xenomai-help@domain.hid

------=_Part_139519_19092849.1186413321333
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi to all,
I'm trying to understand how Xenomai handles priorities, and found a paper
called "Life with Adeos" from 2005 which explains that tasks in secondary
mode force the linux kernel to inherit the RT-Tasks priority.
I also read that User-Space RT Tasks migrate to secondary mode when they
make a system call to the linux-kernel, and migrate back when they use some
Xenomai API.

Does this mean, that the Linux-Kernel will keep the inherited priority until
the RT-Task calls again Xenomai?? what happens is a RT-Task doesn't call
Xenomai for a while??
I hope you understand what I mean,
Thank you,

Rodolfo

------=_Part_139519_19092849.1186413321333
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi to all, <br>I&#39;m trying to understand how Xenomai handles priorities, and found a paper called &quot;Life with Adeos&quot; from 2005 which explains that tasks in secondary mode force the linux kernel to inherit the RT-Tasks priority. 
<br>I also read that User-Space RT Tasks migrate to secondary mode when they make a system call to the linux-kernel, and migrate back when they use some Xenomai API.<br><br>Does this mean, that the Linux-Kernel will keep the inherited priority until the RT-Task calls again Xenomai?? what happens is a RT-Task doesn&#39;t call Xenomai for a while??
<br>I hope you understand what I mean,<br>Thank you,<br><br>Rodolfo<br>

------=_Part_139519_19092849.1186413321333--

