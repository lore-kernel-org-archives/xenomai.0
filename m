From: NZG <ngustavson@domain.hid>
Date: Fri, 4 May 2007 10:58:00 -0500
References: <200705041027.52872.ngustavson@domain.hid>
	<463B543B.8060008@domain.hid>
In-Reply-To: <463B543B.8060008@domain.hid>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200705041058.00400.ngustavson@domain.hid>
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai-core] RTDM problems with structures in headers
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai@xenomai.org
Cc: Jan Kiszka <jan.kiszka@domain.hid>

> Not claiming that I fully understood your problem yet - code talks:
=46rom your recommendation think you got the jist of it.

here's the problematic parts:

/**********************
 * gpio class structure
 */
typedef struct gpio_s{
	const char *name;
	int subclass;
	void *ddr;
	void *data;
	gpio_data shadow;
	gpio_data (*data_read)(struct gpio_s *gpio);
	int (*data_write)(struct gpio_s *gpio,gpio_data data);
	gpio_data (*ddr_read)(struct gpio_s *gpio);=09
	int (*ddr_write)(struct gpio_s *gpio,gpio_data data);
#ifdef CONFIG_GPIOCLASS_RTDM
	struct rtdm_device rtd;
#endif=20
}gpio_t

/***************************************************************************
* class instantiation
*/
struct class_device *gpio_register_class_device(gpio_t *gpio){	=09
	struct class *gpio_master =3D gpio_declare();
	struct class_device *dev =3D class_device_create(gpio_master, NULL, MKDEV(=
0,=20
0), NULL, gpio->name);
	dev->class_data =3D gpio;

#ifdef CONFIG_GPIOCLASS_SYSFS=09
if((gpio->ddr_write)&&(gpio->ddr_read))class_device_create_file(dev,&class_=
device_attr_ddr);=09
if((gpio->data_write)&&(gpio->data_read))class_device_create_file(dev,&clas=
s_device_attr_data);
#endif	=20
	=20
#ifdef CONFIG_GPIOCLASS_RTDM
	rt_gpio_device_create(gpio->rtd);
#endif=20
	return dev;		=09
}


struct class_device *rt_gpio_device_create(rtdm_device *dev){
		gpio_t *gpio =3D container_of(dev,gpio_t,rtd);
		memcpy(dev, &device_tmpl, sizeof(struct rtdm_device));
		strncpy(dev->device_name, gpio->name, RTDM_MAX_DEVNAME_LEN);
		dev->device_sub_class =3D gpio->subclass;
		dev->peripheral_name =3D name;//used to back up and find the original=20
structure.	=09
}

> What about putting the rtdm_device and your standard device structure
> into a "meta" structure. The type of the latter then only has be known
> to those parts that access data "across" the two structure.
Good idea!,
 So were on the same page, you mean like :?

struct rtdm_ meta{
	gpio_t  *gpio;
	struct rtdm_device rtd;
}

static int rt_gpio_ioctl(struct rtdm_dev_context *context,
                   rtdm_user_info_t *user_info, int request, void *umem){
   =20
struct rtsm_meta *meta =3D container_of(context->dev,rtdm_meta,rtd);
gpio_t  *gpio =3D meta->gpio;


That sounds good, then the user space layer wouldn't have to be aware of th=
e=20
Xenomai side at all, with the exception of the atomic locks, which could be=
=20
localized to a single module and defined away as a macro.

clever, thx Jan,
NZG

