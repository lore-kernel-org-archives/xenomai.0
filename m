Message-ID: <44C9D319.7020704@domain.hid>
Date: Fri, 28 Jul 2006 11:04:25 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <1154015872-24969.00053.00861-smmsdV2.1.4@domain.hid>
	<44C8EECE.4070209@domain.hid> <44C90CEF.9090908@domain.hid>
	<44C9136C.7080709@domain.hid> <44C9420D.3070100@domain.hid>
In-Reply-To: <44C9420D.3070100@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigC5E31D9DBFE67E8145FE7328"
Sender: jan.kiszka@domain.hid
Subject: [Xenomai-help] Re: RT_TASK_INFO status
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Nathaniel Villaume <villaume@domain.hid>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigC5E31D9DBFE67E8145FE7328
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Nathaniel Villaume wrote:
> Jan,
> Ok, so I played around with your request some.
>=20
> My goal here is to produce documentation, but not at the expense of
> source-code readability and maintainability.  It's not hard to document=

> defines, but it CAN make the source look uglier.
> Witness nucleus/thread.h:
>=20
> /*! @def XNSUSP */
> #define XNSUSP 0x00000001 /*!< @brief Suspended */
>=20
> /*! @define XNSUSP */
> #define XNSUSP 0x00000002 /*!< Sleep-wait for a resource. */
>=20
> In the first case, @brief is used to get the comment up into the brief
> listing (duh). If this is not done, then a detailed section is created
> with the comment, which is a little kludgier on the output end, but
> still completely usable.

But why are there those @def/@defines? Are those defines already
assigned to some group?

>=20
> Second order of business: refering to this new documentation. In
> include/native/task.h I made a group native_task_status that encompasse=
s
> all the define documentation. This makes it easy to refer to from withi=
n
> the RT_TASK_INFO::status documentation (and anywhere else)

Sounds good.

>=20
> Third: I removed the duplication as you requested. This is not without
> consequence.  Please note the difference between RT_TASK_INFO and
> RT_TASK_MCB (which remainded the same).  To keep the brief member
> documentation, I had to use the /**  comment */ syntax. This is
> inconsistent with other usage, but... this gives the results we want.

Yeah, I noticed this as well. Is this somewhere documented in the
doxygen manual? Anyway, I prefer the output format of "/**" or "/**<"
for such small structures like we have here.

>=20
> Please see the patch and let me know what you think for this initial se=
t.
> Again, the decisions to be made are:
> 1.) Do we document the defines at all?

Via doxygen: those the user needs to know about and they are not already
documented inside some function argument description.

> 1a) If so, do we include brief in the define documentation (or not)?
> 1b) Do we group the defines (or not) for easy reference? (they show up
> under modules/native/Task Status)

I would say: group them, maybe @brief the groups, but do not add
individual @brief to each define.

>=20
> My default action is to continue with the style/grouping as in the patc=
h.

Ack from me. Anyone else any different preferences or additional
suggestions?

>=20
> -Nate
>=20
> Jan Kiszka wrote:
>=20
>> Nathaniel Villaume wrote:
>> =20
>>
>>> In RT_TASK_INFO, can someone tell me what is the set of all possible
>>> values for status?
>>> I'd like to include that in the documentation.
>>>  =20
>>
>> They are defined in include/native/task.h [1], but they widely redirec=
t
>> to defines in include/nucleus/thread.h [2]. Maybe you could add commen=
ts
>> to the native/task.h defines and include them in doxygen.
>>
>> Thanks again for your effort!
>> Jan
>>
>> [1]http://www.rts.uni-hannover.de/xenomai/lxr/source/include/native/ta=
sk.h#L37
>>
>> [2]http://www.rts.uni-hannover.de/xenomai/lxr/source/include/nucleus/t=
hread.h#L25
>>
>>
>> =20
>>
>=20
> -----------------------------------------------------------------------=
-
>=20
> Index: include/native/task.h
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- include/native/task.h	(revision 1383)
> +++ include/native/task.h	(working copy)
> @@ -34,8 +34,20 @@
>  #define T_CPU(cpu) (1 << (24 + (cpu & 7))) /* Up to 8 cpus [0-7] */
>  #define T_CPUMASK  0xff000000
> =20
> -/* Status/mode flags. */
> -#define T_BLOCKED  XNPEND
> +/*!=20
> +  \ingroup native
> +  @defgroup native_task_status Task Status=20
> +  @brief Defines used to specify task state and/or mode=20
> +  */
> +/*! @addtogroup native_task_status=20
> +  @{
> +  */
> +
> +/*! @def T_BLOCKED =20
> +  Task is blocked. See define #XNPEND*/

I wouldn't refer to the nucleus layer here (XN...). The native API
should explain itself independently.

> +#define T_BLOCKED  XNPEND=20
> +/*! @def T_DELAYED =20
> +  Task is delayed. See define #XNDELAY*/
>  #define T_DELAYED  XNDELAY
>  #define T_READY    XNREADY
>  #define T_DORMANT  XNDORMANT
> @@ -49,6 +61,7 @@
>  #define T_RPIOFF   XNRPIOFF
>  #define T_PRIMARY  0x00000200	/* Recycle internal bits status which */=

>  #define T_JOINABLE 0x00000400	/* won't be passed to the nucleus.  */
> +/*! @} */ /* Ends addtogroup native_task_status */
> =20
>  /* Task hook types. */
>  #define T_HOOK_START  XNHOOK_THREAD_START
> @@ -68,31 +81,50 @@
>  struct rt_queue_msg;
>  struct rt_task;
> =20
> +/*! @brief Structure containing task-information useful to users.
> + *
> + *  @see rt_task_inquire()
> +  */
>  typedef struct rt_task_info {
> +   =20
> +    /** Base priority. */
> +    int bprio; =20
> =20
> -    int bprio;			/* !< Base priority. */
> +    /** Current priority. Can change through Priority Inheritance.*/
> +    int cprio;
> +   =20
> +    /** Task's status.
> +     * Status may be any of the defines in task.h
> +     *  @see native_task_status shows possible values.
> +     */
> +    unsigned status;=20
> +   =20
> +    /** Time of next release.*/
> +    RTIME relpoint;=20
> +   =20
> +    /** Symbolic name assigned in creation */
> +    char name[XNOBJECT_NAME_LEN]; =20
> =20
> -    int cprio;			/* !< Current priority. */
> -
> -    unsigned status;		/* !< Status. */
> -
> -    RTIME relpoint;		/* !< Next periodic release point. */
> -
> -    char name[XNOBJECT_NAME_LEN]; /* !< Symbolic name. */
> -
>  } RT_TASK_INFO;

That looks good to me. Note that "/**<" works fine for me as well (in
case there are only short comments...).

> =20
>  #define RT_MCB_FSTORE_LIMIT  64
> +/*! @typedef RT_TASK_MCB
> +  @brief Structure used in passing messages between tasks.
> =20
> +  @param  flowid  Flow identifier.
> +  @param  opcode  Operation code.
> +  @param  data    Message address.
> +  @param  size    Message size (bytes).
> +*/
>  typedef struct rt_task_mcb {
> =20
> -    int flowid;			/* !< Flow identifier. */
> +    int flowid;
> =20
> -    int opcode;			/* !< Operation code. */
> +    int opcode;
> =20
> -    caddr_t data;		/* !< Address of message. */
> +    caddr_t data;
> =20
> -    size_t size;		/* !< Size of message. */
> +    size_t size;
> =20
>  } RT_TASK_MCB;

Just to underline previous statement: no go (IMHO).

> =20
> Index: include/nucleus/thread.h
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- include/nucleus/thread.h	(revision 1383)
> +++ include/nucleus/thread.h	(working copy)
> @@ -1,4 +1,4 @@
> -/*
> +/*! @file nucleus/thread.h
>   * Copyright (C) 2001,2002,2003 Philippe Gerum <rpm@xenomai.org>.
>   *
>   * Xenomai is free software; you can redistribute it and/or modify
> @@ -23,9 +23,13 @@
>  #include <nucleus/timer.h>
> =20
>  /* Status flags */
> -#define XNSUSP    0x00000001	/* Suspended */
> -#define XNPEND    0x00000002	/* Sleep-wait for a resource */
> -#define XNDELAY   0x00000004	/* Delayed */
> +
> +/*! @def XNSUSP */
> +#define XNSUSP    0x00000001	/*!< @brief Suspended */
> +/*! @def XNPEND */
> +#define XNPEND    0x00000002	/*!< Sleep-wait for a resource */
> +/*! @def XNPEND */
> +#define XNDELAY   0x00000004	/*!< Delayed */
>  #define XNREADY   0x00000008	/* Linked to the ready queue */
>  #define XNDORMANT 0x00000010	/* Not started yet or killed */
>  #define XNZOMBIE  0x00000020	/* Zombie thread in deletion process */

Also a repetition: would be nice if we could avoid the @def.

Thanks,
Jan


--------------enigC5E31D9DBFE67E8145FE7328
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFEydMZniDOoMHTA+kRAtuOAJ9IBz4iGJCK9XC5XCX2d6wfNVLUTgCfQP4O
+q8c/7agd+3fZdYmUFn4fcU=
=lrko
-----END PGP SIGNATURE-----

--------------enigC5E31D9DBFE67E8145FE7328--

