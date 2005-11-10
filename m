Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 10 Nov 2005 22:05:07 +0100
Message-ID: <FDBBB5CC70676540B3EF7CFE83FD94E004305A@EINT11.einet.ad.eivd.ch>
From: "ROSSIER Daniel" <Daniel.Rossier@domain.hid>
Subject: [Xenomai-help] Creation of a rt-queue from the user space
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


Hello everyone,

I've recently posted a message in this mailing list about an issue =
regarding the use of realtime queue in xenomai from the user space.=20

I didn't make any significant progress regarding this issue. I've =
upgraded to linux 2.6.12; everything works in the user/kernel space =
except the queue. If I correctly understood, it's necessary to have a =
/dev/rtheap in order to set up a shared memory segment between user and =
kernel space.=20
If this entry does not exist, we get an error at the queue creation =
time.=20

I've observed that if I'm creating manually the entry in /dev, I get the =
same error and the entry disappears from /dev. Then, I've transfered the =
udev/rtheap.rules located in the xenomai/nucleus directory into =
/etc/udev/rules.d. But the system totally freezes after xeno-load.

I've put the segment of code (very simple) for the creation of a simple =
rt-queue.

----------------

int main(int argc, char *argv[]) {

  printf("Now starting: %s\n", argv[0]);

  /* Timer initialization */
  err =3D rt_timer_start(1000000);   /* So, one tick will be equal to 1 =
ms */
  if (err !=3D 0) {
    printf("Error timer: %d\n", err);
    clean_exit(0);
  }

  /* Create the mailbox */
  err =3D rt_queue_create(&mailbox, "MAILBOX", 80, 1, Q_FIFO);
  if (err !=3D 0) {
    printf("mbox creation failed: %d\n", err);
    clean_exit(0);
  }

------------

Thanks for any support.

Regards
Daniel

