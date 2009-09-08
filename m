From: Paul <paul_c@domain.hid>
Date: Tue, 8 Sep 2009 17:20:00 +0100
References: <1252420689.4304.35.camel@domain.hid>
In-Reply-To: <1252420689.4304.35.camel@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Message-Id: <200909081720.00629.paul_c@domain.hid>
Subject: Re: [Xenomai-help] rt_heap cleanup issue
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

On Tuesday 08 September 2009, Christoph Permes wrote:
> void cleanup_module()
> {
> =A0 =A0 int result =3D 0;
> =A0 =A0 // delete heap descriptor
> =A0 =A0 my_shm_pointer =3D NULL;
> =A0 =A0 result =3D rt_heap_delete( &my_heap_desc );
> =A0 =A0 printk( KERN_INFO "Shared memory closed (%d).\n", result );
> }

void cleanup_module()
{
     int result =3D 0;
     while ((result =3D rt_heap_delete( &my_heap_desc )) =3D=3D -EBUSY) {
	set_current_state(TASK_INTERRUPTIBLE);
	schedule_timeout(100);
    }
     printk( KERN_INFO "Shared memory closed (%d).\n", result );
}

I'm sure Gilles will correct me if the code snippet is wrong, but this is o=
ne=20
method I use to ensure shared resources do not cause a segfault (or worse)=
=20
when unloading a kernel module.


Regards, Paul.

