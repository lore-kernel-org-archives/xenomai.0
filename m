Message-ID: <4378B67B.7090200@domain.hid>
Date: Mon, 14 Nov 2005 17:08:27 +0100
From: =?ISO-8859-1?Q?Ignacio_Garc=EDa_P=E9rez?= <iggarpe@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] [BUG] rt_pipe_flush declaration missing
	in	skins/native/pipe.h
References: <4370641D.7010906@domain.hid>	<4370C966.3030903@domain.hid>	<4370D2B8.8070608@domain.hid>	<4370E49F.3070305@domain.hid>
	<437886EF.6070001@domain.hid> <4378A718.80105@domain.hid>
In-Reply-To: <4378A718.80105@domain.hid>
Content-Type: multipart/mixed; boundary="------------060401040502080300070407"
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai-core <xenomai@xenomai.org>

This is a multi-part message in MIME format.
--------------060401040502080300070407
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Philippe Gerum wrote:

> Ignacio Garc=EDa P=E9rez wrote:
>
>> Hi,
>>
>> The subject says it all.
>>
>
> Fixed, thanks.
>
> PS: please send patches when possible, it's faster to handle for me
> and less likely to be forgotten in my job queue. TIA,
>
I updated my source from the repository, and the
EXPORT_SYMBOL(rt_pipe_flush) in pipe.c is missing, so rt_pipe_flush is
not usable yet. Patch attached.

Nacho.

--------------060401040502080300070407
Content-Type: text/plain;
 name="patch.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch.diff"

Index: skins/native/pipe.c
===================================================================
--- skins/native/pipe.c	(revision 143)
+++ skins/native/pipe.c	(working copy)
@@ -1050,5 +1050,6 @@
 EXPORT_SYMBOL(rt_pipe_read);
 EXPORT_SYMBOL(rt_pipe_write);
 EXPORT_SYMBOL(rt_pipe_stream);
+EXPORT_SYMBOL(rt_pipe_flush);
 EXPORT_SYMBOL(rt_pipe_alloc);
 EXPORT_SYMBOL(rt_pipe_free);

--------------060401040502080300070407--

