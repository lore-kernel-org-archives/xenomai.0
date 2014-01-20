MIME-Version: 1.0
From: Seong-hyeon Kim <zedoul@gmail.com>
Date: Mon, 20 Jan 2014 16:55:05 +0100
Message-ID: <CA+dLyOUvoZX5SeN_e2CkwQPJuv_aZ7RgC-x7gGrDwqjGNxCTkg@mail.gmail.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable
Subject: [Xenomai] Asking probe method in RTDM
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Hi,


I am trying to call *probe* function in RTDM device driver. However, I
could not make it, and also fail to find suitable source. It will be very
helpful if someone let me know some good source for it.


What I have been tried is, I use =93platform_driver_register=94 function to
load "platform_driver" structure as bellows:



static int rt_probe(struct platform_device *pdev)

{

int res;

rtdm_printk( "%s %d\n",__func__,__LINE__);

res =3D rtdm_dev_register(&device):

return res:

}


static struct platform_driver rt_id_table[] =3D {

{"test",},

{},

};


static struct platform_driver pwm_driver =3D {

.probe =3D rt_probe,

.remove =3D rt_remove,

.id_table =3D rt_id_table,

.driver =3D {

.name =3D =93DRIVER_NAME",

.owner =3D THIS_MODULE,

},

};


int __init rt_pwm_init(void)

{

rtdm_printk( "%s %d\n",__func__,__LINE__);

return platform_driver_register(&pwm_driver);

}


module_init(rt_pwm_init);



I hope above code is able to call *rt_probe* method, but it only calls
=93rt_pwm_init=94, nothing else, without any messages.


I use Xenomai 2.6, on =93cdsteinkuehler=94 kernel (
https://github.com/cdsteinkuehler/linux-dev) on Beaglebone.



Thank you for reading this.
