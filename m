Message-ID: <e3291e320610040739y2ae413abkd4c037378f75b74f@domain.hid>
Date: Wed, 4 Oct 2006 16:39:39 +0200
From: "d p" <dogpointer@domain.hid>
Subject: Re: [Xenomai-help] root_thread_exit in pSOS skin
In-Reply-To: <4523BD6F.2050708@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_32339_16117597.1159972779251"
References: <e3291e320610030716i59d9bf11q286b2d142b79ef8d@domain.hid>
	<4523BD6F.2050708@domain.hid>
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: xenomai@xenomai.org

------=_Part_32339_16117597.1159972779251
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On 04/10/06, Jan Kiszka <jan.kiszka@domain.hid> wrote:
>
> root_thread_exit maps to __xeno_user_exit [1], and that should get
> called by the UVM main function [2].


OK, but I  put a  xnprintf in root_thread_exit and I never saw this print. I
stop the emulation with CTRL+C.

Regards

------=_Part_32339_16117597.1159972779251
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On 04/10/06, <b class="gmail_sendername">Jan Kiszka</b> &lt;<a href="mailto:jan.kiszka@domain.hid">jan.kiszka@domain.hid</a>&gt; wrote:<div><span class="gmail_quote"></span><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
root_thread_exit maps to __xeno_user_exit [1], and that should get<br>called by the UVM main function [2].</blockquote><div><br>OK, but I&nbsp; put a&nbsp; xnprintf in  root_thread_exit and I never saw this print. I stop the emulation with CTRL+C.
<br><br>Regards<br></div><br></div><br>

------=_Part_32339_16117597.1159972779251--

