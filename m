From: =?utf-8?q?Fran=C3=A7ois_Legal?= <francois.legal@thom.fr.eu.org>
In-Reply-To: <1202-610c0080-1db-1ab27320@266372836>
Content-Type: text/plain; charset="utf-8"
Date: Fri, 06 Aug 2021 10:20:49 +0200
MIME-Version: 1.0
Message-ID: <1202-610cf100-1df-1ab27320@266372902>
Subject: =?utf-8?q?=5BPatch=5D?==?utf-8?q?_drivers=2Fgpio=3A?= Allow selection
 of timestamp source for GPIO  timestamps
Content-Transfer-Encoding: quoted-printable
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

This patch allows to select which time source (monotonic/realtime) is u=
sed to timestamp GPIO events.
The time source used to be monotonic which is the opposite of what othe=
r drivers do. Now default changed to realtime, plus new API added to go=
 back to monotonic.


Signed-off-by: Fran=C3=A7ois LEGAL <devel@thom.fr.eu.org>
---
diff --git a/include/rtdm/uapi/gpio.h b/include/rtdm/uapi/gpio.h
index 2839f7d51..f8a93b7f7 100644
--- a/include/rtdm/uapi/gpio.h
+++ b/include/rtdm/uapi/gpio.h
@@ -30,6 +30,8 @@ struct rtdm=5Fgpio=5Freadout {
 #define GPIO=5FRTIOC=5FREQS		=5FIO(RTDM=5FCLASS=5FGPIO, 4)
 #define GPIO=5FRTIOC=5FRELS		=5FIO(RTDM=5FCLASS=5FGPIO, 5)
 #define GPIO=5FRTIOC=5FTS		=5FIOR(RTDM=5FCLASS=5FGPIO, 7, int)
+#define GPIO=5FRTIOC=5FTS=5FREAL  =5FIOR(RTDM=5FCLASS=5FGPIO, 8, int)
+#define GPIO=5FRTIOC=5FTS=5FMONO  =5FIOR(RTDM=5FCLASS=5FGPIO, 9, int)
 
 #define GPIO=5FTRIGGER=5FNONE		0x0 /* unspecified */
 #define GPIO=5FTRIGGER=5FEDGE=5FRISING	0x1
diff --git a/kernel/drivers/gpio/gpio-core.c b/kernel/drivers/gpio/gpio=
-core.c
index bc283064b..3eaf425c6 100644
--- a/kernel/drivers/gpio/gpio-core.c
+++ b/kernel/drivers/gpio/gpio-core.c
@@ -36,13 +36,15 @@ static LIST=5FHEAD(rtdm=5Fgpio=5Fchips);
 
 static DEFINE=5FMUTEX(chip=5Flock);
 
+static nanosecs=5Fabs=5Ft (*timestamp=5Fget=5Ffunc=5Fptr)(void) =3D rt=
dm=5Fclock=5Fread;
+
 static int gpio=5Fpin=5Finterrupt(rtdm=5Firq=5Ft *irqh)
 {
 	struct rtdm=5Fgpio=5Fpin *pin;
 
 	pin =3D rtdm=5Firq=5Fget=5Farg(irqh, struct rtdm=5Fgpio=5Fpin);
 
-	pin->timestamp =3D rtdm=5Fclock=5Fread=5Fmonotonic();
+	pin->timestamp =3D timestamp=5Fget=5Ffunc=5Fptr();
 	rtdm=5Fevent=5Fsignal(&pin->event);
 
 	return RTDM=5FIRQ=5FHANDLED;
@@ -192,9 +194,18 @@ static int gpio=5Fpin=5Fioctl=5Fnrt(struct rtdm=5F=
fd *fd,
 		chan->requested =3D false;
 		break;
 	case GPIO=5FRTIOC=5FTS:
+	case GPIO=5FRTIOC=5FTS=5FREAL:
+		ret =3D rtdm=5Fsafe=5Fcopy=5Ffrom=5Fuser(fd, &val, arg, sizeof(val))=
;
+		if (ret)
+			return ret;
+		timestamp=5Fget=5Ffunc=5Fptr =3D rtdm=5Fclock=5Fread;
+		chan->want=5Ftimestamp =3D !!val;
+		break;
+	case GPIO=5FRTIOC=5FTS=5FMONO:
 		ret =3D rtdm=5Fsafe=5Fcopy=5Ffrom=5Fuser(fd, &val, arg, sizeof(val))=
;
 		if (ret)
 			return ret;
+		timestamp=5Fget=5Ffunc=5Fptr =3D rtdm=5Fclock=5Fread=5Fmonotonic;
 		chan->want=5Ftimestamp =3D !!val;
 		break;
 	default:


