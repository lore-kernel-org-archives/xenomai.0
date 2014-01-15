From: Asier Tamayo <asier.tamayo@onaedm.com>
Date: Wed, 15 Jan 2014 08:55:14 +0000
Message-ID: <4F6C25B906613147991AA0B688C61D1F1D9F082C@SRVEXCHANGE.ona-electroerosion.com>
Content-Language: es-ES
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: [Xenomai] Accessing an EtherCAT master from a Xenomai driver
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "xenomai@xenomai.org" <xenomai@xenomai.org>

Hello all,

I'm using IgH EtherCAT master for Linux, from EtherLab. I have a problem wi=
th accessing the master from a RTDM driver.

I've already asked this question in the EtherLab list, but have received no=
 response, so I'm posting it here in case someone has worked with EtherLab =
but is no more in the mailing list.

My problem is the following:

I can access the EtherCAT master from a Xenomai user task, but have found n=
o way to do it from a RTDM driver. In my tests, I have tried to follow the =
functions from the Xenomai example, but I find some problems I can't see ho=
w to resolve.

For instance, the Xenomai example (user space application) calls ecrt_maste=
r_activate(), which eventually calls rtdm_mmap_to_user(): in the RTDM drive=
r, rtdm_mmap_to_user() is called with a user_info value set to NULL, and it=
 crashes. Also, some functions have to be called in non-RT context. For exa=
mple, ecrt_master_slave_config(), which allocates memory by causing a page =
fault.

I hope this time I'll have better luck. Best regards,


Asier Tamayo Arbide

Dpto I+D

R&D Department



ONA Electroerosi=F3n, s.a.



t      (34) 946 200 800

m    (34) 600 910 522

f      (34) 946 818 548

e      asier.tamayo@onaedm.com<mailto:asier.tamayo@onaedm.com>

w    www.onaedm.com<http://www.onaedm.com/>








[cid:image001.jpg@01CF11D7.E294FF10]








Aviso legal: Este mensaje y los documentos adjuntos pueden contener informa=
ci=F3n confidencial. Si usted lo ha recibido por error debe saber que la in=
formaci=F3n contenida en el mismo es reservada y su uso no autorizado esta =
prohibido por la ley, por lo que le rogamos que nos lo comunique por la mis=
ma v=EDa y proceda a borrar el mensaje.


Legal advice: The contents of this email and any attachments may contain co=
nfidential information. If you have received it by mistake please be aware =
that the information is private and confidential and as such its non author=
ised use is legally protected, therefore we ask you to contact the sender a=
nd delete the message.



-------------- next part --------------
A non-text attachment was scrubbed...
Name: image001.jpg
Type: image/jpeg
Size: 3717 bytes
Desc: image001.jpg
URL: <http://www.xenomai.org/pipermail/xenomai/attachments/20140115/a63ad03=
c/attachment.jpg>
