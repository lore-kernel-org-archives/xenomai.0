Message-ID: <b647ffbd0608070603q61008d0emc3a6555b62a40cc2@domain.hid>
Date: Mon, 7 Aug 2006 15:03:45 +0200
From: "Dmitry Adamushko" <dmitry.adamushko@domain.hid>
Subject: Re: [Xenomai-help] rt_pipe and rt_queue problems
In-Reply-To: <1154799634.4330.23.camel@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_26378_4641830.1154955825876"
References: <200608021808.18076@domain.hid> <44D0F72E.3020406@domain.hid>
	<200608031628.31584@domain.hid> <44D26C1C.5040506@domain.hid>
	<200608041345.6449@domain.hid> <44D4CC6C.1020709@domain.hid>
	<1154799634.4330.23.camel@domain.hid>
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Petr Cervenka <grugh@domain.hid>
Cc: xenomai@xenomai.org, Jan Kiszka <jan.kiszka@domain.hid>

------=_Part_26378_4641830.1154955825876
Content-Type: multipart/alternative; 
	boundary="----=_Part_26379_1195314.1154955825876"

------=_Part_26379_1195314.1154955825876
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hello,

does this patch make a difference for you?

I haven't followed the whole conversation closely so it's just based on
Jan's trace.

Just a bit blind copy_and_past from __rt_queue_receive() I guess.


-- 
Best regards,
Dmitry Adamushko

------=_Part_26379_1195314.1154955825876
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<br>
Hello,<br>
<br>
does this patch make a difference for you?<br>
<br>
I haven't followed the whole conversation closely so it's just based on Jan's trace.<br>
<br>
Just a bit blind copy_and_past from __rt_queue_receive() I guess.<br>
<br>
<br>-- <br>Best regards,<br>Dmitry Adamushko<br>
<br>
<br>

------=_Part_26379_1195314.1154955825876--

------=_Part_26378_4641830.1154955825876
Content-Type: text/x-patch; name=syscall.c.patch; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: base64
X-Attachment-Id: f_eqkusic0
Content-Disposition: attachment; filename="syscall.c.patch"

LS0tIHN5c2NhbGwtb2xkLmMJMjAwNi0wOC0wNyAxNDo1ODoyOC42OTYxNjgwMDAgKzAyMDAKKysr
IHN5c2NhbGwuYwkyMDA2LTA4LTA3IDE0OjU4OjM5LjMwODM2MTAwMCArMDIwMApAQCAtMjM3NSw3
ICsyMzc1LDcgQEAgc3RhdGljIGludCBfX3J0X3F1ZXVlX3JlYWQoc3RydWN0IHRhc2tfcwogICAg
ICAgICAoY3VyciwgVkVSSUZZX1JFQUQsIF9feG5fcmVnX2FyZzQocmVncyksIHNpemVvZih0aW1l
b3V0KSkpCiAgICAgICAgIHJldHVybiAtRUZBVUxUOwogCi0gICAgX194bl9jb3B5X2Zyb21fdXNl
cihjdXJyLCAmdGltZW91dCwgKHZvaWQgX191c2VyICopX194bl9yZWdfYXJnMyhyZWdzKSwKKyAg
ICBfX3huX2NvcHlfZnJvbV91c2VyKGN1cnIsICZ0aW1lb3V0LCAodm9pZCBfX3VzZXIgKilfX3hu
X3JlZ19hcmc0KHJlZ3MpLAogICAgICAgICAgICAgICAgICAgICAgICAgc2l6ZW9mKHRpbWVvdXQp
KTsKIAogICAgIHJzaXplID0gcnRfcXVldWVfcmVjZWl2ZShxLCAmbWJ1ZiwgdGltZW91dCk7Cg==

------=_Part_26378_4641830.1154955825876--

