From: Rodrigo Rosenfeld Rosas <lbocseg@domain.hid>
Subject: Re: [Xenomai-core] rt-video interface
Date: Tue, 21 Mar 2006 14:34:02 -0300
References: <200603201715.08482.lbocseg@domain.hid> <441F47C6.9080108@domain.hid>
In-Reply-To: <441F47C6.9080108@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Message-Id: <200603211434.03185.lbocseg@domain.hid>
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: xenomai-core <xenomai@xenomai.org>

Em Segunda 20 Mar=3DE7o 2006 21:24, Jan Kiszka escreveu:
>...
>Does your time allow to list the minimal generic services a RTDM video
>capturing driver has to provide in a similar fashion like the serial or
>the CAN profile? If it's mostly about copying existing Linux API specs,
>feel free to just reference them. But the differences should certainly
>fill up a RT-video (or so) profile, and that would be great!

If we're going to try to be as near as possible of the V4L2 API draft, the=
=3D
=3D20
minimal generic services is a lot to implement.

Actually, I don't know if implementing a V4L2 variant would be a good idea.=
=3D
=3D2E.=3D20
Maybe there are designs better suited to real-time applications. I need tim=
=3D
e=3D20
to investigate it more. My advisor asked me for. It's becoming really hard =
=3D
to=3D20
finish my master Thesis until June 15... :(

Basically I would need to have it clearer the most common use cases in real=
=3D
=3D20
situations... From the moment, here is my design (from a user point of view=
=3D
=3D20
of one kind of application): I'm using images to estimate speed of a robot=
=3D
=3D20
and identifying objects. I need the timestamps between both images and all=
=3D
=3D20
processes must be deterministic. I process the images and do the=3D20
calculations.

=3D46or avoid copying, I'm using the mmap facility. I process the image in =
th=3D
e=3D20
same memory region when possible for avoidind the need of allocating more=
=3D20
memory. When using a NTSC camera, we have 60Hz frames, being 30 odds and 30=
=3D
=3D20
evens in a second. It means that a full frame (odd+even) would take about=
=3D20
33ms to complete. It is common, though, to use only half a frame in=3D20
processing not only because it is faster to acquire (17ms) but it is also=
=3D20
faster to process and acceptable in most cases. So, instead of 640x480 fram=
=3D
es=3D20
we would process 640x240 frames. If the proportion is important, the user c=
=3D
an=3D20
do something like:

for (w1=3D3D0,w=3D3D0; w1<640; w1+=3D3D2, w++)
 for(h=3D3D0; h<240; h++)
 {
   process_pixel(w,h);
 }

If all the processing can me made in 17ms, we could process the odd field w=
=3D
hen=3D20
acquiring the even and vice-versa. Otherwise, we could have a buffer with t=
=3D
he=3D20
latest acquires so that we wouldn't need to wait until a frame is completed.

 In summary, my control loop would be something like:

task_acquire
{
	new_image=3D3Dacquire_image();
	speed=3D3Dget_speed(new_image,old_image);
	old_image =3D3D new_image;
}

task_do_pid_control=3D20
{
	drive_motors(speed, desired_speed);
}

Well, that is a use case and I can get this behaviour with the V4L2 API,=3D=
20
although I don't know if it is the best suited API. Let me introduce the V4=
=3D
L2=3D20
API and then (in other messages) we can discuss others approaches.

There are some interfaces available in V4L2: capture, overlay and output. I=
=3D
'll=3D20
discuss only capture here that I think it is the most relevant for=3D20
rt-applications.

There are four IO modes: read/write, streaming I/O (memory mapping or user=
=3D
=3D20
pointer) and asyncronous I/O.

The read/write mode is the simplest but also the less efficient, since it=
=3D20
copies the buffer content to the user. It works like it is expected to. On=
=3D
=3D20
V4L2 API it requires the poll and select implementation but we could adapt=
=3D
=3D20
them to a simpler and more efficient way.

The user pointer approach has no sense for PCI framegrabbers on x86, since=
=3D
=3D20
these boards need a physical contiguous memory region for doing DMA. This=
=3D20
method consists on the user allocating the memory on userspace and passing=
=3D
=3D20
the pointers to the drivers.

The asyncronous I/O is not defined yer, so there are three and not four I/O=
=3D
=3D20
modes.

The third is the most useful for real-time applications and is what I'm=3D20
currently using: streaming by memory mapping.
See http://www.linuxtv.org/downloads/video4linux/API/V4L2_API/spec/x3303.htm

In short, the user request a number of buffers in VIDIOC_REQBUFS ioctl and =
=3D
the=3D20
driver allocate or reserve them and return the number of actual allocated=
=3D20
buffers.

There is another ioctl (VIDIOC_QUERYBUF) for querying each buffer. Along wi=
=3D
th=3D20
other information, the user gets a memory offset to be used in a mmap call.=
=3D
=3D20
Then the buffers will be queued in a input buffer with the VIDIOC_QBUF ioct=
=3D
l.=3D20
When the VIDIOC_STREAMON ioctl is called, the board begins capturing in FIF=
=3D
O=3D20
order of the input buffer and as the acquires are done the buffers are move=
=3D
d=3D20
to an output buffer also in FIFO order. The user dequeue a buffer from the=
=3D
=3D20
output buffer with the VIDIOC_DQBUF ioctl. When the user has finished using=
=3D
=3D20
the result of that buffer (s)he will enqueues it again. When stop processin=
=3D
g,=3D20
a VIDIOC_STREAMOFF ioctl call is made and cleans all buffers besides stoppi=
=3D
ng=3D20
capture.

This method also requires poll and select to be implemented in V4L2. We sho=
=3D
uld=3D20
discuss how to deal with it if we stick with the V4L2 variant idea.

I would like to understand what would be other possible usages of real-time=
=3D
=3D20
vision before I could propose another approach so we can discuss what would=
=3D
=3D20
be better for us.

Besides the API issue, we should think also on the API implementation. I th=
=3D
ink=3D20
we should create a skeleton, common to all drivers to facilitate the driver=
=3D
=3D20
building process.

Well, too much for a first message, I think... :)

Which vision applications do you have in mind?

Rodrigo.

=09

=09
	=09
_______________________________________________________=20
Yahoo! doce lar. Fa=E7a do Yahoo! sua homepage.=20
http://br.yahoo.com/homepageset.html=20



