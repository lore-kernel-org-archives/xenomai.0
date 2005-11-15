Message-ID: <437A0B62.20308@domain.hid>
Date: Tue, 15 Nov 2005 17:22:58 +0100
From: =?ISO-8859-1?Q?Ignacio_Garc=EDa_P=E9rez?= <iggarpe@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] rt_pipe_* usage
References: <OFDC60A907.2FB7647D-ONC12570B9.0058D97B-C12570B9.005A128D@datacon.at>
	<4378BD15.8020206@domain.hid> <4379DFC1.6020904@domain.hid>
In-Reply-To: <4379DFC1.6020904@domain.hid>
Content-Type: multipart/mixed; boundary="------------090705060302010100070706"
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
Cc: xenomai@xenomai.org

This is a multi-part message in MIME format.
--------------090705060302010100070706
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Philippe Gerum wrote:

> Ignacio Garc=EDa P=E9rez wrote:
>
>>>> RT_PIPE_MSG *m =3D rt_pipe_alloc(sizeof(mystruct_t));
>>>> mystruct_t *p =3D (mystruct_t *)P_MSGPTR(m);
>>>> p->whatever1 =3D X;
>>>> p->whatever2 =3D X;
>>>> rt_pipe_send(&mypipe, m, sizeof(mystruct_t), P_NORMAL);
>>>>
>>>> If this is correct, why do I have to specify the size of mystruct_t
>>>> *twice*. Can't it be initialized by rt_pipe_alloc ?.
>>>
>>>
>>> It's initialized actually (*).
>>>
>>
>> So, what's the sense of having to specify it again whet calling
>> rt_pipe_send ?
>>
>
> Because you may (pre-)allocate more than you really need to send
> afterwards.
>
I guess this should be explained in the docs. Please consider the small
patch I attach.

Nacho.

--------------090705060302010100070706
Content-Type: text/plain;
 name="patch.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch.diff"

Index: skins/native/pipe.c
===================================================================
--- skins/native/pipe.c	(revision 143)
+++ skins/native/pipe.c	(working copy)
@@ -598,7 +598,11 @@
  *
  * @param size The size in bytes of the message (payload data
  * only). Zero is a valid value, in which case the service returns
- * immediately without sending any message.
+ * immediately without sending any message. This parameter allows
+ * you to actually send less data than you reserved using the
+ * rt_pipe_alloc() service, which may be the case if you did not
+ * know how much space you needed at the time of allocation. In all
+ * other cases it may be more convenient to just pass P_MSGSIZE(msg).
  *
  * Additionally, rt_pipe_send() causes any data buffered by
  * rt_pipe_stream() to be flushed prior to sending the message. For

--------------090705060302010100070706--

