MIME-Version: 1.0
Date: Fri, 14 Mar 2014 15:22:27 +0530
Message-ID: <CAC-NLwzBXJ6BkmR+L-WnmJ04PnTba+7pbW2Y3nr7D30bozJzTA@mail.gmail.com>
From: ashwin damle <ashwindamle@gmail.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: [Xenomai] Transfer data from a kernel module to user
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Hello Developers,

I am trying to pass data from the Xenomai kernel module, using RTDM driver,
to a user program. I am using the default examples-tut01-skeleton-drv.c and
tut01-skeleton-app.c. The examples are working nicely  and I could get the
right expected results. I am using Linux raspberrypi 3.5.7-xenomai #4
PREEMPT Tue Mar 11 16:49:44 IST 2014 armv6l GNU/Linux, Xenomai used for
during compilation was xenomai-2.6.2.1. The target is RaspberryPi.

The intention is to transfer a integer variable from the kernel to user. I
tried changing the default example program only to reeive the error message
""ERROR : can't copy data from driver". I am unable to figure-out the
problem. Attach is the program which I edited. I have written a comment
wherever I define my variable, which is freq. Below is a snap

"
static ssize_t simple_rtdm_read_nrt(struct rtdm_dev_context *context,
                    rtdm_user_info_t * user_info, void *buf,
                    size_t nbyte)
{
    buffer_t * buffer =3D (buffer_t *) context->dev_private;
    int size =3D (buffer->size > nbyte) ? nbyte : buffer->size;

    buffer->size =3D sizeof(buffer->freq);
    buffer->freq =3D 50;            //my variable, this is printed correctly
as seen in dmesg

    if (rtdm_safe_copy_to_user(user_info, buf, &buffer->freq,
sizeof(buffer->freq)))
        rtdm_printk("ERROR : can't copy data from driver\n");

    return size;
}
"
Attached is the user program, too.

Also, I wanted to know whether it is explicitly required to write to the
device before reading it? I only want to read the device.( My application
is noting the time of GPIO interrupts. )

Could you please help me with this? Request you to help me solve the
problem.

Thanks.
Ashwin

-- =


Support the
-------------- next part --------------
A non-text attachment was scrubbed...
Name: tut01-skeleton-app.c
Type: text/x-csrc
Size: 3667 bytes
Desc: not available
URL: <http://www.xenomai.org/pipermail/xenomai/attachments/20140314/6a2404f=
5/attachment.c>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: tut01-skeleton-drv.c
Type: text/x-csrc
Size: 5110 bytes
Desc: not available
URL: <http://www.xenomai.org/pipermail/xenomai/attachments/20140314/6a2404f=
5/attachment-0001.c>
