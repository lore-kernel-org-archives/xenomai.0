From: "eladyaakovi@campus.technion.ac.il" <eladyaakovi@campus.technion.ac.il>
Date: Thu, 22 Jun 2017 11:45:52 +0000
Message-ID: <VI1PR0101MB20008C1321074C271F56BBA2B8DB0@VI1PR0101MB2000.eurprd01.prod.exchangelabs.com>
References: <VI1PR0101MB2000512FB04A44993FDD1AC6B8DA0@VI1PR0101MB2000.eurprd01.prod.exchangelabs.com>,
 <DB6PR0701MB245673214C08183B8E062DDCB5DA0@DB6PR0701MB2456.eurprd07.prod.outlook.com>
In-Reply-To: <DB6PR0701MB245673214C08183B8E062DDCB5DA0@DB6PR0701MB2456.eurprd07.prod.outlook.com>
Content-Language: he-IL
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1255"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai] Toggling GPIO RT Xenomai on Dragonboard 41c
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Giulio Moro <g.moro@qmul.ac.uk>, "xenomai@xenomai.org" <xenomai@xenomai.org>, "xenomai-request@xenomai.org" <xenomai-request@xenomai.org>

Can you explain please why this is not writing to a file:


time_t t =3D time(NULL) + time_to_run;

while (time(NULL) <  t){

   fprintf(dir,"%d",1);

   rt_task_sleep(1000);

}


not writing 1 to the file ?

dir is a file descriptor.


(without the rt_task_sleep(1000) and the while it works fine).

any suggestions what can i do ?

thanks.

________________________________
=EE=E0=FA: Giulio Moro <g.moro@qmul.ac.uk>
=FE=FE=F0=F9=EC=E7: =E9=E5=ED =F8=E1=E9=F2=E9 21 =E9=E5=F0=E9 2017 15:35:49
=FE=FE=E0=EC: Elad Yaakovi; xenomai@xenomai.org; xenomai-request@xenomai.or=
g
=FE=FE=F0=E5=F9=E0: Re: Toggling GPIO RT Xenomai on Dragonboard 41c

As you ask "Can't we work without device driver ?": here is a driver-less s=
olution which may work on your platform (if it supports memmapping the GPIO=
 banks) and may suit your needs.

I have some working user-space code to read and toggle GPIOs on a BeagleBon=
e Black, which simply uses memory mapping and is real-time safe.
It consists of these files:
https://github.com/BelaPlatform/Bela/blob/master/include/Gpio.h
https://github.com/BelaPlatform/Bela/blob/master/include/GPIOcontrol.h
https://github.com/BelaPlatform/Bela/blob/master/core/GPIOcontrol.cpp

The GPIOcontrol stuff (by Derek Molloy) exports the pin through the sysfs i=
nterface, but then in Gpio.h the actual memory mapping takes place.
You will have to replace these constants with the ones for your architectur=
e (the technical reference manual for your hardware should give you the cor=
rect addresses):

static const uint32_t GPIO_SIZE =3D  0x198;
static const uint32_t GPIO_DATAIN =3D (0x138 / 4);
static const uint32_t GPIO_CLEARDATAOUT =3D (0x190 / 4);
static const uint32_t GPIO_SETDATAOUT =3D (0x194 / 4);
static const uint32_t GPIO_ADDRESSES[4] =3D {
        0x44E07000,
        0x4804C000,
        0x481AC000,
        0x481AE000,
};

Hope this helps,
Giulio

________________________________________
From: Xenomai <xenomai-bounces@xenomai.org> on behalf of eladyaakovi@campus=
.technion.ac.il <eladyaakovi@campus.technion.ac.il>
Sent: 21 June 2017 09:10
To: xenomai@xenomai.org; xenomai-request@xenomai.org
Subject: [Xenomai] Toggling GPIO RT Xenomai on Dragonboard 41c

Hi, I wrote a code that up and down (toggling) gpio.
I want to do the same with RT function.

Here pessudo code:

void not_rt_func(void *arg)
{
time_t t =3D time(NULL) + 10;
while (time(NULL) < t) {
                //gpio up
sleep(1000);
//gpio down
                sleep(1000);
}
return NULL;
}


That code worked well (with up and down function, we used files:



        FILE *dir;
 dir =3D fopen("/sys/class/gpio/gpio13/value","w");







        fprintf(dir, "%d", 1);  //gpio up

        fprintf(dir, "%d", 0);  //gpio down






        fclose(dir);

)


I want to make the same as real time.
I saw examples worked with PWM but it is too complicated to my "problem".
I just want to make this toggling with a RT process (and realtime up and do=
wn GPIO)
He used device driver, should i use it too ?
Can't we work without device driver ?

if we might use it, so i thought to write it like this:



user function:

int dev =3D open("/dev/rtdm/my_gpio",O_RDWR);
RT_TASK rt_task;




void rt_func(void *arg)
{
time_t t =3D time(NULL) + 10;
while (time(NULL) < t) {
ioctl(dev, GPIO_UP,NULL); //gpio up
rt_task_sleep(1000);
ioctl(dev, GPIO_DOWN,NULL); //gpio down
rt_task_sleep(1000);
}
return NULL;
}



device driver:
struct gpio_data {
int gpio;
};

static int gpio_ioctl_rt(struct rtdm_fd *fd, unsigned int request, void __u=
ser *arg)
{
struct gpio_data*ctx =3D rtdm_fd_to_private(fd);
switch (request) {
case GPIO_UP:
if (ctx->gpio > 0)
return -EBUSY;
gpio_set_value(ctx->gpio, 1);
case GPIO_DOWN:
if (ctx->gpio =3D=3D 0)
return -EBUSY;
gpio_set_value(ctx->gpio, 0);
default:
return -EINVAL;
}
}





Do you think it is OK ?

_______________________________________________
Xenomai mailing list
Xenomai@xenomai.org
https://xenomai.org/mailman/listinfo/xenomai
