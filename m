From: "eladyaakovi@campus.technion.ac.il" <eladyaakovi@campus.technion.ac.il>
Date: Wed, 21 Jun 2017 08:10:10 +0000
Message-ID: <VI1PR0101MB2000512FB04A44993FDD1AC6B8DA0@VI1PR0101MB2000.eurprd01.prod.exchangelabs.com>
Content-Language: he-IL
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1255"
Content-Transfer-Encoding: quoted-printable
Subject: [Xenomai] Toggling GPIO RT Xenomai on Dragonboard 41c
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "xenomai@xenomai.org" <xenomai@xenomai.org>, "xenomai-request@xenomai.org" <xenomai-request@xenomai.org>


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

