Message-ID: <4C0772F0.2030806@domain.hid>
Date: Thu, 03 Jun 2010 11:16:32 +0200
From: Erik Schuitema <e.schuitema@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="------------070109090905080709060206"
Subject: [Xenomai-core] rt_printf truncates large strings at end of buffer
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai@xenomai.org

This is a multi-part message in MIME format.
--------------070109090905080709060206
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hi all,

I experienced some undesired behavior when printing large strings (>239 
chars) with rt_printf or one of its variants.

Due to the exact implementation of rt_vfprintf, one has a problem when 
trying to print large strings when the writing position is close to the 
end of the ring buffer, no matter its size or space left.
If the space left at the end of the buffer is larger than 238 chars (= 
RT_PRINT_LINE_BREAK - 2*sizeof(struct entry_head))  (the buffer's write 
pos hasn't automatically wrapped yet) but smaller than the desired 
string length, the string is truncated without any form of feedback to 
the user.

It would be useful to return the actual number of printed characters in 
that case (now rt_vfprintf returns the result of vsnprintf(), which 
returns the number of bytes that would have been printed if there had 
been enough space).

If that conflicts with any specification, it would be nice if there 
could be at least one retry. If the string could not be printed 
completely, the incomplete entry can be modified into an empty entry, 
the writepos can be wrapped, and there can be one retry.

Right now, I have to manually cut my strings in chunks of 239 bytes 
before printing them.

Best regards,
Erik

--------------070109090905080709060206
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>

<meta http-equiv="content-type" content="text/html; charset=ISO-8859-1">
</head>
<body text="#000000" bgcolor="#ffffff">
<div class="moz-text-flowed"
 style="font-family: -moz-fixed; font-size: 12px;" lang="x-western">Hi
all,
<br>
<br>
I experienced some undesired behavior when printing large strings
(&gt;239 chars) with rt_printf or one of its variants.<br>
<br>
Due to the exact implementation of rt_vfprintf, one has a problem when
trying to print large strings when the writing position is close to the
end of the ring buffer, no matter its size or space left.
<br>
If the space left at the end of the buffer is larger than 238 chars (=
RT_PRINT_LINE_BREAK - 2*sizeof(struct entry_head))&nbsp; (the buffer's write
pos hasn't automatically wrapped yet) but smaller than the desired
string length, the string is truncated without any form of feedback to
the user.
<br>
<br>
It would be useful to return the actual number of printed characters in
that case (now rt_vfprintf returns the result of vsnprintf(), which
returns the number of bytes that would have been printed if there had
been enough space).
<br>
<br>
If that conflicts with any specification, it would be nice if there
could be at least one retry. If the string could not be printed
completely, the incomplete entry can be modified into an empty entry,
the writepos can be wrapped, and there can be one retry.
<br>
<br>
Right now, I have to manually cut my strings in chunks of 239 bytes
before printing them.
<br>
<br>
Best regards,
<br>
Erik<br>
</div>
</body>
</html>

--------------070109090905080709060206--

