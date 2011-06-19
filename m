MIME-Version: 1.0
Date: Sun, 19 Jun 2011 15:16:21 +0200
Message-ID: <BANLkTikoPvhb1XmycYm=MROT7=BGA8cisg@domain.hid>
From: Andrey Nechypurenko <andreynech@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Subject: [Xenomai-help] Problem accesing I2C without using Linux kernel
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org

Hi,

I am working on real-time control application using BeagleBoard
and Xenomai. Some sensors are connected to the second i2c bus. It
is necessary to collect sensor data strictly periodically and
that is why I would prefer to query the sensors from xenomai
thread.

I can read sensor data from user space using kernel interface,
i.e. via /dev/i2c-2 file. However, as I understand, doing it from
the xenomai thread will lead to the context switch and degrade
the real-time performance (introduce unpredictable delays and all
other badnesses :-) ). That is why I decide to try to access
OMAP's i2c controller directly without using kernel driver and
/dev file system.

For this purposes, I simply poke the relevant parts from u-boot
sources and thought that it should work. Unfortunately it is
not. I am getting the "Bus error" message which is coming not
from my test program and then the program quits.

I am suspecting that there is some kind of conflict with
kernel. I am not experienced enough with kernel internals and
that is why the questions I would like to ask are: a) whether my
assumption about possible conflict with kernel is reasonable, b)
would it help to recompile the kernel with i2c support completely
disabled and c) if such kernel will work at all on BB? Please
note, that for this application I do not need any power
management and no display output.

Just for the sake of completeness, and if somebody is interested
in more details, here is the brief outline of what I did and how
it fails. I was doing the following steps:

1. Open /dev/mem and memory map the I2C 2 region at
0x48072000 (as defined in the TRM which is in meanwhile become
my most popular reading :-) ):

fd = open("/dev/mem", O_RDWR | O_SYNC);
i2c_base = mmap(NULL, sizeof(i2c_base),
               PROT_READ | PROT_WRITE,
               MAP_SHARED, fd, I2C_DEFAULT_BASE);

Where I2C_DEFAULT_BASE is 0x48072000 and i2c_base is the
structure with corresponding controller registers, i.e.:

struct i2c {
       unsigned short rev;     /* 0x00 */
       unsigned short res1;
       unsigned short ie;      /* 0x04 */
       unsigned short res2;
       unsigned short stat;    /* 0x08 */
       . . .

2. Try to read the status of the i2c controller:

if(readw(&i2c_base->con) & I2C_CON_EN)

This is the very first attempt to read from the mapped memory
and this call fails resulting in the "Bus error" message printed
on the console and application seams to be killed. Here the
readw() function is just a define which simply returns the
content of the memory address passed as parameter. But just to
exclude possible mistakes here I was even trying to access the
memory directly:

if(i2c_base->con & I2C_CON_EN)

But even this line gives the same "Bus error" message. So it
seams like I can not access this memory at all.


I would really appreciate if someone can provide some
explanations and suggestions about possible reasons why my
approach fails and what I can do to fix it.

Thank you,
Andrey.

---------------------------------
http://veter-project.blogspot.com

