Message-ID: <442663AB.2070001@domain.hid>
Date: Sun, 26 Mar 2006 11:49:31 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] rt-video interface
References: <200603201715.08482.lbocseg@domain.hid> <441F47C6.9080108@domain.hid>
	<200603211434.03185.lbocseg@domain.hid>
In-Reply-To: <200603211434.03185.lbocseg@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig99E2699ECF3F9B715EB7001A"
Sender: jan.kiszka@domain.hid
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Rodrigo Rosenfeld Rosas <lbocseg@domain.hid>
Cc: xenomai-core <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig99E2699ECF3F9B715EB7001A
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Rodrigo Rosenfeld Rosas wrote:
> Em Segunda 20 Mar=E7o 2006 21:24, Jan Kiszka escreveu:
>> ...
>> Does your time allow to list the minimal generic services a RTDM video=

>> capturing driver has to provide in a similar fashion like the serial o=
r
>> the CAN profile? If it's mostly about copying existing Linux API specs=
,
>> feel free to just reference them. But the differences should certainly=

>> fill up a RT-video (or so) profile, and that would be great!
>=20
> If we're going to try to be as near as possible of the V4L2 API draft, =
the=20
> minimal generic services is a lot to implement.
>=20
> Actually, I don't know if implementing a V4L2 variant would be a good i=
dea...=20
> Maybe there are designs better suited to real-time applications. I need=
 time=20
> to investigate it more. My advisor asked me for. It's becoming really h=
ard to=20
> finish my master Thesis until June 15... :(

Maybe derived a subset from the full V4L2 API is the way to go. But
let's wait if you discover other interface designs.

>=20
> Basically I would need to have it clearer the most common use cases in =
real=20
> situations... From the moment, here is my design (from a user point of =
view=20
> of one kind of application): I'm using images to estimate speed of a ro=
bot=20
> and identifying objects. I need the timestamps between both images and =
all=20
> processes must be deterministic. I process the images and do the=20
> calculations.
>=20
> For avoid copying, I'm using the mmap facility. I process the image in =
the=20
> same memory region when possible for avoidind the need of allocating mo=
re=20
> memory. When using a NTSC camera, we have 60Hz frames, being 30 odds an=
d 30=20
> evens in a second. It means that a full frame (odd+even) would take abo=
ut=20
> 33ms to complete. It is common, though, to use only half a frame in=20
> processing not only because it is faster to acquire (17ms) but it is al=
so=20
> faster to process and acceptable in most cases. So, instead of 640x480 =
frames=20
> we would process 640x240 frames. If the proportion is important, the us=
er can=20
> do something like:
>=20
> for (w1=3D0,w=3D0; w1<640; w1+=3D2, w++)
>  for(h=3D0; h<240; h++)
>  {
>    process_pixel(w,h);
>  }
>=20
> If all the processing can me made in 17ms, we could process the odd fie=
ld when=20
> acquiring the even and vice-versa. Otherwise, we could have a buffer wi=
th the=20
> latest acquires so that we wouldn't need to wait until a frame is compl=
eted.
>=20
>  In summary, my control loop would be something like:
>=20
> task_acquire
> {
> 	new_image=3Dacquire_image();
> 	speed=3Dget_speed(new_image,old_image);
> 	old_image =3D new_image;
> }
>=20
> task_do_pid_control=20
> {
> 	drive_motors(speed, desired_speed);
> }
>=20
> Well, that is a use case and I can get this behaviour with the V4L2 API=
,=20
> although I don't know if it is the best suited API. Let me introduce th=
e V4L2=20
> API and then (in other messages) we can discuss others approaches.
>=20
> There are some interfaces available in V4L2: capture, overlay and outpu=
t. I'll=20
> discuss only capture here that I think it is the most relevant for=20
> rt-applications.
>=20
> There are four IO modes: read/write, streaming I/O (memory mapping or u=
ser=20
> pointer) and asyncronous I/O.
>=20
> The read/write mode is the simplest but also the less efficient, since =
it=20
> copies the buffer content to the user. It works like it is expected to.=
 On=20
> V4L2 API it requires the poll and select implementation but we could ad=
apt=20
> them to a simpler and more efficient way.
>=20
> The user pointer approach has no sense for PCI framegrabbers on x86, si=
nce=20
> these boards need a physical contiguous memory region for doing DMA. Th=
is=20
> method consists on the user allocating the memory on userspace and pass=
ing=20
> the pointers to the drivers.
>=20
> The asyncronous I/O is not defined yer, so there are three and not four=
 I/O=20
> modes.
>=20
> The third is the most useful for real-time applications and is what I'm=
=20
> currently using: streaming by memory mapping.
> See http://www.linuxtv.org/downloads/video4linux/API/V4L2_API/spec/x330=
3.htm
>=20
> In short, the user request a number of buffers in VIDIOC_REQBUFS ioctl =
and the=20
> driver allocate or reserve them and return the number of actual allocat=
ed=20
> buffers.
>=20
> There is another ioctl (VIDIOC_QUERYBUF) for querying each buffer. Alon=
g with=20
> other information, the user gets a memory offset to be used in a mmap c=
all.=20
> Then the buffers will be queued in a input buffer with the VIDIOC_QBUF =
ioctl.=20
> When the VIDIOC_STREAMON ioctl is called, the board begins capturing in=
 FIFO=20
> order of the input buffer and as the acquires are done the buffers are =
moved=20
> to an output buffer also in FIFO order. The user dequeue a buffer from =
the=20
> output buffer with the VIDIOC_DQBUF ioctl. When the user has finished u=
sing=20
> the result of that buffer (s)he will enqueues it again. When stop proce=
ssing,=20
> a VIDIOC_STREAMOFF ioctl call is made and cleans all buffers besides st=
opping=20
> capture.

This sounds best applicable for hard RT indeed.

>=20
> This method also requires poll and select to be implemented in V4L2. We=
 should=20
> discuss how to deal with it if we stick with the V4L2 variant idea.

Hmm, what file descriptors have to be monitored in parallel so that
poll/select is required?

>=20
> I would like to understand what would be other possible usages of real-=
time=20
> vision before I could propose another approach so we can discuss what w=
ould=20
> be better for us.
>=20
> Besides the API issue, we should think also on the API implementation. =
I think=20
> we should create a skeleton, common to all drivers to facilitate the dr=
iver=20
> building process.
>=20
> Well, too much for a first message, I think... :)
>=20
> Which vision applications do you have in mind?

So far "only" a subset of your scenario: One of my colleagues needs to
synchronise frame timestamps with timestamps of other input, from range
sensors e.g. The actually processing is not (yet?) hard RT, but the
input synchronisation is essential.

Jan


--------------enig99E2699ECF3F9B715EB7001A
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFEJmOrniDOoMHTA+kRAjyWAJ44f+D81X3og4EazvBAGeOJjXfNigCfXc/+
TU+kPtPUsaZS+cu5uhUq3uU=
=iLY8
-----END PGP SIGNATURE-----

--------------enig99E2699ECF3F9B715EB7001A--

