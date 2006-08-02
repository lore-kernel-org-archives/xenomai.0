Message-ID: <44D0429A.5060109@domain.hid>
Date: Wed, 02 Aug 2006 08:13:46 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] Re: RT_TASK_INFO status
References: <1154015872-24969.00053.00861-smmsdV2.1.4@domain.hid>	<44C8EECE.4070209@domain.hid>	<44C90CEF.9090908@domain.hid>	<44C9136C.7080709@domain.hid>	<44C9420D.3070100@domain.hid>	<44C9D319.7020704@domain.hid>
	<17610.5728.464611.778617@domain.hid>
	<44CFA184.9090204@domain.hid>
In-Reply-To: <44CFA184.9090204@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig1B70956DFD34479508CA9E84"
Sender: jan.kiszka@domain.hid
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
--------------enig1B70956DFD34479508CA9E84
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Nathaniel Villaume wrote:
> Please see attached diff. I think I found a good way to do it that
> preserves the readable C-code style ( I gave up using the @define comma=
nd).
> This patch includes changes to the defines and the RT_TASK_INFO and
> RT_TASK_MCB structures.
>=20
> Let me know if you want something different.
>=20

The patch looks good to me, and I assume the output does so as well. :)

Thanks,
Jan

> -Nate
>=20
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
> @@ -34,21 +34,28 @@
>  #define T_CPU(cpu) (1 << (24 + (cpu & 7))) /* Up to 8 cpus [0-7] */
>  #define T_CPUMASK  0xff000000
> =20
> -/* Status/mode flags. */
> -#define T_BLOCKED  XNPEND
> -#define T_DELAYED  XNDELAY
> -#define T_READY    XNREADY
> -#define T_DORMANT  XNDORMANT
> -#define T_STARTED  XNSTARTED
> -#define T_BOOST    XNBOOST
> -#define T_LOCK     XNLOCK
> -#define T_RRB      XNRRB
> -#define T_NOSIG    XNASDI
> -#define T_SHIELD   XNSHIELD
> -#define T_WARNSW   XNTRAPSW
> -#define T_RPIOFF   XNRPIOFF
> +/*!=20
> +  \ingroup native
> +  @defgroup native_task_status Task Status=20
> +  @brief Defines used to specify task state and/or mode=20
> +  @{
> + */
> +
> +#define T_BLOCKED  XNPEND     /**< See #XNPEND    */
> +#define T_DELAYED  XNDELAY    /**< See #XNDELAY   */
> +#define T_READY    XNREADY    /**< See #XNREADY   */
> +#define T_DORMANT  XNDORMANT  /**< See #XNDORMANT */
> +#define T_STARTED  XNSTARTED  /**< See #XNSTARTED */
> +#define T_BOOST    XNBOOST    /**< See #XNBOOST   */
> +#define T_LOCK     XNLOCK     /**< See #XNLOCK    */
> +#define T_RRB      XNRRB      /**< See #XNRRB     */
> +#define T_NOSIG    XNASDI     /**< See #XNASDI    */=20
> +#define T_SHIELD   XNSHIELD   /**< See #XNSHIELD  */=20
> +#define T_WARNSW   XNTRAPSW   /**< See #XNTRAPSW  */=20
> +#define T_RPIOFF   XNRPIOFF   /**< See #XNRPIOFF  */=20
>  #define T_PRIMARY  0x00000200	/* Recycle internal bits status which */=

>  #define T_JOINABLE 0x00000400	/* won't be passed to the nucleus.  */
> +/*! @} */ /* Ends doxygen-group native_task_status */
> =20
>  /* Task hook types. */
>  #define T_HOOK_START  XNHOOK_THREAD_START
> @@ -68,31 +75,38 @@
>  struct rt_queue_msg;
>  struct rt_task;
> =20
> +/** Structure containing task-information useful to users.
> + *
> + *  @see rt_task_inquire()
> + */
>  typedef struct rt_task_info {
> +   =20
> +    int bprio;  /**< Base priority. */
> =20
> -    int bprio;			/* !< Base priority. */
> +    int cprio; /**< Current priority. May change through Priority Inhe=
ritance.*/
> +   =20
> +    unsigned status; /**< Task's status. @see native_task_status */=20
> +   =20
> +    RTIME relpoint; /**< Time of next release.*/=20
> +   =20
> +    char name[XNOBJECT_NAME_LEN];  /**< Symbolic name assigned at crea=
tion. */
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
> =20
>  #define RT_MCB_FSTORE_LIMIT  64
> =20
> +/** Structure used in passing messages between tasks.
> +  @see rt_task_send(), rt_task_reply(), rt_task_receive()
> +*/
>  typedef struct rt_task_mcb {
> =20
> -    int flowid;			/* !< Flow identifier. */
> +    int flowid;   /**< Flow identifier. */
> =20
> -    int opcode;			/* !< Operation code. */
> +    int opcode;   /**< Operation code. */
> =20
> -    caddr_t data;		/* !< Address of message. */
> +    caddr_t data; /**< Message address. */
> =20
> -    size_t size;		/* !< Size of message. */
> +    size_t size;  /**< Message size (bytes). */
> =20
>  } RT_TASK_MCB;
> =20
> Index: include/nucleus/thread.h
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- include/nucleus/thread.h	(revision 1383)
> +++ include/nucleus/thread.h	(working copy)
> @@ -1,4 +1,4 @@
> -/*
> +/*=20
>   * Copyright (C) 2001,2002,2003 Philippe Gerum <rpm@xenomai.org>.
>   *
>   * Xenomai is free software; you can redistribute it and/or modify
> @@ -22,38 +22,48 @@
> =20
>  #include <nucleus/timer.h>
> =20
> +/*! @ingroup nucleus=20
> +  @defgroup nucleus_status_mode Status and Mode Defines.
> +  @brief These defines are the used by the skins to report status of=20
> +         tasks and other objects.=20
> +  @{
> +*/
> +
>  /* Status flags */
> -#define XNSUSP    0x00000001	/* Suspended */
> -#define XNPEND    0x00000002	/* Sleep-wait for a resource */
> -#define XNDELAY   0x00000004	/* Delayed */
> -#define XNREADY   0x00000008	/* Linked to the ready queue */
> -#define XNDORMANT 0x00000010	/* Not started yet or killed */
> -#define XNZOMBIE  0x00000020	/* Zombie thread in deletion process */
> -#define XNRESTART 0x00000040	/* Restarting thread */
> -#define XNSTARTED 0x00000080	/* Could be restarted */
> -#define XNRELAX   0x00000100	/* Relaxed shadow thread (blocking bit) *=
/
> -#define XNHELD    0x00000200	/* Held thread from suspended partition *=
/
> =20
> -#define XNTIMEO   0x00000400	/* Woken up due to a timeout condition */=

> -#define XNRMID    0x00000800	/* Pending on a removed resource */
> -#define XNBREAK   0x00001000	/* Forcibly awaken from a wait state */
> -#define XNKICKED  0x00002000	/* Kicked upon Linux signal (shadow only)=
 */
> -#define XNBOOST   0x00004000	/* Undergoes regular PIP boost */
> -#define XNDEBUG   0x00008000	/* Hit debugger breakpoint (shadow only) =
*/
> +#define XNSUSP    0x00000001 /**< Suspended. */
> +#define XNPEND    0x00000002 /**< Sleep-wait for a resource. */
> +#define XNDELAY   0x00000004 /**< Delayed */
> +#define XNREADY   0x00000008 /**< Linked to the ready queue. */
> +#define XNDORMANT 0x00000010 /**< Not started yet or killed */
> +#define XNZOMBIE  0x00000020 /**< Zombie thread in deletion process */=

> +#define XNRESTART 0x00000040 /**< Restarting thread */
> +#define XNSTARTED 0x00000080 /**< Could be restarted */
> +#define XNRELAX   0x00000100 /**< Relaxed shadow thread (blocking bit)=
 */
> +#define XNHELD    0x00000200 /**< Held thread from suspended partition=
 */
> =20
> +#define XNTIMEO   0x00000400 /**< Woken up due to a timeout condition =
*/
> +#define XNRMID    0x00000800 /**< Pending on a removed resource */
> +#define XNBREAK   0x00001000 /**< Forcibly awaken from a wait state */=

> +#define XNKICKED  0x00002000 /**< Kicked upon Linux signal (shadow onl=
y) */
> +#define XNBOOST   0x00004000 /**< Undergoes regular PIP boost */
> +#define XNDEBUG   0x00008000 /**< Hit debugger breakpoint (shadow only=
) */
> +
>  /* Mode flags. */
> -#define XNLOCK    0x00010000	/* Not preemptible */
> -#define XNRRB     0x00020000	/* Undergoes a round-robin scheduling */
> -#define XNASDI    0x00040000	/* ASR are disabled */
> -#define XNSHIELD  0x00080000	/* IRQ shield is enabled (shadow only) */=

> -#define XNTRAPSW  0x00100000	/* Trap execution mode switches */
> -#define XNRPIOFF  0x00200000	/* Stop priority coupling (shadow only) *=
/
> +#define XNLOCK    0x00010000 /**< Not preemptible */
> +#define XNRRB     0x00020000 /**< Undergoes a round-robin scheduling *=
/
> +#define XNASDI    0x00040000 /**< ASR are disabled */
> +#define XNSHIELD  0x00080000 /**< IRQ shield is enabled (shadow only) =
*/
> +#define XNTRAPSW  0x00100000 /**< Trap execution mode switches */
> +#define XNRPIOFF  0x00200000 /**< Stop priority coupling (shadow only)=
 */
> =20
> -#define XNFPU     0x00400000	/* Thread uses FPU */
> -#define XNSHADOW  0x00800000	/* Shadow thread */
> -#define XNROOT    0x01000000	/* Root thread (i.e. Linux/IDLE) */
> -#define XNINVPS   0x02000000	/* Using inverted priority scale */
> +#define XNFPU     0x00400000 /**< Thread uses FPU */
> +#define XNSHADOW  0x00800000 /**< Shadow thread */
> +#define XNROOT    0x01000000 /**< Root thread (that is, Linux/IDLE) */=

> +#define XNINVPS   0x02000000 /**< Using inverted priority scale */
> =20
> +/*! @} */ /* Ends doxygen comment group: nucleus_status_modes */
> +
>  /*
>    Must follow the declaration order of the above bits. Status symbols
>    are defined as follows:



--------------enig1B70956DFD34479508CA9E84
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFE0EKaniDOoMHTA+kRAskLAJ9K5MVS7Yo3SuWA8XXMZfmPcXgg0ACfYop6
sXYJ0H2GgrGnusb/v0cXm3g=
=a1Sm
-----END PGP SIGNATURE-----

--------------enig1B70956DFD34479508CA9E84--

