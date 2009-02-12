MIME-Version: 1.0
Date: Thu, 12 Feb 2009 14:33:54 +0000
Message-ID: <6a782b880902120633k48de76a0y2fa005bc852d74fb@domain.hid>
From: Thiago Lima <thiagolims@domain.hid>
Content-Type: multipart/alternative; boundary=000e0cd4d1aa1d4fc20462b99c33
Subject: [Xenomai-help] rt_task_add_hook() doesnt work
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

--000e0cd4d1aa1d4fc20462b99c33
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi all !

I need to do some things when a new rt task starts. So that, i need to use
the 'rt_task_add_hook()', defined in xenomai task management service.
So, i have created a linux kernel module in which i call this service in
init_module() function. After that, initialize the module and starts a RT
Task.

But, the hook function isnt called. Does anybody have already faced this
problem ?


--------- kernel module simple code -----

void hook(void *cookie) {
   printk(KERN_INFO "hook().\n");
}

int init_module (void) {
    rt_task_add_hook(T_HOOK_START, &hook);
    return 0;
}

--------- kernel module simple code -----


--=20
Thiago Lima Silva
Graduando - Ci=EAncia da Computa=E7=E3o UFBA
Registered Linux user #466887

--000e0cd4d1aa1d4fc20462b99c33
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi all !<br><br>I need to do some things when a new rt task starts. So that=
, i need to use the &#39;rt_task_add_hook()&#39;, defined in xenomai task m=
anagement service.<br>So, i have created a linux kernel module in which i c=
all this service in init_module() function. After that, initialize the modu=
le and starts a RT Task.<br>
<br>But, the hook function isnt called. Does anybody have already faced thi=
s problem ?<br><br><br>--------- kernel module simple code -----<br><br>voi=
d hook(void *cookie) { <br>&nbsp;&nbsp; printk(KERN_INFO &quot;hook().\n&qu=
ot;);<br>
}<br><br>int init_module (void) {<br>&nbsp;&nbsp;&nbsp; rt_task_add_hook(T_=
HOOK_START, &amp;hook);<br>&nbsp;&nbsp;&nbsp; return 0;<br>}<br><br>-------=
-- kernel module simple code -----<br><br><br>-- <br>Thiago Lima Silva<br>G=
raduando - Ci=EAncia da Computa=E7=E3o UFBA<br>
Registered Linux user #466887<br><br>

--000e0cd4d1aa1d4fc20462b99c33--

